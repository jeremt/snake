// Generated by CoffeeScript 1.3.3
(function() {

  define(["utils/createcontext", "core/map", "core/snake", "core/food", "jquery"], function(createContext, Map, Snake, Food, $) {
    var color, ctx, food, gameLoop, map, over, score, snake, t, ts;
    color = ["cyan", "red", "orange", "purple", "green"][~~(Math.random() * 5)];
    $('h1').css({
      color: color
    });
    ctx = createContext('#snake-view', 500, 500);
    ctx.fillRect(0, 0, ctx.width, ctx.height);
    map = new Map(ctx, 10, 'circle');
    snake = new Snake(map, color, map.width >> 1, map.height >> 1);
    food = new Food(map, color);
    over = function() {
      clearInterval(ts);
      return console.log("GAME OVER");
    };
    ts = null;
    t = 0;
    score = 0;
    gameLoop = function() {
      snake.update();
      if (t === 10) {
        if (snake.eat({
          x: food.x,
          y: food.y
        })) {
          food.spawn();
          ++score;
        }
        snake.move(snake.direction);
        if (snake.hit()) {
          over();
        }
        food.draw();
        t = 0;
        ctx.fillText("Score: " + score, 10, 15);
      }
      return ++t;
    };
    return ts = setInterval(gameLoop, 6);
  });

}).call(this);
