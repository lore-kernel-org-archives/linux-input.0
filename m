From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: uhid: actually use the err number from userspace
Date: Mon, 12 Aug 2019 18:21:05 +0200
Message-ID: <20190812162105.13428-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rheinsberg <david.rheinsberg@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This can help debugging the situation

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

not entirely sure if we can use this in a such simple way.

However, this is useful to mimic device behaviour from userspace.

Cheers,
Benjamin

 drivers/hid/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index fa0cc0899827..2fa32e7fc733 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -284,7 +284,7 @@ static int uhid_hid_set_report(struct hid_device *hid, unsigned char rnum,
 		goto unlock;
 
 	if (uhid->report_buf.u.set_report_reply.err)
-		ret = -EIO;
+		ret = -uhid->report_buf.u.set_report_reply.err;
 	else
 		ret = count;
 
-- 
2.19.2
