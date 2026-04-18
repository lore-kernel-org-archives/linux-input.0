Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC3285C89
	for <linux-input@vger.kernel.org>; Sat, 18 Apr 2026 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776481116; cv=none; b=NgFzyFcMlzvx+/h2LVCXX6/PNPNV9MXYvzA7gZFVFfkq7err1w6OR24HuEj0uyjlChDcMMmkzU5BFUz8SmcnpneS5RgKF3e3J3pf9CHjHME3CTiUi+E03bNunw+s1Hhk0kCnjXdo5rjfNKUBrAkDNX3Bb4HX4OOFnD0iWgl8Iq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776481116; c=relaxed/simple;
	bh=Os3Qd2/rEF3RFRrAtbvsX0CsqiUOJRcpfnFRti8hRTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flmDrO6hHC3wbCLprKyD+aOHFj3uH6Ilo7ZcafLQ/WK37g2AZw57zMTTPYYv9Mz6hJF96ggcswtz2+X3eQRBrSFn/ps2dVKjOLTnu7DY0K+KPCiHVj9VPNMpdROH9k0dwzjEvrj/Vr36+RDFeu/wAJqovyUXGJAE7BdTGfmFPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exponent.digital; spf=pass smtp.mailfrom=exponent.digital; dkim=pass (2048-bit key) header.d=exponent-digital.20251104.gappssmtp.com header.i=@exponent-digital.20251104.gappssmtp.com header.b=aMQq/Jz8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exponent.digital
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exponent.digital
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exponent-digital.20251104.gappssmtp.com header.i=@exponent-digital.20251104.gappssmtp.com header.b="aMQq/Jz8"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f37c09352so1591550b3a.0
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 19:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exponent-digital.20251104.gappssmtp.com; s=20251104; t=1776481114; x=1777085914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wimO4t98B94X++UZm1VpEFfwrjNwlS6cYzn0ZUHBaAs=;
        b=aMQq/Jz8zocx4LSV0PkiQKMh2LR10TOFmWSu6Uh5tjahwZiv408BLMhKPvUmEjEGsE
         AyN+8mxnK8xmQLXelSD1CYfvuPj1DJ/xLWlO++TFujCPjhjVrFmGXLzrVrdpeo8HICSl
         qnDaeZh9PQFHSRUSxSeM55mMY0ppjlefeDwVqjBWPhLlrnZX8G22h91uBiDWy19wsF1f
         Vlz1hwLPXQtxbU/V6wMem+D/Tgrxm1/SMSgdeIfGDn8abgLRHUTsOfydjqHndBiDs/Mi
         bAcOvlPUDrb3JxSL3FOzLEz8rbQGbaq/PQtYQP7N6sI9Xl0m8RkARmMXaNm2vIRB37lx
         duPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776481114; x=1777085914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wimO4t98B94X++UZm1VpEFfwrjNwlS6cYzn0ZUHBaAs=;
        b=ZADYCCHTk14vKKhneqKwd7SxavcA2Si6ZAXRUqtnl9+UEZPG40Dr29WFSmH6SFdytH
         Yx34IvnTDIWx+07NdIDcOY+ch8cf2akaYstkQA7w8sm5BBnFyp0w3CbUE7JuNpfHCP0B
         uR4LpFDE8vnCZXpsBUaCyfOBu1Rw9nXecAUX8cOAQyVZw/TwDW1evP1opuhuYnwBNdXn
         124+/K2K6xaHNd3KS9z3B+osvySTQ4aSXH4hhfJda+z78HT1VB9cjPTpp82p2IndqHZR
         +MjLfr4IBc9LUy/e6taWtVxpe4FJUHXsIyFilRDZB6fC9ETKUC7K/eWIxdrKUm7qTNsX
         3ulg==
X-Forwarded-Encrypted: i=1; AFNElJ+w7gLIB9DKwQ8RjrdWRvF8C9Rgw1r2ROChTzpc+q7Opt99pT1T25Ut3qAf++LamBcy9XssB9n+N7fWiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySZEChip0KDNR3j9gKWUppJB0LYa5AOIBKJRCtH5GKEUvDImn8
	FKrhABd3W6yatbWvVv3ZgQhvbV+hlmrTEiZm168YNZBgeUsqulYBlszGh8njR50KKzA=
