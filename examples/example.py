from locust import HttpLocust, TaskSet, events

def my_success_handler(request_type, name, response_time, response_length, **kw):
    print "Successfully fetched: %s %s \n" % (name, response_time)

events.request_success += my_success_handler
def index(l):
    res = l.client.get("/apiv0.1/events/isrunning")
    print "Result is %s " % res

class UserBehavior(TaskSet):
    tasks = {index:1}

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait=5000
    max_wait=9000
