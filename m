Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380212;
	b=XZQqBI6yhA0+PfrF3HIdffdyX2R0vxYfZ8S7l3EGell5cF7O5QKChdDE986CZfxa1rAc
	 P+twW2wcFrub6PrBY9W+tUZHGqsNlmbI9rqcgKDZRqbdZjGPwmkzFk8LfDUqPKU2JVFQd
	 syyiLRhAIfRBRTK2wgor/Gd016rRZme8eS2I5oO4DaE15Z06fzbgLqHd0yhtSm6kZ0PVP
	 aBinkcllrjEDn6z+l9VM+rA3OwU4zKOl8nMrWL/4PblKEvZcckX2BRj4bKp6tknLxBEkw
	 uK+8FVFSaA6I7r0o85RCRQmEcw3EY+Iz1rcPjtfazIJfnCN+Nqu6Cpo6rV6BbsKOLJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=zUHq5NyxFUrzso01TmgcB4KEGmoA4K/82o3rTfJeaeU=;
	b=oy4hUSYRl30JGSut3eRsnMcrxTUEPJvsl320rmXHGlrBHLGcnt5PJMc4VmYfWEHHmYFD
	 KfJPlklAI/nIV5rUu/CkUobk6ujUc6gjD9IIq9L5iKv8YjspzNOfa9Yrm1AOATceOJqOQ
	 sO6CEOhHASJTHta0hZq0PnXyqvIzinNKV8a/5RY+MB8nDckyZtQrQqVyNonEFpFb1zYG2
	 svSM6+9+UP1HHKADA5HGnQuxz7q/SvV5013UUqvbTiSeiDLM0d54o4a6poTgNo7wNrl3C
	 vzebkhnY8LE1RjmX59DZVUTFco5Le0Y75LB+tDILGpeGfkAfmo2nYFgLXdwo1jV988Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UA5bzGjs;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E8606A9A3
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754E8606A9A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UA5bzGjs
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36dbde64409so5978934eec.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380212; x=1794985012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUHq5NyxFUrzso01TmgcB4KEGmoA4K/82o3rTfJeaeU=;
        b=UA5bzGjsbhLDoh5ba0QCPKm4IcipFkkOUK1U7trxmhH+kx9g7vKkLskWrxqWrv4fvY
         azPlw6ebZFxOxE/ubgnXXJZISnj3Wze48jok9yFSATzjA6GdTXTOB97EGU13/rwbcpmD
         P4WxD/bKwnglXggs7/WyZX+oIm0qZNo6abAXqHcUevlKYbEd++zdcFbBhbUujfkD/oVe
         8lgZTeiw67hXWjHpxanvcsg7ZJ0XYfBctE2rLvwBLODz8MzeSmORZKoUbyvXzElHzRqc
         aPzga4rQQkkcyCUHyrvxPDirPi1e556ZTkkVk+D1HnkOFX16Fj2xoLIEfp3OCjMQHfy8
         hnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380212; x=1794985012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUHq5NyxFUrzso01TmgcB4KEGmoA4K/82o3rTfJeaeU=;
        b=kNK/n+349WmwUEEjLAoK027M4nd63WrhTzLWiJYfbnTkk5Hx91wzsCa+HXp+59jo5p
         hIn7heA44Or1Ry8+1DABgCacfoHUGRwKHXj4Bc/hZMNHaia1X4KIuv40TJqh4xlnYxkI
         Hfu42qLd7iRxfW7oGQc1hvgSKu0780KfvybgFtzpv5o23aIMtxjfoiHFoj5Ms6K8tc35
         cTJvkVFWy+0eeW6fT6rLmckYlLCAZFDTMVfj1qoks5dSlMazFz4w75U0fqEhaZeSuONN
         FdNdY2XWCmzs6fE/JGMix8OzdmLABGGGrMKQTTZjfv14qapqvVMJyfHaLErQt4ulTUel
         O9aQ==
X-Forwarded-Encrypted: i=1; AL+hErHXQFz513pFE42mcwVnRB5Icfihy/pOPg7AOtc7ic0KTBMwqj7XXXhIljeNGoHnFv8VpmPQRZyHoCCsQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9A+s8zWTXCsdc67Cf7rjUc83Darll5l+JeXjJUzPzptTeJwScx
	A+Fug6VeN9bl2+sM/HATDqHCbPVo3ARefwBeITNr5wwEinIyRTvK5eSo
