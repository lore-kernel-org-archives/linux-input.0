From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] hid-example: fix some build issues
Date: Mon, 18 Apr 2011 11:12:51 -0700
Message-ID: <20110418111251.8a922b6b.randy.dunlap@oracle.com>
References: <201104142149.p3ELnnoF008424@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:23740 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab1DRSNd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2011 14:13:33 -0400
In-Reply-To: <201104142149.p3ELnnoF008424@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: akpm@linux-foundation.org, jkosina@suse.cz, Alan Ott <alan@signal11.us>

From: Randy Dunlap <randy.dunlap@oracle.com>

samples/hid-example.o needs some Kconfig and Makefile additions
in order to build.  It should use <linux/*.h> headers from
the build tree, so use HEADERS_CHECK to require that those
header files be present.

Change the kconfig symbol from tristate to bool since
userspace cannot be built as loadable modules.

However, I don't understand why the userspace header files are
not present as reported in Andrew's build log, since it builds
OK on x86_64 without any of these changes.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
---
 samples/Kconfig         |    4 ++--
 samples/hidraw/Makefile |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20110418.orig/samples/hidraw/Makefile
+++ linux-next-20110418/samples/hidraw/Makefile
@@ -6,3 +6,5 @@ hostprogs-y := hid-example
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
+
+HOSTCFLAGS_hid-example.o += -I$(objtree)/usr/include
--- linux-next-20110418.orig/samples/Kconfig
+++ linux-next-20110418/samples/Kconfig
@@ -62,8 +62,8 @@ config SAMPLE_KDB
 	  command to the kdb shell.
 
 config SAMPLE_HIDRAW
-	tristate "Build simple hidraw example"
-	depends on HIDRAW
+	bool "Build simple hidraw example"
+	depends on HIDRAW && HEADERS_CHECK
 	help
 	  Build an example of how to use hidraw from userspace.
 
