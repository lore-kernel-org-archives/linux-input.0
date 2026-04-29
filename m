Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B373191F91
	for <linux-input@vger.kernel.org>; Wed, 29 Apr 2026 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447276; cv=none; b=FDjW6A9t8W2hm136ix7MakN4tjGbfwxYwvxZV+XC4vBVUXfHxvWjIl2YvEc//RqbTVsMB0ZjbGrdjJFtf/KVhcIVzh+B7jUfuWHHmECbfOktxQ8+EVeSIX1W1s6dZ3QzFPChwuLvW9ZkyD/zC6w/wL3ZOWWwCqUBU2wBabJj+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447276; c=relaxed/simple;
	bh=E8L1Hzbvfn2y7DKHe5YQ5PKgqB/nRGPXhOMcNqIRP9E=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u55PTDh2BFSZRXW2QPv9qtiqf+OQatrROZXgpPZctZ4HpViYmY6Bx3cNSrXV80Rqmwnf54Usswigm8yI/cAHVnpdnGaM2AYGj5kW5+Y3tI9Te85U7j7W5iooSREWeSdaPMye+R/HKAWSN7VEsCfgML5pPCfCptRf2YVPUzKcjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=q.tanaka@gmx.com header.b=d8fIBCyM; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=q.tanaka@gmx.com header.b="d8fIBCyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1777447272; x=1778052072; i=q.tanaka@gmx.com;
	bh=h0H1MLNOGjj+G/8jbnIF6d3F52nAGjqWWE06gd+FYCg=;
	h=X-UI-Sender-Class:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Mime-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d8fIBCyMfpwGgA/ltmX9EJjMXQ/yHHDY2oK8uxZU7m2YoM/XZ2UP1hZyN7ovQvBr
	 +oCCXDpurl/7ta00RqDB3jhvhTg7I2au11znJyvWt6QjOa+ff8ypNG/tCtlhl1Oan
	 kuOtVoTAIk6JYtmj/Ib5Ld+Ckf5pN8s2iDUos1RpIfuqLgiw3OTVRpWcJH//HTvBa
	 E1J4JkJHq+BtFU/FnRAL4BlzcMqVO/QRwccCWOTpiYCR3uW5f/43tSYu7TTelUz0z
	 PDwahUWW8jVsPsHdtIF9J4G7bryfZOgTTxaQAW06pHOoCYkWCkKlf6ztGYlSQYNrb
	 Jax3RbyQCsbPdowfhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1w7Uq520U6-007nd4; Wed, 29
 Apr 2026 09:21:12 +0200
Date: Wed, 29 Apr 2026 16:20:40 +0900 (JST)
Message-Id: <20260429.162040.930225048583399359.q.tanaka@gmx.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, q.tanaka@gmx.com
Subject: [PATCH resend] xpad: Add "Nova 2 Lite" from GameSir
From: Qbeliw Tanaka <q.tanaka@gmx.com>
In-Reply-To: <20260211.101707.2126959894059795107.q.tanaka@gmx.com>
References: <20260211.101707.2126959894059795107.q.tanaka@gmx.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dseRsprbutOpJFoEdMtnDt2qUfSLc5EPwdBgnL8eJ7ank2Gsbje
 Wc7jGcmS2j/gtpLTOXQrqAPOxBeXZKWk3aSLe3qo15SdczTEjtLp4U6OClCg9uSN3K+OvHP
 v0fFWpwJeVowJu0DX3z+KMOuYu69zD86smnhdvFQaJQ6aIZKhdGFoO4R0n3jpREMxwyH1ZN
 CFZ1PxGw2qWzIyLuRaXag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L+kMhbuWew0=;H4+ZHwRSdtIqabcjwcyJQJhc1g9
 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
 6aSo+2DCCy52jRw==

Add support for the gamepad "Nova 2 Lite" from GameSir, compatible with the Xbox 360 gamepad.

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
