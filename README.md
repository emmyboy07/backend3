"# backend3" 
/ Retry action function to handle retries
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