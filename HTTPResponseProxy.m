#import "HTTPResponseProxy.h"


@implementation HTTPResponseProxy

@synthesize response;

- (void)dealloc {
	self.response = nil;
	[super dealloc];
}

- (NSInteger)status {
	if (status != 0) {
		return status;
	} else if ([response respondsToSelector:@selector(status)]) {
		return [response status];
	}

	return 200;
}

- (void)setStatus:(NSInteger)statusCode {
	status = statusCode;
}

// Implement the methods required by the HTTPResponse protocol
- (UInt64)contentLength {
	if ([response respondsToSelector:@selector(contentLength)]) {
		return [response contentLength];
	} else {
		return 0;
	}
}

- (UInt64)offset {
	if ([response respondsToSelector:@selector(offset)]) {
		return [response offset];
	} else {
		return 0;
	}
}

- (void)setOffset:(UInt64)offset {
	if ([response respondsToSelector:@selector(setOffset:)]) {
		return [response setOffset:offset];
	}
}

- (NSData *)readDataOfLength:(NSUInteger)length {
	if ([response respondsToSelector:@selector(readDataOfLength:)]) {
		return [response readDataOfLength:length];
	} else {
		return nil;
	}
}

- (BOOL)isDone {
	if ([response respondsToSelector:@selector(isDone)]) {
		return [response isDone];
	} else {
		return YES;
	}
}

// Forward all other invocations to the actual response object
- (void)forwardInvocation:(NSInvocation *)invocation {
	if ([response respondsToSelector:[invocation selector]]) {
		[invocation invokeWithTarget:response];
	} else {
		[super forwardInvocation:invocation];
	}
}

- (BOOL)respondsToSelector:(SEL)selector {
	if ([super respondsToSelector:selector])
		return YES;

	return [response respondsToSelector:selector];
}

@end

