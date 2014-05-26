From: Benoit Taine <benoit.taine@lip6.fr>
Subject: [PATCH 16/18] HID: uhid: Use kmemdup instead of kmalloc + memcpy
Date: Mon, 26 May 2014 17:21:25 +0200
Message-ID: <1401117687-28911-17-git-send-email-benoit.taine@lip6.fr>
References: <1401117687-28911-1-git-send-email-benoit.taine@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1401117687-28911-1-git-send-email-benoit.taine@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: benoit.taine@lip6.fr, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This issue was reported by coccicheck using the semantic patch 
at scripts/coccinelle/api/memdup.cocci

Signed-off-by: Benoit Taine <benoit.taine@lip6.fr>
---
Tested by compilation without errors.

 drivers/hid/uhid.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 0d078c3..0cb92e3 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -441,12 +441,11 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 	if (uhid->rd_size <= 0 || uhid->rd_size > HID_MAX_DESCRIPTOR_SIZE)
 		return -EINVAL;
 
-	uhid->rd_data = kmalloc(uhid->rd_size, GFP_KERNEL);
+	uhid->rd_data = kmemdup(ev->u.create2.rd_data, uhid->rd_size,
+				GFP_KERNEL);
 	if (!uhid->rd_data)
 		return -ENOMEM;
 
-	memcpy(uhid->rd_data, ev->u.create2.rd_data, uhid->rd_size);
-
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);

