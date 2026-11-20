Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164258;
	b=aKoZpPgMgDDc7huwsodKYNcEducCNS+rsY/QuJJKl/oa5eySR47hty6JDI8kXBRe0DAU
	 HtkAtGkD9K842+6usuHpbBOXWca8AKJ+dBr39QHOOPsoec3BidwYa8mtiSLzCTXqd+muj
	 HjDOLJRmTiqRgN/KOoWeWbclQp1WwGsLgc3NFfKlEQbAHT8QUXN6l8h63pXnZFBjiTHYX
	 0d1Z/jubHGFCoF7/jdx7vlfliSlCyOoJxPtmy7KDRlB4xXlcb/4WGBVEm05cMKFI6QpGt
	 MB51Yej2sgB3dF0XUpqAuZo6tjhx9pifSyxVhp2GG+bfgrHEEMAZfklss3mRvmS5PoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0+XcfF4HcuspwkT4FGSSTKd+71NymXVS88FmdIjuRJ8=;
	b=VzNiXkJEn7mZnH3ly1s66/YMxYy5ebDn9G3n5K9aOwZEyTf2Y6fqPBMXS/KhiMFh0ie7
	 VP6Y0C5UzGV1NPKCt0Ib6LpSNy3/uTdixeoaseF6lgxmqXRo91A34gj1+sR+npbT+JZC4
	 NYDv27+cnG6qh4CgZQFmL1UxwQyJHiOzoue4Fg6HjPReglBvQlx5reysAGoCdWNB+hUS7
	 ph7gjTtiPOrLWvfBHpaX9CmpP/puIF2z+D7EK1auepnuUIVaBj55HQeyluXbQ5kj8qpSb
	 VmhWoyD7LpMPE900WAcEnyCrHr7rpa6AYl3J7KRUaN9XxkP4YWr7IVda5H9VNSm0f4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcU7oKJg;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46B60A2617
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E46B60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcU7oKJg
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1284928c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164256; x=1795769056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+XcfF4HcuspwkT4FGSSTKd+71NymXVS88FmdIjuRJ8=;
        b=IcU7oKJgQh8NAq/zv9qw2E4HZ5xdDFKxlYZCH6o/718j8Xv5nJLvBcuZgrNTxMne6q
         7oA0XeLbn/v+Hm7wdFHLwi9pt2UTxNLkW9mnR1r4RIsnOC4O2gR/nMktvk+nr+O53vPk
         pcrfko++HfwdGGorlhxvL9e5cbp4sI7g+DhcbVpyfsOn9MKXpZya5eShsvt08eOavNSx
         3svLTpiKwy1ojq/zdyeLSJwd+5bxmQQLdk+uhw6B2iFahhnwDdLYnlB5Gmi/aKx2C6JC
         lP8mbmUAUmmz3k1U4RcrBR3zHcfe+zGeOb77b0J2nEWvyIV96zoGsiOkN+mtOon6WbG8
         bmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164256; x=1795769056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+XcfF4HcuspwkT4FGSSTKd+71NymXVS88FmdIjuRJ8=;
        b=AyJkcSjip6immRVSxb+W2lhndvxlV8vp8+I5iZE2JXol0fEpqCQqvAajYB2pdkUSu1
         IE6qULbBYnEeA6rhmF1Q9CYjiHAIXki5OZXfOLJ7buGHfbf+b8TO3uxfaMfHV6aYKvxU
         Rj9AtVEhHjmWNwXZtVjumxd/9aldadLAKmTNvKneuxY1R+vk17TdBkni4yZZjL/wQ2DH
         FMQuc2BzElFKsVySD0M/e/y87r5HmeienMs5c8wS0sLqrk5nBpCocw/HtKeeLFPquHom
         lWKJTR3E18uZYgvX2GuPXI7RKj03nc2k4KIw4g08Ui0RvgaRkkwcq4EXSkc2o62MdWbj
         coVw==
X-Forwarded-Encrypted: i=1; AL+hErFUBJ895yXweaOirUfHssVTVlfQBn4p5OUWTrcQ9fIzCVfjpNFMZ3ac9EjFqCyuXB/uhONA65fKSSdDNA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1yUCZEzv5/BmFwovqnhLoAKTdMd7OD+K5nYObOayFaF22yu1F
	ZH2NQWuQbMQu8PnzHEaSmjCrxruTrkNmFMrjsJ2urEMIbi91qyx+i7H4
