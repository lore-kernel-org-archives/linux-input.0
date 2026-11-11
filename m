Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380221;
	b=R5lE1n//3jbjgLcImttxtltev1FqWqhkz+XWpHAUAKZPDMoLfEUruIqhn+XuOj5ESO+2
	 rcaAvALYcLh1S84OPbzwU3haqZ3vY/vluvk9huLXFetM/pOwFjXvye5pf7DLOSo0DUh+n
	 RWabd5f8nR9RXUlQOdRNf/ByLBeBsnzLGoYwni4Miv7Q4OSQzUuRn7wNBnsw6vlZ4f/eE
	 G74CSajRqFOLZGxoJ22d7QlF3gz9PP9NrnBRyGHxA4U5GTUfZpu3/vdEyZJdNgQDkxabi
	 wbfeo2RJIXP6MBHf9sHlOV4bQk4i8hf1rhtxh62NcWjT1RzJMAr7j4uQclYEsjRegAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=XoV5PIcrw1Z3DaArO3kOYgwAVJdr5E7QgHxi/hx80C4=;
	b=XowK6d5cmrsLqfcqllV2EyOhfGuOYDlxdMrg1uhwYXXUNbe3x/dZfqGcTMsB6R6DAIVA
	 OiVpLVpPr0aF3+9lwD9eqYehQNj2Lig72KgCgxdnrVnR6QQ/eqSxd8Ulp9ZQX7myl7afx
	 MmU1SVMTjXFhSSuMMEK7K3J7BFCk2wzFv69X0QN8qa7ULakwn4WcXQuhvBQqadaxdwmUH
	 KoFHMa9bWbnXLpfm3o7Wk8uZ4nAJxqlM+CQRFm+xJHDFGBhpHzD88uFSxAyKuwGuMKlhD
	 ml3V3PgdMhIv7vfdticYqj1l3wm/22u2AjYuT3wv1cyp3GHBlk/FC7ThOt3yOBVGlTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C/NqzYfI";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F5606B7EE
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A14F5606B7EE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C/NqzYfI
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b244fb7fffso3533086c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380220; x=1794985020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoV5PIcrw1Z3DaArO3kOYgwAVJdr5E7QgHxi/hx80C4=;
        b=C/NqzYfIvN15W2YlCVQK77b7WL/gHElr/qGI/Rr4Pee0lip8JnTziZIL+R09Baf7vo
         84ClEXSfcyHhc3+4pDiYcKwsQ8+izLCCdAk/ew4xAGNGW0IOqFrhJ1o2LEvMnDkASCDU
         AMmfHO0Eb8bf5xQfpnhLiK4VQE0yoOl3Cbdmx4qVJlX+5hbh6OI1nT3j+q3jeoePykeD
         rgCDH7v421XgUOD27oTZDSyhWSy155uSrv5XXMWREWyLbl4etimXTd3FkeArFOcAl8fz
         +3UeBWb6LYDRbrTacVXnKOLKrdO6N/I9SbIhiHu8KqnRCtQj6Ux7TRId5QSMugV6LZnI
         clHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380220; x=1794985020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XoV5PIcrw1Z3DaArO3kOYgwAVJdr5E7QgHxi/hx80C4=;
        b=iVj+HZrJIdbnqQJ54+vK4amp5812BvfSab66+k+3aCztumW/eFPTK52/fC6a7cew+K
         odn7m7qzTVycfJKaixm9bFq+Eql1HQ7sJIg7RX7T5t2aBP4iSaAFGomULx+AzzuBdbsR
         i1EPSabi1gR/cggq5cbYLxYSFKocFCjz75YCdgsSX70CqDVE0bJtcJdDFhUErybkuno+
         TZ4ff1OsqduzwQHIrv9r5fAbZdl4lzi5OHv3/HUTpzjUDtQBW3or6qKmWWNz99LcWaII
         Soi0xFKxla2d/9tZWJrr2/pgpuzOQ9sT0mufRNOsrYrBRJXh/ifMrdxLXceYzJb9IulX
         Dw0Q==
X-Forwarded-Encrypted: i=1; AL+hErEWRR0b4Wv+vJFr0pg8ILdHchwmSX7ALXw7iTWM9s5pHS1J7J6TWedsllNXiTs9eAOpbAmR9WD0gBEdEA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8jGqCRF0wmfC7PztaC3qPpt27Ts03orsiHdcts0vYYeVGXPi2s
	oiLjm46WRvdze7N67s78x2G9ydrKqaOgIZzIm+fVjCd4VwESrpBlYNUWQs5V3Q==
X-Gm-Gg: AYBFou1LHAHWRLTKovgMPLIOEbAU69v1bzNZ2GwX9GfZfDxFGKgTv5LAkYfYxVcd9x8
	2kiADp94j7g06tq99nNy0ixibphmQbieX4jOxycWShVoZ5hnzxVy7fJao82OhXKpKxvU4a7Q0eH
	PB4dS/266XRfX6ov7IB137pbF/NSqJc7zsGPg2ydLOsZPsrDQXNn4Dcen+XtlS/q3wgdHCLKrfj
	T2sbcaieN5oUHtRzzhA5HPy4vPvV1FxwqcVcS/Qf9b8SRayYwiZLWeVxiBgzh3HOOIOUl1/rMDD
	LGAPRriIS3zArwx7Di3OwfOz/E3jvgb5C8DCYMt0s4lBOJNZQzHg3YU2OnwQTZ6Wu2WYhuuTASX
	8j1M7jm2WgXvztwaxTjVuN/MZLN2IksJLUVEPJSdQRDpXjzVENFI/jZgXrB+8pvcunMgp6uMPre
	P81Is+x3b90s4XiyqOaZnVL8V+07Tqu+EaycHRhykLLzzJwiGDv2GhvLLVtXMVe80LGlOYYpMJq
	mYBQA1bucgmag2q2MBrOvG8/DWL0Z0isulMOFl3JQj9JWC/EKoiBRy/2SbTIPT9dV+Zak7OK0dv
	c9plaZWAyfZsLo9MKcgz3DlLbg25U4ZysaXZHyH1re7UcVLq58dLMAydHDb8h3XAXxPay1YzFSb
	DBduq9KG05Vmvo6U9VX+narV3tDY44TmyCJZ096Q=
