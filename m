Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E9366819
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140744; cv=none; b=gS6Zu3gdJOMI6kVS8HAZthZrRRNLh0AlWnOJifEWpwoeQvzKJFPYCdX3Iyc6wMyf75Nyj+QQaTcK1/S58rDPes5Tc0D1XIf15rZHLa1CElZ1wd0Z+8Cg0gKSF27PAQXISpYhDfamSVvuGIvDKVw6zTciJTBE0oAMWAgYl/Lx5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140744; c=relaxed/simple;
	bh=yTfX5yigziZaDCkyz+2boyzu28VQAyZws//UMgESf+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRKfcVbWd16Ufii/ePCc0IqzoA4oJOnH+wdU5gXjHMytn7JsVjIk9Ef24Mh0ItB2PFSsA8Uc+A5JhlM5G4JQWLf77lMailpWhrXOdmOnHyMEjai0ehzqfqK5JEC80suHpDdKYBbdW9lPgkNVZYNg+zjUY425lJzMT/49z/+F9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5aq0FgS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5aq0FgS"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b876b5c69baso69432666b.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770140741; x=1770745541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0LT1FRWHCjfMEosZU0PQqZC4X0XAX1+L2weZyVRa54=;
        b=T5aq0FgSbUZENgxSyFUA6czIZIXAkzDZBGOTpfm5HN8Yxojccn4CjHKkGvkz+NJOdO
         X1iQe7v7pqsTKOUCNOHMJ5r02vGSspeBkdLMysAS9xpiXgPPYSJqCbceCip5NGVeb20G
         A/HmteTzapCJlYCKrh/A5Rt/HSM3Kdd53mJFGaBS4xPe/dIbd2D891tyxp2QPVzuN/x9
         Bo9n1pTOo2RSamef5sEN3xnDMZ5IPIpfchgX8gJIbfTMYBzLC965C3aF+kqey3lX8Cej
         Uh8q3UR3Bkl7TqDo7i74eBvssAXQ6ZoGoDIAcKlmL1d07wm+eABRYn2voGYCJhDHsfYt
         /XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770140741; x=1770745541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0LT1FRWHCjfMEosZU0PQqZC4X0XAX1+L2weZyVRa54=;
        b=eBizA21uZcEPnll4HLRRrE8HhViE1WmB3zk/Udk/OwyhxPtJgOCggdI6T2JlCRMdao
         BsW0PFcFgEWSTyY/xPQtVbe1w9k516uml/wjlL+KDr3y8L9SkF1x0ha+SVH8xOX4JMUc
         dDrhL0GKGgf6aeCZAHocscmdFZCsY84wxQ/rWi21tgiE+C88J2qkb6SQEPj9J8mhqsJe
         BSHgseHCCW2cldcnmTxsne1PQNhj7FMkTnVNVy/cmgxt1rPjwIjyXvvETtkN7bH0V4s5
         QIqocY35hgCEJD5/t/5bhxBEhHDqDyqNj0z3X6sURyBAazEJg/Mh1RTQYJWDUHt0GnGL
         4wKg==
X-Forwarded-Encrypted: i=1; AJvYcCWQzJZzcnlda32bpXKj6pSh9NirmM1bB6jNnGFS+bP4F1g0prCPqX2m1cClJ0fIsnij1CPw6yfHRu7laQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK65rXnPa/hjShunH11gBc7PFEFCUJvFca34BvxNc3fQ3EJVN2
	aZM7Kt2dEAmf8eiOZ6OtIMlDvubTrBZ92eec0GU+LzmFMHEGf0MMKMQH
X-Gm-Gg: AZuq6aJqaAE+caJiocOGpUkX8Uu3EFrwTjLp5H3Kc2kyS4ogku0jMEiX8c72A83zuFV
	gceY2pfUpdf3+XD0iDzPOIwgFSA+vQJINhxxhZDCfykFzxjHFKq4tiS6PE+05OxTdtepnT63pHH
	JLHbBrmBeWgOKmFHORzgdIG2A8TexIdt6XB8veK8LcG8SHFEN3/RLo62fLUAbEJkNwjT/oC0cOq
	wusACCNTNGct9jMDcHd5/GXOjFBmHkjaV0U6LaYhlKoaY4lYVqAmHs1GVbU3gxe6GK4wSJyZ7Ze
	gIVcph3tkt6ViJOPbbXaIgLJrJ9FeJ2KtgunJ0luCAFKYfqBgyob1eyF/Va/vTlnsI6NirAcTM0
	Ewb7WOYVyvFUr1MK2v7GiHVAR7bNXtNFir5rTAmjvMrI4+F1wQsaQeCYSgPQCqU81pE3SpXxODv
	co8QN7imxYIL+y/EkLzRIPBZ1AKmK8FOa7gJqsj/kp9SaU2y2MQdI7nja5MFPcq6PY
X-Received: by 2002:a17:906:9f85:b0:b8a:f5a1:32f0 with SMTP id a640c23a62f3a-b8e9f40db1bmr11086166b.3.1770140740863;
        Tue, 03 Feb 2026 09:45:40 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef001csm5078866b.44.2026.02.03.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:45:40 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH 5/5] HID: Update MAINTAINERS for USB HID PID
Date: Tue,  3 Feb 2026 18:45:31 +0100
Message-ID: <20260203174531.2866644-6-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203174531.2866644-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Take de-facto ownership of core hid-pidff driver

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 MAINTAINERS | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0dd762f5648..b6c16e134070 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11205,14 +11205,6 @@ F:	drivers/hid/hid-sensor-*
 F:	drivers/iio/*/hid-*
 F:	include/linux/hid-sensor-*
 
-HID UNIVERSAL PIDFF DRIVER
-M:	Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
-M:	Oleg Makarenko <oleg@makarenk.ooo>
-L:	linux-input@vger.kernel.org
-S:	Maintained
-B:	https://github.com/JacKeTUs/universal-pidff/issues
-F:	drivers/hid/hid-universal-pidff.c
-
 HID VRC-2 CAR CONTROLLER DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-input@vger.kernel.org
@@ -26927,6 +26919,15 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 F:	Documentation/hid/hiddev.rst
 F:	drivers/hid/usbhid/
 
+USB HID PID DRIVERS (USB WHEELBASES, JOYSTICKS, RUDDERS, ...)
+M:	Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
+M:	Oleg Makarenko <oleg@makarenk.ooo>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+B:	https://github.com/JacKeTUs/universal-pidff/issues
+F:	drivers/hid/usbhid/hid-pidff*
+F:	drivers/hid/hid-universal-pidff.c
+
 USB INTEL XHCI ROLE MUX DRIVER
 M:	Hans de Goede <hansg@kernel.org>
 L:	linux-usb@vger.kernel.org
-- 
2.52.0