X-Gm-Gg: AYBFou3KstUj+p9z/05qcbloZPJYaL5g2EgKSZKfc2il5zX4EWzz2cM6s6tbF3r+BNO
	5Z/FGAGCe7h0dFx2kz3SIMPzOUyYa/iqL1SQkybUfQGua+v6iOYZXlSk33Y+scENm5zZfKBat7l
	IPMXQiroKJq2E5cboOvc1ADNWpaG5gg2hhktz3Glm07ju+6DgBlscMYD7PXTolybQ/wLEialYRI
	z/JqLPYKU85Hi/fKdXIgvxgBgvF3xegZlF5cN9t208D/3adVOFsGph/2u6aQdK8TsY+iPG+yc6Q
	MS+griUBuGk+GxhsWhlEG+TkxnjqaZmTrmjEg3uewYweOqydvhV0EakjhmqzV9vIaaQbPOxpbde
	kIss7nEQyBLxqhwkgH4SYGPq6os/Rd45eIsftglcDwgqsfJxhrdY/EpRzHwJmR1BWfyZetnxSuI
	NVBB7NNFlX6Uu9q6JEfMPdklJBjOKk6iCowD++8t9WTDwbDyk9a2s6ApESUP1+brZOGsxDqTqX3
	iA5pOZXU6TyzggMOOPSZzc8ha77lTX6MZw7EKpmAP5Vu7QK3SZF0V0MTHfWm2jmJbmkzgX2Q+jN
	qEKqJkMuESwk3Gq5YSozmzWqUiL8djPN7m1yoyZgKvwdMPGYsnPaT428nDzX70dCixoiokDWqk1
	SojNcivN931rIPvTYTg==
X-Received: by 2002:a05:7023:a41:b0:1b2:649d:dc23 with SMTP id a92af1059eb24-1b556901b95mr2226549c88.35.1795164256261;
        Fri, 20 Nov 2026 00:44:16 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:15 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:43:55 -0800
Subject: [PATCH v3 04/18] HID: logitech-hidpp: rework G920 force-feedback
 initialization
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-next-v3-4-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Querying G920 force-feedback capabilities inside .input_configured()
requires toggling device I/O mid-registration and conflates device
configuration with input setup. At the same time, the single allocated
state structure mixes per-device wheel settings with the lifetime of the
input force-feedback queue, complicating error handling and cleanup.

Exclude generic USB PID force feedback for validated HID++ devices and
query the G920 force-feedback configuration during probe while device
I/O is already active. Keep both probe query failures and force-feedback
initialization errors non-fatal so basic wheel and pedal inputs remain
usable without force feedback, while ensuring failed initialization
leaves input capabilities clean.

