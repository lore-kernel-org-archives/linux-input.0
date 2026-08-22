Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39015493650
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787400586; cv=none; b=BUsS+z77bYKmrpEwo+9HIvCPmY/jRODFU3FFlA5iaptzhe/jCE329EyzVv3vhnidU9tSh+B8vEY/MYCu/o+ZWbgk4WPCOSojJYOsZ6WSJI/LfrwHxqYHQSY1V/VzwjO4c6QotrVs6RPZ5/8UW6fiayd+nWEm3bDec7FG/3YeCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787400586; c=relaxed/simple;
	bh=X1gs4Rva48xs0lcq8cHDkmtAyL1/AiKJnqkvkBF40+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCt57as5mIxRQ9i96mjjGn5DMi8buD47l3c6onS2/xdMbeTzdXk8417rJhdBYTv8ygWt8M7Dv2APkKveHMeoSqF+95nDQIK/80EpCoUkIOh3pt4mi1B31JQhgqTVVREI7grlE1ObVCamv9QLB6SNjFJCwn9JLEkql+eBX/O74jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI4jbV/+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI4jbV/+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8518d5ddaabso1413418b3a.2
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787400584; x=1788005384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iq05ZZV6+TyT8orO7GiiiROR88YN4CoCixnRT+X/gZU=;
        b=mI4jbV/+5n7r8oClgNIkx+NFbA8W4HjRNtNTxrMeb9ABTEXzmDvMlrEoMFIB5YWo+4
         SlFeHSQr1NOrcAVp/+jhhmj8MVP4RHF0nXXOvzbN6t4e0mYBRsi5cS+RAz80gKmFlgrQ
         wev5EqGnM330goiVOas5YmquPW0xAFzJJzgLaIQJ9pZVxJzgVIkkO38aqM6SovrXBcSD
         QnoZRDl7AmIEqksCzccEiGQyMdEIeVBqN7PS/0x6m/C6LwpjrM5VWCX4CD5DdemGpNYh
         Ur7gpQ7i6GSxyAfCPdyJtwCUsjgBb8ILCmn/eRcpBYsMycZXuf+qUl0f68cdVaXrCwDO
         Fe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787400584; x=1788005384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iq05ZZV6+TyT8orO7GiiiROR88YN4CoCixnRT+X/gZU=;
        b=G2zTkWFBT8vch/NyOzV8xeC8Ye3piVQAmAEOQfunLmBL4hH22yyST4zMytghMmJbsa
         8kAMNAPpnb/1SGrRYFwYgyirZ5+vPmEZH6UKQcugBQwuwLFWAEgvk9cxT/kxDLVxuy0B
         Hc+SvdvOu6Ib1LltwRusZ8raJypxcL939QxlhHavOeuXPNoyhKzmY3veQOrXSn3dRIGs
         b/b1tI8RX8pL0souUyy4WWgoK5DmOERAed6gPnH8kGp/E0FQMIH79P7NRPYqVe8uxP+e
         vrsiK2noe2lA2P96BGsuTAloxZpy1rKyaHEBq0OwovVSkEkLe0GWbAQYCISDTHE95TVz
         FPMw==
X-Gm-Message-State: AFuF++mn+ZLoN9IQmAAawGcJE4oGj2ESijSBp6vNKx/EHVvbKmdODwBa
	VnDAvtK31rbSDzKlUqIYK7D/ePpOJlWw2ZOD2nNRUjQ+nG+wHuANhMFT
