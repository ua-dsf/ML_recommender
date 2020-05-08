# Notes recommenders

## Using App descriptions to cluster Cyverse App

The App_kNN notebook gives a first exploration of clustering Cyverse Apps on their text descriptions. This approach seems to help clustering apps by their topic but also lead to un-wanted behavior, such as with Apps where the description is minimal or voluntarily replaced by dumb text (e.g. "blabla" or "test").

## Using User behaviors to retrieve k-NN

The Users_kNN notebooks focuses on exploring user behavior to help recommendations. The number of time an App was run by user was used to inform a k-NN search for users with same behaviors. The matrix being very sparse, cosine similarity seemed to perform best. However, users tends to run a large number of time one or 2 apps therefore their behavior can be skewed toward these apps. Retrieving a user with similar behavior will therefore be of minimal information to recommend an app.

In conclusion, the top_ten R script allows to generate the top ten app run by user from a specific domain. This list can serve as a minimal working recommendation for new users comming on the platform. Additional curation of this list could include ratings and number of successful runs.