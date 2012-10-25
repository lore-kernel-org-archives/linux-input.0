From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] hid: put the case in the right switch statement
Date: Thu, 25 Oct 2012 15:35:25 +0100
Message-ID: <20121025143512.17155.56181.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53796 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450Ab2JYOds (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 10:33:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hid/hid-multitouch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3eb02b9..c97011c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -421,11 +421,11 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			 * contact max are global to the report */
 			td->last_field_index = field->index;
 			return -1;
-		}
 		case HID_DG_TOUCH:
 			/* Legacy devices use TIPSWITCH and not TOUCH.
 			 * Let's just ignore this field. */
 			return -1;
+		}
 		/* let hid-input decide for the others */
 		return 0;
 

