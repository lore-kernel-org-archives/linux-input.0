Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225495;
	b=dT97Sjge8mo3ZRcoZnwDeRz+PweFu2juDZGJWhA0sfAkWdCYpdGpBowFexJm/+P0aLsf
	 UqoyZUlOXefOnGiErLTwFFd29pBBCCn4jiYZwbDEoyZvLlYHFjoumN0yqlaatAvoMMdzn
	 lZ7GT52bC0Iag3spYmQIJ/nCj/mzl3qOjuzo5rsdJkBX5qtM5+qeM8bHuP8dUihN/Udg/
	 rAmpsIxRB73KRpoANwsXlMHMCu6LMKlvFolliyo79FmJvwVJo+/WOb95/ZWbh2K/HgqYG
	 XxYlf8kDk2OjMz1bDcrmMgKEEtiYajxcTeeoTfRQhhKqufQJeuFCIUz+vbhcvegFvyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dR7rNSd7I0CJITruwcGeZYyM9gU61ZrWyy7h4McZSok=;
	b=hu97drrTi8t0+6N0MWg4kmZlUie7GKi3SOYKsgrB9CJN4z/dQA6Uon5aAHsozqAFkUBq
	 0iOeotdsAsIjrwjR2qKgHl7KXViyolA/u9UlK0NzNJKWvwOV2kOa9W1Z7JIH5gdwmOdpR
	 acsxdw8WII9cfmVQIzdxtPDmV69/96ENj2Wlfye/zYBypTwqBdwo3o6A7vYfQlLgmoIIG
	 Ta6ik1gwzOyA/eS1z20xgGsRZwwgjJTqAynWUZqcEolPykeX4dp+RfmjWaAL6mfPPTbOb
	 /JvGwRLgIgPMnh/3RmV9pjrWRTzvG0o9vIdOQHg5K6CR6z+fqfrb/WyLCUceGIOkvbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdxuZwdy;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A5606A332
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 01:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B56A5606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdxuZwdy
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a315ed211so1676625eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795225492; x=1795830292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dR7rNSd7I0CJITruwcGeZYyM9gU61ZrWyy7h4McZSok=;
        b=WdxuZwdyai6RM01DgH6zzrBEEoCIcsCnJ0vAbTBSFfRiSldeJGBTMiTtSznCAfTdYs
         6Xjl+FBaFHNazYDVn8Yyuqh/lMP4lt9EtLPJkZbAnD0Hf2eb2xMD0/VX0kBzzC+LeHLj
         fgkIv7zqQj3uTEbFr0Vn8xTmiORihT7t6IQMBX1Q6Wn6SoNQLNHSi172thy/DQOMDy4Q
         YpWOUOl6OmkXkM9EnwGFLcg/wtkvxo335JTRWcfBNzVrMDNvIZJbbZDTcnBFYAcV2NyK
         /V2YEuPSY/U5l1jbg4XoAWoNXiaLllFsXzJUwaKVVqeC2yBRc+AVPoAhDGZLspuHoz0p
         YkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795225492; x=1795830292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dR7rNSd7I0CJITruwcGeZYyM9gU61ZrWyy7h4McZSok=;
        b=HagHQwycDaOIl4r/+TMRRD3s5pW7b8zUY2EG7vH4bHfB3nrIhPUZDoJiVl7eu59AhV
         UIeGNxu5Ot/13IG0GdvphaqRRNZ0DfstmEkQL2c8z4gV2yxX/x+d+l1SBgaXOc/RRlSw
         s/6Y50EacDctdpHDe/6NxCqUU9n/iSCBgU3i53ERY6YurEg21Q+NwkMR7cHBTd4nOfZc
         sswecVZSRuHMf0Ohq/fk/GghbXiCwxCAn0bRyb50mhBz9cNRDypTKywHyEX8eYq43vI6
         fxiutP1ZTwS3LAmrHEfToLqOvzldXAmk9V/r679qt5LIRh6RVvgMqmhTY5QZmktdYuMf
         mhDg==
X-Gm-Message-State: APuU4Z8o8ssUC01s34nnIVaWT8ShHGSjuqRqGmUxaMFemY+pqti6gYFK
	cUolpHWJaRrAsTUpdi6oMD8VUVbKWi25Kq6yUcb6uYm0uWOa6YDtXu0w
