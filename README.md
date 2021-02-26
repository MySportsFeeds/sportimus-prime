# sportimus-prime
A general-use sports backend with local API and reference UI for fantasy sports.

# Goals
1. This project is intended to provide a core set of backend services for most sports-based projects and/or businesses.  The included services will be generic enough to be used by various types of projects (fantasy sports, DFS, machine learning, charting/graphing, etc).
2. It will provide the integrated means to access the MysportsFeeds API.  A valid API key will be needed to enable access, which can be obtained via http://www.mysportsfeeds.com.
3. All data will be persisted in a local database, acquired from the MySportsFeeds API.
4. Most of the included services will be free, but future services/features may require the purchase of an additional license key to unlock.
5. **YOU MAY NOT** use this project and its services to share or otherwise redestribute the data, or compete with the MySportsFeeds API in any way.  Anyone found to be violating this condition will have their MySportsFeeds access revoked.

# Code Stack
Backend:
* Node.js
* Express
* MySQL

Frontend:
* Bootstrap?
* Angular?
* React?

# Core Services
1. System Options
3. Accounts (user + admin)
4. Data Acquisition and Management:
   1. MySportsFeeds API integration
   2. Leagues and Seasons
   3. Seasonal Schedules
   4. Persons (Players, Officials, Team/League executives)
   5. Games (scheduling, play-by-play data, etc)
   6. DFS Providers and Slates/Salaries
   7. Odds Providers
   8. Projections (fantasy and real-world)
5. Fantasy Services
   1. Contests
   2. Salaries

... to be continued ...
