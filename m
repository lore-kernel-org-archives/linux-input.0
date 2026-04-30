Received: from outbound.pv.icloud.com (pv-2004j-snip4-11.eps.apple.com [57.103.65.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70C4779A4
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574146; cv=none; b=QhQl7811ePkibFXfXWw2UlEqavhPTGxq+lzlDgZerQUGBU7Sz2oth8kxnFa2GG5+LBZAaM5gWu2Nth6vBDzb8gNIRRk1RJgQic7NVztxPrb2nM1bU8aozKrkgr1JqTZnh1oQFN3HEMrE1W/E7jRxSkr7DOEgrIrrlZeofgB+8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574146; c=relaxed/simple;
	bh=dcwyF4cvuz/slS8FZ+e6FOOD3JkaUyfHP9mubAbamwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaYKlVdERLcdtGHZ+kI+Jwo7Yd1OUAAC2PY/YdOin+wjFrPCkcW+wLFN0Qs0r+rwZYoh7kLRkmRLAnCcUWSjmXRw/H1oJvln+IUdqrXna7ZyTM6ZchgByqItEK+TvCaLL3B2rYxAkz5rVIRLQtaO+Q5qgj+kVeOZRXCznfKEv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zharov.dev; spf=pass smtp.mailfrom=zharov.dev; dkim=pass (2048-bit key) header.d=zharov.dev header.i=@zharov.dev header.b=GMSEOxkO; arc=none smtp.client-ip=57.103.65.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zharov.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zharov.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zharov.dev header.i=@zharov.dev header.b="GMSEOxkO"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-2 (Postfix) with ESMTPS id 63E9F1800108;
	Thu, 30 Apr 2026 18:35:42 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBMHV8HXBxCAVYCWwBLVxQEG1wDQwpRBHkCWwxFBEReXR1FTVEPDxNWFkcMVB9yClEZQQJBRVYVT1hBDgpfEhhcFFxQWB5GElYNXQkZG0ReUBtfAkIPHBNWFRMdQxkPKwhKBEMHRQJeCyUTCVNWSBhYClwbGQ9XBhkVWgkKVwBAC04DWQRbA0gKTQFfGVoAQghNAkAGRlEfVwxSDkMrSBhYClwbGQ9XBgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zharov.dev; s=sig1; t=1777574144; x=1780166144; bh=J2bls9ydMGM5ANP6CLMlRhh/bkCG1JSWUs+7d59Zo0w=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=GMSEOxkOOx8/oOPQ1lAM0nO5UuEiJ8mnfdZ18mLUVa9IhddlECr6zWDByw75yseBF6od6tXiRrNHrjg13aG9Ni+KjzM9dBV40WlxsvW0T89KHHmJsJehX6OgaUaxH7tGx/YDmEY0DoFEMC1em/kNmCk73f5HuLOLUZG80yj5xXqSSIsEonKYRyNSY95Xq2NUCblycO9cNPG/t9DbEabMZlQ0flUC/4bzKaLfxwZ1Hphu2yyh77SObYxrgiIFIwK6XaLOQWV9Gmxa4ega4Ql6+qF1ZOXvwqM0ve9kbHFfuCPugkfNKNRyy1+KaBUI0sH/EMqIpSf5YmjtjWxpST4R4Q==
mail-alias-created-date: 1702755994548
Received: from grater (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-2 (Postfix) with ESMTPSA id DBC99180026A;
	Thu, 30 Apr 2026 18:35:39 +0000 (UTC)
From: Dmitriy Zharov <contact@zharov.dev>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitriy Zharov <contact@zharov.dev>
Subject: [PATCH] Input: xpad - add support for ASUS ROG RAIKIRI II
Date: Thu, 30 Apr 2026 22:35:22 +0400
Message-ID: <20260430183522.122151-1-contact@zharov.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j3iYI542pld2JZm6e47f18J8cSsu2_ps
X-Proofpoint-GUID: j3iYI542pld2JZm6e47f18J8cSsu2_ps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE5MiBTYWx0ZWRfXyJG3vPnViFEi
 bv4JbdzVGrFYKMujyiGsg6YAxgDmVemd7RLxUc6UNjGazjjl5ILoUQFDqgiRMRfiuI4XtQd+ron
 Ll8hNPgT8NDBJpHw3FlJv8WpfpuHDeMWjwsthRs/z8BJO+iakcLymNWnjeOEsmUn2qciyXqINEK
 lS4KO+1Hg1NqyzNjt+z1imVwD1ume9sg04+NkFFLdZNYONejKsvbZu+9qRJEuuTvLx98E6fPrxj
 52QlhbPryMiIBoxrSZhwEGggz5syvDW9Z93/6K0Xz/EkFEN/YkizqjjMnodC7ReDyPMZsOEdF2j
 6HgBeiuOl9HgENSD81k4qAy8wesVb2J8OhA0a6rc78Iz5IUQ0ETGG50kBMvRCw=
X-Authority-Info-Out: v=2.4 cv=BcrVE7t2 c=1 sm=1 tr=0 ts=69f3a0fe
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mPQ374jQI6yuZqEZBz4A:9

Add the VID/PIDs for the ASUS ROG RAIKIRI II controller to xpad_device
and the VID to xpad_table. The controller has a physical PC/XBOX toggle
which switches between XBOX360 and XBOXONE protocols.

Signed-off-by: Dmitriy Zharov <contact@zharov.dev>
---
 drivers/input/joystick/xpad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 0549fdc5a985..f64c07d0ea38 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -186,6 +186,10 @@ static const struct xpad_device {
 	{ 0x07ff, 0xffff, "Mad Catz GamePad", 0, XTYPE_XBOX360 },
 	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
+	{ 0x0b05, 0x1c91, "ASUS ROG RAIKIRI II", 0, XTYPE_XBOX360 },
+	{ 0x0b05, 0x1c92, "ASUS ROG RAIKIRI II WIRELESS", 0, XTYPE_XBOX360 },
+	{ 0x0b05, 0x1c96, "ASUS ROG RAIKIRI II XBOX", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
+	{ 0x0b05, 0x1d04, "ASUS ROG RAIKIRI II XBOX WIRELESS", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x0c12, 0x0005, "Intec wireless", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8801, "Nyko Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
@@ -507,6 +511,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
 	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
 	XPAD_XBOX360_VENDOR(0x07ff),		/* Mad Catz Gamepad */
+	XPAD_XBOX360_VENDOR(0x0b05),		/* ASUS controllers */
 	XPAD_XBOXONE_VENDOR(0x0b05),		/* ASUS controllers */
 	XPAD_XBOX360_VENDOR(0x0c12),		/* Zeroplus X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x0db0),		/* Micro Star International X-Box 360 controllers */
-- 
2.54.0

