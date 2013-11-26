From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v2] HID: uhid: fix leak for 64/32 UHID_CREATE
Date: Tue, 26 Nov 2013 13:58:18 +0100
Message-ID: <1385470698-6036-1-git-send-email-dh.herrmann@gmail.com>
References: <1385449330.23855.46.camel@deadeye.wl.decadent.org.uk>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1385449330.23855.46.camel@deadeye.wl.decadent.org.uk>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

UHID allows short writes so user-space can omit unused fields. We
automatically set them to 0 in the kernel. However, the 64/32 bit
compat-handler didn't do that in the UHID_CREATE fallback. This will
reveal random kernel heap data (of random size, even) to user-space.

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/hid/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 93b00d7..cedc6da 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -287,7 +287,7 @@ static int uhid_event_from_user(const char __user *buffer, size_t len,
 			 */
 			struct uhid_create_req_compat *compat;
 
-			compat = kmalloc(sizeof(*compat), GFP_KERNEL);
+			compat = kzalloc(sizeof(*compat), GFP_KERNEL);
 			if (!compat)
 				return -ENOMEM;
 
-- 
1.8.4.2
