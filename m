Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E5B640
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737922; cv=none; b=rLDDGYPmn2qsaQAZieSyVOEJV8YmYpcvHqz+Ejwh9s0yIerjI79diPddu4lXSv68kYLm+JbVvS4Oco5j7UNoUWdzkGS5esxGFbOBhaMuqgDc1va+sgzD0ovZjbG2ZGY6jT0WuF3n+S6xvLlCqWeZFBG/i4a1CtKhrHWwSE3EKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737922; c=relaxed/simple;
	bh=XqIirb5a6cC1sxfVg83nKEun+o0hRjnXt2lHt0Xl158=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aexHzGMjOJcTjRuSKQCf1uz+ZUdUDHZerWC0bKJ64w8AdVj7ddr5qxCTAz6czOI/owI6vLsSXGfP/jNoe1Pe6WbTDvoqIbpjidN0N9mhRVye+OqDgmEhrKt/YIKI4M45g+EClDPCznYqKLmF+kZIW5PXznuK+RoKIqRJPFjv7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=wWvKXyKw; arc=none smtp.client-ip=213.209.10.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="wWvKXyKw"
Received: from KnightIndustries ([151.45.156.93])
	by smtp-33.iol.local with ESMTPA
	id FwsYxDFtdDle7Fwsex26on; Sun, 11 Oct 2026 18:58:37 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1791737917; bh=uNkgmZjAvfGMYFRXdH2RlObaxfWFeLaTzbmSRv/syWA=;
	h=From;
	b=wWvKXyKwfiYNDYenoa3LsvN9HJIK8/6/EA+Mp/yt7d6bhp/yFzeJumC1g3nyfMk7b
	 1UtiSxmKjZjRGzhbDU0fK7KYMIiGe4k+/2qpB8mlGZhrxDToK1QMOZbZC0GXg1+rBx
	 QSJIkS2lmc2otdTEBOAQ174E403FaSBJmLzLFRRVVA0T0YsBD2sVRhCJorxcBSzgar
	 /IAKFzvx5rgBWZXoL/mOFoDXDp7tHTFyY9degtuEb+S5ug7FzvISBqvh97nPFTuu60
	 mNi1OKjo32yiNoZV34KNLC8eG3qnrLwGnJIkvkwVJu3Bk/VmfsLAIumuzuYEbDcBhM
	 3TrHfTu4vxl5Q==
X-CNFS-Analysis: v=2.4 cv=CMkamxrD c=1 sm=1 tr=0 ts=6acbc03d cx=a_exe
 a=dMomL7OUOMxyzfrmwCBbWw==:117 a=dMomL7OUOMxyzfrmwCBbWw==:17
 a=QmeXOjnvPUAQAOWKIboA:9
From: Francesco Orlando <francesco.orlando99@libero.it>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Francesco Orlando <francesco.orlando99@libero.it>
Subject: [PATCH v2] Input: xpad - add GameSir Nova Lite support
Date: Sun, 11 Oct 2026 18:58:21 +0200
Message-ID: <20261011165821.72698-1-francesco.orlando99@libero.it>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAieVIe8cCOntbyKDs/EE49ysJ3KmmdOI8O/NU0mAM3jrjCofzlGh5I5DsAEo/O9zd+lU173xiCczMfx6nHxrtb4Yu/PjfkbWyyghZqHzekdJENqmm5f
 lnO3TvA5SZgAo4CY6uKwHi8/RxDeRdSvgAwy8dzCpSs+AtOFkDvpl3PNeyvQ5n860fiBzouFX3Kap3Ni4z5c9E13SD8JLATV1ISFJel37aLGoA0kUK6L+QOc
 g5YYLk3ZyOsv9tenrUJSv2eQyVrfFsIHf6V+O3X3NA4eKy4GDDSY3nl1d2eT/D/R

    Add vendor and product ID for GameSir Nova Lite (0x3537:0x1040)
    in XInput mode to enable force feedback rumble support.

Signed-off-by: Francesco Orlando <francesco.orlando99@libero.it>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6406ceab9..2076f584e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -405,6 +405,7 @@ static const struct xpad_device {
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
 	{ 0x366c, 0x0005, "ByoWave Proteus Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE, FLAG_DELAY_INIT },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
-- 
2.56.0