X-Gm-Gg: AYBFou0xd4UF/encnkqKIH+dFzV5Ebc494Wa+Qya5bvZggTadIds+2iNqs50U5d29XU
	uMZSjlzw+A6E8s6VnVJr/b3WVpsSjMpuCoB0SJGqHpeYVxG/Tgrx/813WE/mGbloK2iG98bQcI6
	h8R00DJP2SM/5QJ7/0HpRHMtTH3Sx5vAx16wWNH6CRcXOj9Gh6kEkh2ztnLtFMHkFv26fFTg7aB
	Y0UEj/lTMB7GA5E8GGR/ZoWLxoMuwSl6Bdxa7Fu17STUddZskqvLDHwBqUNZ4GIRoXk2llR8fa+
	vIeTWv53JJhNCZoZfwCH6YCHA9OHUiMecQHeCKUCmlspg0rBi9Jx+rOyc8JzqpRV/bO3LQyHsEP
	LhLHlPFCcUURWpFf6cRPps8OwmCzGwye9wmCBsW56CzM1NC0Peqqntnp4yzotkP+qXMCFZVjHsK
	zukOkho/p8Zz+t9zVdKa9snTtxp1KHS/AQoIKRsBAGJpJWcKCUrtc/Jr60CCzsoclPaDAzNA6zr
	bnxPFqK4Ug+FnekOlxHu9tNPr1p/EUwQ1shP53IWCwsJdAJnvYwwiermFYMaqlNt49f2CLe3mLK
	bNcgG7y0Imj/SuI+blprk4ZaFf8UfBNLiYuH+ZMVN9fHil2TMRcxz12OK8tMI7L0EAmoO9Ndllj
	zkJJGwJIST8giy1cTNQ==
X-Received: by 2002:a05:7022:f503:b0:156:6676:d0e2 with SMTP id a92af1059eb24-1b3c08752f6mr1266348c88.10.1794380211294;
        Tue, 10 Nov 2026 22:56:51 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:50 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:16 -0800
Subject: [PATCH v2 18/33] HID: logitech-hidpp: rework G920 force-feedback
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
Message-Id: <20261110-hid-logitech-hidpp-v2-18-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

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
index cf42626ab98d..bad6739c618c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2341,15 +2341,19 @@ static void hidpp_touchpad_raw_xy_event(struct hidpp_device *hidpp_dev,
 
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
@@ -2413,6 +2417,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 {
 	struct hidpp_ff_work_data *wd = container_of(w, struct hidpp_ff_work_data, work);
 	struct hidpp_ff_private_data *data = wd->data;
+	struct g920_data *g920 = data->hidpp->private_data;
 	struct hidpp_report response;
 	u8 slot;
 	int ret;
@@ -2420,7 +2425,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 	/* add slot number if needed */
 	switch (wd->effect_id) {
 	case HIDPP_FF_EFFECTID_AUTOCENTER:
-		wd->params[0] = data->slot_autocenter;
+		wd->params[0] = g920->slot_autocenter;
 		break;
 	case HIDPP_FF_EFFECTID_NONE:
 		/* leave slot as zero */
@@ -2432,8 +2437,9 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 	}
 
 	/* send command and wait for reply */
-	ret = hidpp_send_fap_command_sync(data->hidpp, data->feature_index,
-		wd->command, wd->params, wd->size, &response);
+	ret = hidpp_send_fap_command_sync(data->hidpp, g920->feature_index,
+					  wd->command, wd->params, wd->size,
+					  &response);
 
 	if (ret) {
 		hid_err(data->hidpp->hid_dev, "Failed to send command to device!\n");
@@ -2450,7 +2456,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 				data->effect_ids[slot-1] = wd->effect_id;
 			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
 				/* autocenter spring uploaded */
-				data->slot_autocenter = slot;
+				g920->slot_autocenter = slot;
 		}
 		break;
 	case HIDPP_FF_DESTROY_EFFECT:
@@ -2461,14 +2467,14 @@ static void hidpp_ff_work_handler(struct work_struct *w)
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
@@ -2715,19 +2721,17 @@ static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
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
 
@@ -2736,7 +2740,7 @@ static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute
 	params[0] = range >> 8;
 	params[1] = range & 0x00FF;
 
-	hidpp_ff_queue_work(data, -1, HIDPP_FF_SET_APERTURE, params, ARRAY_SIZE(params));
+	hidpp_ff_queue_work(g920->ff, -1, HIDPP_FF_SET_APERTURE, params, ARRAY_SIZE(params));
 
 	return count;
 }
@@ -2746,13 +2750,15 @@ static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, hidpp
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
@@ -2771,16 +2777,14 @@ static void g920_input_close(struct input_dev *dev)
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
@@ -2788,17 +2792,22 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
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
@@ -2813,38 +2822,16 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
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
@@ -2861,21 +2848,10 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
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
@@ -3376,7 +3352,7 @@ static int k400_connect(struct hid_device *hdev)
 #define HIDPP_PAGE_G920_FORCE_FEEDBACK			0x8123
 
 static int g920_ff_set_autocenter(struct hidpp_device *hidpp,
-				  struct hidpp_ff_private_data *data)
+				  struct g920_data *data)
 {
 	struct hidpp_report response;
 	u8 params[HIDPP_AUTOCENTER_PARAMS_LENGTH] = {
@@ -3391,71 +3367,83 @@ static int g920_ff_set_autocenter(struct hidpp_device *hidpp,
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
@@ -4040,21 +4028,15 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
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
 
@@ -4633,7 +4615,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidpp_device *hidpp;
 	int ret;
-	unsigned int connect_mask = HID_CONNECT_DEFAULT;
+	unsigned int connect_mask;
 
 	/* report_fixup needs drvdata to be set before we call hid_parse */
 	hidpp = devm_kzalloc_obj(&hdev->dev, *hidpp);
@@ -4723,6 +4705,16 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
2.56.0.542.g3ef89b7020-goog

