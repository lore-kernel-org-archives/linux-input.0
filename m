Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703802;
	b=AyGhm9YzVkrWaCqqjDa6cRAki86r7BX3xFq2yYY4lJ3tfAUK1+wlkM9ea3dF3RFZzgg7
	 UTcWQ5pd/Y90c418pNknpWcYYclqVsqCufqPXx4CAV9ibNz8hc1A0LBabKCyfD0CzMh69
	 CUqn7/MsWB9rDfR3kA2jFEOQZJhZlgW6gLoOeCnMZfgAyebOZ610e4ibteiK0jKw/2V+L
	 m7qtc+ZBFNDhlkNDzlyqqWEMY6fTrD4HOAFbCqtCPcCxbmlHcv0GVbiUkfV06yWIURhhg
	 6nq5SKBuZUips0znbZnSYZ4Z+ThPwWWgN85rpNk2ugsmGm04bEi/BZ9jmiknBB1Yzfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=wZ2A4qfQpgB1E9Hmrqw85vL60jFNYPf3t/HcdS6s4Lc=;
	b=rB7DBYfARRjXoheOhG/0Tk007Z0HnOUhH6xRfxHHNRmDVUTkrPGISsIHberH4ho2Mb8X
	 /G7XUB9kjK9BPF3kbTNuK3UhgDrayOqWeOFWLVEoWI98wLN6tKibu/UvpNVwqaMunkaz6
	 6LnFRpT1vcIf52ZjnVVdRk1F5IImjn9tpvqtZVT7nlb06X8KlxWl7Xf2Rph6LnQ0vdPuo
	 iw2bp+iqJyFYL2VQwuTYGRB0QguUjBw5tJNM9JA11afuAABb7YZjyW6TirM+uo6qlgJ06
	 MiiHIyMhU2BRsq82BorFfOgxs9c68NJGKAzGT8L50GnRm9T46tz9SIumDSg4HSt4Hag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LJEFTgK2;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF5606A334
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 14:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4BF5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LJEFTgK2
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso7164617e87.0
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795703799; x=1796308599; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wZ2A4qfQpgB1E9Hmrqw85vL60jFNYPf3t/HcdS6s4Lc=;
        b=LJEFTgK2y+bSpXry0PbbjVe1EY/gQIxL0YjKFkbtnmSeP2S3iAFI4cpcJpA0QfgVf2
         t1p7/r5jtP5ruD7Zaniry3wA6I29YfBMO67y/KyyN1YFvJHJrUNO5NowSSA4mm3hKTAm
         jsDENlFJr0+j8Ohz8rimlhi1RnEn3SNcnGzDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703799; x=1796308599;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wZ2A4qfQpgB1E9Hmrqw85vL60jFNYPf3t/HcdS6s4Lc=;
        b=pvJZG6k/r+LsudO1iaiaPp1/S0zeD80ltNLNgdzkjKtPMM1pDXgNULfh3OF/I8hO/u
         rWb0VcD9uS0V4AxYgUMatG5hcGVLBXrynxdKV07N3YJLWnCN3aLUC9D5g5ZBfjNf7VZj
         pdMLQnRuLkEdRbEujPhH94+NY2xLw6G0SqSYiCaX5NyHRPmv+6ykf+sIdjyX/SQJulWg
         Tvl+JDxEDrFq07utDSnlXAbSJSUSXs+t30j4WmpXlfFvJUpKDn6cYq4zZBmFQYSKUPhr
         lZp7gfEi5Uk0/L/zWBzMbPUKSDacuot74tzFRictqba/9CXXkGxUvRQRzyQSmM+iCUrX
         M20w==
X-Forwarded-Encrypted: i=1; AL+hErE+HBSvir5/UwSn7OYOdZOptboLW5S3RBwv2evOHKKDWzW4W1zsQQtfrda63YLsDmZwb4bYGxBQLBjxzw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9rUBSCu43E5W9c/qxSVK+yHyW7oD94fi4fcybr2r8wCuGxd984
	I2vM5LKUMzsyVhKLdXreWskYOLoTPWYS8wHPnIyBK/BVJ0gIe3t/FG1VDFa1WhdlAg==
