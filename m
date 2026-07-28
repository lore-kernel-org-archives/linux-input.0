Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECC47252D
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269605; cv=none; b=HBIzRgFlT36Cxmy26NGbVE5ROgksKwfYEa8rOaZcXpe8nCHr9EdXbF3YyJD27Gyymnty/xwKGODECl7q0NS/aX20haDFx6njk7lKrjXU3km4CXjJXk8hzEYtUQja8AdW8J7u/0vQJMWOH7rPzsvqNCTLTtTUsj6a3tvjYLGO8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269605; c=relaxed/simple;
	bh=4luG2hmpWyFJWkmKvZMDQSxL33SSuExPIm2+H7ranB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f0jmZ0WI9mZdL65PD2hkCail7/kFbaz7Kp9UIiF/qqPDpwPURSQbxoiLbKQOUx78N4BZzULXWFOGXGwKQV1FtVcTnBt9Mn6YgBN0/kOT5vGhtnvMca/Sfh6UMM4VKacbwHF4ZpRvwaFLpEoXQ3TRyqz4FDTNjunBp0WTNX7rpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/Y/BhAX; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/Y/BhAX"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb42a2f5feso160444a34.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785269602; x=1785874402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=th6oI5nehAiUicnacwkSW8h0p4JlZVK79nafq8BjjgA=;
        b=O/Y/BhAXmQjiE2RgccrnfUDs5nuM04fvKNqtRLvNRCRq7cDfX7jxl0lyUMLQqrxtN3
         lT3XPOfJ1zKTOCDU3hAcQncAAKmqBapp0F9tcetMScNWouGigvhp4Og5Znk7piiYQrVV
         P4K9xLIxpwq8dgWvL2bIlLoWVn5KS+0mYkjr8I7DjueGwO/5gksNbU0wUms3biV/nNlD
         zPTRy/usU5SCPUuhcjgvLxoutiBPOnbr6nYGklvt0CEK58EuQtK1Mq2OCBKVCaBCbm90
         BfqJ0V3hyR2mvB6DbGH6grWtMFPgJ/g9st86FWLnJYz1IyZbQrED2bMR9mwjRe+zp+p0
         qxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785269602; x=1785874402;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=th6oI5nehAiUicnacwkSW8h0p4JlZVK79nafq8BjjgA=;
        b=MSiZKokJOT79o9IJFGCPztOBQyK67RbqlAzYhZtdRfJy5Z6Rp/qTXL9LkKQuebVb7a
         SW5jUPVaw3K2yKvyaszEDO7SStiyy6eLWjCY87lK0+4XcczvHb0orQsHOV6SimeIiPcK
         Bfv7y9P9FP8sOpmCmZ0ZyQVHGZffNVxvNGiAvWtkG7chraOibt8NtPY3+LPvtkVf6xNf
         6WjuiC8NoLrcdCSoYmO59jVtBGcuCtCyd33W03wr7bo1iSAlm/i30OODmgwB5E8DwxpJ
         N3uNCa0elFhvSScwaSKY3xMGv1egwq0aPc43dmhFIbWAwR8OKz8lKkgn2qC08NL6tjOD
         NboQ==
X-Forwarded-Encrypted: i=1; AHgh+RpX+OeQRb8oqQ8zgClXlQrcavEA8DFg4VFsmc8VYQAMQdlxjvsH5J4mcmwJ0G5uo7ZMG91YZ1ymOWtPHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SzTtgI3UWauXE+7WqP09bvNtAnwFrbte35iV1Sjy+JHrsMIr
	TeB2PfGTJIMEU3YDziBzXhzhI1mQ+49JZ1v64dFCt0PNO+EBkayaGZXw
X-Gm-Gg: AR+sD10yTN9IEzJiC4zojGomoUsFHxynIhqTb+MJ9DaCgfKInDUNnVWaaiSp4UXncFI
	CrqphdtGhsuG48xz5CUbeh/fQ2f35HG5JnorOnKJvVpAejCHS8O9FpbLNV5AQpC50+0gp7nYZ79
	Xt1Zt2m9Tj1c3GRonSfer6JEvx9sCdC2ovwNfGS6WUuzrQrS4SgYO7ISINQLQmrfOcNCdfFFO5C
	hLxIKL6O9GR2vl2vIIVIIQIqW9/UmJT1TsSPl3WyCT+e3Nu6PB/Mnn4X6hSKwk8fHKd3145d2h/
	Cllzyet7lUzZbEadWHAJqMJGzjy+69m+FEY8EE8iwranddP4Wx4fD3kYoNiWvG0Bs8p/HmEA1np
	h/Jj4q94//8FmuL3b6bj8HH3VJUmlRXsUUGFEZsZhjDLis2uXd6RL60o3hMvMxpsgM0BOCA4sXZ
	+T9w==
X-Received: by 2002:a05:6820:61e:b0:6a3:2de8:797a with SMTP id 006d021491bc7-6ac969c9f5emr2159616eaf.11.1785269602011;
        Tue, 28 Jul 2026 13:13:22 -0700 (PDT)
