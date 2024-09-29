let width = 864;
let height = 864;
let columns = 3;
let rows = 3;

let steps = 8;

let x = 0;
let y = 0;

for (let i = 0; i < steps; i++) {
    console.log(`
      ${(100 / steps) * i}% {
          background-position: -${(width / columns) * x}px -${
        (height / rows) * y
    }px;
      }
  `);

    x++;

    if ((i + 1) % columns === 0) {
        y++;
        x = 0;
    }
}
console.log(`
100% {
  background-position: 0 0;
}`);