X-Gm-Gg: AZFdTZdEBfDILlMp5GeUgKE5Ef+d7WJr+u1+SBwh/ewMqw+44FfdnahTjBSmwFjlLv+
	nI5G+NjD0+8D4WNFQ5m1H6xjJnDXV7l1y23WCY4PUOPeoLgZoayI78Y4jSBuWRa5X8mf4Iw7I2o
	gVxJZYkbPdtW4U05x2mDvWY1vEUJrDKmu7HHPCnelPkrI9Q0YGxPdKuNuRAqHV+xFt8tG8q3orx
	Cg1RDs8CSWjAyz4aHt8HU92JuMzaO9T9iNcCdodByVeT7FtdemELgcnrFEKgn632h4bJCIJ0cR3
	TZfMfMqveSHL04jNM9cwArIowjYhvrBYgPTa+FiG7RJBuajB9Nlk6/aLcLaDTvXxScQN+NfW8ed
	KJ0CLQrJLdqvcq90Es8RvKEvXMrlPgtCDwI+14nBOJm+v0kQUpPI4BMhZq8zqj4jvd8jGj51W+U
	3wfqEnoIMTm+/bAxHVTUwEGxeuHM+Wm2s6NMS+qE6bLSVew5fiM/8C75xrqGNKaISvgXUJu9Rmp
	whRngfV9gc/eXc3lE+3ALBsjkKRrcc0A2IBfg47Hx6fgMKLWGKFcRelzj5opbOAelWA/LdmViyq
	8aTHlojZdicVFaerA6GX2PUGkt1GW5BKEnPnoRc21mOOGaw/wrranZyxAJ1yjWNgB0R7OQGymPS
	LQrrG9lA2ACpN7R1Vo24yR4x9+2A3T14=
X-Received: by 2002:a05:6512:3b21:b0:5c1:5746:9c3a with SMTP id 2adb3069b0e04-5c1bc8f3c5emr6643497e87.62.1795703798763;
        Thu, 26 Nov 2026 06:36:38 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0563casm5231653e87.67.2026.11.26.06.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:36:38 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Nov 2026 14:36:35 +0000
Subject: [PATCH v2] HID: Merge duplicated documentation for Lenovo Legion
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
Message-Id: <20261126-lenovo-go-v2-1-99db2904513e@chromium.org>
X-B4-Tracking: v=1; b=H4sIAPNDCGsC/23MQQ6CMBCF4auQWVvTVsDiynsYFlKGdhJhSKuNh
 vTuVtYu/5eXb4OIgTDCpdogYKJIvJTQhwqsvy8OBY2lQUvdSnNS4oELJxaOxXmo0dbDJO3YQPm
 vASd679atL+0pPjl8djqp3/pPSUoogV2jWzQGUXZX6wPP9JqPHBz0OecvWQpfj6UAAAA=
X-Change-ID: 20260831-lenovo-go-7b4ec4bf0cd5
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Revert unrelated "built in" -> "built-in" typo change in os_mode description (Mark Pearson)
- Pick up Reviewed-by from Mark Pearson
- Add Jonathan Corbet and linux-doc@vger.kernel.org to Cc (Mark Pearson)
- Link to v1: https://lore.kernel.org/r/20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org
---
 .../ABI/testing/sysfs-driver-hid-lenovo-go         |  9 +++---
 .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------------
 2 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
index c8221373ef76..07f3ea054383 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
@@ -365,10 +365,11 @@ What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-
 Date:		April 2026
 Contact:	linux-input@vger.kernel.org
 Description:	This controls the behavior of built in chord combinations.
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
base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
change-id: 20260831-lenovo-go-7b4ec4bf0cd5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

