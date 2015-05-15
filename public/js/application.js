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

  $('#main').on('click', ':submit', function(event){
    addNewTask(event);
  });

};

function addNewTask(event){
  event.preventDefault();

  var stageToAppend = $("select[name='stage']").val();
  var appendTarget = $('div.'+stageToAppend+":first-child");
  var route = $('#taskroute').attr('action');

  var data = $("form").serialize();

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
    console.log(response);
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
  console.log(title);
  var detail = $(title);
  console.log(detail);
  detail.toggle();

};

function reassignTask(event){
  event.preventDefault();
  var newStage = event.target.closest('ul');
  console.log(newStage);
  var stageName = newStage.id;
  console.log(stageName);
  var taskId = event.originalEvent.dataTransfer.getData("Id");
  console.log(taskId)
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

// function buildTask(options){

//   var newTaskDiv = $('#tasktemplate').html();

//   var

// };

// function showTaskForm(event) {
//   event.preventDefault();
//   taskForm.dialog( "open" );
// };


// var addTask = function(){}

  // var tasks = $('.task');
  // // console.log(tasks);
  // $.each(tasks, function(task){
  //   task.addEventListener("dragstart", startDrag, false);
  //   var startDrag = function(event){
  //     event.dataTransfer.setData('Text', event.target.id);
  //     console.log(event.dataTransfer.getData('Text'));
  //   };
  // });
