Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A0282F1E
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733044; cv=none; b=pJm1/rJ3FS7o4MWhiYU6KRbKdXlljbhoNRg/DPAD6NyXDGawKtatVL6li5SuRARq/EdgP5FO5LFYbpE97xBXtyigJhO92laZZiAl4dmZSrxJkS9ImCMC2YE3ifc7oLblGqpMkF0srnEsD9zEz0mW5qPeiQvLDRV/y+0Rc5CHMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733044; c=relaxed/simple;
	bh=TXluLokLhWQnxiJS5jZwfeoysdUBM/mReUut4Cwhf9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLTz4VylP671wM2tQLoRVTSoUHZFoTX2y2zZ9V77pBhAhADICtCCP0MTwtJ0scHPFOIWCP3GpQjHMl2GpVcpuGEIIsRvMvXg5KYsY2QnQptyl4r+SATWf/7Zr4aPNPZdm+O40Wy/cdDOJiQS2RCVOpKZ1zE3M1pGly3HLP+DgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=vBXoHLVe; arc=none smtp.client-ip=213.209.10.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="vBXoHLVe"
Received: from KnightIndustries ([151.45.156.93])
	by smtp-33.iol.local with ESMTPA
	id FvZLxCa18Dle7FvZTx1plX; Sun, 11 Oct 2026 17:34:43 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1791732883; bh=62EleFhyZGwhO3p0AH1Pl1laLzKzwkSu5KufzyDZCwU=;
	h=From;
	b=vBXoHLVeGGd3E7tU3mtuGG8MCgC7bpIvePQzE/uBuP1xpCgUTNR+WL4SD4OJM9r1H
	 fVETnqHy7drDjE7/aWnK0b4BhOwlBBUJD8YsNA27nbw+BdfoJ9M3ebCRdBA8JrVB+f
	 uHfIvLAylxzdFfq7FeThj/ZsWHskFKBZssUqdwxUYcjBzX+Qpst1lnBkwcBxLBoHa2
	 5rsvqRpr/CxnrPzQ6fTzse5ghhck8TD39JJhJf61yoduBhiSnU+ma27fQR+KHPfW4Z
	 wxUHe++xgKE3d14lNnFxJN0F+QhzVs/sLQWupPSL8CQrkXgidkaa2Nn5d1fuIvvIEE
	 PIUiub2+FDX0g==
X-CNFS-Analysis: v=2.4 cv=CMkamxrD c=1 sm=1 tr=0 ts=6acbac93 cx=a_exe
 a=dMomL7OUOMxyzfrmwCBbWw==:117 a=dMomL7OUOMxyzfrmwCBbWw==:17
 a=QmeXOjnvPUAQAOWKIboA:9
From: Francesco Orlando <francesco.orlando99@libero.it>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Francesco Orlando <francesco.orlando99@libero.it>
Subject: [PATCH] Input: xpad - add GameSir Nova Lite support
Date: Sun, 11 Oct 2026 17:34:22 +0200
Message-ID: <20261011153422.66844-1-francesco.orlando99@libero.it>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPthnCyaYappShurNMWWFikDDn8aguPYzJakQVknHrIlQ5AMam10R9VwofN5wQQHcPF4Ta4Eo4QqDxwnywNnZRsT5BCADXvnllQwBKYm2cz9Iv0NKpCK
 fkG5yLM/Nno2uf1LvHRvyUoygsjYpJMP43qol52SqRZKHQKCP/qZVDXI0T0CPTwamUIPEWb6eG2iX583jIJqoyxa5wRS71d5rBMztLC9ve0OyDMn2FEFjxnP
 UZmmlmj9PEwj+jkvqDUHwpomY0eAkNh6k3GMO+tEei1Pmv42EgHPfoqWgMlp2ZK/

    Add vendor and product ID for GameSir Nova Lite (0x3537:0x1040)
    in XInput mode to enable force feedback rumble support.

Signed-off-by: Francesco Orlando <francesco.orlando99@libero.it>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6406ceab9..00a26693d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -403,6 +403,7 @@ static const struct xpad_device {
 	{ 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
 	{ 0x3507, 0x000b, "ZENAIM LEVERLESS", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
-- 
2.56.0

