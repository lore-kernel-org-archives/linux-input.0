Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380224;
	b=RVW+GHBagCpFfKKbpzBdMQhf9mfDuV4MtReCWAHjP4oQQbTZ0JGsTtd7xGZNA1H/8+JJ
	 Xg/3G0AmE/A7LJAfaEyZw4aZtqHjTLmwG+W8yWUwBP+pQJg0QLJrh/PauVGr8GFhHhBEk
	 HdXxHbxQVqS1BffKB4ExHsZOrrv3I0hNshvzznHsX+zXU4jH3IpsBQG1J6MwJUFEKYPMi
	 L61A1JnONV/w3/0z5Cyj32xWyMrFxSGJ8sefA3SbU4wEA8qJefro9Tj/qnc+AmfQLEg4m
	 2gNGCw4TCVxqfd+e/ZOuM2Ywn+yk9Uk2g9e+KqKl7AyuurhFmS5VnsyoWvKI5bdYo6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=c+hkChxIouVHZtYIZYtCjRRp/vac+u0Vif+0cs2KiTY=;
	b=K5Ui+KxjDUiXXxx7OSurJD1DEZyzkywSozRLb/imDp0yDQmW4Im+v9gxX1rOGUutL0Ud
	 sLQ50ogJDsUsDImmGhQveJNxJ9yZB3UCKW9YNP/hQq3MhIy0BDsfMbLTMvumgRQPLctIV
	 rHbh1lXFQZdLw7W4N8nRakOYJ9DUf1t8ryw43c6fMSJI4Lldw04kNiKMGm+9gS4a5jgFY
	 iAjZALpX8oqA2VX5pjy4wXXcn9e25qJoZryRDgyfvwVIt3iFzvSsfzlH0u8yuVvlSkj9z
	 wIdgOKYLDc5nbQglqar0X9We6gp3PzxqIVF3UuxoRs9dzBeTSInyKPXwzwJwIbJIsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=za5w0TRh;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB65606B7F1
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB65606B7F1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=za5w0TRh
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so744962c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380223; x=1794985023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+hkChxIouVHZtYIZYtCjRRp/vac+u0Vif+0cs2KiTY=;
        b=za5w0TRh/YVPyKpQfVzi/SDFA8/rrKwJ/MtqZsF4Z1ksbREEo1dvbb5VzjeoVqnn0X
         RDobaoyno6NaikuDoS9trXMUNEoga2PLPDIX+7614ms+oesNPNLr/4afJLbfNZ7If29f
         RQ5/hRgZPTdEjAHzyxQR0eXqZXA9QurZuei+OSOBpigtC3dqkusMq7wAqZjEt03zwQA3
         UKkq0iYPRXj7RqHOjx2IVP9o9YTwnRpPjSZ+gaQDfRMvKYLnSUxktFC39mVqGMXmHzVR
         SzQ9jWCurvvu5l+z0UV1syK7riuD36UzT/yX9oFA9WIPKnahFOQkg3PI9RVg8v9MBImu
         wxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380223; x=1794985023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+hkChxIouVHZtYIZYtCjRRp/vac+u0Vif+0cs2KiTY=;
        b=GTo4/Rn17lq0/tjrt05KHAHKpFxBopOoebx1t0MEYtdaAPjQyReUvyWaW5kifoYzC8
         XOSozdUBWMVIy/qBqUZUpuzPXY1M3/XJnmoXX41aN857Fp1CGB2bzUeCmTDNE2Bibksj
         lOzf8qIXtC6Za/m7DnAGIc3lHCZaQzKok6ipDCPADLuNOoy3wy8AqTxUOK6h5JeRb4jM
         3e6y1StpIsNIdniC50O1202VMzXI7hvk/YRWm/PhEoCsFZ7uBrNOb6dybVfBsJK1n+wC
         PvVski6n+ei34hgGv6z2/yzIqR3Lxr2c25HSGBX/lIu7aZfln0U6inCJZdwM6ienlrZA
         AwLw==
X-Forwarded-Encrypted: i=1; AL+hErH8PQjRTp4M7ZuhG74lk0zpAB1lLuEOFhlOZTQLCKAIcBM2Dk+r7/gjlFmyWQcAsLjHWOg5l7bjvWT/Pw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9L5S1XOsmlLx9c/13s1ur1fxOQyaEhOBOG2rIlmxgJKTCyD5/a
	7Ua/L83RE0AU5jlmcRbmKPDDwCBUZioiXwjlTRZ9GEY7zq0vRLNb9h4W
