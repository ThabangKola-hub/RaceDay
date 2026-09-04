# RaceDay
YOUTUBE VIDEO LINK _ - https://youtu.be/QnxX3vhSobw
## Project Overview

RaceDay is a web-based event management system designed to support road running, walking and cycling events.

The system allows organisers to manage events and event categories, while participants can browse events, enrol in events and track their race performance.

The project is being developed using C#, ASP.NET Core, SQL Server and RESTful web services.

---

## Project Objectives

The main objectives of the RaceDay system are to:

- Allow users to register and authenticate.
- Support Organiser and Participant roles.
- Allow Organisers to create and manage events.
- Allow Organisers to manage event categories.
- Allow Participants to browse available events.
- Allow Participants to enrol in event categories.
- Allow Organisers to record participant results.
- Allow Participants to view their performance history.
- Store event, participant, enrolment and result information in a relational database.
- Provide a RESTful API for communication between clients and the RaceDay system.

---

## User Roles

### Organiser

Organisers are responsible for managing RaceDay events.

Organisers can:

- Create events.
- Update events.
- Delete events.
- Create event categories.
- Update event categories.
- Manage participant enrolments.
- Record participant results.
- Update results.

### Participant

Participants use the system to participate in RaceDay events.

Participants can:

- Register for an account.
- Log in.
- View their profile.
- Browse events.
- View event details.
- Enrol in event categories.
- View their enrolments.
- View their personal race results and performance history.

---

## Database

The RaceDay database is designed using a relational database structure.

The main entities are:

- User
- Event
- Category
- Route
- Enrolment
- Result
- WeatherCache

The database contains primary keys and foreign keys to maintain relationships between entities.

The database design is documented in the `/docs` directory.

---

## REST API

The planned RaceDay API uses RESTful HTTP methods.

| Method | Purpose |
|--------|---------|
| GET | Retrieve information |
| POST | Create new information |
| PUT | Update existing information |
| DELETE | Delete information |

### Main API Resources

```text
/api/auth
/api/users
/api/events
/api/categories
/api/enrolments
/api/results