X-Gm-Gg: AYBFou27A3a4J2WDw/bC1bx0RRNy7FMGVdgeKyjSmrBuSm5YBlXRXLrIx+XMv1u6SOg
	ZghtoYxUovXsAPYkizwIuYeFunio2YWUJKvAhSB9oimnlZ9qe2QJWBUNxGdp+Say07mP3PH8oYA
	U7XgLw7bvZDb7wBzfTqOv8pIwN2O6hF+464/nMZeLBmd6PY3zd78xuy6nO5ddJnE/R1TNpIaDf4
	RK0iyVZWP6gxBykS37IUE5T55JAZeJiVChGDuTbfVsTj9LsJ/0x0YQ4bemKelDbLD4Nt8+u3tD4
	vASgFax5Zum56vsPi8W+0t5Ir/mOjpToGAonWslZYlJOSIqq7gYRnOnQzsAz+yj0S9XVdGOngzC
	aZAyy13XmwPuVvllv05rdHzpjwfzAJukbwAySUnLIW6pTHePzfJ6hlg2bdDqyjkcuVhdT9bJldx
	18l6EtrZ9eSjiy9V7FXLWZdbs6RH8NIH4oXcJ97ogf/UA5+zBeaXAFsgJm9Z8Fnh6g9Ebvwx7qa
	s3E8PZe5oU7Yrk/OzmsL+COeyZVgxHU2vOMKusm3Qo7MHTJ9KZYlpYoPJa96f0g0XZzYrZ5u+Pv
	9mGRnmKW1z8UKaL/xenRGwIyI2QWqLvN/Zqe2ZW2pODiIirc3MlT1vPoSgGR7q6WvWAB5tvZmW4
	C8gvo5gpDhEz06Zbnr0wfUKymDvMjqgPYNY9cfXcIX4wqrhN1AfEpmTr0axiOziiEjA==
X-Received: by 2002:a05:7301:8616:b0:385:9424:5c08 with SMTP id 5a478bee46e88-38594245c66mr5030135eec.4.1795225491760;
        Fri, 20 Nov 2026 17:44:51 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([14.137.24.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm12724247eec.22.2026.11.20.17.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 17:44:51 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Rosalie Wanders <rosalie@mailbox.org>,
	Brenton Simpson <appsforartists@google.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [PATCH] HID: sony: fix DJ Hero PS3 turntable input mapping
Date: Sat, 21 Nov 2026 14:42:58 +1300
Message-ID: <20261121014257.1630667-2-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DJ Hero PS3 turntable mapping has several problems:

 - The cross fader and platter button vendor usages are swapped. The
   cross fader is usage 0x2d and the platter buttons are 0x2e, so the
   cross fader was reported on ABS_RZ and the buttons on ABS_RX.

 - The platter buttons are a bitmask in the low byte of the field at
   byte 23, not an axis, so exposing them as ABS_RZ is not usable.

 - ps3_turntable_absmap only has entries for Z and Rz, so any other
   Generic Desktop usage below its size (such as the unused X/Y left
   stick) maps to ABS_X (0) and clobbers the left platter. The hat
   switch is above the array size and gets ignored, so the d-pad is
   lost.

Map the usages correctly, following the layout documented by the
PlasticBand project. Report the six platter buttons as
BTN_TRIGGER_HAPPY1-6 from a raw_event handler, let the HID core handle
the hat switch, and ignore the unused left stick and the unused fourth
accelerometer field.

Fixes: 7245b0017d12 ("HID: sony: add support for more instruments")
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---

Notes:
    The fix was ported from an out-of-tree hid-sony build, and the port and changelog were written with the help of an AI coding assistant (Claude Opus 5.5). Build-tested with W=1; checkpatch clean.
    
    Runtime-tested on a 7.2.11 kernel with a PS3 DJ Hero turntable, using an external test harness that sends each of 20 input cases, reads the resulting events back over evdev, and checks them against the expected codes and values. All 20 input cases matched.

 drivers/hid/hid-sony.c | 95 +++++++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 20 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 228e74819037..574d3ff3dfb7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -94,9 +94,17 @@
 #define GHL_GUITAR_POKE_INTERVAL 8 /* In seconds */
 #define GUITAR_TILT_USAGE 44
 
-#define TURNTABLE_EFFECTS_KNOB_USAGE 44
-#define TURNTABLE_PLATTER_BUTTONS_USAGE 45
-#define TURNTABLE_CROSS_FADER_USAGE 46
+/*
+ * DJ Hero turntable vendor usages, for the 10-bit fields at bytes 19-24 that
+ * are accelerometer X/Z/Y on other PS3 devices. See
+ * https://github.com/TheNathannator/PlasticBand/blob/main/Docs/Instruments/Turntable/PS3.md
+ */
+#define TURNTABLE_EFFECTS_KNOB_USAGE 0x2c
+#define TURNTABLE_CROSS_FADER_USAGE 0x2d
+#define TURNTABLE_PLATTER_BUTTONS_USAGE 0x2e
+#define TURNTABLE_UNUSED_GYRO_USAGE 0x2f
+/* Platter buttons are a bitmask in the low byte of the field at byte 23 */
+#define TURNTABLE_PLATTER_BUTTONS_OFFSET 23
 
 /* Magic data taken from GHLtarUtility:
  * https://github.com/ghlre/GHLtarUtility/blob/master/PS3Guitar.cs
@@ -438,9 +446,17 @@ static const unsigned int rb4_absmap[] = {
 	[0x31] = ABS_Y,
 };
 
-static const unsigned int ps3_turntable_absmap[] = {
-	[0x32] = ABS_X,
-	[0x35] = ABS_Y,
+/* Platter buttons, reported as keys by djh_turntable_raw_event */
+static const struct {
+	u8 mask;
+	unsigned int key;
+} djh_turntable_platter_buttons[] = {
+	{ 0x10, BTN_TRIGGER_HAPPY1 }, /* left green */
+	{ 0x20, BTN_TRIGGER_HAPPY2 }, /* left red */
+	{ 0x40, BTN_TRIGGER_HAPPY3 }, /* left blue */
+	{ 0x01, BTN_TRIGGER_HAPPY4 }, /* right green */
+	{ 0x02, BTN_TRIGGER_HAPPY5 }, /* right red */
+	{ 0x04, BTN_TRIGGER_HAPPY6 }, /* right blue */
 };
 
 static const unsigned int instrument_keymap[] = {
@@ -662,32 +678,68 @@ static int djh_turntable_mapping(struct hid_device *hdev, struct hid_input *hi,
 			  unsigned long **bit, int *max)
 {
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
-		unsigned int abs = usage->hid & HID_USAGE;
-
-		if (abs == TURNTABLE_CROSS_FADER_USAGE) {
+		switch (usage->hid & HID_USAGE) {
+		case TURNTABLE_CROSS_FADER_USAGE:
 			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_RX);
 			return 1;
-		} else if (abs == TURNTABLE_EFFECTS_KNOB_USAGE) {
+		case TURNTABLE_EFFECTS_KNOB_USAGE:
 			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_RY);
 			return 1;
-		} else if (abs == TURNTABLE_PLATTER_BUTTONS_USAGE) {
-			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_RZ);
-			return 1;
+		case TURNTABLE_PLATTER_BUTTONS_USAGE:
+			/* A bitmask, reported as keys by djh_turntable_raw_event */
+		case TURNTABLE_UNUSED_GYRO_USAGE:
+			return -1;
 		}
 	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
-		unsigned int abs = usage->hid & HID_USAGE;
-
-		if (abs >= ARRAY_SIZE(ps3_turntable_absmap))
+		switch (usage->hid) {
+		case HID_GD_HATSWITCH:
+			/* Let the HID parser deal with the HAT. */
+			return 0;
+		case HID_GD_Z:
+			/* Left platter velocity */
+			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_X);
+			return 1;
+		case HID_GD_RZ:
+			/* Right platter velocity */
+			hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ABS_Y);
+			return 1;
+		default:
+			/* The left stick is unused */
 			return -1;
+		}
+	}
+	return 0;
+}
 