X-Gm-Gg: AeBDieuytC4OZQ5Z2Ifllb79qfmQKf3kAXaoHJDEDIsqgcitBQ1In0R7HTnwNuq0rcz
	+VTb44MTF5Kpzp6q4s+PQgEBf9nkiV62Etp5U2ZizD1e4IyaKYlwWe7cK9yc6WoaDcbwijpLl/B
	FbrBWG+yt9IPxMOZawZqf3b5M9tNYFWG8V7dWodFNt787QeLQJv7ZRKXU7P0ECI+ZPlubMy+pI5
	iXu3E2I2NHqNzpk2zfVIdoUSk4Te3MI7b1ri/Mh8CaQhEBkeQ2wbS0m82NVBg7ThhSbSFx45dai
	6yK3kLBgOS0qoKJ5mjLWAxLCBwNmN8ooptOSPSH55DI0vVTo7jgoQuJO7MGpA8EmIGH+JcSntY6
	LQKHgcz8VuI230VJddXlttJWUkWN9D2ag3D9g6wEUEmUSMCYXZvclY6ZDwlnzNa1W2q0gB6K+ik
	w8gTFhMb7xyUGZQQnszQb0nauJbLA3jxLRA4FYbjjo6SWi/BMsnjbn2+Qontk=
X-Received: by 2002:a05:6a00:27ab:b0:82f:4725:f6d0 with SMTP id d2e1a72fcca58-82f8b5476bdmr4184949b3a.29.1776481114219;
        Fri, 17 Apr 2026 19:58:34 -0700 (PDT)
Received: from yohji.localdomain ([101.100.136.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9819e5sm3524552b3a.2.2026.04.17.19.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 19:58:33 -0700 (PDT)
From: Taylor Hewetson <taylor@exponent.digital>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taylor Hewetson <taylor@exponent.digital>
Subject: [PATCH] HID: usbhid: sanitize hid->uniq against non-printable bytes
Date: Sat, 18 Apr 2026 14:58:23 +1200
Message-ID: <20260418025823.21767-1-taylor@exponent.digital>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some USB HID devices (observed on ASUS ROG Azoth via its 2.4GHz
dongle, USB ID 0b05:1a85) report an iSerialNumber string whose
USB string descriptor declares a longer length than the actual
serial, leaving uninitialized firmware memory - including control
characters such as 0x18 - appended to the returned string.

These non-printable bytes propagate into hid->uniq, which in turn
populates /sys/class/input/inputN/uniq. Downstream userspace
components (systemd sd-device property_is_valid(), and by extension
mutter input enumeration on GNOME Wayland sessions) reject devices
with control characters in their uniq, rendering otherwise-
functional input devices unusable in graphical sessions despite
the kernel input layer correctly translating keypresses.

Truncate hid->uniq at the first byte outside the printable ASCII
range (0x20..0x7e) after the serial is read.

Signed-off-by: Taylor Hewetson <taylor@exponent.digital>
---
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1427,8 +1427,17 @@
 		snprintf(hid->phys + len, sizeof(hid->phys) - len,
 			 "%d", intf->altsetting[0].desc.bInterfaceNumber);
 
-	if (usb_string(dev, dev->descriptor.iSerialNumber, hid->uniq, 64) <= 0)
+	if (usb_string(dev, dev->descriptor.iSerialNumber, hid->uniq, 64) <= 0) {
 		hid->uniq[0] = 0;
+	} else {
+		size_t i;
+		for (i = 0; i < sizeof(hid->uniq) && hid->uniq[i]; i++) {
+			if (hid->uniq[i] < 0x20 || hid->uniq[i] > 0x7e) {
+				hid->uniq[i] = 0;
+				break;
+			}
+		}
+	}
 
 	usbhid = kzalloc(sizeof(*usbhid), GFP_KERNEL);
 	if (usbhid == NULL) {