X-Gm-Gg: AYBFou0Wivo8Prc8gnG21v7J2wqwjdgFYrFfHN1gc6kfKG2FhKc6vCzROxKD0scsQ5d
	+FweLwTTmxYpubVwtJ+VfnkjI0Qh5SA/dGzZu8y3heS6TR8DF8EQhuZ8tupgx9xzLTo0JB0Cm8s
	qLXaENx1pC8PZX8s4//waaVax/9uxLAnjdncmbMQWl/78etanvejtpmTcRpulHDSSxQHn4QF5wK
	2TxRLQGTk9Ytq1B4eXabZdrsxS0H0yaGREmzQWooa7jMlkNCwropvcH0gu4ACgbREKRLY4qnMIy
	bo+HzDTAOwtkQt6n812m2OII7+XRBvmO8Uf7UtMe8dYIWk/IXwm94kkM59w9fB1hSEepQ1ujEcU
	G1HM4IMiBwaOuhC0hQ1+1c2RukJHhkvabFbNsh0cttJem9zvaMeLZbhfhbTeNySVrIHwf8PLFVR
	RtMFhrs+VutkBalERcMq2SQSwAUmGpqawXjVMHzKyNFzOtWHNxOwAk1aKiIAnO3WgsZw8jkdsAb
	/HKVI9h4CXW+w0I963s3nKlnRAKoTVmelX1thxKvo7ONUAaCtvEkgj5ElNFP+k/hNlWqOq1TE7f
	ocGf6ALwbUhHbyETcceQUenwwjCMzSRAHCB8OlSJusOIP7T3lOZk2jMeRFR57v521WU2uczDPdU
	ESgI6ae/wEgy91NdHI95c+g2x8dqHN7ThCys3GBE=
X-Received: by 2002:a05:7022:ed02:b0:1b2:6a1d:bf58 with SMTP id a92af1059eb24-1b3c035280dmr1360043c88.38.1794380222952;
        Tue, 10 Nov 2026 22:57:02 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:57:02 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:23 -0800
Subject: [PATCH v2 25/33] HID: logitech-hidpp: clean up G920 force-feedback
 helpers
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
Message-Id: <20261110-hid-logitech-hidpp-v2-25-30743e91d83b@gmail.com>
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

Perform several minor cleanups across the G920 force-feedback support:

- In hidpp_ff_init(), obtain the firmware version directly in a single
  expression from the USB device descriptor, drop the redundant
  hid_is_usb() check on the already-matched G920 device, and remove
  unused local variables.
- In hidpp_ff_upload_effect(), remove the dead force calculation in the
  periodic effect upload case where magnitude is written directly.
- Zero-initialize stack parameter buffers in effect upload, playback,
  autocenter, and gain helpers so unused parameter bytes sent over USB
  are always clean zeroes.
- Drop the write-only gain field from struct g920_data, remove the
  unused HIDPP_FF_GET_GLOBAL_GAINS query at probe time, and remove the
  gain cache update from the work handler.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 43 +++++-----------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 20f7e8367ee1..1d80e7b7a99e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2310,7 +2310,6 @@ static void hidpp_touchpad_raw_xy_event(struct hidpp_device *hidpp_dev,
 #define HIDPP_FF_DESTROY_EFFECT		0x41
 #define HIDPP_FF_GET_APERTURE		0x51
 #define HIDPP_FF_SET_APERTURE		0x61
-#define HIDPP_FF_GET_GLOBAL_GAINS	0x71
 #define HIDPP_FF_SET_GLOBAL_GAINS	0x81
 
 #define HIDPP_FF_EFFECT_STATE_GET	0x00
@@ -2349,7 +2348,6 @@ struct g920_data {
 	u8 feature_index;
 	u8 slot_autocenter;
 	u8 num_effects;
-	u16 gain;
 	u16 range;
 };
 
@@ -2412,8 +2410,6 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 					  &response);
 	if (ret)
 		hid_err(data->hidpp->hid_dev, "Failed to send command to device!\n");
-	else if (wd->command == HIDPP_FF_SET_GLOBAL_GAINS)
-		g920->gain = (wd->params[0] << 8) + wd->params[1];
 
 	atomic_dec(&data->workqueue_size);
 	kfree(wd);
@@ -2453,7 +2449,7 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 	struct hid_device *hid = hidpp->hid_dev;
 	struct g920_data *g920 = hidpp->private_data;
 	struct hidpp_report response;
-	u8 params[20];
+	u8 params[20] = {};
 	u8 size;
 	int force, error;
 
@@ -2510,7 +2506,6 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 				effect->u.periodic.waveform);
 			return -EINVAL;
 		}