-		abs = ps3_turntable_absmap[abs];
+static int djh_turntable_raw_event(struct sony_sc *sc, u8 *rd, int size)
+{
+	u8 buttons;
+	int i;
+
+	if (size <= TURNTABLE_PLATTER_BUTTONS_OFFSET)
+		return 0;
+
+	buttons = rd[TURNTABLE_PLATTER_BUTTONS_OFFSET];
+
+	/*
+	 * Synced along with the rest of the report by the HID core, which
+	 * still handles the rest of the report as usual.
+	 */
+	for (i = 0; i < ARRAY_SIZE(djh_turntable_platter_buttons); i++)
+		input_report_key(sc->input_dev, djh_turntable_platter_buttons[i].key,
+				 buttons & djh_turntable_platter_buttons[i].mask);
 
-		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
-		return 1;
-	}
 	return 0;
 }
 
+static void djh_turntable_setup_input(struct input_dev *input_dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(djh_turntable_platter_buttons); i++)
+		input_set_capability(input_dev, EV_KEY, djh_turntable_platter_buttons[i].key);
+}
+
 static int instrument_mapping(struct hid_device *hdev, struct hid_input *hi,
 			  struct hid_field *field, struct hid_usage *usage,
 			  unsigned long **bit, int *max)
@@ -2288,6 +2340,9 @@ static int sony_input_configured(struct hid_device *hdev,
 		sony_init_raw_event_handler(sc, rb4_ps4_guitar_raw_event);
 	} else if (sc->quirks & RB4_GUITAR_PS5) {
 		sony_init_raw_event_handler(sc, rb4_ps5_guitar_raw_event);
+	} else if (sc->quirks & DJH_TURNTABLE) {
+		djh_turntable_setup_input(hidinput->input);
+		sony_init_raw_event_handler(sc, djh_turntable_raw_event);
 	}
 
 	if (sc->quirks & SONY_LED_SUPPORT) {
-- 
2.56.0

