package project.editor;

import js.jquery.JQuery;
import util.Vector;
import util.Color;
import util.Fields;

class ProjectGeneralPanel extends ProjectEditorPanel
{
  public static function startup()
  {
    Ogmo.projectEditor.addPanel(new ProjectGeneralPanel());
  }

  public var projectName:JQuery;
  public var backgroundColor:JQuery;
  public var gridColor:JQuery;
  public var angleExport:JQuery;
  public var levelMinSize:JQuery;
  public var levelMaxSize:JQuery;
	public var levelValueManager:ValueTemplateManager;

  public function new()
  {
    super(0, "general", "General", "sliders");
    // general settings

    projectName = Fields.createField("Project Name");
    Fields.createSettingsBlock(root, projectName, SettingsBlock.Full, "Name", SettingsBlock.InlineTitle);

    backgroundColor = Fields.createColor("Background Color", Color.white, root);
    Fields.createSettingsBlock(root, backgroundColor, SettingsBlock.Third, "Bg Color", SettingsBlock.InlineTitle);

    gridColor = Fields.createColor("Grid Color", Color.white);
    Fields.createSettingsBlock(root, gridColor, SettingsBlock.Third, "Grid Color", SettingsBlock.InlineTitle);

    var options = new Map();
    options.set('0', 'Radians');
    options.set('1', 'Degrees');
    angleExport = Fields.createOptions(options);
    Fields.createSettingsBlock(root, angleExport, SettingsBlock.Third, "Angle Export Mode", SettingsBlock.InlineTitle);

    // level size
    levelMinSize = Fields.createVector(new Vector(0, 0));
    Fields.createSettingsBlock(root, levelMinSize, SettingsBlock.Half, "Min. Level Size", SettingsBlock.InlineTitle);
    levelMaxSize = Fields.createVector(new Vector(0, 0));
    Fields.createSettingsBlock(root, levelMaxSize, SettingsBlock.Half, "Max. Level Size", SettingsBlock.InlineTitle);

    // level custom fields
    levelValueManager = new ValueTemplateManager(root, []);
  }

  override function begin():Void
  {
    Fields.setField(projectName, OGMO.project.name);
    Fields.setColor(backgroundColor, OGMO.project.backgroundColor);
    Fields.setColor(gridColor, OGMO.project.gridColor);
    angleExport.val(OGMO.project.anglesRadians ? "0" : "1");
    Fields.setVector(levelMinSize, OGMO.project.levelMinSize);
    Fields.setVector(levelMaxSize, OGMO.project.levelMaxSize);
    levelValueManager.inspect(null, false);
    levelValueManager.values = OGMO.project.levelValues;
    levelValueManager.refreshList();
  }

  override function end():Void
  {
    OGMO.project.name = projectName.val();
    OGMO.project.backgroundColor = Fields.getColor(backgroundColor);
    OGMO.project.gridColor = Fields.getColor(gridColor);
    OGMO.project.anglesRadians = angleExport.val() == "0";
    OGMO.project.levelMinSize = Fields.getVector(levelMinSize);
    OGMO.project.levelMaxSize = Fields.getVector(levelMaxSize);
    OGMO.project.levelValues = levelValueManager.values;
  }
}
