From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/3] xen: Make xen-blkfront write its
	protocol ABI to xenstore
Date: Mon, 25 Feb 2008 14:02:24 +0100
Message-ID: <87mypp6vfj.fsf@pike.pond.sub.org>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com
List-Id: linux-input@vger.kernel.org

Frontends are expected to write their protocol ABI to xenstore.  Since
the protocol ABI defaults to the backend's native ABI, things work
fine without that as long as the frontend's native ABI is identical to
the backend's native ABI.  This is not the case for xen-blkfront
running 32-on-64, because its ABI differs between 32 and 64 bit, and
thus needs this fix.

Based on http://xenbits.xensource.com/xen-unstable.hg?rev/c545932a18f3
and http://xenbits.xensource.com/xen-unstable.hg?rev/ffe52263b430 by
Gerd Hoffmann <kraxel@suse.de>

Signed-off-by: Markus Armbruster <armbru@redhat.com>

---
 drivers/block/xen-blkfront.c         |    7 +++++++
 include/xen/interface/io/protocols.h |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 include/xen/interface/io/protocols.h

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8afce67..e69164a 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -46,6 +46,7 @@
 
 #include <xen/interface/grant_table.h>
 #include <xen/interface/io/blkif.h>
+#include <xen/interface/io/protocols.h>
 
 #include <asm/xen/hypervisor.h>
 
@@ -597,6 +598,12 @@ again:
 		message = "writing event-channel";
 		goto abort_transaction;
 	}
+	err = xenbus_printf(xbt, dev->nodename, "protocol", "%s",
+			    XEN_IO_PROTO_ABI_NATIVE);
+	if (err) {
+		message = "writing protocol";
+		goto abort_transaction;
+	}
 
 	err = xenbus_transaction_end(xbt, 0);
 	if (err) {
diff --git a/include/xen/interface/io/protocols.h b/include/xen/interface/io/protocols.h
new file mode 100644
index 0000000..01fc8ae
--- /dev/null
+++ b/include/xen/interface/io/protocols.h
@@ -0,0 +1,21 @@
+#ifndef __XEN_PROTOCOLS_H__
+#define __XEN_PROTOCOLS_H__
+
+#define XEN_IO_PROTO_ABI_X86_32     "x86_32-abi"
+#define XEN_IO_PROTO_ABI_X86_64     "x86_64-abi"
+#define XEN_IO_PROTO_ABI_IA64       "ia64-abi"
+#define XEN_IO_PROTO_ABI_POWERPC64  "powerpc64-abi"
+
+#if defined(__i386__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_32
+#elif defined(__x86_64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_X86_64
+#elif defined(__ia64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_IA64
+#elif defined(__powerpc64__)
+# define XEN_IO_PROTO_ABI_NATIVE XEN_IO_PROTO_ABI_POWERPC64
+#else
+# error arch fixup needed here
+#endif
+
+#endif
-- 
1.5.3.3


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
