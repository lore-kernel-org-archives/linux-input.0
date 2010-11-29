From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 1/7] hid: egalax: Use kzalloc
Date: Mon, 29 Nov 2010 08:43:26 +0100
Message-ID: <1291016612-25102-2-git-send-email-rydberg@euromail.se>
References: <1291016612-25102-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291016612-25102-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

To avoid unnecessary explicit initialization, allocate zeroed memory.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-egalax.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
index 54b017a..5a1b52e 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -221,7 +221,7 @@ static int egalax_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct egalax_data *td;
 	struct hid_report *report;
 
-	td = kmalloc(sizeof(struct egalax_data), GFP_KERNEL);
+	td = kzalloc(sizeof(struct egalax_data), GFP_KERNEL);
 	if (!td) {
 		dev_err(&hdev->dev, "cannot allocate eGalax data\n");
 		return -ENOMEM;
-- 
1.7.1
