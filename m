Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535D3C3C14
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024609; cv=none; b=IoQJSZNGASGMTHHq+EtNw6Zx7Nk/wa0/zH/DBoogJr2ZaEv8G3OTPnE5TLWdnjFPB+O5EjluTtSi935Ul+ysLfoZBOsc02ZxTkr/shrnXCVtkCJKcAzXvI2yojhzJqKIjSou29DlUCzvG+VftIUsjV8oZv0l+IKxuNimIs9qY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024609; c=relaxed/simple;
	bh=Nr8soLk7HjSX69yt6n4Yu7jzL2a6NtPIuZF2j1MLzYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyoXcxHcBj6NewQXSMTP1j/6ZIxWebMlaI0SX2OjoOY2+d/9EB3GNOefBHyY5sLouIw3vhhACrNgBS4Ca789ymDE7vD618op+bCUPBwdo6A2YWYzrc510Uk+0KgCsMLDK3DvieqDgTELXt3aKyeK4nIOYqUeCbXyD/5t+vwp1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXr549fy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXr549fy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4aa0248cfso1113147a12.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 00:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789024607; x=1789629407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SySIigzjl9v6ifCPrWGqAFgrXQJf6WaDMYUEkKC20gM=;
        b=EXr549fyAxAcW28D81QSomtZ8i+W5YeQ/NWMu9uDoNXAqgSmtEn+8AE3GvHxyf7Po5
         pb7nWl0uVXEQzAlw41VwVm5w1eBbD8BXnWpI18PgjIJBDuc/4lBEI3eTkX/xQ/lku/II
         tc06YZxxHbIkucCiuAAYp30mQIqIWhterc98t5+VK9RvtMqMyxwYQkhGQtFKmasckdaJ
         a1Q6ZmF3hn6FcpHOfxF79mwHoBglf6pfJr7vGVmR2geXOXyIR8XxxIFtZG1ioba6tSFh
         TP1bSWdgUHMMnNs35yr+6+SiY92XijeAxQpurnQuaAi6FX23k7ffI8h3j5TnU4/8mHLF
         rBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789024607; x=1789629407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SySIigzjl9v6ifCPrWGqAFgrXQJf6WaDMYUEkKC20gM=;
        b=cmOB5u43E8sUxe0iV6D7tGm/Pf5RqRPjkKuRH1KNDeW1e9H0uvHe7WMjsIgls01gnd
         yWldNMVWewoVQLN8AflHfEWTGE6m+YdopPCj9HQ/YuLJ3Z0fatQMgtaxF+JwMy8ryg14
         V71FpqOJjUI1RkRhQ9ctGu1G8tTAY0ga5PhyHI7kZpccuRj6ojcKI11eamerJ697WaME
         wFE/Got7B18tZj2vZlITzXfH/eDi51TBjEPrv8ZvWsbKHOjKOZqJSQXZGy9GzcybuTt6
         SKYi6sRmyoc/uji1CZDHHhlznPLI7kfcWNF4Lwk/yxyWM6JnlOk+uoyn0WgpD3ba+w6m
         KeVg==
X-Gm-Message-State: AFuF++mbPaDsuFvf3ijTHTJL4UTX1I63UjhAVX/KDKpnhobH/ZQ9yI06
	zImyXECF0kin2lSU+m0WobLwe+0BmVrsnvGW9wrA94Dr+0PNG3hplirXilFMIW3C
X-Gm-Gg: AYBFou3IUW2tSMBaApES4c9HUl1z76HC3OY3oeHrB6dNM4yG86yokN63LAt+8E/7l9m
	X4Qc3tbKaJ617UfTSwJR9fGCcQXAPT5iQfc4M+XXxkAgN8+cvDbrbAKSLHwCLR2ukfEuu6PkOt+
	Gg9wocuRNXZa5HMfrI+2STGEjX7WLxZc7YrTdQA585KL0IZrOtM9MtU9/gOfACHvgs9ilSHTnZE
	MM2KwVTD9ukUQ9ELgEKCO2swoSuvR2Ll8gfy28HY1P3BBDybSep+Lnp1tHJMWeyodZZJYaqL76K
	bQTI1xq8LWM3YfSYjDvTbnAeg0glvKqcM2/tOu8mxY6paJBUfa5nfFBbgCQlmsEhdrsVXF8FvlB
	qUduZveDTAXnRSzxw+EfTkrUneyxt6LdjUcfr3XNWSx6BRtrztsOWXJ/0W+fPesPfNzVbaYus6c
	8MoxbyiMBa/YhBQSRqZpU9oBq1HWsFfIQQFYgr0xTJdcYBE57fPkC2kN9aVGIth0x0OHYgnRy5N
	4YU0+ESAUSCnCcKTn+O1vGi1Jfvo16tQpqKsCVgLc64DxhOiAtFXs6dqPUF/Gi0cTE9KD16BUj8
	MCjOwLMjaKpAPtnJf7tkoM+P4jwHOT00gDe7UMZfJb8=
X-Received: by 2002:a17:90b:52c4:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-39b260d3375mr58693114a91.2.1789024606785;
        Thu, 10 Sep 2026 00:16:46 -0700 (PDT)
Received: from Charlie ([67.169.216.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bae865d2csm3118230a91.1.2026.09.10.00.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:16:45 -0700 (PDT)
From: Jeremy Nyberg <slickstretch3.0@gmail.com>
X-Google-Original-From: Jeremy Nyberg <SlickStretch3.0@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	Jeremy Nyberg <SlickStretch3.0@gmail.com>
Subject: [PATCH] Input: xpad - fix PDP Marvel Xbox 360 controller
Date: Thu, 10 Sep 2026 00:16:27 -0700
Message-ID: <20260910071627.236014-1-SlickStretch3.0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PDP Marvel Xbox 360 controller with USB ID 0e6f:0147 is
incorrectly classified as an Xbox One controller.

With the current XTYPE_XBOXONE classification, the controller is
detected but produces no input, while its four player LEDs continue
blinking indefinitely.

Classify USB ID 0e6f:0147 as an Xbox 360 controller instead.

Tested on a PDP Marvel Xbox 360 controller with USB ID 0e6f:0147.
All inputs register correctly and the player LED indicates the
current player.

Signed-off-by: Jeremy Nyberg <SlickStretch3.0@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 2da0b7f17..b7a9a940d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -215,7 +215,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0139, "Afterglow Prismatic Wired Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x013a, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0146, "Rock Candy Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
-	{ 0x0e6f, 0x0147, "PDP Marvel Xbox One Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0147, "PDP Marvel Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x015c, "PDP Xbox One Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x015d, "PDP Mirror's Edge Official Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0161, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
-- 
2.55.0

