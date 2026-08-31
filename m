Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8C3D25A2
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174741; cv=none; b=MgBrW1XnlPwsbSvvsisztuD6DZf2nxhaENeXdwaZ9yoi7HbuLs8+NVTVh6zf1WYV33xQr8HrYxak+F1jvnd+2epePODr/XD6s0SUOweyfPQ61lH2bIf8hAw+Mj64zA0M7UtDaVS/FpaBxBlrghwwLapYcjVY4RahaFw2tyef/Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174741; c=relaxed/simple;
	bh=AsOz+oNscCl9RZI3te2sew7N0y+pek6xru3C7aqS9XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OTpNvYaqG9Fc1aVR3nhQrQ3PKnlYjxoXB2RCxhR4xPYmu1RFOsqF8i+YCTkX1GqNTvDrGfjHT5t29Tvaa3HL+GL2CwWgRY3bu1GLDSO2ybB+txRsTKBfTLKIxfIJRUVy5zUpu1YCVCU+DGSFohFd1AP2ALtO99geaQhVAkbM1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FSnwQYTR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FSnwQYTR"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aec201b582so4030474e87.1
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788174736; x=1788779536; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l5ZB320lDl+SnNWGHnW1xzOqG/h1rSK0736CPhMeVKE=;
        b=FSnwQYTRviy92oVyI5AmbFcpP2beHu65BS6bKAIrAz9APJSMeZj2Y4c2lXT5rVRLcJ
         IeqBzhcDCBN8bqoEFZ9Lgz71XPu/QmdJ91eZcYikiZ1kCK4Tzi2UcnU2iJ0WUHokjo0P
         hKUzKB5119DLZPuJ1ae9FaASkxwccsyYuNtHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174736; x=1788779536;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l5ZB320lDl+SnNWGHnW1xzOqG/h1rSK0736CPhMeVKE=;
        b=NBDlW7XzZsyGr/HAG9zq6c5tb0za38q2i81AKHQXMvuvyprSYFoDV6o0ktIqjIDW93
         1PZtqnb1ybn+Kq+/ducI1SLninhscg3Zl0LG5Ih0qCtbzusPhSgaOPFyNpHQ7b4niiEG
         CLr4yknMF9JW3fV4BtaRlATWoiPcr1n3y0proRKH3ZYvZv3yQUg4/LYWVJtPDXU5hCox
         qvs6+CcO+IYW0++81mnpK2qY6xjYCd9aHZ1DLeUgyYZQPQrzPQPWnayxxV/R9Ohx8jVo
         uubZNOr1kN2NrasRzTxe1G1Dao/qOBHu6bp7HeVdG/hRBOyb11PoU3L4eeY0g8zxffoR
         sp/g==
X-Gm-Message-State: AFuF++lrlc6rfOKsKFIgsvD+A6bGD4FxE4GUXABeOKA06LAaZPTMybXY
	0ubmTgFVpU1T3bgZXBZXGSyEn/skt+gRM/7kXzkhZaISxPHYGHJYbUqfWz9Cjx5DdA==
X-Gm-Gg: AYBFou3Mojswyyak7inePka1q34lAJP+JNOCKANWKk6Zu4+54WWnuQlmUb7oO7PQSkh
	kn0q84fycOC2jtvQ3qH02zJNVrVjp/mOXs74l/ZJwbjoJ0hDJ2AaLvN13lOwOnWeOAYPayuUA1J
	KlIVZ7WIf3F7NJuPFHhwyYqzsVrZiLcMDZFba+mnpeLhDDeUNYAXOh0jdG6XpkDld3QxO62Mlw7
	/Gcdv09kpNs5UZrvzL3PTNxgw0riIrZDMjSWNqDdYnvruG3H3YUbOQQ6ACUztZHVxeg4WZddYJ4
	sQTcglE20eefuuew5Y1i7x9BS55OvPWJqjr5sCWXTj/eGh6zE2JVH+R1gg1S0ZkSug4rOjfiXBK
	KA0NtcWz3WMipxAIM770Xafm2wWSG3Uw6A4HSHf68EPC4yOCOy62Rp8PXT21+6jCy5/eWrx+V1R
	eI8D2iOMiP1BK3pxHY0ftB9S/I71IL5KMC6SK2gOM+YVXPQ1hyIYmIcvxwAdAmxH38OltV6oli/
	CTIEn/tDwJtUIpObgZ1cDd3ETG10GfT1FNedergb/sOhqiMLA==
X-Received: by 2002:a05:6512:3b98:b0:5b4:a8c3:d26f with SMTP id 2adb3069b0e04-5b5e6907269mr7993088e87.23.1788174736051;
        Mon, 31 Aug 2026 04:12:16 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e89cfae5sm2042767e87.23.2026.08.31.04.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:12:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 31 Aug 2026 11:12:11 +0000
Subject: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
X-B4-Tracking: v=1; b=H4sIAIphlWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2ND3ZzUvPyyfN30fF3zJJPUZJOkNIPkFFMloPqCotS0zAqwWdGxtbU
 AqGTbjlsAAAA=
X-Change-ID: 20260831-lenovo-go-7b4ec4bf0cd5
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge them in
sysfs-driver-hid-lenovo-go to avoid this warning:

WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
[WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
[WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
[WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261

Cc: stable@vger.kernel.org
Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
 .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------------
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
index c8221373ef76..f3ba3504939d 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
@@ -364,11 +364,12 @@ Description:	This displays the available options for the mode attribute.
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
 Date:		April 2026
 Contact:	linux-input@vger.kernel.org
-Description:	This controls the behavior of built in chord combinations.
+Description:	This controls the behavior of built-in chord combinations.
+		For the Legion Go S, this controls the touchpad's operating mode.
 
 		Values are windows or linux.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
 Date:		April 2026
@@ -377,7 +378,7 @@ Description:	This displays the available options for the os_mode attribute.
 
 		Values are windows or linux.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
 Date:		April 2026
@@ -640,7 +641,7 @@ Description:	This controls enabling or disabling the touchpad.
 
 		Values are true, false.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
 Date:		April 2026
@@ -649,7 +650,7 @@ Description:	This displays the available options for the touchpad/enabled attrib
 
 		Values are true, false.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled
 Date:		April 2026
diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
index 4d317074bb7e..218164cfe544 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
@@ -231,41 +231,6 @@ Description:	This displays the available options for the mouse/step attribute.
 
 		Applies to Lenovo Legion Go S line of handheld devices.
 
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This controls which value is used for the touchpads operating mode.
-
-		Values are windows or linux.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This displays the available options for the os_mode attribute.
-
-		Values are windows or linux.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This controls enabling or disabling the built-in touchpad.
-
-		Values are true or false.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This displays the available options for the touchpad/enabled attribute.
-
-		Values are true or false.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
 Date:		April 2026

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-lenovo-go-7b4ec4bf0cd5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

