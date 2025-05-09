package rope

import "core:testing"
import "core:mem"
import "core:log"

@(test)
CreateRopeTest :: proc(t: ^testing.T) {
	runes: []rune = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'}
	rope := CreateRope(runes, nil)	
	testing.expect(t, rope != nil)

	DeleteRope(rope)
}

@(test)
DeleteRopeTest :: proc(t: ^testing.T) {
	runes: []rune = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'}
	rope := CreateRope(runes, nil)	

	DeleteRope(rope)
	testing.expect_leaks(t, proc(t: ^testing.T) {}, proc(t: ^testing.T, ta: ^mem.Tracking_Allocator) {
		testing.expect(t, ta.total_memory_allocated - ta.total_memory_freed == 0)
	})
}

@(test)
IndexTest :: proc(t: ^testing.T) {
	runes: []rune = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'}
	rope := CreateRope(runes, nil)	
	testing.expect_value(t, Index(rope, 0), 'a')
	testing.expect_value(t, Index(rope, 1), 'b')
	testing.expect_value(t, Index(rope, 2), 'c')
	testing.expect_value(t, Index(rope, 3), 'd')
	testing.expect_value(t, Index(rope, 4), 'e')
	testing.expect_value(t, Index(rope, 5), 'f')
	testing.expect_value(t, Index(rope, 6), 'g')
	testing.expect_value(t, Index(rope, 7), 'h')

	DeleteRope(rope)
}

@(test)
CollectLeavesTest :: proc(t: ^testing.T) {
	runes: []rune = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'}
	rope := CreateRope(runes, nil)	
	leaves := CollectLeaves(rope)
	testing.expect_value(t, len(leaves), 2)

	delete(leaves)
	DeleteRope(rope)
}