Split the overloaded force-feedback state by lifetime so device-level
G920 wheel settings are devm-managed for the bound device lifetime,
while the input force-feedback queue and slot tracking are allocated
with a flexible array and owned strictly by the force-feedback device.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 210 +++++++++++++++++++--------------------
 1 file changed, 101 insertions(+), 109 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 44a7b4dfc9d9..19adf5796807 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2346,15 +2346,19 @@ static void hidpp_touchpad_raw_xy_event(struct hidpp_device *hidpp_dev,
 
 struct hidpp_ff_private_data {
 	struct hidpp_device *hidpp;
+	struct workqueue_struct *wq;
+	atomic_t workqueue_size;
+	u8 num_effects;
+	int effect_ids[] __counted_by(num_effects);
+};
+
+struct g920_data {
+	struct hidpp_ff_private_data *ff;
 	u8 feature_index;
-	u8 version;
-	u16 gain;
-	s16 range;
 	u8 slot_autocenter;
 	u8 num_effects;
-	int *effect_ids;
-	struct workqueue_struct *wq;
-	atomic_t workqueue_size;
+	u16 gain;
+	u16 range;
 };
 
 struct hidpp_ff_work_data {
@@ -2418,6 +2422,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 {
 	struct hidpp_ff_work_data *wd = container_of(w, struct hidpp_ff_work_data, work);
 	struct hidpp_ff_private_data *data = wd->data;
+	struct g920_data *g920 = data->hidpp->private_data;
 	struct hidpp_report response;
 	u8 slot;
 	int ret;
@@ -2425,7 +2430,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 	/* add slot number if needed */
 	switch (wd->effect_id) {
 	case HIDPP_FF_EFFECTID_AUTOCENTER:
-		wd->params[0] = data->slot_autocenter;
+		wd->params[0] = g920->slot_autocenter;
 		break;
 	case HIDPP_FF_EFFECTID_NONE:
 		/* leave slot as zero */
@@ -2437,8 +2442,9 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 	}
 
 	/* send command and wait for reply */
-	ret = hidpp_send_fap_command_sync(data->hidpp, data->feature_index,
-		wd->command, wd->params, wd->size, &response);
+	ret = hidpp_send_fap_command_sync(data->hidpp, g920->feature_index,
+					  wd->command, wd->params, wd->size,
+					  &response);
 
 	if (ret) {
 		hid_err(data->hidpp->hid_dev, "Failed to send command to device!\n");
@@ -2455,7 +2461,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 				data->effect_ids[slot-1] = wd->effect_id;
 			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
 				/* autocenter spring uploaded */
-				data->slot_autocenter = slot;
+				g920->slot_autocenter = slot;
 		}
 		break;
 	case HIDPP_FF_DESTROY_EFFECT:
@@ -2466,14 +2472,14 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 				data->effect_ids[slot-1] = -1;
 			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
 				/* autocenter spring destroyed */
-				data->slot_autocenter = 0;
+				g920->slot_autocenter = 0;
 		}
 		break;
 	case HIDPP_FF_SET_GLOBAL_GAINS:
-		data->gain = (wd->params[0] << 8) + wd->params[1];
+		g920->gain = (wd->params[0] << 8) + wd->params[1];
 		break;
 	case HIDPP_FF_SET_APERTURE:
-		data->range = (wd->params[0] << 8) + wd->params[1];
+		g920->range = (wd->params[0] << 8) + wd->params[1];
 		break;
 	default:
 		/* no action needed */
@@ -2720,19 +2726,17 @@ static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
 static ssize_t hidpp_ff_range_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hid_device *hid = to_hid_device(dev);
-	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	struct input_dev *idev = hidinput->input;
-	struct hidpp_ff_private_data *data = idev->ff->private;
+	struct hidpp_device *hidpp = hid_get_drvdata(hid);
+	struct g920_data *g920 = hidpp->private_data;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", data->range);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", g920->range);
 }
 
 static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hid_device *hid = to_hid_device(dev);
-	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	struct input_dev *idev = hidinput->input;
-	struct hidpp_ff_private_data *data = idev->ff->private;
+	struct hidpp_device *hidpp = hid_get_drvdata(hid);
+	struct g920_data *g920 = hidpp->private_data;
 	u8 params[2];
 	int range = simple_strtoul(buf, NULL, 10);
 
@@ -2741,7 +2745,7 @@ static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute
 	params[0] = range >> 8;
 	params[1] = range & 0x00FF;
 
-	hidpp_ff_queue_work(data, -1, HIDPP_FF_SET_APERTURE, params, ARRAY_SIZE(params));
+	hidpp_ff_queue_work(g920->ff, -1, HIDPP_FF_SET_APERTURE, params, ARRAY_SIZE(params));
 
 	return count;
 }
@@ -2751,13 +2755,15 @@ static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, hidpp
 static void hidpp_ff_destroy(struct ff_device *ff)
 {
 	struct hidpp_ff_private_data *data = ff->private;
-	struct hid_device *hid = data->hidpp->hid_dev;
+	struct hidpp_device *hidpp = data->hidpp;
+	struct hid_device *hid = hidpp->hid_dev;
+	struct g920_data *g920 = hidpp->private_data;
 
 	hid_info(hid, "Unloading HID++ force feedback.\n");
 
 	device_remove_file(&hid->dev, &dev_attr_range);
 	destroy_workqueue(data->wq);
-	kfree(data->effect_ids);
+	g920->ff = NULL;
 }
 
 static int g920_input_open(struct input_dev *dev)
@@ -2776,16 +2782,14 @@ static void g920_input_close(struct input_dev *dev)
 	hid_hw_close(hid);
 }
 
