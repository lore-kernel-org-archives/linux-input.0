Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2C1514F8
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770772690; cv=none; b=KOtBRwexWCwAiGyUOY3F/N0h0twDmjz3xV785a11XxGiWGF00spPBWs8oBogs8syf1grH/eDV0SZvywxE8ztitJcnJwOcy3VlbSqGKqUcmMj8irLA3cU8SjSuC7iUEN9lbnL7akXeqzBd/lfLQ6b2SiYFHFf5FjZbBe5P1i6A/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770772690; c=relaxed/simple;
	bh=cYW+V1WYfERZd/tlS++ow/loNT0FhjWddzYhitVizp8=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=JuSHNhTV+x1umLINtm3JWmnHvNdJgTV1zFq4nvw9YYi5KE1bTpjlTB74TwMk5rK8aHjzl/uLGlxG3G1VuFw1NVAkAg5k8MUeUuXMKLBRBQl++kfStVNvAq4+dK4WkUpil2TrZamUSegkhzO97zJ3Dz+29l/E8wmiRcuoQ9eUBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=q.tanaka@gmx.com header.b=EoTQ8swQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=q.tanaka@gmx.com header.b="EoTQ8swQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770772686; x=1771377486; i=q.tanaka@gmx.com;
	bh=qe1BI27CwIC7kzMml1n4+lgnZnrkzbNKp8qOs8u79WI=;
	h=X-UI-Sender-Class:Date:Message-Id:To:Cc:Subject:From:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EoTQ8swQNHzkg8gx4i8G9a0hWKwapkGELvN358adM+K4tIoZZhZgA4f4dSwLIEtq
	 Zod7v8m33GeIlYUk5/7oSQTsFHg2RzhUTl6Ckg1USql0fCQj44Hphde/fwAfiISMb
	 rqH9pnU/NiqCL6DC/Op+/B04sc5HrFggv5qzhaGEtZAFFdjHTxIL1l8LxZOsj69Or
	 uEoFAkPswGFu20IxxCewgdNmh0hjTSkGCphDPOKpIFQxjj2zyv2O6PhPh03njiueF
	 r3GAn2Kk7ChA8sHY6KIjLFsiyNCFgwyu+Q1O8dg4NZK4DL+RTIOvj8RR1SPSM/0pr
	 REpZ6YqgwaLT1R95lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([180.31.131.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBm1U-1vxi6a3qhA-008JZa; Wed, 11
 Feb 2026 02:18:05 +0100
Date: Wed, 11 Feb 2026 10:17:07 +0900 (JST)
Message-Id: <20260211.101707.2126959894059795107.q.tanaka@gmx.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, q.tanaka@gmx.com
Subject: [PATCH] Input: xpad: Add support for "Nova 2 Lite" from GameSir
From: Qbeliw Tanaka <q.tanaka@gmx.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Feb_11_10_17_07_2026_761)--"
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:L5Jz3DKSOcT6jqy6LeNEQ0uPMqJAWkKYJv6NskdAh09tYEcxBUQ
 wADAU+R6s91Zie1fclCcx2lnKv3Mvvrw5AsYu8ws1I2sKlO3Xo7tVeHxxHEAdW+NRss1E/k
 KGO0f1Zc5J0dAKvD/snwdpPiN0ANGb6ce/CaMsw/vlY4xvcG4VARljVM+R/tJ3oGzB4MuOc
 ujA8FA3I/STsGKTULHzpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:evC9/SaP6lM=;N7mXGQmLC9Teqlwzt2D82EE1h/f
 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
 2ZtrWn7tZR+fbXhemabPTpv0h9AXh

----Next_Part(Wed_Feb_11_10_17_07_2026_761)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi.

This patch adds support for the gamepad "Nova 2 Lite" from GameSir. It is compatible with the Xbox 360 gamepad.

Thanks bedforehand.


----Next_Part(Wed_Feb_11_10_17_07_2026_761)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-patch-v1-joydev-xpad-Add-support-for-Nova-2-Lite-fro.patch"

From 124e8e9057fcfb2439c195fe17f498da22802a18 Mon Sep 17 00:00:00 2001
From: Qbeliw Tanaka <q.tanaka@gmx.com>
Date: Tue, 10 Feb 2026 21:51:12 +0900
Subject: [PATCH] Input: xpad: Add support for "Nova 2 Lite" from
 GameSir

This patch adds support for the gamepad "Nova 2 Lite" from GameSir. It is compatible with the Xbox 360 gamepad.

Signed-off-by: Qbeliw Tanaka <q.tanaka@gmx.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 363d50949..8d96349c3 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -421,6 +421,7 @@ static const struct xpad_device {
 	{ 0x3285, 0x0662, "Nacon Revolution5 Pro", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
 	{ 0x366c, 0x0005, "ByoWave Proteus Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE, FLAG_DELAY_INIT },
--
2.52.0

----Next_Part(Wed_Feb_11_10_17_07_2026_761)----
