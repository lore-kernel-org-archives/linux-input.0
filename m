Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB733A1DB
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773014641; cv=none; b=rP7QfwRLYW3aaCUOzHwTW7NxPQR+6MKnUmmOsvq+it7DPbR7lO3WrYsSKgBV9/FLkB+HPeQ8mdXmxmsMfMLddBPr5ZTfVlYWmwJIHclHWnRrEQbv2he3eL/Fa+nwRzn3/4JYX0qELS4Z6C4ws2DeaQi3tLCZ7KJ7l2kUzMmNh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773014641; c=relaxed/simple;
	bh=wPZiFdqCiDOOFye8FKOQoufL7cyIaxgiXa67+xHsn0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoqxeXiPZXml65sRGnka5xgAyo2n/UcPOHwK4+P+nqTiGk9iwOM7maroOll//F7fsCZODeVskwp2HUZi/RlCxRno59vMY8vldY0ge1ysx0X99re+w0KmmzLkfxz0/4srj2K0/i6MJqyuLRqu8xJzASxjUR7x59tNN2Og0JQOCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbp9gB87; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbp9gB87"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae82df847bso15602985ad.2
        for <linux-input@vger.kernel.org>; Sun, 08 Mar 2026 17:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773014639; x=1773619439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=lbp9gB87GRviLuybrdKpqdO+ljmRKZY5VVQHdEu+c3QBm5XVHX7wf/cMJ0SiNngIOT
         H9O7uQTIrHNMg056XFWtfEAhBUtN4/D7El/We2kp5b1gjiFBCF8p+MmBeIle3UlluQDK
         t6SVaMi+tXHpV8tUMNXFuqko6n00OOvCoq6jzT0Z0+wY4m0k8CjpdnhdDS/SmekAmwVT
         umpd6bE+4L5bB2xwL+eMr4K5ll3m9V5DQwP7U6VM/pt3E8gmXKzkixMU0cZVDIWbxNbA
         0FWdNZ6aXscakiStpIesvrUJUPa6eAnDRxIIW67zrlQrVftOup4ZhSw3O/y75p8EfhM9
         UdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773014639; x=1773619439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkTY0vM9EzW6XUSGNuKIJpMIFfDu1qpzZf7r+qP4u6M=;
        b=uaH6TA1zuN8EbhzdG83q3JnIZoK6v3tekTbxiPdkV4BUC5gpng38c03oMmvi+NWxq9
         W2FMHb1Sclp4KoJv59kqSE80j4DLOtOYZh9H8Bzoqml1yQdpKq/jcD9X6/x8WVjl20wh
         rEKXJ3AXVrmV7bKbajBjxOh10Qp1qWByF1umu0F7bJQ4l/bX+qpgjPTCqF/OLvJwxLJa
         GzkKs5xV4h1v4XYAA1xqTPJYRW18RNoQLM4aEPvz2PeqoT6erBtfA/N3reP1gwDHrikL
         9gbuuOeQaSqS1k3uDYhIBSDLZV6JEow6xCFjJ2Lq1cY6ht0InFnvkUZn7r/80UytkTnX
         2ZjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxbxiAwN3+eEKHcmAOfdwcV/ubAqLYTgQzdlB4Q249MBihhX26Qa/YCqT9F1BTD3/UPds2DS0EL/t+4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUzFQO9RVhNVoJZj76ByF7PqX45sIDkvmMDx8PpNUQBrsmMKb
	vHJXy7CJa8DPzchMYUZ7yjLpB6VJ8+cVYpx5KjMAAy1PFXzI3jO1tlNq
X-Gm-Gg: ATEYQzz1LwyGYbd7V188PoPeZ2E7iVUdTlW13+e3cS6jHJB2f1y0mX3iFbw59CC9JuW
	BgeWqcyqnHPbpbE4kKbBEQCb/DM7c6iKYmqubPgdSPNlUaTCSn0LKrSPSuYd+mYv2XYYg40yscA
	Fy9N9Z8fM0dllHk+jkT+0YQbQi1nv+N4Jn/7/Ej+LBidgAbgOpNi4J5MqKq/mn4euqCEc2dgUgn
	KTUGxL/oajldhVA36yj3MRZSrg88OoRiZIdjgqN8QgQKvP94K7Lam5W/uYETMG6fHqAUXrMsACB
	U8a3ftXJCaL8pNOo5C/IBIBRZjOBpI55RN+7WjcemF2izKb0DOWrpIGEYh3bRSk4EFVZstRRKH0
	JO/VjPCekbNYezQDtVgZMYr9xcGC6v0Wp+tBFXGSjQ/z3BC3z3X0J8HaQEeSmJEHSKUN5BoUMCc
	Z9UyPYXOrGv7Z2DS4eEdKgr1iE11Oyu+BZfYQKBbrEefjahQSrjnxaRIdKqmAEE2kjJR2+
X-Received: by 2002:a17:902:ce88:b0:2ae:4d23:334d with SMTP id d9443c01a7336-2ae82572cf9mr95162765ad.56.1773014639053;
        Sun, 08 Mar 2026 17:03:59 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm104845405ad.29.2026.03.08.17.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:03:58 -0700 (PDT)
From: phucduc.bui@gmail.com
To: krzk+dt@kernel.org,
	geert+renesas@glider.be
Cc: krzk@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	phucduc.bui@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: [PATCH v4 2/2] arm: dts: renesas: r8a7740-armadillo800eva: Add wakeup-source to st1232
Date: Mon,  9 Mar 2026 07:03:19 +0700
Message-ID: <20260309000319.74880-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309000319.74880-1-phucduc.bui@gmail.com>
References: <20260309000319.74880-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Add the wakeup-source property to the ST1232 touchscreen node
in the device tree so that the touchscreen interrupt can wake
the system from suspend when the panel is touched.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
index 04d24b6d8056..d47a6cc3e756 100644
--- a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
@@ -228,6 +228,7 @@ touchscreen@55 {
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
 		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
+		wakeup-source;
 	};
 };
 
-- 
2.43.0

