Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E843806D2;
	Sun, 18 Oct 2026 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792367813; cv=none; b=QprxSo/g1jwY6Sxahj6K8q5NNqyZ4OUoyQ0v+9eho2mVsjEgh9BWZENK7Je1TvXBRz4vJaheOQL2wn4B8CAYBTq030dHn+6p0Ym26WyrOK+w7Op3LBNqxepIWTm6o4Dx1Az5qReKJa6K821wcSyRHN+c20Hn9LU0O5uqi6a6eXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792367813; c=relaxed/simple;
	bh=/hVZ4uoqCs6R+RkF1vosrKsoP7P79ROOvFWa4kONcsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gCUCVJqlgYokjVh2Hc/okKEo7O6Nh3louWOyKQkh8vPSplUhbiR44p6fdfi5cIK5JyV5TDwZQgPAI6e/uQyyMPn48BmZuoSLz+s8uuWPs/MhvlnqohRV84K7C6m/zn/f/SqJmoGRYxyL2s4ihow/Mivn98jskYpiYcarsGkU7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abhj5JAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abhj5JAe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA75CC2BCC7;
	Sun, 18 Oct 2026 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792367812;
	bh=/hVZ4uoqCs6R+RkF1vosrKsoP7P79ROOvFWa4kONcsQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=abhj5JAetihWCMbIWqVs4L74d6QgoMfa85IfGcwYWqheVmxRXJ2gVvB4K4I0iGoe6
	 yHfH8t7tneOpyYYeCSUXrecSPRMU9QzSD+GI5e2i8pYw4N6UtD1v+qNn+luRkJ5I2g
	 sIWBXEYGsA4hsoRbwDDd+fB2byBZQkqQOF9dUl1vA4sC6rOLXcLiucS3x5UMQRXOdw
	 1z7/ZpbjRd+uGJQ2zBto96kfJoSv+M7/DnXBJYhV4GQNcny9Al6dSoRnnhg6HZaIHi
	 uJfDK2bvqtZ2SvqGp2dUCTkvJVdrB4bjClshrVFn9Le7oXeJKguQ3gTN3he8a32+r0
	 CpQPKtSATeGgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73999CCF2D5;
	Sun, 18 Oct 2026 23:56:52 +0000 (UTC)
From: Teo Casares via B4 Relay <devnull+teo.nakora.fi@kernel.org>
Date: Sun, 18 Oct 2026 19:56:50 -0400
Subject: [PATCH] HID: multitouch: use Win8 class for ELAN 04F3:3358
 (Surface Laptop Ultra)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-elan-3358-v1-1-31770ebecfe3@nakora.fi>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0ML3dScxDxdY2NTC92UtFSTFDMLS4PUVBMloPqCotS0zAqwWdGxEH5
 xaVJWanIJyACl2loAcv70SW0AAAA=
X-Change-ID: 20261018-elan-3358-dfe4d6890ee4
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Teo Casares <teo@nakora.fi>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792367811; l=2541;
 i=teo@nakora.fi; s=20261018; h=from:subject:message-id;
 bh=UgpHOe8bXIQbdG9aTq6ED0je/Z/6mXB/BG2rJb4/+fc=;
 b=S2fX9n+OrIDybyluIOLb7LakD/mWJDYSgO7FdrgKbRK3Xt4S0gGHatp5S7DnGQ6LEaDaaDFfF
 e2kab1GL1EcDiDGi+jJ6cpZ82O/2B1EAQAkbIVtpugugJIouovh76EY
X-Developer-Key: i=teo@nakora.fi; a=ed25519;
 pk=gQlDjO8thAfg2FOuRC8JG101i211dGw9bNBbyYUZcZs=
X-Endpoint-Received: by B4 Relay for teo@nakora.fi/20261018 with
 auth_id=1232
X-Original-From: Teo Casares <teo@nakora.fi>
Reply-To: teo@nakora.fi

From: Teo Casares <teo@nakora.fi>

The Surface Laptop Ultra touchpad declares its PTPHQA blob on the
Digitizers usage page (0x000d00c5) instead of the vendor page
(0xff0000c5), so it is not detected as a Win8 device and gets the
generic class, which ignores Confidence. Palms are then reported as
fingers.

Add a device entry with MT_CLS_WIN_8 so Confidence maps to
MT_TOOL_PALM. The entry matches HID_GROUP_MULTITOUCH on purpose: if
the firmware is ever fixed, the generic Win8 entry takes over.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Teo Casares <teo@nakora.fi>
---
Report descriptor excerpt (MSHW0734, 1129 bytes):

  836: 06 00 ff      Usage Page (Vendor 0xff00)
  839: 05 0d         Usage Page (Digitizers)
  ...
  1060: 85 06        Report ID (6)
  1062: 09 c5        Usage (0xc5)
  ...
  1072: 75 08 96 00 01 b1 02   Report Size (8), Report Count (256), Feature

The device stays in the generic group, so HID_QUIRK_MULTI_INPUT is
still set; as with other PTPs, MT_CLS_WIN_8 also exports the legacy
Mouse collection as an extra input node. Haptics are unaffected: the
descriptor has no Auto Trigger usage.

Tested on a Surface Laptop Ultra running 7.2.8 with the same hunk:
the touchpad reports MT_TOOL_PALM for palm contacts, and clicks,
click-and-drag and long stationary contacts behave as before.
Build-tested on hid.git for-next.

Root-cause analysis, patch and changelog were drafted with an LLM coding
assistant (Claude Opus 5.5 via Claude Code); I reviewed the change and
tested it on the hardware. A HID-BPF descriptor fixup restoring the
vendor usage page should also work; happy to send that instead or in
addition if preferred.
---
 drivers/hid/hid-multitouch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c4d2..4e969438b2 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2425,6 +2425,11 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ELAN, 0x32ae) },
 
+	/* Surface Laptop Ultra: PTPHQA blob not on the vendor page */
+	{ .driver_data = MT_CLS_WIN_8,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH,
+			USB_VENDOR_ID_ELAN, 0x3358) },
+
 	/* Elitegroup panel */
 	{ .driver_data = MT_CLS_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_ELITEGROUP,

---
base-commit: ae6927c533a4454570950125ca8ba909c45f20f9
change-id: 20261018-elan-3358-dfe4d6890ee4

Best regards,
--  
Teo Casares <teo@nakora.fi>


