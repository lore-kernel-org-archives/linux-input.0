Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2337BE64;
	Thu, 20 Aug 2026 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259665; cv=none; b=Df57h8AzjGWPwuXAqf0iZ5TOWa/Pd7xXMFm/1p3mxHJLSLZIq0wCw1KUP2dsv+ntifYa9QeS7rk3Y18DWaQfnsQJnQFXytjaD61m9KxQZkRC48V50TvCTxVIGzOCzLecEG0gHaMwQZuTE+ge/RhVuEC4ihoZeyT3U9K+fGjSCEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259665; c=relaxed/simple;
	bh=1yW4Ij4G59n+zZgbSMAfC3FRTS7pbUij1qq8AKLAI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlFiXqLH7hyrAv4Sm+15R9TcX4una/CjIUNs3iLNQgbiboziklK/gknOuf/7P9N8wZzVstlF7+4NWvrYbfuiaH9/2uymNfrS5qTquOoycIrFRcd0zq3ow95KuIi59LDsh+rT54kSYiDbst90LKGIzz+Wf3Q4TIdlBRsxhVzGAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Po+vYSwu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Po+vYSwu"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7A90687A68;
	Thu, 20 Aug 2026 23:01:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qAHr7fyi8Ypz; Thu, 20 Aug 2026 23:00:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1787259659; bh=1yW4Ij4G59n+zZgbSMAfC3FRTS7pbUij1qq8AKLAI+c=;
	h=From:To:Cc:Subject:Date;
	b=Po+vYSwu3tdNWWg7E/G8HzwiZ1yC0ZFVSnbX0Bgh3aF9/ndfQQjKcXnzrUk1QowJQ
	 i2NAeroT0iot+IdRpVjuB6zT0xFVcueEDLmA6RjgBDc+WtrQw+Z4jf9HLYVGoGXLeo
	 SetgIiO4qU6CgG7IOT5E15VCxo9aqFqQCV5WhZ4WP6Q7w03/3iDx9sO56gXhjIH2Op
	 Wpm+scl3cCSLMQBwIC8uJ1i0cUz6jQ3sKZTCmaHsrdLTZaAwSroTX6MP9+HcXBo/TC
	 BK/GQd8Njos+sg8EO3bWlzFIpj/0nVUEgtVc8W3sqxuzykk+G+oQzo3s9qcxkQvI4c
	 VKNdYpmxYQJHA==
From: "R. Larocque" <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	kees@kernel.org,
	rlarocque@disroot.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Thu, 20 Aug 2026 17:00:54 -0400
Message-ID: <20260820210054.12933-1-rlarocque@disroot.org>
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
+				     "Disabling intertouch for board id %u\n",
+				     info->board_id);
+			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
-- 
2.53.0

