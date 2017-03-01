From: Joe Perches <joe@perches.com>
Subject: [PATCH 2/2] HID: Remove unnecessary OOM messages
Date: Wed,  1 Mar 2017 11:19:10 -0800
Message-ID: <0fbe692283802d36df389af7cbda9a4bff44db5e.1488395879.git.joe@perches.com>
References: <cover.1488395879.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1488395879.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Stefan Achatz <erazor_de@users.sourceforge.net>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Allocation failures from k.alloc and dev_k.alloc calls already
have a generic stack dump and these additional logging messages
just make the code larger and the allocations more likely to fail.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/hid-a4tech.c          |  4 +---
 drivers/hid/hid-apple.c           |  4 +---
 drivers/hid/hid-asus.c            |  5 +----
 drivers/hid/hid-lenovo.c          |  7 ++-----
 drivers/hid/hid-lg.c              |  5 ++---
 drivers/hid/hid-lg4ff.c           |  4 +---
 drivers/hid/hid-logitech-dj.c     | 12 +++---------
 drivers/hid/hid-magicmouse.c      |  4 +---
 drivers/hid/hid-multitouch.c      |  9 +++------
 drivers/hid/hid-ntrig.c           |  4 +---
 drivers/hid/hid-picolcd_core.c    |  1 -
 drivers/hid/hid-picolcd_leds.c    |  1 -
 drivers/hid/hid-prodikeys.c       |  5 +----
 drivers/hid/hid-rmi.c             |  4 +---
 drivers/hid/hid-roccat-arvo.c     |  5 ++---
 drivers/hid/hid-roccat-isku.c     |  5 ++---
 drivers/hid/hid-roccat-koneplus.c |  5 ++---
 drivers/hid/hid-roccat-konepure.c |  5 ++---
 drivers/hid/hid-roccat-kovaplus.c |  5 ++---
 drivers/hid/hid-roccat-lua.c      |  5 ++---
 drivers/hid/hid-roccat-pyra.c     |  5 ++---
 drivers/hid/hid-roccat-ryos.c     |  5 ++---
 drivers/hid/hid-roccat-savu.c     |  5 ++---
 drivers/hid/hid-saitek.c          |  4 +---
 drivers/hid/hid-sensor-hub.c      |  6 +-----
 drivers/hid/hid-sony.c            |  1 -
 26 files changed, 38 insertions(+), 87 deletions(-)

diff --git a/drivers/hid/hid-a4tech.c b/drivers/hid/hid-a4tech.c
index 9428ea7cdf8a..6b583bde147c 100644
--- a/drivers/hid/hid-a4tech.c
+++ b/drivers/hid/hid-a4tech.c
@@ -91,10 +91,8 @@ static int a4_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	int ret;
 
 	a4 = devm_kzalloc(&hdev->dev, sizeof(*a4), GFP_KERNEL);
