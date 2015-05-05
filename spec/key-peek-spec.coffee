KeyPeek = require '../lib/key-peek'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "KeyPeek", ->
  activationPromise = null
  workspaceElement = null

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('key-peek')

  describe "when the key-peek:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(workspaceElement.querySelector('.key-peek')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch(workspaceElement, 'key-peek:toggle')

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.key-peek')).toExist()
        atom.commands.dispatch(workspaceElement, 'key-peek:toggle')
        expect(workspaceElement.classList.contains('key-peek')).not.toExist()
