From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 41/68] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date: Thu, 29 Nov 2018 00:55:32 -0500
Message-ID: <20181129055559.159228-41-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: David Herrmann <dh.herrmann@gmail.com>

[ Upstream commit 4d26d1d1e8065bb3326a7c06d5d4698e581443a9 ]

This reverts commit 336fd4f5f25157e9e8bd50e898a1bbcd99eaea46.

Please note that `strlcpy()` does *NOT* do what you think it does.
strlcpy() *ALWAYS* reads the full input string, regardless of the
'length' parameter. That is, if the input is not zero-terminated,
strlcpy() will *READ* beyond input boundaries. It does this, because it
always returns the size it *would* copy if the target was big enough,
not the truncated size it actually copied.

The original code was perfectly fine. The hid device is
zero-initialized and the strncpy() functions copied up to n-1
characters. The result is always zero-terminated this way.

This is the third time someone tried to replace strncpy with strlcpy in
this function, and gets it wrong. I now added a comment that should at
least make people reconsider.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/uhid.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 051639c09f72..840634e0f1e3 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -497,12 +497,13 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		goto err_free;
 	}
 
-	len = min(sizeof(hid->name), sizeof(ev->u.create2.name));
-	strlcpy(hid->name, ev->u.create2.name, len);
-	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys));
-	strlcpy(hid->phys, ev->u.create2.phys, len);
-	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq));
-	strlcpy(hid->uniq, ev->u.create2.uniq, len);
+	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
+	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
+	strncpy(hid->name, ev->u.create2.name, len);
+	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
+	strncpy(hid->phys, ev->u.create2.phys, len);
+	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
+	strncpy(hid->uniq, ev->u.create2.uniq, len);
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;
-- 
2.17.1
