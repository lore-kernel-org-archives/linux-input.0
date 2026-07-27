Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB13BBFD0;
	Mon, 27 Jul 2026 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168712; cv=none; b=PrxTM/DaYLU9C6lm481hjCgj28Bnjn6EfOWPLm5I8KnE1+yqmkc5g6P7pj2337yUWXzR6bjrWIAoJqG6jchc9Ae0syjWjIYIQVvERSNRhRnFYLD9aYzwjeNiiVBbYuOMyxrk6OSscrGpRnsFW9fryytF/II3LmsX1U3uMmrmrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168712; c=relaxed/simple;
	bh=y5KFPr3c0EO2yGC/tBN6MG5ls5ri7dOPlK8yL55MxIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JW6ZaF8juUSdnArCWH3tMUC12bJeyqDvRzeqKu1j6BV5uocI7r63ZRIJ/l5bKdjU0Y/ahIN41+92yirgLIB+SkP/EHi2ezKN4bOO+ncWextHdnZSLZB1bNEk4uKj/GNKAbuyq4fl94+soapBWfVK/A4ePyDVPt18C8qVV5gVO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Du+FlVme; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDdAviUY; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Du+FlVme";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDdAviUY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C634F1D00193;
	Mon, 27 Jul 2026 12:11:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 12:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1785168708; x=1785255108; bh=RO
	Mp4GkUqXnY54hDlWK9x6AHoRqPCCjcVEz/XUUK/U8=; b=Du+FlVmeQNyy/Mzorz
	hCXVOA+j1TgKDVL0pQqKkpotxCRIuHEhKJRs1K0YrIIHMnj+QuSCwPSklK/EqN0G
	Wdj6+MKS3Rsz0Unjlkv6hLhGqpW3V8mDVB3G6ovSj410Hi5pfldAk13xXhwBCYao
	qxhWzD3oBWZRbkY0ofMKHncfbgV5JQiL5WqvWnypkGZeEAWshPlt2pB0TZ0LZV7y
	UMHtL8YUqb1NFzbb2PJ49MYC2JX1tK9uZbuFS6izEd28y/fOpwdDACQz/Vvv9Lr9
	t9K438HjeVFcY1So3/LeAZZk7UJC5rMCwVdyYnIgOlkUPw4niqBTZ+629NPqziyc
	HYmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785168708; x=1785255108; bh=ROMp4GkUqXnY54hDlWK9x6AHoRqP
	CCjcVEz/XUUK/U8=; b=NDdAviUY5zE+qSg1PTv1qJmKmkodyS8Fph80aJYsvB17
	EsjyjjoptO77n0kDmZ8Ke8dN4wPz816e4jxaq/M0JiIB9hAoZ0RxsVicWvAtjS2N
	sFeuTo8quZwf678o4oq7m1uN2PJd351tBPkh39/jAzzn11zek24dX0NhBZOYnsjc
	4GbPK1cPVho2d63WijmcgH2NnoexHHXvOV9f0qz7IzVc8eEt7UE/UsNbQur9ryDR
	FUpInPfdZkr9RB6ohUovLkAtdkoua4BfvaGNi8tZhnPWFY40TXKSA89Rg7CycVBt
	AcQiZ95m+fdAlbgScFCK3UVq1X7rnJs9i2FXZ0uGmw==
X-ME-Sender: <xms:RINnaobFDMIREbza6s_IOCmYtobrdcVah7M9_CZtzjsYrq3kZn1bww>
    <xme:RINnahOMjj3hz_ORIsxiCzd72x_fXl-4KGw5aNPZr2BC452pHCu40D5eVil1o7EhJ
    psl8-QzWsKnQNfKr5DCZWOsl_JMm6gsA-lf3MyPKlfUJnGD3a0>
X-ME-Received: <xmr:RINnatbrT5A3SoRiARariFoPPt_vEf05RIVIuLobYpsT_fMrb51BIOnxW_HcSSnJeTwuy-4oYZ1-FOlrir-9R57v7MMhOTsIdg>
X-ME-Proxy-Cause: dmFkZTGHp40VqsUl10ueQB3YVNYz8GTUCXLEMI0Jq47EB/Zhr2P4E6GugeQ+YBzsUhM+E2
    +D4S3jF/7T0iW+EkXKzs/VVysBZathdzpW5hpdQSPoc6QgQieJP9ioZCt1aQM0QS2R1I86
    b28jNZ70j0IwJDciXOx4OrkmONUmbRO9ZwU4raola1M6tzcWEDfIhnZVD37izFpcODHM4a
    EhyvsXimPZWari/QPHAbC/nxHs+mbr4xW0Y0ltDReSdEW+EWmlvfILmYqMW1bivhIdXD+x
    kTtUeV4oUix2in5wMTSyCoSwHUPyog/306WutfIipLHD85RQJL431W0KkMMjwtvsuW8drl
    e9Y6mdeSlfxH/Fthlh6CV8+Qr9eDVllx/eaBkCs7mx0fEYxgeZT1U8ksyWIYcui1Pgg94P
    wgQ7Qnu0UTrr3DdnlX1+kHpHHEZ3LZBwLFgIFteRzPXI0wSWd1nA/U3CzrOB6r0HuiOZoW
    yGnC+dWtpJuDINqWAwCtAxEIjUeCOQTzBplSxXoTC1PUMf0HBHDg0AkvjiZlFOz29XumSW
    4GcKDkBQM82Xcb6Bulk+aY9aeigvzXnbKRCejHtlf7rlKrbVTeWmW7q+HaUftFOH29Skys
    t/ZDu1+5676iAvYk7wX8GGK68xmC5aFb6bycjwPsY5Fnt4gXJTbT5poPDTBQ
