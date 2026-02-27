document.addEventListener("DOMContentLoaded", function() {

    // Toggle Back to Top button based on scroll position
    const fabUp = document.getElementById("fab-up");
    if(fabUp) {
        window.addEventListener("scroll", function() {
            if(window.scrollY > 300) {
                fabUp.classList.add("show");
            } else {
                fabUp.classList.remove("show");
            }
        });
        fabUp.addEventListener("click", function(e) {
            e.preventDefault();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    // Generate Table of Contents (TOC) for blog pages
    const articleContent = document.getElementById("article-content");
    const tocList = document.getElementById("toc-list");
    
    if(articleContent && tocList) {
        const headings = articleContent.querySelectorAll("h2, h3");
        if(headings.length > 0) {
            let currentH2List = null;
            
            headings.forEach(function(heading, index) {
                // Ensure heading has an ID
                if(!heading.id) {
                    heading.id = 'heading-' + index;
                }
                
                const li = document.createElement("li");
                const a = document.createElement("a");
                a.href = "#" + heading.id;
                a.textContent = heading.textContent;
                
                // Add smooth scrolling for TOC links
                a.addEventListener("click", function(e) {
                    e.preventDefault();
                    document.getElementById(heading.id).scrollIntoView({ behavior: 'smooth' });
                });
                
                li.appendChild(a);
                
                if(heading.tagName.toLowerCase() === 'h2') {
                    tocList.appendChild(li);
                    currentH2List = document.createElement("ul");
                    li.appendChild(currentH2List);
                } else if(heading.tagName.toLowerCase() === 'h3') {
                    if(currentH2List) {
                        currentH2List.appendChild(li);
                    } else {
                        tocList.appendChild(li); // Fallback if h3 appears before h2
                    }
                }
            });
        } else {
            document.querySelector('.toc-container').style.display = 'none';
        }
    }

    // Toggle TOC open/close
    const tocToggle = document.getElementById("toc-toggle");
    if(tocToggle) {
        tocToggle.addEventListener("click", function() {
            const content = document.querySelector(".toc-content");
            if(content.style.display === "none") {
                content.style.display = "block";
                this.innerHTML = '<i class="fas fa-chevron-up"></i>';
            } else {
                content.style.display = "none";
                this.innerHTML = '<i class="fas fa-chevron-down"></i>';
            }
        });
    }
});