X-Received: by 2002:a05:7023:d0d:b0:1a1:8bac:c1c1 with SMTP id a92af1059eb24-1b3c02f06b0mr1632616c88.15.1794380219612;
        Tue, 10 Nov 2026 22:56:59 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:58 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:21 -0800
Subject: [PATCH v2 23/33] HID: logitech-hidpp: index G920 force-feedback
 slots by effect ID
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
Message-Id: <20261110-hid-logitech-hidpp-v2-23-30743e91d83b@gmail.com>
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

The G920 driver previously maintained an effect_ids array indexed by
hardware slot minus 1 to store the associated input effect ID. Locating
the hardware slot assigned to an effect ID required iterating through
the array in hidpp_ff_find_effect() on every playback, destroy, or
update request.

Reverse the mapping by storing an array of hardware slot numbers indexed
directly by the 0-based input effect ID. Because input effect IDs are
allocated in the range 0 to num_effects - 1, looking up a slot becomes
an O(1) array access and hidpp_ff_find_effect() can be removed. Sizing
the array as u8 slots[] also allows zero to represent an unassigned slot
because hardware slot numbers returned by the device are non-zero,
eliminating the need to initialize entries to -1.

In g920_get_config(), deduct the reserved autocenter slot count when
storing num_effects so that data.num_effects reflects the number of
user-assignable effect slots and can be passed directly to
input_ff_create().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ceaa57af6eab..9526286ba406 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2344,7 +2344,7 @@ struct hidpp_ff_private_data {
 	struct workqueue_struct *wq;
 	atomic_t workqueue_size;
 	u8 num_effects;
-	int effect_ids[] __counted_by(num_effects);
+	u8 slots[] __counted_by(num_effects);
 };
 
 struct g920_data {
@@ -2401,17 +2401,6 @@ static const char *HIDPP_FF_CONDITION_NAMES[] = {
 };
 
 
-static u8 hidpp_ff_find_effect(struct hidpp_ff_private_data *data, int effect_id)
-{
-	int i;
-
-	for (i = 0; i < data->num_effects; i++)
-		if (data->effect_ids[i] == effect_id)
-			return i+1;
-
-	return 0;
-}
-
 static void hidpp_ff_work_handler(struct work_struct *w)
 {
 	struct hidpp_ff_work_data *wd = container_of(w, struct hidpp_ff_work_data, work);
@@ -2431,7 +2420,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 		break;
 	default:
 		/* find current slot for effect */
-		wd->params[0] = hidpp_ff_find_effect(data, wd->effect_id);
+		wd->params[0] = data->slots[wd->effect_id];
 		break;
 	}
 
@@ -2449,10 +2438,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 	switch (wd->command) {
 	case HIDPP_FF_DOWNLOAD_EFFECT:
 		slot = response.fap.params[0];
-		if (slot > 0 && slot <= data->num_effects) {
+		if (slot > 0) {
 			if (wd->effect_id >= 0)
 				/* regular effect uploaded */
-				data->effect_ids[slot-1] = wd->effect_id;
+				data->slots[wd->effect_id] = slot;
 			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
 				/* autocenter spring uploaded */
 				g920->slot_autocenter = slot;
@@ -2460,10 +2449,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 		break;
 	case HIDPP_FF_DESTROY_EFFECT:
 		slot = wd->params[0];
-		if (slot > 0 && slot <= data->num_effects) {
+		if (slot > 0) {
 			if (wd->effect_id >= 0)
 				/* regular effect destroyed */
-				data->effect_ids[slot-1] = -1;
+				data->slots[wd->effect_id] = 0;
 			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
 				/* autocenter spring destroyed */
 				g920->slot_autocenter = 0;
@@ -2855,14 +2844,12 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	}
 
 	struct hidpp_ff_private_data *data __free(kfree) =
-		kzalloc_flex(*data, effect_ids, num_slots);
+		kzalloc_flex(*data, slots, num_slots);
 	if (!data)
 		return -ENOMEM;
 
 	data->hidpp = hidpp;
 	data->num_effects = num_slots;
-	for (j = 0; j < num_slots; j++)
-		data->effect_ids[j] = -1;
 
 	/* init the hardware command queue */
 	atomic_set(&data->workqueue_size, 0);
@@ -2883,7 +2870,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
 			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
-	error = input_ff_create(dev, num_slots - HIDPP_FF_RESERVED_SLOTS);
+	error = input_ff_create(dev, num_slots);
 	if (error) {
 		hid_err(hid, "Failed to create FF device!\n");
 		bitmap_zero(dev->ffbit, FF_CNT);
@@ -3461,7 +3448,7 @@ static int g920_get_config(struct hidpp_device *hidpp)
 		return -EINVAL;
 	}
 
-	data.num_effects = response.fap.params[0];
+	data.num_effects = response.fap.params[0] - HIDPP_FF_RESERVED_SLOTS;
 
 	/* reset all forces */
 	ret = hidpp_send_fap_command_sync(hidpp, data.feature_index,

-- 
2.56.0.542.g3ef89b7020-goog