X-ME-Proxy: <xmx:RINnav37x4sjvquUJoiTvPVfulXV9ZrIfc91PMyyXrzFagaznzcW6Q>
    <xmx:RINnajessmur1fSozY-3vGr8Zepx9ngmP_Stx63esK_tsACmX5hskg>
    <xmx:RINnagGkrfFeBuvfqB6sCYRcTHavkSn4bbUW-Cuv8s8dnWrxJdcWww>
    <xmx:RINnak1NRppAl_3AglLjPN1L2MBA1zsLDaF5Fxrc7pE8OMG-qYlslg>
    <xmx:RINnaqyZjoHVXtLg0jLFIplBUFQVjl07JOP8rkplG-BNjqDFmtKAAjUr>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 12:11:47 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Date: Mon, 27 Jul 2026 18:11:24 +0200
Subject: [PATCH] Input: xpad - add out-of-bounds checks for xpadone
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-xpadone_length_checks-v1-1-19aa9331e82d@kroah.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrBuIQUzbq5QiGn/NtCVKRkUQ7
 260y2/x3kaCyBB6ZhtFLCw8hIT8lpHzdeihuE0mo02prbFqHet2CKh+CP3kK+fhvqL0PTe6eVh
 bFh2ldozoeL2+r/ffMjcfuOmc0b4fo472KnkAAAA=
X-Change-ID: 20260727-xpadone_length_checks-08120b97764f
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785168706; l=3792;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=y5KFPr3c0EO2yGC/tBN6MG5ls5ri7dOPlK8yL55MxIA=;
 b=weIMrWTx8e3EcZEt81gegVZqEvdkB3SWqURbGh7SpDqUpBPIU9KaJr2Y1kWXIwPe5HMu84PyZ
 25IT1ilKUvQAfUbf2nqgDeOjeWLoZ9rheEQR7kTTnam/1Vov4Lj2F6O
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

Add size checks for the "len" variable in xpadone_process_packet().
This prevents out-of-bounds accesses to the "data" buffer, as "len"
comes directly from the hardware.

Assisted-by: gkh_clanker_t1000
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/input/joystick/xpad.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..abda6b5c7c95 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1035,8 +1035,14 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	struct input_dev *dev = xpad->dev;
 	bool do_sync = false;
 
+	if (len < 2)
+		return;
+	len = min(len, XPAD_PKT_LEN);
+
 	/* the xbox button has its own special report */
 	if (data[0] == GIP_CMD_VIRTUAL_KEY) {
+		if (len < 5)
+			return;
 		/*
 		 * The Xbox One S controller requires these reports to be
 		 * acked otherwise it continues sending them forever and
@@ -1052,6 +1058,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	} else if (data[0] == GIP_CMD_FIRMWARE) {
 		/* Some packet formats force us to use this separate to poll paddle inputs */
 		if (xpad->packet_type == PKT_XBE2_FW_5_11) {
+			if (len < 20)
+				return;
 			/* Mute paddles if controller is in a custom profile slot
 			 * Checked by looking at the active profile slot to
 			 * verify it's the default slot
@@ -1079,6 +1087,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					 error);
 		}
 	} else if (data[0] == GIP_CMD_INPUT) { /* The main valid packet type for inputs */
+		if (len < 18)
+			return;
 		/* menu/view buttons */
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
@@ -1145,13 +1155,18 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		}
 
 		/* Profile button has a value of 0-3, so it is reported as an axis */
-		if (xpad->mapping & MAP_PROFILE_BUTTON)
+		if (xpad->mapping & MAP_PROFILE_BUTTON) {
+			if (len < 35)
+				return;
 			input_report_abs(dev, ABS_PROFILE, data[34]);
+		}
 
 		/* paddle handling */
 		/* based on SDL's SDL_hidapi_xboxone.c */
 		if (xpad->mapping & MAP_PADDLES) {
 			if (xpad->packet_type == PKT_XBE1) {
+				if (len < 33)
+					return;
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1165,6 +1180,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[32] & BIT(0));
 				input_report_key(dev, BTN_GRIPL2, data[32] & BIT(2));
 			} else if (xpad->packet_type == PKT_XBE2_FW_OLD) {
+				if (len < 20)
+					return;
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1178,6 +1195,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[18] & BIT(2));
 				input_report_key(dev, BTN_GRIPL2, data[18] & BIT(3));
 			} else if (xpad->packet_type == PKT_XBE2_FW_5_EARLY) {
+				if (len < 24)
+					return;
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260727-xpadone_length_checks-08120b97764f

Best regards,
--  
Griffin Kroah-Hartman <griffin@kroah.com>

