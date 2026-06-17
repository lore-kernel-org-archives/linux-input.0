Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49530C167;
	Wed, 17 Jun 2026 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667271; cv=none; b=IwpBBhfDZORs7OlaEhGDibeF1esBczyL9HOxNmxPx176A2zlGuu36DtYIH7/UBywWkJMxKTT3FGSfDqDg6qYbOgwL2lBIJsK7YDJo76oOddI43fmW1qmpFyAPYK+Hhl4KQOL4C+vbFqhSFd9cvqsRosXLGPp0+hkzu3saA5fn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667271; c=relaxed/simple;
	bh=umjdSoQmgd00z5R0nCn5XIOnaGqNBTlzyV6w/NbhZmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Krz4bMDLB0RpA1uEJnab/zACmHH4u49udVyILLfjFRne6oFlp7INPt4XxdEKtzdv/tKy09VEQ4cIWgX7f311mVG0gAZDrIwr8q0Ll+xjkUM/fYw65hgj5CDS/cJy3M3cb+WfiHFbvnPWRXyASLdnwimIg/4CQ0lihlHuPwyzA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=C3PWMajt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="C3PWMajt"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DA573277AA;
	Wed, 17 Jun 2026 05:34:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-0kIdq5oPW8; Wed, 17 Jun 2026 05:34:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781667268; bh=umjdSoQmgd00z5R0nCn5XIOnaGqNBTlzyV6w/NbhZmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3PWMajt2rGle+qMS7JEacbK+GeJXuEsGutnG+l9XpqpWMQlz6nE1En6LkG/8PdCQ
	 sWJkhRxudk06Jz0mHbAWLkgF7Gs1/mX7ORTk6H1mo1OtPspWq4qlNieO3fOLqMAW7R
	 wLfJmFVq3w33acTKB+s5BP/ksQbMo/tFd5kKHybt1vYR1TzFc25VqVc2+eUciBwSHa
	 AMwfRSDh9sFSDmZibG6mPzOcOAdphGkJelLf2ExWr/Xw49oo9EC9NrtFl5aqJECghI
	 ZBDv2MryuAKiObrUr6KVSzHp8OHxSDYDtgNN4uKZhU9U8L6fHa8gl2BLSFmfNcb7w9
	 /4xYdHhctxmPQ==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Tue, 16 Jun 2026 23:34:22 -0400
Message-ID: <20260617033422.54434-1-rlarocque@disroot.org>
In-Reply-To: <20260617025619.41237-1-rlarocque@disroot.org>
References: <20260617025619.41237-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Lenovo ThinkPad T440p (PNP ID LEN0036, board id 2722) has a
Synaptics touchpad whose SMBus companion is not ready at boot and
takes ~200 s to appear. During this window the touchpad
and pointer are completely unresponsive on approximately 50% of
boots, making the machine unusable until the companion finally
registers.

The device is in the topbuttonpad_pnp_ids[] SMBus allowlist, so the
kernel attempts to use SMBus/RMI4 mode by default. When the companion
is not ready, psmouse_smbus_init() leaves breadcrumbs and returns
-EAGAIN, the PS/2 fallback path is taken, but the device does not
function properly until the companion appears and RMI4 takes over.

Disable SMBus InterTouch for PNP ID LEN0036 with board id 2722 so
the touchpad and TrackPoint work immediately via PS/2 from boot.
Users can still force SMBus with psmouse.synaptics_intertouch=1 if
needed.

Tested-by: Raphaël Larocque <rlarocque@disroot.org>
Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
---
 drivers/input/mouse/synaptics.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c70502e24031..dd11ffdd51ae 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1837,6 +1837,16 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 
 			return -ENXIO;
 		}
+
+		/* Disable intertouch on known-broken board revisions */
+		if (psmouse_matches_pnp_id(psmouse,
+				(const char * const []){"LEN0036", NULL}) &&
+		    info->board_id == 2722) {
+			psmouse_info(psmouse,
+				     "Disabling intertouch for board id %u\n",
+				     info->board_id);
+			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
-- 
2.53.0

