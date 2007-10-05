From: Oliver Neukum <oliver@neukum.org>
Subject: [PATCH]resource leak in hiddev if autoresume fails
Date: Fri, 5 Oct 2007 16:04:17 +0200
Message-ID: <200710051604.18234.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Jiri Kosina <jikos@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

Hi,

several resources are not freed if autoresume fails.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

----

--- a/drivers/hid/usbhid/hiddev.c	2007-10-05 15:42:45.000000000 +0200
+++ b/drivers/hid/usbhid/hiddev.c	2007-10-05 15:54:32.000000000 +0200
@@ -280,18 +280,21 @@ static int hiddev_open(struct inode *ino
 
 	list->hiddev = hiddev_table[i];
 
-	spin_lock_irqsave(&list->hiddev->list_lock, flags);
-	list_add_tail(&list->node, &hiddev_table[i]->list);
-	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
-
-	file->private_data = list;
-
 	if (!list->hiddev->open++)
 		if (list->hiddev->exist) {
 			struct hid_device *hid = hiddev_table[i]->hid;
 			res = usbhid_get_power(hid);
-			if (res < 0)
+			if (res < 0) {
+				hiddev_table[i]->open--;
+				kfree(list);
 				return -EIO;
+			} else {
+				spin_lock_irqsave(&list->hiddev->list_lock, flags);
+				list_add_tail(&list->node, &hiddev_table[i]->list);
+				spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
+
+				file->private_data = list;	
+			}
 			usbhid_open(hid);
 		}
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
