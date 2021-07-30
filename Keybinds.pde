int keySize = 50;
int viewMode = 0;
JSONObject keys;
JSONObject binds;
JSONArray layout;
JSONArray bindKeys;

void setup() {
  size(1280, 720);
  frameRate(24);
  stroke(0);
  textAlign(CENTER, TOP);
  
  keys = loadJSONObject("keys_dsaf_dirtyBomb.json");
  //keys = loadJSONObject("keys_dsaf_minecraft.json");
  //keys = loadJSONObject("keys_dsaf_rainbow6siege.json");
  //keys = loadJSONObject("keys_dsaf_titanfall2.json");
  //keys = loadJSONObject("keys_dsaf_template.json");
  binds = loadJSONObject("binds.json");
  layout = loadJSONObject("key_layout.json").getJSONArray("keys");
  bindKeys = binds.getJSONArray("keys");
}

void draw() {
  background(255);
  for (int i = 0; i < layout.size(); i++) {
    JSONObject currentKey = layout.getJSONObject(i);
    float x = currentKey.getFloat("x") * keySize + keySize;
    float y = currentKey.getFloat("y") * keySize + keySize;
    float w = currentKey.getFloat("w") * keySize;
    float h = currentKey.getFloat("h") * keySize;
    String label = currentKey.getString("key");
    String access = currentKey.getString("access");
    String bind = keys.getString(label);
    boolean noBind = bind == null || bind.equals("");
    fill(0);
    stroke(0);
    textSize(keySize * 0.5);
    if (viewMode == 0) {
      text("Viewing - Accessability", width / 4, keySize * 0.1);
      switch (access) {
        case "instant":
          fill(0, 255, 0);
          break;
        case "quick":
          fill(30, 200, 30);
          break;
        case "accessory":
          fill(0, 200, 200);
          break;
        case "menu":
          fill(180, 160, 40);
          break;
        case "inaccessable":
          if (noBind) fill(120);
          else fill(51, 102, 255);
          break;
        case "rebound":
          fill(255, 204, 0);
          break;
        case "system":
          fill(140, 0, 0);
          break;
        case "system_?":
          fill(0, 255, 255);
          break;
        default:
          fill(255, 0, 255);
      }
    } else if (viewMode == 1) {
      text("Viewing - Importance", width / 4, keySize * 0.1);
      if (noBind) {
        fill(120);
      } else {
        for (int j = 0; j < bindKeys.size(); j++) {
          JSONObject bindKey = bindKeys.getJSONObject(j);
          String currentBind = bindKey.getString("bind");
          if (currentBind.equals(bind)) {
            String importance = bindKey.getString("importance");
            switch (importance) {
              case "major":
                fill(0, 255, 0);
                break;
              case "semi-major":
                fill(30, 200, 30);
                break;
              case "rare":
                fill(0, 200, 200);
                break;
              case "specific":
                fill(180, 160, 40);
                break;
              default:
                fill(255, 0, 255);
            }
            break;
          }
        }
      }
    } else if (viewMode == 2) {
      text("Viewing - Category", width / 4, keySize * 0.1);
      if (noBind) {
        fill(120);
      } else {
        for (int j = 0; j < bindKeys.size(); j++) {
          JSONObject bindKey = bindKeys.getJSONObject(j);
          String currentBind = bindKey.getString("bind");
          if (currentBind.equals(bind)) {
            String category = bindKey.getString("category");
            switch (category) {
              case "movement":
                fill(247, 247, 0);
                break;
              case "combat":
                fill(204, 0, 0);
                break;
              case "communication":
                fill(0, 153, 204);
                break;
              case "action":
                fill(0, 51, 204);
                break;
              case "menu":
                fill(51, 153, 51);
                break;
              case "technical":
                fill(204, 0, 255);
                break;
              case "render":
                fill(51, 204, 51);
                break;
              default:
                fill(255, 0, 255);
            }
            break;
          }
        }
      }
    }
    rect(x, y, w, h);
    fill(0);
    textSize(min(w * 1.4 / label.length(), 12));
    text(label.toUpperCase(), x + w / 2, y);
    if (noBind) continue;
    float bindTS = min(w * 1.5 / bind.length(), 10);
    String[] bindParts;
    if (bindTS < 10) {
      bindParts = split(bind, ' ');
    } else {
      bindParts = new String[1];
      bindParts[0] = bind;
    }
    for (int j = 0; j < bindParts.length; j++) {
      bindTS = min(w * 1.5 / bindParts[j].length(), 10);
      textSize(bindTS);
      text(bindParts[j], x + w / 2, y + 18 + j * 10);
    }
  }
}

void keyPressed() {
  switch (key) {
    case 'n':
      viewMode++;
      viewMode %= 3;
      break;
    default:
      //nothing
  }
}