Received: from desktop ([2806:107e:1a:2f14:d204:ec3e:fc64:563b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458867f39c2sm813742fac.9.2026.07.28.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:13:21 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrei Fed <andfed.net@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: [PATCH v2] HID: input: read battery capacity from its actual report offset
Date: Tue, 28 Jul 2026 14:13:09 -0600
Message-ID: <20260728201309.776026-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hidinput_query_battery_capacity() assumes the state-of-charge value is
the first byte following the report ID (buf[1]) and ignores where the
battery field actually sits within the report.

An Apple Magic Trackpad 2 precedes the AbsoluteStateOfCharge byte with a
byte of status flags in its battery reports, so this query returns the
flags byte instead of the charge level.

The device happens to make that easy to observe, because it exposes the
same cell twice: its report descriptor declares AbsoluteStateOfCharge in
two reports (0x90 and 0x9b), so hidinput_setup_battery() registers two
power supplies. Only the first one is refreshed by hid-magicmouse -- it
uses hid_get_battery(), which returns the first battery of the list --
and that refresh goes through the report event path, which parses the
field correctly. Nothing ever reports the second one, so every read of
its capacity takes the query path above. On a USB-C Magic Trackpad over
USB, on an unpatched 7.1.5:

  hid-<serial>-battery-144 = 100%  (Charging)      <- report event path
  hid-<serial>-battery-155 =   3%  (Discharging)   <- query path

Both are the same physical battery. A raw HIDIOCGINPUT of the two
reports at that same moment:

  report 0x90 -> [90 03 64]
  report 0x9b -> [9b 03 64 64 00 00 10 00 00 00 00 00 00 00]
                     ^flags ^SoC = 0x64 = 100%

The device answers correctly in both cases; only the offset the kernel
reads the capacity from is wrong. 0x03 is the flags byte (present,
charging), reported as "3%".

Bluetooth takes the same query path for its capacity, where the trackpad
reported a bogus near-constant ~4% -- 0b100, the FullyCharged flag --
regardless of the real charge.

Store the battery field's offset within the report at setup time and use
it when querying, so the capacity is read from its real position. The
report event path already parses the field correctly through the HID
core; only the explicit GET_REPORT query was wrong.

Devices whose capacity field is the first field in the report have a
report_offset of 0 and are unaffected (buf[1 + 0] == buf[1]).

Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
---
No code changes since v1, only the commit message and tags.

Changes in v2:
- Added Fixes: 581c4484769e, which introduced
  hidinput_query_battery_capacity() with the hardcoded buf[1], and a
  stable tag.
- Dropped the claim in v1 that USB is unaffected. It is not: the
  trackpad's descriptor declares AbsoluteStateOfCharge in two reports,
  hidinput_setup_battery() registers a power supply for each, and
  hid-magicmouse only ever refreshes the first one (hid_get_battery()
  returns the head of the list). The second power supply therefore
  serves every read from the broken query path, and shows 3% -- the
  flags byte -- permanently, on USB, next to the first one showing the
  correct 100%. That replaces the v1 example, since it puts the working
  and the broken path on the same cell at the same instant.
- v1: https://lore.kernel.org/linux-input/20260702192139.114809-1-pepemontfort@gmail.com/

This is complementary to the driver-side battery work in flight for the
same hardware [1][2] rather than a competitor to it: those enable or
adjust *who* fetches the battery, this fixes *where* the generic query
reads the value from. Worth noting for that discussion that
HID_BATTERY_QUIRK_AVOID_QUERY would not help the case above -- with the
query skipped, the second power supply falls back to bat->capacity,
which nothing ever writes, so it would report 0% instead of 3%.

The duplicate power supply itself looks like a separate issue and I am
not addressing it here.

[1] https://lore.kernel.org/linux-input/20260706175507.47288-1-andfed.net@gmail.com/
[2] https://lore.kernel.org/linux-input/20260714101235.99447-1-signshop.alec@gmail.com/

 drivers/hid/hid-input.c | 17 +++++++++++++----
 include/linux/hid.h     |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600ca..b55cbe7f6 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -432,17 +432,25 @@ static int hidinput_scale_battery_capacity(struct hid_battery *bat,
 static int hidinput_query_battery_capacity(struct hid_battery *bat)
 {
 	int ret;
+	/*
+	 * The capacity field may not be the first field in the report: some
+	 * devices (e.g. the Apple Magic Trackpad 2 over Bluetooth) precede it
+	 * with status flags. Read it from its actual byte offset in the report
+	 * (report_offset is in bits; the leading byte is the report id).
+	 */
+	int offset = 1 + bat->report_offset / 8;
+	int len = offset + 1;
 
-	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
+	u8 *buf __free(kfree) = kmalloc(max(len, 4), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, 4,
+	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, max(len, 4),
 				 bat->report_type, HID_REQ_GET_REPORT);
-	if (ret < 2)
+	if (ret < len)
 		return -ENODATA;
 
-	return hidinput_scale_battery_capacity(bat, buf[1]);
+	return hidinput_scale_battery_capacity(bat, buf[offset]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -593,6 +601,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	bat->max = max;
 	bat->report_type = report_type;
 	bat->report_id = field->report->id;
+	bat->report_offset = field->report_offset;
 	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	bat->status = HID_BATTERY_UNKNOWN;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 47dc0bc89..51b21f980 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -642,6 +642,7 @@ enum hid_battery_status {
  * @max: maximum battery value from HID descriptor
  * @report_type: HID report type (input/feature)
  * @report_id: HID report ID for this battery
+ * @report_offset: bit offset of the capacity field within its report
  * @charge_status: current charging status
  * @status: battery reporting status
  * @capacity: current battery capacity (0-100)
@@ -657,6 +658,7 @@ struct hid_battery {
 	__s32 max;
 	__s32 report_type;
 	__s32 report_id;
+	__s32 report_offset;
 	__s32 charge_status;
 	enum hid_battery_status status;
 	__s32 capacity;

base-commit: b7556c8e713c88596046a906c7c4385218d44736
-- 
2.55.0

