// Retry action function to handle retries
async function retryAction(action, retries = 3, delay = 2000) {
    let lastError;
    for (let attempt = 1; attempt <= retries; attempt++) {
        try {
            return await action();
        } catch (error) {
            console.warn(`Action failed. Attempt ${attempt}/${retries}: ${error.message}`);
            lastError = error;
            if (attempt < retries) {
                await new Promise(resolve => setTimeout(resolve, delay));
            }
        }
    }
    throw lastError;
}

// Main function to search and simulate movie download
async function searchAndDownloadMovie(movieName) {
    const browser = await puppeteer.launch({
        headless: false,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage',
            '--disable-blink-features=AutomationControlled',
            '--disable-web-security',
            '--allow-running-insecure-content',
        ],
    });

    const page = await browser.newPage();
