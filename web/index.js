async function getTabInfo() {
    const tabs = await chrome.tabs.query({ 'active': true })
    console.log(tabs);
    return JSON.stringify({
        id: tabs[0].id,
        index: tabs[0].index,
        url: tabs[0].url,
        title: tabs[0].title
    })
}

async function getAllTabInfo() {
    const tabs = await chrome.tabs.query({});
    let tabData = [];
    for (let i = 0; i < tabs.length; i++) {
        tabData.push({
            id: tabs[i].id,
            index: tabs[i].index,
            url: tabs[i].url,
            title: tabs[i].title
        })
    }
    return JSON.stringify(tabData)
}

async function getCookieByURL(url) {
    let domain = url;
    domain = domain.split('//')[1]; // http://google.com/about
    domain = domain.split('/')[0];  // google.com/about

    if (domain.split('www.').length > 1) domain = domain.split('www.')[1]; // www.google.com

    const result = await new Promise((r) => {
        chrome.cookies.getAll({}, (cookies) => {
            let arr = [];
            cookies.forEach(e => {
                console.log(e);
                if (e.domain.includes(domain)) {
                    arr.push(e)
                }
            });
            r(arr)
        })
    })
    return JSON.stringify(result);
}