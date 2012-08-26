From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 17/20] HID: Only dump input if someone is listening
Date: Sun, 26 Aug 2012 14:57:35 +0200
Message-ID: <1345985858-445-18-git-send-email-rydberg@euromail.se>
References: <1345985858-445-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345985858-445-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

Going through the motions of printing the debug message information
takes a long time; using the keyboard can lead to a 160 us irqsoff
latency. This patch skips hid_dump_input() when there are no open
handles, which brings latency down to 100 us.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 60ea284..5b74e78 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -996,7 +996,8 @@ static void hid_process_event(struct hid_device *hid, struct hid_field *field,
 	struct hid_driver *hdrv = hid->driver;
 	int ret;
 
-	hid_dump_input(hid, usage, value);
+	if (!list_empty(&hid->debug_list))
+		hid_dump_input(hid, usage, value);
 
 	if (hdrv && hdrv->event && hid_match_usage(hid, usage)) {
 		ret = hdrv->event(hid, field, usage, value);
-- 
1.7.12
