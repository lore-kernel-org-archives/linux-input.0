Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3B50EBE0;
	Thu, 10 Sep 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058676; cv=none; b=JSlszPqL806uJHmM+b7iMPo8ACdVy82b0Y9udMmEV/BprOn2y58XJW+RZukD9NmJzvsSsbC1X4BuQ4mU196dpM3bqW7i4kXfpuYb/GFjl7EZM/D/T5aQjNLX68DbMjpoF0+jArIYigginrNsH0MZ9YC7Um36Gu/w4sOGP6/OCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058676; c=relaxed/simple;
	bh=eLJunRGapd+NAyYnBkmT3gtHDHbwMV6Md2sdXTELOCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yz+DS938DD1GSgvaC2XUSCyXwHO6BfQ8DdzCerJEf9gsnSg9OWkszMQPF5tdF1HT9C+FblUMb32efbDUzMqIJHWOisw4AlLBmGNL0E/PbseU7jjlHxiKCW7ifB0u/kq6xbGFbbBAlQUEQlACa+B1rNVkGAAXQC8TqoOVlDrxJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EbAFa2EQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EbAFa2EQ"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0798780B7F;
	Thu, 10 Sep 2026 18:44:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smildPEo2dfE; Thu, 10 Sep 2026 18:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789058669; bh=eLJunRGapd+NAyYnBkmT3gtHDHbwMV6Md2sdXTELOCQ=;
	h=From:To:Cc:Subject:Date;
	b=EbAFa2EQ0As0lFSWqW3edREH22rMQN7neUfKQG2VMsHT9IphxSxaYK5p7j1y+KmwD
	 n/WQriWWTs0m5ddjlyqxVO/H3TDXxKWbci3Vqoc5DbQu6u3MXMe9Mci4nwGr228RPE
	 GTwR5DZBR9T62799HDrZx3P0Vx1rGdeUoJGkV5Ylab01xqymT2nwi+2sdZu3/KXgc/
	 AmHSclsA+zuQeeeCWPuCDCsvDYDlaLbk4QulXsR71C1yZCOu6bxVWvCJ3Tn+vuobRX
	 QoAziADGc7Yy9xqsoLFt0Y3Xc6EJWXzYGunZWjqZIyM+S5NUi9PLY1arWBKMkCdZCV
	 LptIqg/dDXNXg==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH V2 RESEND] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Thu, 10 Sep 2026 12:44:25 -0400
Message-ID: <20260910164425.12832-1-rlarocque@disroot.org>
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
+				     "Disabling intertouch for board id %u\n",
+				     info->board_id);
+			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
-- 
2.53.0