-static int hidpp_ff_init(struct hidpp_device *hidpp,
-			 struct hidpp_ff_private_data *data)
+static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 {
 	struct hid_device *hid = hidpp->hid_dev;
-	struct hid_input *hidinput;
-	struct input_dev *dev;
+	struct g920_data *g920 = hidpp->private_data;
 	struct usb_device_descriptor *udesc;
 	u16 bcdDevice;
 	struct ff_device *ff;
-	int error, j, num_slots = data->num_effects;
+	int error, j, num_slots = g920->num_effects;
 	u8 version;
 
 	if (!hid_is_usb(hid)) {
@@ -2793,17 +2797,22 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		return -ENODEV;
 	}
 
-	if (list_empty(&hid->inputs)) {
-		hid_err(hid, "no inputs found\n");
-		return -ENODEV;
-	}
-	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
-	dev = hidinput->input;
+	struct hidpp_ff_private_data *data __free(kfree) =
+		kzalloc_flex(*data, effect_ids, num_slots);
+	if (!data)
+		return -ENOMEM;
 
-	if (!dev) {
-		hid_err(hid, "Struct input_dev not set!\n");
-		return -EINVAL;
-	}
+	data->hidpp = hidpp;
+	data->num_effects = num_slots;
+	for (j = 0; j < num_slots; j++)
+		data->effect_ids[j] = -1;
+
+	/* init the hardware command queue */
+	atomic_set(&data->workqueue_size, 0);
+
+	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	if (!data->wq)
+		return -ENOMEM;
 
 	/* Get firmware release */
 	udesc = &(hid_to_usb_dev(hid)->descriptor);
@@ -2818,38 +2827,16 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
 	error = input_ff_create(dev, num_slots - HIDPP_FF_RESERVED_SLOTS);
-
 	if (error) {
-		hid_err(dev, "Failed to create FF device!\n");
+		hid_err(hid, "Failed to create FF device!\n");
+		bitmap_zero(dev->ffbit, FF_CNT);
+		destroy_workqueue(data->wq);
 		return error;
 	}
-	/*
-	 * Create a copy of passed data, so we can transfer memory
-	 * ownership to FF core
-	 */
-	data = kmemdup(data, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		error = -ENOMEM;
-		goto err_destroy_ff;
-	}
-	data->effect_ids = kzalloc_objs(int, num_slots);
-	if (!data->effect_ids) {
-		error = -ENOMEM;
-		goto err_free_data;
-	}
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
-	if (!data->wq) {
-		error = -ENOMEM;
-		goto err_free_effect_ids;
-	}
-
-	data->hidpp = hidpp;
-	data->version = version;
-	for (j = 0; j < num_slots; j++)
-		data->effect_ids[j] = -1;
 
 	ff = dev->ff;
-	ff->private = data;
+	g920->ff = data;
+	ff->private = no_free_ptr(data);
 
 	ff->upload = hidpp_ff_upload_effect;
 	ff->erase = hidpp_ff_erase_effect;
@@ -2866,21 +2853,10 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	if (error)
 		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d!\n", error);
 
-	/* init the hardware command queue */
-	atomic_set(&data->workqueue_size, 0);
-
 	hid_info(hid, "Force feedback support loaded (firmware release %d).\n",
 		 version);
 
 	return 0;
-
-err_free_effect_ids:
-	kfree(data->effect_ids);
-err_free_data:
-	kfree(data);
-err_destroy_ff:
-	input_ff_destroy(dev);
-	return error;
 }
 
 /* ************************************************************************** */
@@ -3381,7 +3357,7 @@ static int k400_connect(struct hid_device *hdev)
 #define HIDPP_PAGE_G920_FORCE_FEEDBACK			0x8123
 
 static int g920_ff_set_autocenter(struct hidpp_device *hidpp,
-				  struct hidpp_ff_private_data *data)
+				  struct g920_data *data)
 {
 	struct hidpp_report response;
 	u8 params[HIDPP_AUTOCENTER_PARAMS_LENGTH] = {
@@ -3396,71 +3372,83 @@ static int g920_ff_set_autocenter(struct hidpp_device *hidpp,
 					  HIDPP_FF_DOWNLOAD_EFFECT,
 					  params, ARRAY_SIZE(params),
 					  &response);
-	if (ret)
+	if (ret) {
 		hid_warn(hidpp->hid_dev, "Failed to autocenter device!\n");
-	else
-		data->slot_autocenter = response.fap.params[0];
+		return ret;
+	}
 
-	return ret;
+	data->slot_autocenter = response.fap.params[0];
+	return 0;
 }
 
-static int g920_get_config(struct hidpp_device *hidpp,
-			   struct hidpp_ff_private_data *data)
+static int g920_get_config(struct hidpp_device *hidpp)
 {
+	struct g920_data data = {};
 	struct hidpp_report response;
 	int ret;
 
-	memset(data, 0, sizeof(*data));
-
 	/* Find feature and store for later use */
 	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_G920_FORCE_FEEDBACK,
-				     &data->feature_index);
+				     &data.feature_index);
 	if (ret)
 		return ret;
 
 	/* Read number of slots available in device */
