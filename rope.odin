package rope 

Rope :: struct($T: typeid) {
	left: ^Rope,
	right: ^Rope,
	parent: ^Rope,
	count: int,
	value: []T,
}

CreateRope :: proc(value: []$T) -> Rope(T) {
	rope := Rope {
		left = nil,
		right = nil,
		parent = nil,
		count = len(value)/2,
		value = nil,
	}
	left := Rope {
		left = nil,
		right = nil,
		parent = &rope,
		count = len(value)/2,
		value = make([]T, left.count),
	}
	right := Rope {
		left = nil,
		right = nil,
		parent = &rope,
		count = len(value)/2+1,
		value = make([]T, len(value) - left.count),
	}
	for i := 0; i < len(left.value); i += 1 {
		left.value[i] = value[i]
	}
	for i := 0; i < len(right.value); i += 1 {
		right.value[i] = value[i + left.count]
	}
	rope.left = &left
	rope.right = &right
}

Index :: proc(rope: ^Rope($T)) -> T {

}

Insert :: proc(rope: ^Rope($T), index: int) {

}

Append :: proc(rope: ^Rope($T)) {

}

Delete :: proc (rope: ^Rope($T), index: int) {

}
