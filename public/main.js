$(function () {
    const { board_id } = $('[data-board_id]').data()
    const ws = new WebSocket(`ws://${window.location.hostname}:9292/board/${board_id}/socket`)
    
    $(".colname").droppable({
        accept: ".task",
        drop: evt => $(evt.target).removeClass("bw2"),
        over: evt => $(evt.target).addClass("bw2"),
        out: evt => $(evt.target).removeClass("bw2")
    })
    
    $(".colname").on("drop", function (evt, ui) {
        const task_id = $(ui.draggable).attr("id").split("-").pop()
        const colname = $(evt.target).attr("id")
        ws.send([board_id, task_id, colname].join("|"))
    })

    $(".task").draggable({
        containment: "#board",
        helper: "clone",
        start: (evt) => $(evt.target).addClass("o-20"),
        stop: (evt) => $(evt.target).removeClass("o-20")
    })

    ws.onmessage = msg => {
        const [task_id, from_col, to_col] = msg.data.split("|")
        move(task_id, from_col, to_col)
    }

    function move (task_id, from_col, to_col) {
        $(`#task-${task_id}`).appendTo(`#${to_col}`)
        if (to_col == "done") {
            $(`#task-${task_id} p`).addClass("strike")
        } else {
            $(`#task-${task_id} p`).removeClass("strike")
        }
    }
})