-	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,
+	ret = hidpp_send_fap_command_sync(hidpp, data.feature_index,
 					  HIDPP_FF_GET_INFO,
 					  NULL, 0,
 					  &response);
 	if (ret)
 		return ret;
 
-	data->num_effects = response.fap.params[0];
+	if (response.fap.params[0] <= HIDPP_FF_RESERVED_SLOTS ||
+	    response.fap.params[0] > FF_MAX_EFFECTS + HIDPP_FF_RESERVED_SLOTS) {
+		hid_err(hidpp->hid_dev,
+			"Invalid force feedback slot count %u\n",
+			response.fap.params[0]);
+		return -EINVAL;
+	}
+
+	data.num_effects = response.fap.params[0];
 
 	/* reset all forces */
-	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,
+	ret = hidpp_send_fap_command_sync(hidpp, data.feature_index,
 					  HIDPP_FF_RESET_ALL,
 					  NULL, 0,
 					  &response);
 	if (ret)
 		hid_warn(hidpp->hid_dev, "Failed to reset all forces!\n");
 
-	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,
+	ret = hidpp_send_fap_command_sync(hidpp, data.feature_index,
 					  HIDPP_FF_GET_APERTURE,
 					  NULL, 0,
 					  &response);
-	if (ret) {
+	if (ret)
 		hid_warn(hidpp->hid_dev,
 			 "Failed to read range from device!\n");
-	}
-	data->range = ret ?
+	data.range = ret ?
 		900 : get_unaligned_be16(&response.fap.params[0]);
 
 	/* Read the current gain values */
-	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,
+	ret = hidpp_send_fap_command_sync(hidpp, data.feature_index,
 					  HIDPP_FF_GET_GLOBAL_GAINS,
 					  NULL, 0,
 					  &response);
 	if (ret)
 		hid_warn(hidpp->hid_dev,
 			 "Failed to read gain values from device!\n");
-	data->gain = ret ?
+	data.gain = ret ?
 		0xffff : get_unaligned_be16(&response.fap.params[0]);
 
 	/* ignore boost value at response.fap.params[2] */
 
-	return g920_ff_set_autocenter(hidpp, data);
+	ret = g920_ff_set_autocenter(hidpp, &data);
+	if (ret)
+		return ret;
+
+	hidpp->private_data = devm_kmemdup(&hidpp->hid_dev->dev, &data,
+					   sizeof(data), GFP_KERNEL);
+	return hidpp->private_data ? 0 : -ENOMEM;
 }
 
 /* -------------------------------------------------------------------------- */
@@ -4045,21 +4033,15 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		return 0;
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		struct hidpp_ff_private_data data;
-
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
-		hid_device_io_start(hdev);
-		ret = g920_get_config(hidpp, &data);
-		hid_device_io_stop(hdev);
-		if (!ret)
-			ret = hidpp_ff_init(hidpp, &data);
-
-		if (ret) {
-			hid_warn(hidpp->hid_dev,
-				 "Unable to initialize force feedback support, errno %d\n",
-				 ret);
+		if (hidpp->private_data) {
+			ret = hidpp_ff_init(hidpp, input);
+			if (ret)
+				hid_warn(hdev,
+					 "Unable to initialize force feedback support, errno %d\n",
+					 ret);
 		}
 	}
 
@@ -4639,7 +4621,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidpp_device *hidpp;
 	int ret;
-	unsigned int connect_mask = HID_CONNECT_DEFAULT;
+	unsigned int connect_mask;
 
 	/* report_fixup needs drvdata to be set before we call hid_parse */
 	hidpp = devm_kzalloc_obj(&hdev->dev, *hidpp);
@@ -4729,6 +4711,16 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	else
 		hidpp_non_unifying_init(hidpp);
 
+	if ((hidpp->quirks & HIDPP_QUIRK_CLASS_G920) && hid_is_usb(hdev)) {
+		ret = g920_get_config(hidpp);
+		if (ret)
+			hid_warn(hdev,
+				 "Unable to query force feedback config, errno %d\n",
+				 ret);
+	}
+
+	/* None of the HID++ devices use generic USB PID force-feedback. */
+	connect_mask = HID_CONNECT_DEFAULT & ~HID_CONNECT_FF;
 	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;
 

-- 
2.56.1.750.gf70dc682cf-goog

