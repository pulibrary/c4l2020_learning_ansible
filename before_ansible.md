# Before Ansible

We are creating a "contrived" :wink: project to drive this workshop. Your organization operations group is tasked with migrating to a drupal based content management system. This is a greenfield project where your group will need to set up the following:

 1. A LoadBalancer
 1. A RDBMS and Search
 1. Drupal application
 1. Monitor and log the applications

 You or your group elect to use your last 4 or (3 if your laptop has less than 16GB) servers for:

 1. 2 serving Drupal
 1. 1 for RDBMS and Apache Solr
 1. 1 Loadbalancer

 Without Ansible you would have to know how to install and configure: 

 1. [HaProxy](http://www.haproxy.org/) - For loadbalancing
 1. [Drupal](https://www.drupal.org/) - For the CMS
 1. [PostgreSQL](https://www.postgresql.org/) - for the RDBMS
 1. [Apache Solr](https://lucene.apache.org/solr/) - for search
 1. [Alerta](http://alerta.io) - for monitoring and alerts

 You would would need to remember not just the instructions to set this up but how to manage this up 6 months down the road and/or onboard new and current staff (including future you) on what it takes to maintain this very important application. We will go through the exercise of installing and configuring these and time permitting doing these using pre-recorded steps to avoid using StackOverflow and then compare the comfort ansible provides us. But first let's walk through the manual steps.
