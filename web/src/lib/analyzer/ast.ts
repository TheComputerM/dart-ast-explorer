export class AstTreeNode {
  readonly id: number;
  readonly type: string;
  readonly source: string;
  readonly range: [number, number];
  readonly children: AstTreeNode[];

  constructor(id: number, type: string, source: string, start: number, end: number) {
    this.id = id;
    this.type = type;
    this.source = source;
    this.range = [start, end];
    this.children = [];
  }

  findChild(id: number) {
    return this.children.find((node) => node.id === id);
  }
}

export class AstTreeBuilder {
  readonly rootNode: AstTreeNode;
  readonly _currentAddress: number[];

  constructor() {
    this.rootNode = new AstTreeNode(0, "ROOT", '', 0, 0);
    this._currentAddress = [];
  }

  enterNode(node: AstTreeNode) {
    const parentNode = this._getNodeAtCurrentAddress();
    parentNode.children.push(node);
    this._currentAddress.push(node.id);
  }

  exitNode() {
    this._currentAddress.pop();
  }

  _getNodeAtCurrentAddress() {
    let currentNode = this.rootNode;
    for (const id of this._currentAddress) {
      currentNode = currentNode.findChild(id)!;
    }
    return currentNode;
  }
}