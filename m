Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCC417D8C;
	Wed,  5 Aug 2026 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923804; cv=none; b=Puuyl+0sGsIHSLJG/72WMVC+Y2azC2WaTYV+bf5sym7qKZBBF92A8qpoqDKhqaWmCpJ/7VZKAmU28Ks5pRP+t6QOc8BtKFl0LFjuU+1SWYKW6PYIyyJpqNYYq0Xow5q6mD1CqAi/UzDEHC3z23WyIdSRJybIYSOaUgPG3y4gsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923804; c=relaxed/simple;
	bh=PCULd3aOCMPWlFtJNldzCFrdhWkCSzV7ap70zn+oqvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uh0fem0z3r38i4GX0Zn6jdH2t6XWcS1rt0cveYxaZhG2lj/tTVxzfWpFtb4z3L/VXL88DdA1njixx7lgOcyobjBzMbP/fFYzb6N7TVgkwhH1dnl5pnQlM7PdVu0ZtmUn8YXeJ+bD/b4R6UtVdH/T2OBEn0H7ff+Q/cegBlmnkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LJ0nanhy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GBP9HhoF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LJ0nanhy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GBP9HhoF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B6617A017A;
	Wed,  5 Aug 2026 05:56:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 05:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785923801;
	 x=1786010201; bh=EPzYfu2VEbdpjs22wUAJ45Oz2q2xsxBmXwFNif4jbP8=; b=
	LJ0nanhy4cl01fU9U4d5YQgcZ+3DaMF8lIaj2wAUgauF1DgYrfaU0XOKkfXRjZps
	xbk/UX18Kb3YCkHiPXu7HV3xTNKUgbWvsOABeBJP9v/jrJFfT5QTthBrd2WWXhC/
	VndTu9ZOKeZS3Q/9yqc4J05WLY9TVdTEO/oi52ItLEJ/aTHSe8bOIg6ddzOVjVvM
	cGRCWE3mS+5XSRfGlDY+wwVTVSHHUroX5QT3GVv/VWLrd6CO87PyaZW0zMypPlgg
	0x52iBG60yKEo01XmBxRaClMuvP0pi8YU49uPGORHckziL2h7zsygUc1qLJy61zh
	yLdteRKKrSJne2LiQj122g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785923801; x=
	1786010201; bh=EPzYfu2VEbdpjs22wUAJ45Oz2q2xsxBmXwFNif4jbP8=; b=G
	BP9HhoFiS2wIFiCzILREqU8dYvYkvcQmAXpKK4LGdVCYhLOPb0BkWwzhOegvuTr3
	CoOvlI0rsGL+K3Xl2IaUGi5P9BZGcjp4p6llQlAMeX4iqgV/9z1hyCcNtQdjByKI
	zhJgebNF58zanmJQVg3HRw66ZgvNbe4riww6CQJPLnfZGKvbWysXpsE/ptNCFwvP
	dEgX0NRPf0pWLemvtU8F6PifaP6czAJ2txdWJoryh5nLDcjZ3CAVU34pAHfsJTPZ
	bkqrKFeCcUNwusG0GnnanxpsQ7rytDUw6Ooy1YFX6v54CzkX0jd6hpG2qV42Ul5K
	yOqArDQ8JxRD8cSnqApsQ==
X-ME-Sender: <xms:2QhzaksiP5h2iKfvvT8CG7odAMBGFWKHQKRpgVlKIl-943le4c16-A>
    <xme:2QhzavQJ9QtCo1nZslHzuqdRJOqNSVsZBH1RaO4VqGblxVqs_NIzmUYamuyBJI6ce
    Nr3i2VPDMAF24WRLh7I-rAwubsQCWrsl7OL8lrQxpzK7zeptPA>
