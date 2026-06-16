Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CA43D4E8;
	Tue, 16 Jun 2026 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629914; cv=none; b=KXJtaxWWfRMeF3X0zBIgZ0EA/WNx0ifoZpAMbV5/uZFRChuLwa4DjvreG5gFbVc7uCXJGUb5e9L88jAh5YfuWNISuCB0F5IxzPyLVdrqwxTWwqHgbO0o54gVndlIO2BpV9Soa4yr/LLLUOpQdhYAkYm8NAjS/nb0zJrNjFyNaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629914; c=relaxed/simple;
	bh=WhB90p3xsE+aEg4ZeHzDIhxUuI2E9r1hAX/8IoLSRH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WdyQldvg4iEeLoZWHAidqofWBakvgNM9aeECAb32tP/KbCb9nGQkRZw1xgImtHALzVITrsEBUykovaZ/StPQG9kcbF51WTFmDd3AZKYb2r2CiU75WvjWzjTJOdCqgC4hgYqu8GQz3W8ecNRtD9PxB1uTV+Q0/OKMkj3H7PXU3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FIZDxuHC; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FIZDxuHC"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 550A82720E;
	Tue, 16 Jun 2026 19:11:44 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fhnnEOeF8SR4; Tue, 16 Jun 2026 19:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781629903; bh=WhB90p3xsE+aEg4ZeHzDIhxUuI2E9r1hAX/8IoLSRH4=;
	h=From:To:Cc:Subject:Date;
	b=FIZDxuHCYEP6ysnhm6GFUiVI9GJX0NElrm0RtEfi2ee7ToP956RdNqjq3mtwFH5oj
	 yUOOgCfrNLi71uIO41dG3d7hLeKgjUNqPUC7RTxzuVCHpBIzOshF79Lgox+Wlicp+F
	 XHJ32p3akdTmD20goFF9riPhGouszJQKH13zjK9sU2i6xPxNOaJwGa/qvnqZYnqC+Z
	 0d6OemeZeocjqZzSdZ3xZEdX5G1hkpBMVeFparr+pvURWRDZZQREGl0H+fr+S7bdY/
	 j0HnF40TNSwRczJzBdnaYpqjbVfS6am5m6CZIjrqSY+hiGKYKQwt3TeM2oF1Z0sQYT
	 0ZMYjPmmy9Gew==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Tue, 16 Jun 2026 13:11:36 -0400
Message-ID: <20260616171137.19069-1-rlarocque@disroot.org>
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
takes roughly 200 seconds to appear. During this window the touchpad
and TrackPoint are completely unresponsive on approximately 50% of
boots, making the machine unusable until the companion finally
registers.

The device is in the topbuttonpad_pnp_ids[] SMBus allowlist, so the
kernel attempts to use SMBus/RMI4 mode by default. When the companion
is not ready, psmouse_smbus_init() leaves breadcrumbs and returns
-EAGAIN, the PS/2 fallback path is taken, but the device does not
function properly until the companion appears and RMI4 takes over.

Disable SMBus InterTouch for board id 2722 so the touchpad and
TrackPoint work immediately via PS/2 from boot. Users can still force
SMBus with psmouse.synaptics_intertouch=1 if needed.

Tested-by: Raphaël Larocque <rlarocque@disroot.org>
Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
---
 drivers/input/mouse/synaptics.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c70502e24031..8f38bc498798 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1837,6 +1837,14 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 
 			return -ENXIO;
 		}
+
+		/* Disable intertouch on known-broken board revisions */
+		if (info->board_id == 2722) {
+			psmouse_info(psmouse,
+				     "Disabling intertouch for board id %d\n",
+				     info->board_id);
+			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
-- 
2.53.0