-		force = (effect->u.periodic.magnitude * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
 		params[6] = effect->u.periodic.magnitude >> 8;
 		params[7] = effect->u.periodic.magnitude & 255;
 		params[8] = effect->u.periodic.offset >> 8;
@@ -2617,7 +2612,7 @@ static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effec
 static int hidpp_ff_playback(struct input_dev *dev, int effect_id, int value)
 {
 	struct hidpp_ff_private_data *data = dev->ff->private;
-	u8 params[2];
+	u8 params[2] = {};
 
 	params[0] = data->slots[effect_id];
 	if (!dev->ready || !params[0])
@@ -2662,22 +2657,18 @@ static void hidpp_ff_set_autocenter(struct input_dev *dev, u16 magnitude)
 {
 	struct hidpp_ff_private_data *data = dev->ff->private;
 	struct g920_data *g920 = data->hidpp->private_data;
-	u8 params[HIDPP_AUTOCENTER_PARAMS_LENGTH];
+	u8 params[HIDPP_AUTOCENTER_PARAMS_LENGTH] = {};
 
 	dbg_hid("Setting autocenter to %d.\n", magnitude);
 
 	/* start a standard spring effect */
 	params[0] = g920->slot_autocenter;
 	params[1] = HIDPP_FF_EFFECT_SPRING | HIDPP_FF_EFFECT_AUTOSTART;
-	/* zero delay and duration */
-	params[2] = params[3] = params[4] = params[5] = 0;
 	/* set coeff to 25% of saturation */
 	params[8] = params[14] = magnitude >> 11;
 	params[9] = params[15] = (magnitude >> 3) & 255;
 	params[6] = params[16] = magnitude >> 9;
 	params[7] = params[17] = (magnitude >> 1) & 255;
-	/* zero deadband and center */
-	params[10] = params[11] = params[12] = params[13] = 0;
 
 	hidpp_ff_queue_work(data, HIDPP_FF_DOWNLOAD_EFFECT, params, ARRAY_SIZE(params));
 }
@@ -2685,14 +2676,12 @@ static void hidpp_ff_set_autocenter(struct input_dev *dev, u16 magnitude)
 static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
 {
 	struct hidpp_ff_private_data *data = dev->ff->private;
-	u8 params[4];
+	u8 params[4] = {};
 
 	dbg_hid("Setting gain to %d.\n", gain);
 
 	params[0] = gain >> 8;
 	params[1] = gain & 255;
-	params[2] = 0; /* no boost */
-	params[3] = 0;
 
 	hidpp_ff_queue_work(data, HIDPP_FF_SET_GLOBAL_GAINS, params, ARRAY_SIZE(params));
 }
@@ -2826,17 +2815,10 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 {
 	struct hid_device *hid = hidpp->hid_dev;
 	struct g920_data *g920 = hidpp->private_data;
-	struct usb_device_descriptor *udesc;
-	u16 bcdDevice;
 	struct ff_device *ff;
 	int error, j, num_slots = g920->num_effects;
 	u8 version;
 
-	if (!hid_is_usb(hid)) {
-		hid_err(hid, "device is not USB\n");
-		return -ENODEV;
-	}
-
 	struct hidpp_ff_private_data *data __free(kfree) =
 		kzalloc_flex(*data, slots, num_slots);
 	if (!data)
@@ -2853,9 +2835,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 		return -ENOMEM;
 
 	/* Get firmware release */
-	udesc = &(hid_to_usb_dev(hid)->descriptor);
-	bcdDevice = le16_to_cpu(udesc->bcdDevice);
-	version = bcdDevice & 255;
+	version = le16_to_cpu(hid_to_usb_dev(hid)->descriptor.bcdDevice) & 0xff;
 
 	/* Set supported force feedback capabilities */
 	for (j = 0; hidpp_ff_effects[j] >= 0; j++)
@@ -3462,19 +3442,6 @@ static int g920_get_config(struct hidpp_device *hidpp)
 	data.range = ret ?
 		900 : get_unaligned_be16(&response.fap.params[0]);
 
-	/* Read the current gain values */
-	ret = hidpp_send_fap_command_sync(hidpp, data.feature_index,
-					  HIDPP_FF_GET_GLOBAL_GAINS,
-					  NULL, 0,
-					  &response);
-	if (ret)
-		hid_warn(hidpp->hid_dev,
-			 "Failed to read gain values from device!\n");
-	data.gain = ret ?
-		0xffff : get_unaligned_be16(&response.fap.params[0]);
-
-	/* ignore boost value at response.fap.params[2] */
-
 	ret = g920_ff_set_autocenter(hidpp, &data);
 	if (ret)
 		return ret;

-- 
2.56.0.542.g3ef89b7020-goog