X-ME-Received: <xmr:2QhzaqOqd7B5wrwMJ48AZtCGuml4vYq5GnLU03jhd5l7LkYx1-uk7IoY9ochCkAC5Wa9CRhk5U784p_RDxrdKMhizF8w74w_dat-b66Eyfm0zj_wiWg>
X-ME-Proxy-Cause: dmFkZTErfihmOAQGP1owjinQa15+b58ASSp2+EpXbMDCY18TakmGdDOd7kS8QlWJHK6Akk
    JmZvI11v1vDpWVeMy6GH/+8SXf4DfFC67MWfsrwTuOZlktEcNWSO67WhyknexN3hurM52E
    ADVRYD6u8JSJGsN3tC4tRthmsBlaFiKaSBh3tN/tFOt1dPnIBaUdvkvArJT1bKgqhDCslM
    Zy6lNXyqgUvtM8btJ7En0SOupr11+pqUULhGqHA5Xo7BkWIYuoihnYrmFQrckUAzC8jg0M
    bT+BTxqemc31+eHPm7BJ8b9lOgPt4Ddk9WdbOw0GYMtz+Xdu83vxH5m557vnBS97gkeCVb
    tnNJkcEzzjOKJJhH/WyKWBwa+1KROm04wrYvIPWQGsx5SSJABlpJ2jcE/gSt06EYY0kQtj
    THLZDQBZ3N55cjMxp6rxn9wYVOYbqxyhT9+ZVNnx37yVWpDvE/tD9PJNZxFc1VtFqxfRHE
    slkHZ4vVpzPFkAHBePmlpexqSl+VXKyvXMHQixR1UzYr5UWFZH0ljasf+FmhI6QGoYCtWg
    u8tAn5y6sjjFROCuOQ+LJ5Q2Gigrx5W34H6kJaIc/XwnM43zEdJPdQcEV/LRk9OjTQpFqx
    xhWyFNDrBITrFy22lEv5szUehGQGosuSIhZDX77avSTl3JnmmKqBJyrsIpJw
X-ME-Proxy: <xmx:2QhzakZnHJ37-MnZpgsfJvkwUwApy3mcR9ixGYGEzdub25Ox0RozUQ>
    <xmx:2QhzakzwU9rmhikNeu8D62weTTcTMG1K_3CnFWQ-JEQOmJ0tNhgNrg>
    <xmx:2QhzavJ-3uiNu02Fj4HlrWr-Ns7MdzhQM9_tzsB2pF1rIXEfeOslyA>
    <xmx:2QhzauoL9JK0zxOEUQbWDhkLcp46kkH8cdjTaR4XkH_E02GjOdtWBg>
    <xmx:2Qhzarn6XgDvtixtAnGJzkc8hwdTcHJG_e59DOFX1Gr5K4gMQTP8wOkc>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:56:40 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Date: Wed, 05 Aug 2026 11:56:35 +0200
Subject: [PATCH v2 1/3] Input: xpad - add out-of-bounds checks for xpadone
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-xpadone_length_checks-v2-1-f3e925e0280b@kroah.com>
References: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
In-Reply-To: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785923798; l=3959;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=PCULd3aOCMPWlFtJNldzCFrdhWkCSzV7ap70zn+oqvE=;
 b=hdwHOTuwHLjZeE9ARruDXu9UwnlfRsmZC9R2472d+Fy7jVJtUd8nUnAxQJ7QjIyC2/niec6IY
 xxovh8JNV/PBV/6AaDPtbx59bhAoQCTVpdhe5cC0K1/X1wQ5dHgBVhV
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

Add size checks for the "len" variable in xpadone_process_packet().
This prevents out-of-bounds accesses to the "data" buffer, as "len"
comes directly from the hardware.

Assisted-by: gkh_clanker_t1000
Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/input/joystick/xpad.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..9ce792503b3a 100644
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
@@ -1079,9 +1087,13 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					 error);
 		}
 	} else if (data[0] == GIP_CMD_INPUT) { /* The main valid packet type for inputs */
+		if (len < 18)
+			return;
 		/* menu/view buttons */
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
+		do_sync = true;
+
 		if (xpad->mapping & MAP_SHARE_BUTTON) {
 			u32 offset = (xpad->mapping & MAP_SHARE_OFFSET) ? 26 : 18;
 
@@ -1145,13 +1157,18 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		}
 
 		/* Profile button has a value of 0-3, so it is reported as an axis */
-		if (xpad->mapping & MAP_PROFILE_BUTTON)
+		if (xpad->mapping & MAP_PROFILE_BUTTON) {
+			if (len < 35)
+				goto exit;
 			input_report_abs(dev, ABS_PROFILE, data[34]);
+		}
 
 		/* paddle handling */
 		/* based on SDL's SDL_hidapi_xboxone.c */
 		if (xpad->mapping & MAP_PADDLES) {
 			if (xpad->packet_type == PKT_XBE1) {
+				if (len < 33)
+					goto exit;
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1165,6 +1182,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[32] & BIT(0));
 				input_report_key(dev, BTN_GRIPL2, data[32] & BIT(2));
 			} else if (xpad->packet_type == PKT_XBE2_FW_OLD) {
+				if (len < 20)
+					goto exit;
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1178,6 +1197,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[18] & BIT(2));
 				input_report_key(dev, BTN_GRIPL2, data[18] & BIT(3));
 			} else if (xpad->packet_type == PKT_XBE2_FW_5_EARLY) {
+				if (len < 24)
+					goto exit;
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1197,7 +1218,7 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 
 		do_sync = true;
 	}
-
+exit:
 	if (do_sync)
 		input_sync(dev);
 }

-- 
2.55.0

