# **Agent Pie: The Food & Beverage DocBot**

A digital training solution tailored for the Food & Beverage (F&B) industry, centered around a sophisticated Document Intelligence Bot designed to streamline employee onboarding, ensure rigorous compliance with operational standards, and meticulously track individual and team performance.

#### **Project Overview**
Agent Pie is an innovative prototype meticulously engineered to address the inherent challenges within F&B training paradigms. It revolutionizes traditional training methods by transforming static, often dense, Standard Operating Procedures (SOPs) into engaging, interactive, and easily digestible micro-learning modules. At the heart of our solution lies a **grounded Document Intelligence Bot** (DocBot), which provides secure, precise, and verifiable answers sourced directly from the ingested operational documents.

---

#### **Key Features (MVP)**
This prototype delivers on the core hackathon requirements:

* **Grounded Docbot:** A conversational agent that provides answers *only* from ingested SOPs, with inline citations back to the source document and version.
* **Procedure Mode:** Provides clear, step-by-step guidance for complex operational tasks, such as equipment startup or shutdown procedures, complemented by an intuitive checklist-based user experience.
* **Microlearning & Quizzes:** Features automatically generated quizzes, complete with detailed explanations for answers and integrated spaced repetition scheduling (e.g., leveraging the Leitner system) to significantly enhance knowledge retention and recall.
* **Manager Dashboard:** Offers a dedicated and comprehensive interface for managers to monitor key performance indicators (KPIs), including training program completion rates, average quiz scores per employee and module, and current SOP version coverage across the workforce.
* **Role-Based Access:** Basic authentication and user roles (Crew vs. Manager) to control access to content and features.
* **Content Versioning:** Enables seamless updates to SOPs, ensuring the DocBot immediately references the latest document versions, complete with a transparent and accessible audit trail for changes.

---

#### **Architecture**
Agent Pie is architected using a modern microservices approach, underpinned by a powerful **Retrieval-Augmented Generation (RAG)** system to ensure contextual accuracy and relevance of information.



Our system is composed of the following services:

* **Ingestion Pipeline:** A robust Python-based script responsible for processing raw source documents (supporting formats such as PDF, DOCX, and Markdown). It employs Optical Character Recognition (OCR) when necessary, extracts textual content, segments it into semantically coherent and manageable paragraphs (chunks), and subsequently generates vector embeddings for each chunk.
* **Indexing Service:** A **[Your Vector DB here, e.g., ChromaDB]** instance that stores the vector embeddings and their associated metadata (document title, version, section). This allows for rapid semantic search.
* **RAG Service:** The core of our bot. It takes a user query, retrieves the most relevant document chunks from the vector store, and passes them to a large language model to generate a grounded, citable response.
* **Learning & Analytics Services:** A backend component that manages quiz generation, spaced repetition schedules (using the Leitner system), and logs user events (quiz scores, checklist completions) to a **[Your DB, e.g., SQLite/Postgres]** database.
* **Flutter Frontend:** The client application, optimized for tablets and mobile devices. It communicates with the backend APIs to deliver the chat interface, procedure mode, quizzes, and manager dashboard.

---

#### **Setup & Installation Guide**

**Prerequisites:**
* **Flutter SDK** (Latest stable channel)
* **Python 3.9+**
* **Git**
* A valid **API key** for your chosen LLM (e.g., OpenAI API Key).

**1. Clone the repository:**
```bash
git clone [https://github.com/YourTeam/AgentPie.git](https://github.com/YourTeam/AgentPie.git)
cd AgentPie



#### **Frontend Architecture**
The Flutter frontend is structured using the **GetX** state management library following the **MVC (Model-View-Controller)** design pattern. This promotes a clean, scalable, and maintainable codebase for the client application.

