Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B13064AE;
	Wed, 17 Jun 2026 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781664992; cv=none; b=aXvHXMNN5Vc9XqVsn6w2VI/NRDNM32ZcOsa6dvA2RF6lCyn/Q8pBzC2gCFSkvyGCdZH0MZsvIGLIrE7QezY4SeclB2nVjuqsCIERcGOC2QcpZJgO1yCozrVTgHcy/c5VZGHurSDkedzGP83CPv7RNja7foZvYB0GEXW1Ggt2o1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781664992; c=relaxed/simple;
	bh=bbleOu7QuFtAJZI7gnESuyd/yALZ/sWAcRC1zcKbYVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sy7d4qSS+N5wiLs018/YaN63vdhw54QZE2KEIq13YWrgP4AG+bSWy2g/xcmTUC0gLwZXxzgT1rZoGUJmce71wcKVFOiuhz6SDbactXojULxe58gXK/YIWorteo8oLHjcKAvMoQQ9C7iqB1wjtPETJqhBh4eruLV/NSquLc9WPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eKI2ws+s; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eKI2ws+s"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CE2CF277AA;
	Wed, 17 Jun 2026 04:56:27 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HuAjHemd311P; Wed, 17 Jun 2026 04:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781664987; bh=bbleOu7QuFtAJZI7gnESuyd/yALZ/sWAcRC1zcKbYVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eKI2ws+sLi87/Trk1Vt2jVPmFuvJ1FS+7qHWlVzdzNV21daB7D0mX/CyMh4AX3811
	 nXW+Lg7z6SmIfz9HbogDLSHqLFRAr/uHnxGmB5ZRKgTRYIc0ZyT2XwTrTzfbcgpXRy
	 ++Kj0iHnvUIBkgYvrM/583ezzTWwI56xh2+kdPvvOeF4m5liOJzAdWCpI2JC1wemTG
	 7vMhETCHTiDzoY00NrLAfPf7yHytFuIAwT3FyVGfXmW2kVE7bwBXaer3iqikmTwwnh
	 iXlKohQOyXOfTeX+7jaypIQSUonmntu8cDN7KCQXFiS9FQiluoSng6tMMJvSr5YNQy
	 4gsIrQKp8j2+g==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Tue, 16 Jun 2026 22:56:19 -0400
Message-ID: <20260617025619.41237-1-rlarocque@disroot.org>
In-Reply-To: <20260616171137.19069-1-rlarocque@disroot.org>
References: <20260616171137.19069-1-rlarocque@disroot.org>
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
index c70502e24031..982685918459 100644
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
+				     "Disabling intertouch for board id %d\n",
+				     info->board_id);
+			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
-- 
2.53.0

