Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E03B4EA9
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968355; cv=none; b=Rasw9LOvmBEW4ugRqUhmDQwFGovf1BFE1gKLDEpuJkdtU8XbjCveQcsXey8zw6UKdHQfFip3QaYL7apK4axW9OSoehSY2uZ3shAXj7g4uPXLsrUf5o4qUbO4pOcFFwth8CpijddfmLlXN/0F7gziLoABZbQ28szgdGoPSBg90PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968355; c=relaxed/simple;
	bh=VM0olKhJIj/KPcr8is/HllNc6teoAT1UAh+C09EaggU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnb+QQpsgyhXwm1Zs/93AjryNTl91aRmHryKBswYkuP9dsWK4bUxJxeYWmzx3IR4ZCrZCXSZstmO3YOD1DAk51U/jmlupkK+F9kZv+rMLRsfdRdqcyN5Hcyw/M5WM3NFtCU0C+xuYEpMmU41G2I0XB/O/Mvmuzl8zixJIk8ttHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qniVcs8g; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qniVcs8g"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8111c0c7561so39644307b3.3
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 05:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786968353; x=1787573153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXg9QhzRvt3h4R8IIbnQcvHTKkm/Kk3Du4OqBCUAo78=;
        b=qniVcs8ge2zvXrVHS+R7oxpFF4EVkLKynuWMyWDxFQG19r1BEd+mPa0D3qCNTas5ht
         hozHL7DbnuLp1C3hrOnZX+Prd7w8Vh5YWZ/ouDu4JD359/EuGcyeqq0qxfaOgGvGDUtb
         ZLxX832kToZb5AQDL4mkn0ajWt2SNbXRxEFfUWcZ85Ubr+1d1xQIbc0iE4LL84dA9aVu
         TUvO8vfVeXJvzJPtDHvva46dTA7daM5ELQWjMNOBHjjy03SI7EATxRw3gXfbvkn4409/
         QA9qEFB7IvsTh3FCaV1XGMAlB85LI5/103Ni7BP9LvzotzC/solUP5ibpOMZMtfZRjps
         aGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786968353; x=1787573153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXg9QhzRvt3h4R8IIbnQcvHTKkm/Kk3Du4OqBCUAo78=;
        b=UREM3/KzDktaGKJs+MY4WFcM56wcFRnK3RvMpMAdU7TyXgHbuArjjPVA1YPMJoOoTP
         vCUzlUXonCdkNlbNZrCT1uudKsk0Dw5SHnZply72dnvN0MoRRH6fHKJa2vHHwENyw4Fv
         UCIATbh4dSdMzu+CCL+/RI2ZjdCb2R7LhNjNAqxjTpDd0aXXsmiLVuQARbebyPRU2x8S
         mU2j/XD6NNaI+8RxDSrNrwo3aBeTHdgW7X0bw6fcnsHM9YiiDNNgM5JJj3ZWYlgWuAWs
         vKazrCOqLyCKku0V9y/Gn5VcNmZuiJNoyqp9CWIMxT53+dvYH39ArdczkqEGW5NtnEAv
         zUPg==
X-Forwarded-Encrypted: i=1; AHgh+RqNwYZWk7djHRqVKJKdnImX5dYFMLHa2N/sSfjpBi4okF3r6JZasEEZpv0vA6QgxDRcR6TttO6PmbfdbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3WCsBVNIioVgda43N+5VYxVk/6tADKunpUuhMHJwbrd1Lzq8p
	0fdzj8RUQDNMeodPqK54HBBtysWWwQZKERVRCrdjTWsjzebd8UaF8gGB
X-Gm-Gg: AR+sD104Gx7OpQU4u5uF5guCczkEEFSHxqJ7+bn1OiAkO3KpHA2idZTirAV6zrZF276
	MLFi2d/qMUhxEEkM2aFRBT9gsSjJPSoXhPAO8/MpQUTFqjf8gYTPHHWyn+AoTrRwtjtgTEy1/Kg
	R3sU2jmtda404t+iJ5PT8Da4Ow3zqls7H2K0fctSdqNAqQJ7+re7SIYuITEy88D/QxiWvJh2FCl
	fYpoKnDNfiXv9X3pNQF8+at8xiu/TlCkoXmsMf+IRkqWiFWX035oSe45MZyFLSdroZPSOSDkm00
	WlxrWMmOyWepqGuOUJqKtx+jAf+VZLiWBii2KI3lPM/L5VrrjvD5hPW14ijewkbkUvHq4fok0Si
	ned7jLQjNhDbQd0tmUzbjePvV+cwoUGe4fdkv9sH7cJowEGvJkosoDUOu+OCNzg8o2Bo+MYlO4i
	suRywCkBU/6ivYOd6hhkMCW7YDkeRaB4j6KwconiQxeQvxVRt3QS98VS0t7RP3ZzxdhLwOhVX14
	q+Y2J1EBVxiu1Hs+UbGPII=
X-Received: by 2002:a05:690c:6606:b0:820:1014:526a with SMTP id 00721157ae682-84131a3f4bemr595017b3.29.1786968353468;
        Mon, 17 Aug 2026 05:05:53 -0700 (PDT)
Received: from pop-os.. ([2806:2f0:5681:f856:da65:c1ed:fade:bdcf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f25c13f3sm1599267b3.26.2026.08.17.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:05:53 -0700 (PDT)
From: Oscar Priego Verdugo <oscar.priegov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: YOSHIOKA Takuma <lo48576@hard-wi.red>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Priego Verdugo <oscar.priegov@gmail.com>
Subject: [PATCH] HID: elecom: fix bus type for M-XGL20DLBK
Date: Mon, 17 Aug 2026 06:05:46 -0600
Message-Id: <20260817120546.273232-1-oscar.priegov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M-XGL20DLBK is matched as a USB device by hid-elecom, but
its entry in hid_have_special_driver[] uses HID_BLUETOOTH_DEVICE.

This prevents the special-driver quirk entry from matching the USB
device handled by hid-elecom. Use HID_USB_DEVICE there as well.

Fixes: 55633e681afb ("HID: elecom: add support for EX-G M-XGL20DLBK wireless mouse")
Signed-off-by: Oscar Priego Verdugo <oscar.priegov@gmail.com>
---
 drivers/hid/hid-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 57d8efdd9b89..0ad8ca20cb9d 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -422,7 +422,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #endif
 #if IS_ENABLED(CONFIG_HID_ELECOM)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1MRBK_01AC) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_018F) },
-- 
2.34.1

