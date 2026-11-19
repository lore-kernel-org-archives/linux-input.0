Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795132055;
	b=u/g+jVe0DnnZejMvmaagoF+5K1ao1sNybTV90FLc9g36Qc+6yeFwsqjqzLjDH4OfjDdB
	 /P98WRw2SqERMj10O5+D41edoGIOhuSFLDVsfRgRi9FC2ekAL19HsFdR+B+CpBZxAwbAn
	 vopxRGJKn0rMdcsfVKil+Uv+C21RfZSLhjczYLk+Ey0dV6PwUqu9FxkHv7WVBGnL1Y8nt
	 BFv+VjvyedLdfswztFHSyL3RZHOSnE4HDSxo6enBxUI4eE4g7Wogq4Xh32qsrkTuNSx40
	 vxZV6r/t5WyMGrookNbN0p/s4NMT14U6gnbHlGsWSpPKsSRv9zjeTGG9uBAoGb7gXUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132055;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DTs5SOJWJp94kIlyxUY8f0JDFrAdULICMXyWcqzcd7I=;
	b=YvvxjOrhXdGyavK79IQ+FyQ+Fa/4ySwiRtSW7TSjKr0WLlq04Q+T37HfAe812xxJJICZ
	 o+fbIaqjlSNj+v9Hs5lVtevUUgU9+bhDXMUHAKCJWIRqLMa77IsaxCvWU/E0aWH9y77UN
	 HW2O1F5ccr+6NlP5Oatr203DizZak5dAGpmCGo2eq8fFrqlgnsCZOGit7LPLF21j6BR+d
	 XuuWbcH/EAmWKHnFBiCw+9e7B7+SEx9ifQIT3qXZkxg7dm5RyUemM5vX5Yw0Ren1F4cSK
	 yRSwfRu+5OM84JnHVGPZc0S3WzI08qohijYNPoJ2k8uKBMiStLBMfoX/1soXY1v89rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NycRdyO4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F65606A332
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NycRdyO4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795132055;
	b=RqRitfAIRollLQn+Y07CrCSVlS8jD6tXoFc5sWHE1kr8hfYNZNMPuksskU/XtopoSGGJ
	 9Cilce4vVkWxVU/Y5VtALdc/P5BlzH6jNiKxcpdT+q7AXGBLnVUY0WUZXNko3Vp9jhoy1
	 bQ4jGwN0VQARQGwZjo+IwQYGLAUTQKaAJZ2AUhwKLRoMeVH4yYzQwZ8pamZ+LFDu3RGG6
	 nQdz0AgdDSJQeC9d17draZZtmRnIqECyFFYoqBzi/bW/UxNQFe0MvFHfevw0UjLT3MSa9
	 Ww0i6X9+ib7fGmYcq3JNe2hOoFeE+OKelp9RXBAbWt5IAbIVMcx3MiJlK8EzaxWGwmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795132055;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DTs5SOJWJp94kIlyxUY8f0JDFrAdULICMXyWcqzcd7I=;
	b=Kt2w8IYINuXG6MmqkUkyRhyUpg2fPTMCAwV7B9WsfzD0Py6ndJ6Vg5l4xpPR5lhPJ9P8
	 Ke0LFsR4r1c3KmH0E6AqN2uJdSuHAPu8zJ/EpuQehY4TZrZT0tjgBQixTavlKm+ryldy2
	 u+63co01IdVMvAbApduboBT3mmWxeOWaBi49PECH8oaMqErs6ukWGJl0N2uKH7kOJQT0r
	 MKUF9+DSH8YaE+Sf046kY5AOGDSoEB3dKW2SWE0Z23WoJd0AIKe2Za1WsQSvjn0FQxsg9
	 MYhMJLK7fsDroKWA4EHAZJ6Q78Kv3B/Uu9Rl7SJpZHOk1KLsIYsmIzsQsPLXSuJERCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B5AE01F000C4;
	Thu, 19 Nov 2026 23:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795132055;
	bh=DTs5SOJWJp94kIlyxUY8f0JDFrAdULICMXyWcqzcd7I=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=NycRdyO4SK5df6eLEzPIRYOe7A0eVAwI2EhjhQzS1CxxW0YXISxVsJlNPgFP2JMLn
	 ivHQq+5XnbNgDx2E31pNkQdUZLylr05tYNx5dXWBLyweiYA0I0Ub75KS72lz9OB40t
	 Jcx8dcZ8P0UyqBGPi/nJCBl3R8POVA/C5UxKpcxWyBOwcnEGcTNMkg2Z4bEJF/7d5L
	 r1sw03/Iv9/qJj0tzpThxEhdMoX4cFpgW+C7YWkyCbF8qgBR4WeNdlCfowmnMH+g6V
	 A0UHJabXIA509wuC5bqQFn1mko81HwTLnl3Ripn8SRC89ymwQcJZK8DttCwZi/f+2a
	 yaQdCmqLi8B7w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 38F484235A;
	Thu, 19 Nov 2026 23:47:34 +0000 (UTC)
