From: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/3] fbdev: Make deferred I/O work as advertized
Date: Mon, 25 Feb 2008 14:03:52 +0100
Message-ID: <87k5kt6vd3.fsf@pike.pond.sub.org>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com
List-Id: linux-input@vger.kernel.org

Deferred I/O was utterly broken.  Reading the mmap()ed framebuffer
worked, but writing it made the VM endlessly invoke
vm_ops.page_mkwrite().  That happened because we failed to set
page->mapping and page->index.

The fix is to set them, and clean up properly before the framebuffer
gets released.

Fix extracted from this linux-fbdev-devel message:

    Subject: [PATCH 1/1 2.6.24] fbdev: defio and Metronomefb
    From: Jaya Kumar <jayakumar.lkml@gmail.com>
    Date: 2008-02-18 13:41:26

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>

---

 drivers/video/fb_defio.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index 0f8cfb9..24843fd 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -4,7 +4,7 @@
  *  Copyright (C) 2006 Jaya Kumar
  *
  * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
+ * License. See the file COPYING in the main directory of this archive
  * for more details.
  */
 
@@ -31,7 +31,7 @@ static int fb_deferred_io_fault(struct vm_area_struct *vma,
 	unsigned long offset;
 	struct page *page;
 	struct fb_info *info = vma->vm_private_data;
-	/* info->screen_base is in System RAM */
+	/* info->screen_base is virtual memory */
 	void *screen_base = (void __force *) info->screen_base;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
@@ -43,6 +43,15 @@ static int fb_deferred_io_fault(struct vm_area_struct *vma,
 		return VM_FAULT_SIGBUS;
 
 	get_page(page);
+
+	if (vma->vm_file)
+		page->mapping = vma->vm_file->f_mapping;
+	else
+		printk(KERN_ERR "no mapping available\n");
+
+	BUG_ON(!page->mapping);
+	page->index = vmf->pgoff;
+
 	vmf->page = page;
 	return 0;
 }
@@ -138,11 +147,20 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_init);
 
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
+	void *screen_base = (void __force *) info->screen_base;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct page *page;
+	int i;
 
 	BUG_ON(!fbdefio);
 	cancel_delayed_work(&info->deferred_work);
 	flush_scheduled_work();
+
+	/* clear out the mapping that we setup */
+	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
+		page = vmalloc_to_page(screen_base + i);
+		page->mapping = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
