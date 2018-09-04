From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/4] HID: input: do not append a suffix if the name already has it
Date: Tue,  4 Sep 2018 15:31:13 +0200
Message-ID: <20180904133115.5111-3-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Or it creates some weird input names like:
"MI Dongle MI Wireless Mouse Mouse"

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ac201817a2dd..1e9ba8f7a16b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1516,6 +1516,7 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	struct hid_input *hidinput = kzalloc(sizeof(*hidinput), GFP_KERNEL);
 	struct input_dev *input_dev = input_allocate_device();
 	const char *suffix = NULL;
+	size_t suffix_len, name_len;
 
 	if (!hidinput || !input_dev)
 		goto fail;
@@ -1559,10 +1560,15 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
 	}
 
 	if (suffix) {
-		hidinput->name = kasprintf(GFP_KERNEL, "%s %s",
-					   hid->name, suffix);
-		if (!hidinput->name)
-			goto fail;
+		name_len = strlen(hid->name);
+		suffix_len = strlen(suffix);
+		if ((name_len < suffix_len) ||
+		    strcmp(hid->name + name_len - suffix_len, suffix)) {
+			hidinput->name = kasprintf(GFP_KERNEL, "%s %s",
+						   hid->name, suffix);
+			if (!hidinput->name)
+				goto fail;
+		}
 	}
 
 	input_set_drvdata(input_dev, hid);
-- 
2.14.3