-	if (a4 == NULL) {
-		hid_err(hdev, "can't alloc device descriptor\n");
+	if (a4 == NULL)
 		return -ENOMEM;
-	}
 
 	a4->quirks = id->driver_data;
 
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 2e046082210f..9711c195fdd7 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -372,10 +372,8 @@ static int apple_probe(struct hid_device *hdev,
 	int ret;
 
 	asc = devm_kzalloc(&hdev->dev, sizeof(*asc), GFP_KERNEL);
-	if (asc == NULL) {
-		hid_err(hdev, "can't alloc apple descriptor\n");
+	if (asc == NULL)
 		return -ENOMEM;
-	}
 
 	asc->quirks = quirks;
 
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 70b12f89a193..1ee6aac855a3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -224,7 +224,6 @@ static int asus_start_multitouch(struct hid_device *hdev)
 
 	if (!dmabuf) {
 		ret = -ENOMEM;
-		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
 		return ret;
 	}
 
@@ -257,10 +256,8 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct asus_drvdata *drvdata;
 
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (drvdata == NULL) {
-		hid_err(hdev, "Can't alloc Asus descriptor\n");
+	if (drvdata == NULL)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, drvdata);
 
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 1ac4ff4d57a6..63e15aa10926 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -688,7 +688,6 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 				    sizeof(struct lenovo_drvdata_tpkbd),
 				    GFP_KERNEL);
 	if (data_pointer == NULL) {
-		hid_err(hdev, "Could not allocate memory for driver data\n");
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -700,7 +699,6 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	name_mute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
 	name_micmute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
 	if (name_mute == NULL || name_micmute == NULL) {
-		hid_err(hdev, "Could not allocate memory for led data\n");
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -746,10 +744,9 @@ static int lenovo_probe_cptkbd(struct hid_device *hdev)
 	cptkbd_data = devm_kzalloc(&hdev->dev,
 					sizeof(*cptkbd_data),
 					GFP_KERNEL);
-	if (cptkbd_data == NULL) {
-		hid_err(hdev, "can't alloc keyboard descriptor\n");
+	if (cptkbd_data == NULL)
 		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, cptkbd_data);
 
 	/*
diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 52026dc94d5c..5ce045734fd9 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -728,10 +728,9 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	drv_data = kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
-	if (!drv_data) {
-		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
+	if (!drv_data)
 		return -ENOMEM;
-	}
+
 	drv_data->quirks = id->driver_data;
 
 	hid_set_drvdata(hdev, (void *)drv_data);
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 1fc12e357035..2b3d455ef080 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1403,10 +1403,8 @@ int lg4ff_init(struct hid_device *hid)
 
 		for (j = 0; j < 5; j++) {
 			led = kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
-			if (!led) {
-				hid_err(hid, "can't allocate memory for LED %d\n", j);
+			if (!led)
 				goto err_leds;
-			}
 
 			name = (void *)(&led[1]);
 			snprintf(name, name_sz, "%s::RPM%d", dev_name(&hid->dev), j+1);
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 5bc6d80d5be7..7227a9cc394f 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -418,12 +418,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys));
 
 	dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
-
-	if (!dj_dev) {
-		dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
-			__func__);
+	if (!dj_dev)
 		goto dj_device_allocate_fail;
-	}
 
 	dj_dev->reports_supported = get_unaligned_le32(
 		dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
@@ -1008,11 +1004,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 	/* Treat interface 2 */
 
 	djrcv_dev = kzalloc(sizeof(struct dj_receiver_dev), GFP_KERNEL);
-	if (!djrcv_dev) {
-		dev_err(&hdev->dev,
-			"%s:failed allocating dj_receiver_dev\n", __func__);
+	if (!djrcv_dev)
 		return -ENOMEM;
-	}
+
 	djrcv_dev->hdev = hdev;
 	INIT_WORK(&djrcv_dev->work, delayedwork_callback);
 	spin_lock_init(&djrcv_dev->lock);
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 20b40ad26325..e01f87f420a0 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -500,10 +500,8 @@ static int magicmouse_probe(struct hid_device *hdev,
 	int ret;
 
 	msc = devm_kzalloc(&hdev->dev, sizeof(*msc), GFP_KERNEL);
-	if (msc == NULL) {
-		hid_err(hdev, "can't alloc magicmouse descriptor\n");
+	if (msc == NULL)
 		return -ENOMEM;
-	}
 
 	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 692647485a53..b13d7fa0b2a2 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1128,10 +1128,9 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	td = devm_kzalloc(&hdev->dev, sizeof(struct mt_device), GFP_KERNEL);
-	if (!td) {
-		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
+	if (!td)
 		return -ENOMEM;
-	}
+
 	td->mtclass = *mtclass;
 	td->inputmode = -1;
 	td->maxcontact_report_id = -1;
@@ -1142,10 +1141,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	td->fields = devm_kzalloc(&hdev->dev, sizeof(struct mt_fields),
 				  GFP_KERNEL);
-	if (!td->fields) {
-		dev_err(&hdev->dev, "cannot allocate multitouch fields data\n");
+	if (!td->fields)
 		return -ENOMEM;
-	}
 
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
 		td->serial_maybe = true;
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 1b0084d4af2e..c612dd454776 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -905,10 +905,8 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				| HID_QUIRK_NO_INIT_REPORTS;
 
 	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
-	if (!nd) {
-		hid_err(hdev, "cannot allocate N-Trig data\n");
+	if (!nd)
 		return -ENOMEM;
-	}
 
 	nd->reading_mt = 0;
 	nd->min_width = 0;
diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index c1b29a9eb41a..5dc48ecc1b98 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -549,7 +549,6 @@ static int picolcd_probe(struct hid_device *hdev,
 	 */
 	data = kzalloc(sizeof(struct picolcd_data), GFP_KERNEL);
 	if (data == NULL) {
-		hid_err(hdev, "can't allocate space for Minibox PicoLCD device data\n");
 		error = -ENOMEM;
 		goto err_no_cleanup;
 	}
diff --git a/drivers/hid/hid-picolcd_leds.c b/drivers/hid/hid-picolcd_leds.c
index a802b4f49c7b..871cad90730a 100644
--- a/drivers/hid/hid-picolcd_leds.c
+++ b/drivers/hid/hid-picolcd_leds.c
@@ -122,7 +122,6 @@ int picolcd_init_leds(struct picolcd_data *data, struct hid_report *report)
 	for (i = 0; i < 8; i++) {
 		led = kzalloc(sizeof(struct led_classdev)+name_sz, GFP_KERNEL);
 		if (!led) {
-			dev_err(dev, "can't allocate memory for LED %d\n", i);
 			ret = -ENOMEM;
 			goto err;
 		}
diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index f095bf8a3aa9..b3776686ae8c 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -802,16 +802,13 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct pcmidi_snd *pm = NULL;
 
 	pk = kzalloc(sizeof(*pk), GFP_KERNEL);
-	if (pk == NULL) {
-		hid_err(hdev, "can't alloc descriptor\n");
+	if (pk == NULL)
 		return -ENOMEM;
-	}
 
 	pk->hdev = hdev;
 
 	pm = kzalloc(sizeof(*pm), GFP_KERNEL);
 	if (pm == NULL) {
-		hid_err(hdev, "can't alloc descriptor\n");
 		ret = -ENOMEM;
 		goto err_free_pk;
 	}
diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 5b40c2614599..25cbf422d40b 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -666,10 +666,8 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	alloc_size = data->output_report_size + data->input_report_size;
 
 	data->writeReport = devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);
-	if (!data->writeReport) {
-		hid_err(hdev, "failed to allocate buffer for HID reports\n");
+	if (!data->writeReport)
 		return -ENOMEM;
-	}
 
 	data->readReport = data->writeReport + data->output_report_size;
 
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
diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
index 39e642686ff0..bf35ca08c805 100644
--- a/drivers/hid/hid-saitek.c
+++ b/drivers/hid/hid-saitek.c
@@ -45,10 +45,8 @@ static int saitek_probe(struct hid_device *hdev,
 	int ret;
 
 	ssc = devm_kzalloc(&hdev->dev, sizeof(*ssc), GFP_KERNEL);
-	if (ssc == NULL) {
-		hid_err(hdev, "can't alloc saitek descriptor\n");
+	if (ssc == NULL)
 		return -ENOMEM;
-	}
 
 	ssc->quirks = quirks;
 	ssc->mode = -1;
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4ef73374a8f9..0cae98423a69 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -640,10 +640,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	struct hid_sensor_hub_device *collection_hsdev = NULL;
 
 	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
-	if (!sd) {
-		hid_err(hdev, "cannot allocate Sensor data\n");
+	if (!sd)
 		return -ENOMEM;
-	}
 
 	hid_set_drvdata(hdev, sd);
 	sd->quirks = id->driver_data;
@@ -676,7 +674,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
 						      sizeof(struct mfd_cell),
 						      GFP_KERNEL);
 	if (sd->hid_sensor_hub_client_devs == NULL) {
-		hid_err(hdev, "Failed to allocate memory for mfd cells\n");
 		ret = -ENOMEM;
 		goto err_stop_hw;
 	}
@@ -690,7 +687,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			hsdev = devm_kzalloc(&hdev->dev, sizeof(*hsdev),
 					     GFP_KERNEL);
 			if (!hsdev) {
-				hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
 				ret = -ENOMEM;
 				goto err_stop_hw;
 			}
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f405b07d0381..3516fe30ccf2 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1950,7 +1950,6 @@ static int sony_leds_init(struct sony_sc *sc)
 
 		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
 		if (!led) {
-			hid_err(hdev, "Couldn't allocate memory for LED %d\n", n);
 			ret = -ENOMEM;
 			goto error_leds;
 		}
-- 
2.10.0.rc2.1.g053435c
