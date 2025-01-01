int shape = 128;
int [][] cells = new int[shape][shape];

void setup(){
  size(1000, 800);
  
  for (int i = 0; i < cells.length; i++){
    int [] row = new int[shape];
    for (int j = 0; j < row.length; j++){
      if(j == 0 || j == row.length - 1 || i == 0 || i == cells.length - 1) {
        row[j] = 0; // Fills the edges with zeroes
      } else {
        row[j] = round(random(0, 1)); // Fill others with either zero or one
      }
    }
    cells[i] = row;
  }
  
  //frameRate(20);
}



void draw(){
  background(255);
  
  // Create live cells by mouse click
  if(mousePressed){
    int i = round(mouseY/(height/shape));
    int j = round(mouseX/(width/shape));
    for(int y = i - 1; y <= i + 1; y ++){
      for(int b = j - 1; b <= j + 1; b ++){
        cells[y][b] = 1;
      }
    }
  }
  
  
  int[][] new_cells = new int[shape][shape];
  // Drawing and checking cells, ignoring edges
  for (int i = 1; i < cells.length - 1; i++){ 
    for (int j = 1; j < cells[i].length - 1; j++){
      if(cells[i][j] == 1) {
        fill(0); // Filling black a live cell
      } else {
        fill(255); // Filling white a dead cell
      }
      int x = (width/shape) * j;
      int y = (height/shape) * i;
      rect(x, y, width/shape, height/shape);
      
      new_cells[i][j] = live_or_die(i, j);
    } 
  }
  
  // Updating for next generation
  cells = new_cells;
  
}

int live_or_die(int i, int j) {
  int total_live_neighbors = 0;

  // Count live neighbors
  for(int y = i - 1; y <= i + 1; y ++) {
    for(int z = j - 1; z <= j + 1; z ++){
      if(i == y && j == z) continue; // Ignores itself
      if(cells[y][z] == 1) total_live_neighbors += 1;
    }
  }
  
  // Apply the Game of Life rules
  if (cells[i][j] == 1) {
    return (total_live_neighbors < 2 || total_live_neighbors > 3) ? 0 : 1; // Cell dies or stays alive
  } else {
    return (total_live_neighbors == 3) ? 1 : 0; // Cell becomes alive or stays dead
  }
}
