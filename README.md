📚 NexusDev: Uni Textbook MarketplaceTechnical Validation & Database Optimization📝 Project OverviewThis repository serves as the technical validation for the Uni Textbook Marketplace. The primary focus is demonstrating a high-performance database architecture tailored for read-heavy, multi-filter searches typical of high-traffic student marketplaces.🎯 Validation GoalsSchema Design: Implementation of structured listings for academic accuracy.Optimization: Strategic indexing to ensure sub-millisecond query responses.Search Capability: Demonstration of complex multi-filter queries (Module, Condition, Price).Performance Metrics: Documentation of execution plans using EXPLAIN ANALYZE.👥 The TeamContributorRoleDeliverableTiegoProject LeadIntegration, Coordination & DocumentationNeoDatabase ArchitectOptimized Schema & IndexingGiftData EngineerSample Dataset GenerationOmphemetsePerformance AnalystSQL Query Optimization & TestingJoshQA EngineerVisual Performance Verification🏗 Database Architecture📊 Schema: listingsWe utilize a mix of strict typing for core data and JSONB for flexible metadata.FieldTypeDescriptionidUUIDPrimary Key (Distributed-safe)titleVARCHARTextbook title (Indexed for search)isbnVARCHAR(13)Standard ISBN identifierconditionENUMLike New, Good, Acceptable, PoorannotationVARCHARLevel of markings (None, Light, Heavy)extrasJSONBFlexible fields (Access codes, included notes)priceDECIMALSelling price in local currencymodule_codeVARCHARUniversity course code (e.g., COS301)🚀 Performance IndexingTo ensure scalability, we implemented the following composite indexes:idx_listings_module_price: Optimizes the most frequent search path.idx_listings_edition_condition: Refines results for specific academic requirements.idx_listings_module_annotation: Targets students looking for "clean" copies.🛠 Usage & DeploymentThis project is fully containerized for instant environment replication.🔌 Connection CredentialsHost: localhostPort: 5433Database: marketplaceUser/Pass: postgres / postgres💻 Quick Start Commands1. Environment InitializationBash# Build the validation image
docker build -t textbook-db .

# Launch the environment (detached mode)
docker compose up --build -d
2. Testing & VerificationBash# Run the automated verification suite
bash verify.sh
3. Maintenance & CleanupBash# Stop and remove containers
docker compose down -v

# Hard reset of the SQL environment
docker rm textbook-postgres
🔍 Sample Query DemonstrationBelow is an example of a single-filter lookup utilized in the performance testing suite:SQL-- Fetching all listings for a specific module
SELECT title, price, condition 
FROM listings 
WHERE module_code = 'COS301'
ORDER BY price ASC;
Note: Performance screenshots and execution logs can be found in the /screenshots directory.
