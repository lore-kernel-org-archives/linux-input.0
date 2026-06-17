Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D823EEAEB;
	Wed, 17 Jun 2026 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696744; cv=none; b=P7BNS50QH40RykrN6AMYipx909dTpFY+MW45QAW7IMF1mjaXj5INuH/880UIgM+nDnoTUwf9Ff/BC4b6h/rh7QEcKPYuADDmvA0+cOYinCXeifiTmRVtfgBbW3LiSn81jwPiHKsL6cxTNyVQvgyuZkzQWR2AkJVMIBmClGQwRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696744; c=relaxed/simple;
	bh=umjdSoQmgd00z5R0nCn5XIOnaGqNBTlzyV6w/NbhZmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3wqEwriWrEX6Wv6N09b6xGmkxzYeKK968/NUmx51t6evSiO9Tfr3B+Og9f8BkV2YtyKAA1xBLo6Imcwab97RM6un2xqwsQgwPAe0lgJG7gvEpj1FuKrC/VCBC0WcrppOMvEGDByUGBUE9DHZXQ+dGzDbNS2aUqMm/+JfgNLG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XKq+ls/+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XKq+ls/+"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0C276262D4;
	Wed, 17 Jun 2026 13:45:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fuYwqK4s-Tqf; Wed, 17 Jun 2026 13:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781696737; bh=umjdSoQmgd00z5R0nCn5XIOnaGqNBTlzyV6w/NbhZmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XKq+ls/+UuvHgB8Syg2k/IWviNUbp+gemh2LWa95lj3cZ7E0D3ciHd3SFU80iucKU
	 QLv+8+glChaH0crBwHCtX7Jv6q/rbhjS720bAHS+zOD3Zw5Y+qGvXw+4UqZ3iAiUnV
	 0u++dMplNI/iHBqDzIutc7UN0fhhJBd+7GmG5pGZHiEP0jEetqR+4KYF7UAzCKZjoB
	 /H4z5GewNr97wT2cnK+M4gw6uE1JjOflDT5K7zdRYV8hmGL2dbt6sJMITjVPH5HGcY
	 eVByrufHNs1nvgHinRZElp3wiio/4F47iLHnPoLG0HAA3RUIGh3V2vMQi+wvvpH/JJ
	 n7rDd+M7fK45Q==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH v3] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Wed, 17 Jun 2026 07:45:31 -0400
Message-ID: <20260617114531.146885-1-rlarocque@disroot.org>
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

