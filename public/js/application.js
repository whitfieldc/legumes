$(document).ready(function() {

bindEvents();

});

function bindEvents(){

  $('div.stage').on("dragover", function(event){
    event.preventDefault();
  })

  $('#main').on("dragstart", 'div.task', function(event){
    event.originalEvent.dataTransfer.setData("Id", event.target.id);
    event.originalEvent.dataTransfer.setData("Text", event.target.firstChild.innerHTML);
  });

  $('div.stage').on("drop", function(event){
    reassignTask(event);
  });

  $('div.stage').on('click', 'a', function(event){
    showDetail(event);
  })

  $('#main').on('click', '#addTask', function(event){
    toggleTaskForm(event);
  });

  $('#main').on('click', ':submit.createtask ', function(event){
    addNewTask(event);
  });

  $('#main').on('click', ':submit.delete ', function(event){
    removeTask(event);
  });


};

function removeTask(event){
  event.preventDefault();
  console.log('in the ajax delete')

  var doomedTask = $(event.target).closest('.task');
  var taskId = doomedTask.attr('id')

  var deletion = $.ajax({
    type: 'delete',
    url: '/tasks/' + taskId,
  });
  doomedTask.hide();
}

function addNewTask(event){
  event.preventDefault();
  console.log(event);
  var stageToAppend = $("select[name='stage']").val();
  console.log(stageToAppend);
  var appendTarget = $('#'+stageToAppend);
  debugger
  console.log(appendTarget);
  var route = $('#taskroute').attr('action');
  var data = $("#taskroute").serialize();

  var creation = $.ajax({
    type: "post",
    url: route,
    data: data,
    success: function(data){
      console.log(data)
    }
  });

  creation.done(function(response){
    var newTask = $(response);
    console.log(newTask);
    console.log(appendTarget);
    // console.log(response);
    appendTarget.append(newTask);
    $('#taskform').hide();
    $('#addTask').show();
    });

};

function toggleTaskForm(event){
  event.preventDefault();
  $(event.target).hide();
  $('#taskform').show();
};

function showDetail(event){
  event.preventDefault();
  var title = $(event.target).closest('a').attr('href');
  var detail = $(title);
  detail.toggle();

};

function reassignTask(event){
  event.preventDefault();
  var newStage = event.target.closest('ul');
  var stageName = newStage.id;
  var taskId = event.originalEvent.dataTransfer.getData("Id");
  var text = event.originalEvent.dataTransfer.getData("Text");

  var data = {
    stageName: stageName
  };

  var update = $.ajax({
    type: 'patch',
    url: '/tasks/' + taskId,
    data: data,
  })
  newStage.appendChild(document.getElementById(taskId));
  update.done(function(response){
    console.log(response);
  });

};
