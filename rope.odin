package rope 

MaxRopeLeafLength :: 6

Rope :: struct($T: typeid) {
	left: ^Rope(T),
	right: ^Rope(T),
	parent: ^Rope(T),
	count: int,
	value: []T,
}

CreateRope :: proc(value: []$T, parent: ^Rope(T)) -> ^Rope(T) {
	parentCopy := parent
	if parent == nil {
		parentCopy = new(Rope(T))
		parentCopy.parent = nil
		parentCopy.count = len(value)/2
		parentCopy.value = nil
	}

	left := new(Rope(T))
	left.left = nil
	left.right = nil
	left.parent = parentCopy
	left.count = len(value)/2

	right := new(Rope(T))
	right.left = nil
	right.right = nil
	right.parent = parentCopy
	right.count = len(value)/2 - left.count

	leftValue: []T = make([]T, left.count)
	rightValue: []T = make([]T, len(value) - left.count)

	for i := 0; i < len(leftValue); i += 1 {
		leftValue[i] = value[i]
	}
	for i := 0; i < len(rightValue); i += 1 {
		rightValue[i] = value[i + left.count]
	}
	if len(leftValue) > MaxRopeLeafLength {
		parentCopy.left = left
		CreateRope(leftValue, left)
	} else {
		parentCopy.left = left
		left.value = leftValue
	}
	if len(rightValue) > MaxRopeLeafLength {
		parentCopy.right = right
		CreateRope(rightValue, right)
	} else {
		parentCopy.right = right
		right.value = rightValue
	}

	return parentCopy
}

DeleteRope :: proc(rope: ^Rope($T)) {
	if rope.left != nil {
		DeleteRope(rope.left)
	}	
	if rope.right != nil {
		DeleteRope(rope.right)
	}
	delete(rope.value)
	free(rope)
}

Index :: proc(rope: ^Rope($T), index: int) -> T {
	if index < rope.count {
		if rope.left != nil {
			return Index(rope.left, index)
		} else {
			return rope.value[index]
		}
	} else {
		if rope.right != nil {
			return Index(rope.right, index - rope.count)
		} else {
			return rope.value[index]
		}
	}
}

Concat :: proc(ropeLeft: ^Rope($T), ropeRight: ^Rope(T)) -> ^Rope(T){
	rope := new(Rope(T))
	rope.left = ropeLeft
	rope.right = ropeRight
	rope.count = ropeLeft
	rope.value = nil
	return rope
}

Rebalance :: proc(rope: ^Rope($T)) {
	
}

Insert :: proc(rope: ^Rope($T), index: int) {

}

Append :: proc(rope: ^Rope($T)) {

}

Delete :: proc (rope: ^Rope($T), index: int) {

}