From: Joan Maillard via B4 Relay <devnull+joan.md.proton.me@kernel.org>
Date: Fri, 20 Nov 2026 00:47:19 +0100
Subject: [PATCH] Input: xpad - drop truncated Xbox 360 input reports
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-xpad-truncated-v1-1-74514e0498c3@proton.me>
X-B4-Tracking: v=1; b=H4sIAIaK/2oC/x3MTQqAIBBA4avErBOawJ+6SrQQnWo2JlohSHdPW
 n6L9ypkSkwZ5q5Cooczn6EB+w7cYcNOgn0zjMOoEHESJVovrnQHZy/yAqVE5zUZpQ20KCbauPz
 DZX3fDzx2oDVgAAAA
X-Change-ID: 20261119-xpad-truncated-1551cd7e8678
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Joan Maillard <joan.md@proton.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795132053; l=5127;
 i=joan.md@proton.me; s=20261119; h=from:subject:message-id;
 bh=tdp62fZVjV9JdeJU7vPAFFDtdaU/xYLcHfV3h/gbUnc=;
 b=+GQZP3vrDf3u3V7oL+0/froD6+KAzdgmO8XVsch5C+L3EF98jhyJX8Cu7WiscZyBJTBf6m2lo
 l/HhV1rFBW+B75jOBi8RTwYlIA3q/NzjncqiwpA0iE6zPsmF+vROfCc
X-Developer-Key: i=joan.md@proton.me; a=ed25519;
 pk=kywOHDNagSGO48kcqDUiYZklWcOrOiU0lmBEaVM3qWk=
X-Endpoint-Received: by B4 Relay for joan.md@proton.me/20261119 with
 auth_id=1574
X-Original-From: Joan Maillard <joan.md@proton.me>
Reply-To: joan.md@proton.me
Content-Transfer-Encoding: 7bit

From: Joan Maillard <joan.md@proton.me>

The GuliKit KingKong3 Max (NS39, firmware V5.9) enumerates as a wired
Xbox 360 controller (045e:028e, manufacturer string "Guli") and
occasionally sends truncated input reports. This leads to intrusive
phantom inputs behaving like fast and repeated keypresses, making the
controller unusable while wired.

A usbmon capture over 150 seconds with no buttons pressed contained 156957
regular 20-byte reports, 3012 transfers that failed with -EOVERFLOW,
362 zero-length packets and 284 truncated packets of 6 to 19 bytes,
mostly 16. Every truncated packet arrived within a burst of -EOVERFLOW
errors, most of them directly after one, so the pad appears to
occasionally send oversized transfers of which only a fragment
gets through. Most of the 16-byte packets are the previous report
with its first four bytes missing. For example:

  20 bytes: 00 14 00 00 00 00 67 01 87 01 47 ff 57 ff 00 00 00 00 00 00
  16 bytes:             00 00 67 01 87 01 47 ff 57 ff 00 00 00 00 00 00

