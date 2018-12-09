Let's try this as a tree.  I have a hunch I want the links to point to the step
each step depends on, not the ones it enables. But let's try to think about how
it works both ways.

## First, parsing:

### Forward pointing tree

We'll keep an array (or maybe a hash, keyed by step letter) of all steps
hanging around. If either of the steps mentioned in the line doesn't exist,
create them. Then, add the second step to the array of children of the first
step.

### Backward pointing tree

Exactly the same, except add the first step to the array of children of the
second step.

## Walking the tree

Make sure we keep the array/hash of all nodes from the parsing step for
convenience.

### Forward pointing tree

Make a new array, called `available`, of all the steps that are not children of
any other step. (This is probably where the backwards-pointing tree makes more
sense). Sort it alphabetically by step name.

  1. Move the first `available` step out of the array and into a `result`
     array.
  1. Put all of the children of the last step in the `result` array into the
     `available` array. Sort `available`.
  1. Repeat until `available` is empty

Sad trombone -- this doesn't account for steps that are dependent on multiple
parents!

So, alternative approach. Let's add a `complete` flag to each step, and also
store parent links on each step.

  1. Move the first `available step out of the array and into a `result` array.
     Mark it complete.
  1. Move each child whose parents are entirely complete into `available` and
     sort it
  1. Repeat until `available` is empty


### Backward pointing tree

The initial `available` array is all of the steps with no children.

  1. Move the first `available` step out of the array and into a `result`
     array. Also remove it from global.
  1. Find all the steps in the global array that point to the just-moved step.
     Put them in the `available` array and sort.
  1. Repeat until the global array is empty.

## Decision

The backward pointing tree makes it easier to pick the set of starting steps,
but makes the ordering of the final steps more complicated and harder to reason
about, so let's go with forward-pointing.
