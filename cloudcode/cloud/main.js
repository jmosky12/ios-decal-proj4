
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.job("delete", function(request, status) {
  // Set up to modify user data
  Parse.Cloud.useMasterKey();
  var counter = 0;
  // Query for all users
  var query = new Parse.Query(Parse.User);
  query.each(function(user) {
      // Update to plan value passed in
      user.set("plan", Math.random());
      if (counter % 100 === 0) {
        // Set the  job's progress status
        status.message(counter + " users processed.");
      }
      counter += 1;
      console.log(user.get("username"))
      return user.save();
  }).then(function() {
    // Set the job's success status
    status.success("Migration completed successfully.");
  }, function(error) {
    // Set the job's error status
    status.error("Uh oh, something went wrong.");
  });
});

Parse.Cloud.job("real_delete", function(request, status) {
	Parse.Cloud.useMasterKey();

  var query = new Parse.Query(Parse.Object.extend("SnapPost"));
  query.each(function(post) {
    //console.log(post.id)
   // post.set("duration", post.get("duration") - 1);
    var duration = post.get("duration")
    var elapsed = (Date.now() - post.createdAt) / 1000
    if ( elapsed > duration) {

      console.log("Duration exceeded for the following post: " + post.get("comment") + " real duration: " + elapsed)
      post.destroy(  {
          success: function(myObject) {
            console.log("destruction successful")
          },
          error: function(myObject, error) {
            // The delete failed.
            // error is a Parse.Error with an error code and message.
            console.log("Destruction failed")
          }
        }
      );
    } else {
      console.log("Post: " + post.get("comment") + "; time duration: " + elapsed)    
      //return post.save();
    }
  }).then(function(success) {
    status.success("hello?");
  }, 
  function(error) {
    status.error("something went wrong")
  })

});

Parse.Cloud.define("populate", function(request, status) {
  Parse.Cloud.useMasterKey();
  var query = new Parse.Query(Parse.User)
  query.get("HP1DyYDh9C", {
    success: function(user) {
      var Post = Parse.Object.extend("SnapPost")
      var newPost = new Post();
      newPost.set("comment", "Hello world! I love Snapbook.")
      newPost.set("duration", 3600)
      newPost.set("score", 100)
      newPost.set("user", user)
      newPost.save()
      status.success("posted")
    },
    error: function(object, error) {
      status.error("error!")
    }
  })
});
