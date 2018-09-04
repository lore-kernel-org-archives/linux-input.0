From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/4] HID: core: fix grouping by application
Date: Tue,  4 Sep 2018 15:31:14 +0200
Message-ID: <20180904133115.5111-4-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

commit f07b3c1da92d ("HID: generic: create one input report per
application type") was effectively the same as MULTI_INPUT:
hidinput->report was never set, so hidinput_match_application()
always returned null.

Fix that by testing against the real application.

Note that this breaks some old eGalax touchscreens that expect MULTI_INPUT
instead of HID_QUIRK_INPUT_PER_APP. Enable this quirk for backward
compatibility on all non-Win8 touchscreens.

link: https://bugzilla.kernel.org/show_bug.cgi?id=200847
link: https://bugzilla.kernel.org/show_bug.cgi?id=200849
link: https://bugs.archlinux.org/task/59699
link: https://github.com/NixOS/nixpkgs/issues/45165

Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

This replaces https://patchwork.kernel.org/patch/10583471/
A proper fix is better than a revert.

 drivers/hid/hid-input.c      | 4 ++--
 drivers/hid/hid-multitouch.c | 3 +++
 include/linux/hid.h          | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 1e9ba8f7a16b..907b08e50a9b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1588,6 +1588,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	input_dev->dev.parent = &hid->dev;
 
 	hidinput->input = input_dev;
+	hidinput->application = application;
 	list_add_tail(&hidinput->list, &hid->inputs);
 
 	INIT_LIST_HEAD(&hidinput->reports);
@@ -1683,8 +1684,7 @@ static struct hid_input *hidinput_match_application(struct hid_report *report)
 	struct hid_input *hidinput;
 
 	list_for_each_entry(hidinput, &hid->inputs, list) {
-		if (hidinput->report &&
-		    hidinput->report->application == report->application)
+		if (hidinput->application == report->application)
 			return hidinput;
 	}
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 88da991ef256..da954f3f4da7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1697,6 +1697,9 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
 
+	if (id->group != HID_GROUP_MULTITOUCH_WIN_8)
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
+
 	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
 	ret = hid_parse(hdev);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 834e6461a690..d44a78362942 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -526,6 +526,7 @@ struct hid_input {
 	const char *name;
 	bool registered;
 	struct list_head reports;	/* the list of reports */
+	unsigned int application;	/* application usage for this input */
 };
 
 enum hid_type {
-- 
2.14.3
