#!/bin/bash

# Configuration
BACKEND_URL="http://localhost:8000"
FRONTEND_URL="http://localhost:3000"

echo "Testing Endpoints..."
echo "===================="

test_endpoint() {
    local url=$1
    local name=$2
    local method=${3:-GET}
    
    echo -n "Testing $name ($method $url)... "
    # Get full output for debugging if it's 000
    curl_output=$(curl -v -X "$method" "$url" 2>&1)
    status_code=$(echo "$curl_output" | grep "< HTTP" | tail -n 1 | awk '{print $3}' || echo "000")
    
    # If status_code is still empty, retry with simpler grep
    if [ -z "$status_code" ]; then
        status_code=$(curl -s -o /dev/null -w "%{http_code}" -X "$method" "$url")
    fi
    
    if [[ "$status_code" -ge 200 && "$status_code" -lt 300 ]]; then
        echo -e "\e[32mOK ($status_code)\e[0m"
    elif [[ "$status_code" -eq 401 || "$status_code" -eq 403 ]]; then
        echo -e "\e[33mAUTH REQUIRED ($status_code)\e[0m"
    else
        echo -e "\e[31mFAILED ($status_code)\e[0m"
    fi
}

echo "--- Backend Endpoints ---"
test_endpoint "$BACKEND_URL/admin/" "Admin"
test_endpoint "$BACKEND_URL/authentication/list/" "Auth List"
test_endpoint "$BACKEND_URL/authentication/profile/" "Auth Profile"
test_endpoint "$BACKEND_URL/data/book/" "Data Book"
test_endpoint "$BACKEND_URL/data/wanted/" "Data Wanted"
test_endpoint "$BACKEND_URL/data/giveaway/" "Data Giveaway"
test_endpoint "$BACKEND_URL/data/wanted/country/" "Data Wanted Country"
test_endpoint "$BACKEND_URL/data/giveaway/country/" "Data Giveaway Country"
test_endpoint "$BACKEND_URL/transaction/myTransactions/" "Transactions"

echo "--- Frontend Routes ---"
test_endpoint "$FRONTEND_URL/" "Home"
test_endpoint "$FRONTEND_URL/signin" "Signin"
test_endpoint "$FRONTEND_URL/register" "Register"
test_endpoint "$FRONTEND_URL/about" "About"
test_endpoint "$FRONTEND_URL/support" "Support"
test_endpoint "$FRONTEND_URL/SearchResults" "Search Results"
test_endpoint "$FRONTEND_URL/user/Addbook" "Add Book"
test_endpoint "$FRONTEND_URL/user/Settings" "Settings"

echo "===================="
echo "Testing Complete."
