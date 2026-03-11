Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602F37AA73;
	Wed, 11 Mar 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212912; cv=none; b=euuut7crOrfM7e+fB0IbVjvf+eC84Te+ViB10YgzdwSK1AbcOnJzczo61swCZzDync8qS7O38O+t6UtPOgw66JlPe1npNW5kFZ1Cv66HaPJHmFcZrhaBP1LpN8Cg07cpDMiXKUMtuB462ZdRF+IZyyjEPzCcewzov1DCKfSEpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212912; c=relaxed/simple;
	bh=9Vnkik4lqwJu6UP/zBMvBHcMJMmLJshFmMDGbv95dDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q15DM57aYZlccTeMM7RxXnbA7SRvEzHJXcuoeBDIgsaMg8eWMV/7cnawUxY1KNDIcmjqnDHJ/ZYImJgq3+pHDD2H6qLNLxu+JLJ+T3ahAoVanHomAEbBs2ZHEZTTcVabnwIHSxiGrTLUvuptXW/7/2mPQ+/UH/d2m2CvXaT5V9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A34xI0fX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A34xI0fX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBA87C2BC9E;
	Wed, 11 Mar 2026 07:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773212911;
	bh=9Vnkik4lqwJu6UP/zBMvBHcMJMmLJshFmMDGbv95dDg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=A34xI0fXTDf8KjBPltbq1hvBzaWS/wdmhSvFvE+D/oOLAleWfB17fr7wosSamnxXq
	 u5QrL4OFgcFEswGxmmRFz7t+u163CB9JevzAuo7T00B4JLTKEVnBunrqequPvfX8hX
	 tvg3BRoZKOYMdH4DrCRJwTeI8aXNnSFu9x3dBdiaw1vZgQz7SfVhqpmIDKSPXSdQRY
	 8Odd3KPMFPFRQ6vdY/n6+8/kSFbI2KjZASOxKXWXBBJ8y9FT1gHMJF6K0IHeN+33Zw
	 G4bnd5+EebWEHn2dmLXbslwFaVFzq2J4Y5h8pyfDNpfeFDopAy/34tzkojBxzQpfGg
	 VRTnKfrvxVpdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8E4FD062F;
	Wed, 11 Mar 2026 07:08:31 +0000 (UTC)
From: Henry Barnor via B4 Relay <devnull+hbarnor.chromium.org@kernel.org>
Date: Wed, 11 Mar 2026 00:08:08 -0700
Subject: [PATCH] Input: atkbd - skip cleanup when used as a wakeup source
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-wakeup-v1-1-de0ca1e997bf@chromium.org>
X-B4-Tracking: v=1; b=H4sIANcUsWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MD3fLE7NTSAt3UZFPzRAuLRANDMyMloOKCotS0zAqwQdGxtbUAhyE
 m0FgAAAA=
X-Change-ID: 20260310-wakeup-ec57a88a0162
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Henry Barnor <hbarnor@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773212911; l=2223;
 i=hbarnor@chromium.org; s=20260310; h=from:subject:message-id;
 bh=MfJP1wyUZPDCLJM5KFWSmvdvXpl3DMtCkHxzp2gMujI=;
 b=EBNBVb+wFXuXKnmjDMVhfSzLCXBhJPFehNEnDOCPmgoB2jjUIBCiEsu3tw4C9QgbzCtUbQCOM
 vNH4MK6pc7TChRhImfj7YJyvbz4fz31jidkcxBehsnZCSRNYBFVsbtX
X-Developer-Key: i=hbarnor@chromium.org; a=ed25519;
 pk=JKPg5qzWEnyydlog1gYUHR7MFuQ8kSrmT8lacyNN9JI=
X-Endpoint-Received: by B4 Relay for hbarnor@chromium.org/20260310 with
 auth_id=673
X-Original-From: Henry Barnor <hbarnor@chromium.org>
Reply-To: hbarnor@chromium.org

From: Henry Barnor <hbarnor@chromium.org>

In systems using suspend-to-idle, the serio core calls atkbd_cleanup()
during the suspend transition. Currently, this function unconditionally
calls atkbd_disable(), setting atkbd->enabled to false.

This creates a race condition during wakeup: when a key is pressed to
wake the system, atkbd_receive_byte() is triggered. It correctly signals
a wakeup event to the PM core, but then checks atkbd->enabled. Because
the driver was disabled during suspend, the scancode is discarded.
The system wakes up, but the initial keystroke is lost.

This is particularly problematic for platforms like Android that rely on
the input event itself to complete the wakeup transition and turn on the
screen. On these systems, the device wakes up but remains in a dim state
because the initial interaction was lost.

This patch modifies atkbd_cleanup() to skip disabling and resetting
the keyboard if the device is configured as a wakeup source. This
preserves atkbd->enabled = true through the sleep duration, ensuring
the wake-up scancode is reported to the input subsystem.

Note that this also affects the shutdown path. However, if a device is
configured for wakeup, skipping the reset to "default" state is
consistent with the goal of allowing the hardware to trigger a
system-state transition. Modern BIOS/UEFI implementations perform their
own keyboard initialization, so skipping the legacy reset on reboot
for these devices poses minimal risk.

Signed-off-by: Henry Barnor <hbarnor@chromium.org>
---
 drivers/input/keyboard/atkbd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 4560d3964eee..1fba1932412e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -958,6 +958,9 @@ static void atkbd_cleanup(struct serio *serio)
 {
 	struct atkbd *atkbd = atkbd_from_serio(serio);
 
+	if (device_may_wakeup(&serio->dev))
+		return;
+
 	atkbd_disable(atkbd);
 	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_DEF);
 }

---
base-commit: 6d4b67a2a76a4ff2393fe88119ae4332821b82b4
change-id: 20260310-wakeup-ec57a88a0162

Best regards,
-- 
Henry Barnor <hbarnor@chromium.org>


