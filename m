Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB34B7A3E
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156024; cv=none; b=UhOwhWPf2Lx5PelUuS1lai26zSIDZ2oaNM2cpNbnXOz/hoN6AA02d73k6j/wsM6kKenb7nO7cDq68elBogkTrn1jmHYrf0nHUnomwXioKyGMw18JsgYhvt76PaAtltCHjmhmAZZYxC3fImeIBWr2Wna8GcwedAyf1DElAhwbWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156024; c=relaxed/simple;
	bh=1ew6bbxlX9uOw73KIuj2b+3qsY9r0Lnu4XC3xe1vkZM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ac7QHTEH8M8zp10vSD/9FSqae9wbXJ335/zzcxQGrXD1jIKWev12E494UkIjmWAovGp98MykfrENkxu+o4OGA+X2qr3fx0MmURibonSZHG6hz3uZWVKl1+2I30h141tz66yguPxtsBzOETsvGH146W+qNmV/5kjx86z71eBiKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnjXyOkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnjXyOkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972EF1F000C8;
	Fri, 16 Oct 2026 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792156021;
	bh=jtcvZJSlLUNRaBcI2J/z8dZ6Iar6Hl4Kqt3kPz85Pgo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=CnjXyOkhfCDU5i2UqyNisylPGq/tA2lcJYZRSFsmHqaYC3W3rlqSAJYiHe0NYqrXk
	 ppy1ReJdIjxAryyKpe9wXdyBWFJhwYvsqt9S8dmmSMOhYmoTnUpW6o4nWzpDFIzMqF
	 3gTr7HfWj+r+71h2z4ZX+/08Vkp4pe8teF3VeVHe4RApgsxlO2gwamPzTnNxdRzuTj
	 YxRMH4+rYBtHRID6KihK+NUj4GPfKTeAocO9GeZOTEM9zu/jDJHJYDK6W6ZVqhGzsR
	 E065WYHTTFsrukvi1oRpY1xCvlq6pAIea6NoB1wKLwzHreMKfV31i2Y3KGctOAhiek
	 vtJ3lpQDGBZwA==
Date: Fri, 16 Oct 2026 15:06:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: synonym <20000l@pm.me>
cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
    "luke@ljones.dev" <luke@ljones.dev>, 
    "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: ASUS T302CHI keyboard dock (0b05:182f) missing from hid-asus,
 brightness keys dead
In-Reply-To: <OCupKvK8JTzwwSrGfH05iZGTNOuUCg3cPoiTlNgdDUUt24LbtaNYWciyGx1C90egfE2C8EdnANX7sXM6IwBh5xfycQNq-ji_xAuNLRAVvQQ=@pm.me>
Message-ID: <o1392s9p-6rrq-3179-289p-447n1703pp1p@xreary.bet>
References: <OCupKvK8JTzwwSrGfH05iZGTNOuUCg3cPoiTlNgdDUUt24LbtaNYWciyGx1C90egfE2C8EdnANX7sXM6IwBh5xfycQNq-ji_xAuNLRAVvQQ=@pm.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Jiri Kosina <jkosina@suse.com>

synonym reports: "The dock (USB 0b05:182f) reports brightness on the ASUS
vendor usage page 0xff31, usages 0x10 and 0x20, which hid-asus already maps to
KEY_BRIGHTNESSDOWN / KEY_BRIGHTNESSUP. Because the device is not in
asus_devices[], it is claimed by hid-generic, which ignores the vendor page
entirely, so Fn+F5 and Fn+F6 produce no input events at all - not even a
scancode. Keys on the standard consumer page (volume) on the same device work
fine, which makes this look like a backlight or ACPI problem rather than a HID
one."

Add the device ID.

Reported-by: synonym <20000l@pm.me>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-asus.c | 2 ++
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ec966fc0a411..42655a6d59d9 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1733,6 +1733,8 @@ static const struct hid_device_id asus_devices[] = {
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T302CHI_KEYBOARD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, asus_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 43bbddf84e61..63d69d49ee50 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -218,6 +218,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
 #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
 #define USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD	0x183d
+#define USB_DEVICE_ID_ASUSTEK_T302CHI_KEYBOARD	0x182f
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD	0x4b42

-- 
Jiri Kosina
SUSE Labs

