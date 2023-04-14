/**
 * @name Comp3310 workshop 6 query
 * @kind problem
 * @problem.severity warning
 * @id java/example/shared-stacktrace
 */

import java

class SystemPrint extends MethodAccess {
  SystemPrint() {
    this.getMethod().hasName("println") and
    this.getMethod().getDeclaringType().hasQualifiedName("java.io", "PrintStream")
  }
}

class ThrowableStack extends MethodAccess {
  ThrowableStack() {
    this.getMethod().hasName("printStackTrace") and
    this.getMethod().getDeclaringType() instanceof ThrowableType and
    this.getNumArgument() = 0
  }
}

class UnsafeOutput extends MethodAccess {
  UnsafeOutput() {
    this.getMethod().hasName("getMessage") and
    this.getMethod().getDeclaringType() instanceof ThrowableType
  }
}

from Call call, Argument arg
where
  arg = call.getAnArgument() and
  arg instanceof UnsafeOutput and
  arg.getCall() instanceof SystemPrint
  or
  call instanceof ThrowableStack
select call, "This shares the stack trace with the user."
