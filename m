Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F92E7BD3;
	Tue, 18 Aug 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085751; cv=none; b=fxBG1X/vivA4+EyCQlp+5buIVLE7Zn9zS3fLSJVe6eRepuGWUqCI7P8BXu/l//F/UJSgQuGHcVB25lDliTRr5zpjVRLqEvEpG6MInfQXxBi8i3GkVumUO67U1Ixzq67AGwS+ird37cBV+QSCCcK6hb4r0WaOf1tY5xBdgsxGqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085751; c=relaxed/simple;
	bh=ttesYcSF/j9GGKibNZOrrHsXM4R4gOLJaevptwqTfGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AM/RlgLwVGdx7U4sOJKJQXPy6EOlZ2NI6WcedCIV2CLG+I+6xoSlmuP2W2hKQKtj3HGXNhm3G3vNuKAtrEsalu+IgVuTHblisbR0ej+rTRXTpLmlXtMb7oEpxRkpuPcZlgLhrOygR7xE4IhevlT5eGIs+8/u6Y6UusU13INSOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=A+YVD9xM; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="A+YVD9xM"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5A9B288287;
	Tue, 18 Aug 2026 22:42:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JEu_JiG0l4uE; Tue, 18 Aug 2026 22:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1787085739; bh=ttesYcSF/j9GGKibNZOrrHsXM4R4gOLJaevptwqTfGc=;
	h=From:To:Cc:Subject:Date;
	b=A+YVD9xMiQY8uEkaPG6KCufHsUWk+c65uLrFs+boMAvuIow9ooV5vJPhMxhyoE7bG
	 PyHV4t3CaIpVw8NYeKCVMTaiKRWmK8I5/nBdutEK8VhTDkbZRcEleMzgBsc9O8Kkj2
	 FYCPLDOWhD8TwfOWJh8P3QDYp8tSbBFcyrm7yfdSzcoQGRyIhPHeW4bNuJOZQD43W9
	 hkN6ujVSY9hT2lBt7wW0uWTwhMZz6YGlvNQP02vZ5/E/qC6aP67o9ck/DONxayKARs
	 vXtRzMlkQ6UsfSzTY6QRxjSzJeLWqc12vSHIU62qvz5O/dKM9zWDsHz+EAL60tThA5
	 eniSJSLS3pxCQ==
From: "R. Larocque" <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	kees@kernel.org,
	rlarocque@disroot.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Tue, 18 Aug 2026 16:42:15 -0400
Message-ID: <20260818204215.72914-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Raphaël Larocque <rlarocque@disroot.org>

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