X-Gm-Gg: AR+sD11I7P7dmCWBgOVLjoTKoIHemc/33OvzO3V5fkvaPaVDq9oOUcHcwOlALR8ySpN
	DK90TVTPliYCdAzfbBTYzZxT+Fa0uGDDCvPeJptBf5udpn+9EBSx1cQGQNdq403H0xQtJUXhLZa
	TyUuUi44bdsM9DkbDo54+NSrwD2F3Zdlglq0P6o5Ip+Pz+YUkaUrtIc35ISPUsQyqKFPDDa2/UF
	holj+3IMBCV4OvZtxxq2ZKfX/bEGXKevy6LVitFtnV+BOweyC8F4fhlgdLBOfpfkEmafYcSsMXY
	EocjYKEI2TSwJE4mClhE6vPeUr1FkPdQv+TMqKDt1581QR2DCfEkcoVwTe3lIcxcCmDOBX/heCw
	K+c2YwlFgQAXR6DTJL0WYcKe+Ijv45pjaQDE5+IxMnR+1wCD1UBBvYAStq0gvkScwri5/3hBunS
	toouc17J3EpTJBVlbariR7tL4kjhy1czHgLsxmJX9aGS2vDKBmv8/DStxtZVcOnFMAJvK9FDNlZ
	ouLKNSpIhC4l5TFVmeVl3p0kBQz3u46LPOS2NImAg7CNnCzz2LF9nHNKI8QHxcfBR8QXMehcuV7
	HWkNA/iBmGsNpMs/1nHPz+30
X-Received: by 2002:a05:6a00:39a1:b0:847:93f3:a4b6 with SMTP id d2e1a72fcca58-851fa0667d8mr19516948b3a.17.1787400584464;
        Sat, 22 Aug 2026 05:09:44 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eedccb1sm557171b3a.8.2026.08.22.05.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 05:09:43 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Sat, 22 Aug 2026 20:09:26 +0800
Message-ID: <20260822120926.153849-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_wac_pen_serial_enforce() iterates over a field's usages (up to
field->maxusage) but indexes the report bits by j * report_size:

	for (i = 0; i < report->maxfield; i++) {
		for (j = 0; j < report->field[i]->maxusage; j++) {
			...
			value = hid_field_extract(hdev, raw_data + 1,
						  offset + j * size, size);

In hid_add_field() the usage array is sized max(usage_index,
report_count), so field->maxusage can be far larger than report_count
when a descriptor lists more usages than its Report Count.  A field
declaring Usage Minimum 0 / Usage Maximum 0x2ffe with Report Count 1
gives maxusage == 12288 while the field's bit region is only 8 bits
wide.  The extract at j == 12287 then reads bit offset 12287 * 8, i.e.
byte 12287 of raw_data + 1, roughly 12 KB past a 2-byte received
report.  __extract() performs no bounds check.

The value read that way is stored into wacom_wac->serial[0] and can be
emitted to userspace as an MSC_SERIAL event by wacom_wac_pen_report(),
so this is an information disclosure and not just an out-of-bounds
read.  A malicious device only has to claim vendor id 0x056a for
hid_scan_report() to place it in HID_GROUP_WACOM and have this driver
bound to it, and a single crafted input report is enough to trigger the
read.

Clamp the inner loop to the field's actual report region with
min(maxusage, report_count), so usages that have no report data behind
them are no longer extracted.

Verified on v6.12.104, whose wacom_sys.c is identical to mainline here,
with a UHID reproducer and with an emulated USB device (raw-gadget): a
hardware watchpoint on wacom_wac->serial[0] fires with an out-of-bounds
heap byte while a 2-byte report is being processed, and no longer fires
once the loop is clamped.

Fixes: 83417206427b ("HID: wacom: Queue events with missing type/serial data for later processing")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
The reproducer is available on request.

Compile-tested on bd5f485f3f02, x86_64 defconfig + CONFIG_HID_WACOM=y.

 drivers/hid/wacom_sys.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..1ea8763b68a8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -113,8 +113,10 @@ static int wacom_wac_pen_serial_enforce(struct hid_device *hdev,
 
 	/* Queue events which have invalid tool type or serial number */
 	for (i = 0; i < report->maxfield; i++) {
-		for (j = 0; j < report->field[i]->maxusage; j++) {
-			struct hid_field *field = report->field[i];
+		struct hid_field *field = report->field[i];
+		unsigned int count = min(field->maxusage, field->report_count);
+
+		for (j = 0; j < count; j++) {
 			struct hid_usage *usage = &field->usage[j];
 			unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 			unsigned int offset;

base-commit: bd5f485f3f026225b86573e559af0b7254ef4184
-- 
2.43.0

