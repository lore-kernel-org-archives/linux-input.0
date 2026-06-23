Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674337A4AF;
	Tue, 23 Jun 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224094; cv=none; b=u8cyV3vAZhYpZ63VzIth9Hg2a5RnxxU7rdYyq/6d3u83JjI1v1iFhCzL2uIpjdU3Cmrhw+4S0pLTNRLnqnfilGzCb17VMAyFaD6M8kizFIudRWzHi7uunlfN1pZpFp1IDXrnjuyGshDyjcOHH7yPo+IiNfIyD8iGfiVpgDLUQdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224094; c=relaxed/simple;
	bh=umjdSoQmgd00z5R0nCn5XIOnaGqNBTlzyV6w/NbhZmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y7QAd5i8HxmyeTtsG5m4unLM5aWaWasV4E1McqIsVO8/JmSw3/IRMEMMZOy+IQ5H5KfaNfQeIMYw3hkwElbLf+1fkvOaW/TkKs/WfsmvrKukENeooO2DraZIOy+m0qA6tE8hNQyL8wDjZ/SfVP0AyvD6JKce994sXOdAIWRoKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CwA+hg06; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CwA+hg06"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6B61527708;
	Tue, 23 Jun 2026 16:14:44 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6NjYsd_oM5R; Tue, 23 Jun 2026 16:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782224083; bh=umjdSoQmgd00z5R0nCn5XIOnaGqNBTlzyV6w/NbhZmE=;
	h=From:To:Cc:Subject:Date;
	b=CwA+hg06uoMeRqZ2bJruzp8yidXYgU3BbFD0Wa9C37tZZ/pNWN+oITwzE4DDaiTjD
	 kOMVfzwyX/gYXIReurjlNWKnh1hOZ1zYee9D7/y0j4MJg+OglA1l00zvUlHgrSH3Ry
	 2WvRur8yBLNso/hIMDrJHWWSv242fWHxUc409lpeDwSGUY1QAS7TmD+UFzhMxxTwlY
	 0PPwTRsuwcIrcpEaLNoV98Y8OI61R8BkjRtrIm4GN24pdJiFpu0s/mlqxTMoXF/pLk
	 +8i5Vth7KGJvFV3i2EfO3CkCGzpruaNfhmy/hrtpb6r9G/6BofzxDLHbPztmaCA2D1
	 ncH/k0C23QEsQ==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH v3] Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)
Date: Tue, 23 Jun 2026 10:14:36 -0400
Message-ID: <20260623141436.5781-1-rlarocque@disroot.org>
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

