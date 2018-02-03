From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: Roccat: Delete an error message for a failed memory
 allocation in nine functions
Date: Sat, 3 Feb 2018 11:50:12 +0100
Message-ID: <5df2ad06-296d-7552-d36d-dd8b09ad6f6d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 11:45:15 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-roccat-arvo.c     | 5 ++---
 drivers/hid/hid-roccat-isku.c     | 5 ++---
 drivers/hid/hid-roccat-koneplus.c | 5 ++---
 drivers/hid/hid-roccat-konepure.c | 5 ++---
 drivers/hid/hid-roccat-kovaplus.c | 5 ++---
 drivers/hid/hid-roccat-lua.c      | 5 ++---
 drivers/hid/hid-roccat-pyra.c     | 5 ++---
 drivers/hid/hid-roccat-ryos.c     | 5 ++---
 drivers/hid/hid-roccat-savu.c     | 5 ++---
 9 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 329c5d1270f9..8d1eccd4fffd 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -300,10 +300,9 @@ static int arvo_init_specials(struct hid_device *hdev)
 	}
 
 	arvo = kzalloc(sizeof(*arvo), GFP_KERNEL);
-	if (!arvo) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!arvo)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, arvo);
 
 	retval = arvo_init_arvo_device_struct(usb_dev, arvo);
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 02db537f8f3e..6f18925c72db 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -280,10 +280,9 @@ static int isku_init_specials(struct hid_device *hdev)
 	}
 
 	isku = kzalloc(sizeof(*isku), GFP_KERNEL);
-	if (!isku) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!isku)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, isku);
 
 	retval = isku_init_isku_device_struct(usb_dev, isku);
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 09e8fc72aa1d..3981553d02a6 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -385,10 +385,9 @@ static int koneplus_init_specials(struct hid_device *hdev)
 			== USB_INTERFACE_PROTOCOL_MOUSE) {
 
 		koneplus = kzalloc(sizeof(*koneplus), GFP_KERNEL);
-		if (!koneplus) {
-			hid_err(hdev, "can't alloc device descriptor\n");
+		if (!koneplus)
 			return -ENOMEM;
-		}
+
 		hid_set_drvdata(hdev, koneplus);
 
 		retval = koneplus_init_koneplus_device_struct(usb_dev, koneplus);
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 07de2f9014c6..529e6024e73f 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -89,10 +89,9 @@ static int konepure_init_specials(struct hid_device *hdev)
 	}
 
 	konepure = kzalloc(sizeof(*konepure), GFP_KERNEL);
-	if (!konepure) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!konepure)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, konepure);
 
 	retval = roccat_common2_device_init_struct(usb_dev, konepure);
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 43617fb28b87..da9c090542c6 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -452,10 +452,9 @@ static int kovaplus_init_specials(struct hid_device *hdev)
 			== USB_INTERFACE_PROTOCOL_MOUSE) {
 
 		kovaplus = kzalloc(sizeof(*kovaplus), GFP_KERNEL);
-		if (!kovaplus) {
-			hid_err(hdev, "can't alloc device descriptor\n");
+		if (!kovaplus)
 			return -ENOMEM;
-		}
+
 		hid_set_drvdata(hdev, kovaplus);
 
 		retval = kovaplus_init_kovaplus_device_struct(usb_dev, kovaplus);
diff --git a/drivers/hid/hid-roccat-lua.c b/drivers/hid/hid-roccat-lua.c
index ac1a7313e259..0ccaa345de27 100644
--- a/drivers/hid/hid-roccat-lua.c
+++ b/drivers/hid/hid-roccat-lua.c
@@ -123,10 +123,9 @@ static int lua_init_specials(struct hid_device *hdev)
 	int retval;
 
 	lua = kzalloc(sizeof(*lua), GFP_KERNEL);
-	if (!lua) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!lua)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, lua);
 
 	retval = lua_init_lua_device_struct(usb_dev, lua);
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index b30aa7b82bf8..c22cc42dadb6 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -404,10 +404,9 @@ static int pyra_init_specials(struct hid_device *hdev)
 			== USB_INTERFACE_PROTOCOL_MOUSE) {
 
 		pyra = kzalloc(sizeof(*pyra), GFP_KERNEL);
-		if (!pyra) {
-			hid_err(hdev, "can't alloc device descriptor\n");
+		if (!pyra)
 			return -ENOMEM;
-		}
+
 		hid_set_drvdata(hdev, pyra);
 
 		retval = pyra_init_pyra_device_struct(usb_dev, pyra);
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index 47cc8f30ff6d..1153e07ae415 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -97,10 +97,9 @@ static int ryos_init_specials(struct hid_device *hdev)
 	}
 
 	ryos = kzalloc(sizeof(*ryos), GFP_KERNEL);
-	if (!ryos) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!ryos)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, ryos);
 
 	retval = roccat_common2_device_init_struct(usb_dev, ryos);
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 6dbf6e04dce7..3b39f6556708 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -69,10 +69,9 @@ static int savu_init_specials(struct hid_device *hdev)
 	}
 
 	savu = kzalloc(sizeof(*savu), GFP_KERNEL);
-	if (!savu) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (!savu)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, savu);
 
 	retval = roccat_common2_device_init_struct(usb_dev, savu);
-- 
2.16.1