xpad360_process_packet() only checks that byte 0 is 0x00, which such a
packet often passes, so the stick values are parsed as buttons and
triggers. With the stick above at rest, userspace sees D-pad left, Back,
left stick click and LB pressed, with the left trigger at 135. The
truncated packets come in bursts, so the phantom presses repeat at about
50 Hz for a few hundred milliseconds. The same pad shows no phantom
inputs on Windows.

Byte 1 of an Xbox 360 input report holds the report length (0x14). Drop
input reports that are shorter than the 14 bytes the parser reads, or
shorter than the length they declare. This leaves complete reports
untouched and does not affect non-input packets, which are already
ignored.

A bug report was also sent to the manufacturer GuliKit.

The diagnosis (analysis of evtest logs and the usbmon capture), the fix
and a first draft of this changelog were produced with the help of an AI
assistant (Claude Opus 5.5 by Anthropic). I reviewed and tested the change.

Signed-off-by: Joan Maillard <joan.md@proton.me>
---
Tested on Debian's 7.2.12 kernel with the KK3 Max; no phantom inputs
made it through to the game during 4 hours of play. I would be happy to make
a short capture run to compare the debug log and a parallel usbmon
capture, along with the commands used to extract them, upon request.

The check is deliberately lenient: it accepts any input report that is at
least 14 bytes long and as long as it declares, so pads that send shorter
but complete reports keep working. A device-specific quirk was
considered, but would be hard to reliably target: the pad uses Microsoft's
VID/PID, and its manufacturer string changed between firmware versions
(specifically, before writing the patch, an older firmware was in the
controller; it reported "FMD" on V3.8, "Guli" on V5.9).

I also considered doing the check inside xpad360_process_packet(), next to
the existing byte 0 check. That function is shared with the wireless receiver
path, which passes the report embedded at offset 4 of a larger frame, so
it would need a length parameter and would change behavior for wireless pads,
which I cannot test. I therefore kept the check in the wired dispatch path;
happy to move it if that is preferred.

Thank you very much for any attention and time you might spend on this
matter.
---
 drivers/input/joystick/xpad.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d2eb48d98fead7d89eb3e45613a52176c4fa5fad..0a9e23f6b5fd26950335d39a73c5205c879b9f17 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1217,6 +1217,30 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		input_sync(dev);
 }
 
+/*
+ * Some third-party pads occasionally send truncated input reports, which
+ * xpad360_process_packet() would parse with stick data in the button
+ * fields. Byte 1 of an Xbox 360 input report holds the report length, so
+ * treat an input report as truncated if it is shorter than the 14 bytes
+ * the parser reads or than the length it declares.
+ */
+static bool xpad360_is_truncated(struct usb_xpad *xpad, u32 len)
+{
+	const unsigned char *data = xpad->idata;
+
+	if (data[0] != 0x00)
+		return false;
+
+	if (len >= 14 && data[1] >= 14 && len >= data[1])
+		return false;
+
+	if (len)
+		dev_dbg(&xpad->intf->dev,
+			"dropping truncated report, %u bytes: %*ph\n",
+			len, (int)len, data);
+	return true;
+}
+
 static void xpad_irq_in(struct urb *urb)
 {
 	struct usb_xpad *xpad = urb->context;
@@ -1244,6 +1268,8 @@ static void xpad_irq_in(struct urb *urb)
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
+		if (xpad360_is_truncated(xpad, urb->actual_length))
+			break;
 		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
 		break;
 	case XTYPE_XBOX360W:

---
base-commit: 8dac6df92a2e66e2098bbc69061964cfe7e8375b
change-id: 20261119-xpad-truncated-1551cd7e8678

Best regards,
-- 
Joan Maillard <joan.md@proton.me>


