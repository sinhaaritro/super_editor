import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

/// Example of a horizontal rule component that is not directly selectable.
///
/// The user can select around the horizontal rule, but cannot select it, specifically.
class UnselectableHrDemo extends StatefulWidget {
  @override
  _UnselectableHrDemoState createState() => _UnselectableHrDemoState();
}

class _UnselectableHrDemoState extends State<UnselectableHrDemo> {
  late MutableDocument _doc;
  late DocumentEditor _docEditor;

  @override
  void initState() {
    super.initState();
    _doc = _createDocument();
    _docEditor = DocumentEditor(document: _doc);
  }

  @override
  void dispose() {
    _doc.dispose();
    super.dispose();
  }

  MutableDocument _createDocument() {
    return MutableDocument(
      nodes: [
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          text: AttributedText(
            text:
                "Below is a horizontal rule (HR). Normally in a SuperEditor, the user can tap to select an HR. In this case, you can't select the HR. You can only select around it. Try and find out:",
          ),
        ),
        HorizontalRuleNode(id: DocumentEditor.createNodeId()),
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          text: AttributedText(
            text:
                "Duis mollis libero eu scelerisque ullamcorper. Pellentesque eleifend arcu nec augue molestie, at iaculis dui rutrum. Etiam lobortis magna at magna pellentesque ornare. Sed accumsan, libero vel porta molestie, tortor lorem eleifend ante, at egestas leo felis sed nunc. Quisque mi neque, molestie vel dolor a, eleifend tempor odio.",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SuperEditor(
      editor: _docEditor,
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
      // Add a new component builder that creates an unselectable
      // horizontal rule, instead of creating the usual selectable kind.
      componentBuilders: [
        _unselectableHrBuilder,
        ...defaultComponentBuilders,
      ],
    );
  }
}

/// SuperEditor [ComponentBuilder] that builds a horizontal rule that is
/// not selectable.
Widget? _unselectableHrBuilder(ComponentContext componentContext) {
  if (componentContext.documentNode is! HorizontalRuleNode) {
    return null;
  }

  return _UnselectableHorizontalRuleComponent(
    componentKey: componentContext.componentKey,
  );
}

class _UnselectableHorizontalRuleComponent extends StatelessWidget {
  const _UnselectableHorizontalRuleComponent({
    Key? key,
    required this.componentKey,
  }) : super(key: key);

  final GlobalKey componentKey;

  @override
  Widget build(BuildContext context) {
    return BoxComponent(
      key: componentKey,
      isVisuallySelectable: false,
      child: const Divider(
        color: Color(0xFF000000),
        thickness: 1.0,
      ),
    );
  }
}
