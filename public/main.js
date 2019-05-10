$(function () {
    
    $(".colname").droppable({
        accept: ".task",
        drop: evt => $(evt.target).removeClass("bw2"),
        over: evt => $(evt.target).addClass("bw2"),
        out: evt => $(evt.target).removeClass("bw2")
    })
    
    $(".colname").on("drop", function (evt, ui) {
        const { board_id } = $('[data-board_id]').data()
        const task = $(ui.draggable).attr("id").split("-").pop()
        const colname = $(evt.target).attr("id")
        window.location.replace(`/board/${board_id}/task/${task}/colname/${colname}`)
    })

    $(".task").draggable()
})