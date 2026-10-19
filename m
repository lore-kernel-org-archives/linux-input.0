Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D414F4039;
	Mon, 19 Oct 2026 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417247; cv=none; b=UejATsckQjmBV91RXA/bvJeAKjPsWTK2TSOjN7rZlL5PR5e64txD655lmaga7pZFLAwFw1mbFZ8G+a04zVf90ibHFqfXnlSTSjt+dk0XHZi9m+ngK+jA5qSDxsi4DnpSHOlLDnhmUA3rstGZQhkJtsWaMNB6pXST3yHNrCenTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417247; c=relaxed/simple;
	bh=moiyvTYJKQMpFVV/LIsha8c3Een2I88zoVhP0srJne4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H30prIfGrGTx0tPtDhYGTJU8vWb4BnZ+IZVL2yAAxqRUbtKgjLqx2vsUXocNFTACAXQFYG6xadVA4oLx69AOVpb9eWYbJ/5hervU2LLuAwIBJ9CehJ6cxLahX5rD05M+kkwKDzmflW1KdM5rIJT9OgfCRTg8jhgPis1uY/SqC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkMYHraI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkMYHraI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6940C2BCFC;
	Mon, 19 Oct 2026 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792417246;
	bh=moiyvTYJKQMpFVV/LIsha8c3Een2I88zoVhP0srJne4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kkMYHraIlCQRlAc0ruyLIPnbLaBd+yf9ceA7jQ9Cfv0OSJgW9eGYu4h5cU76UN4bl
	 mG4dJDfsw73GpmEWd2aV1sHkYeX8dg5opXnitpM8m4L/A0BoimOvO70QFmLDyNLxps
	 XVNrc9Wk/sUeDvhLAN+bQsCe8D81ls1USTK4RXhFA2OJaIHUeI1w2KZ/z0UCmMTKPG
	 mc5z/cZj4nsNneoUILatYwoXREZhFdqkQ+VcHhxJ4CCsHgFWZIMYGz+5hpSkjGhEK5
	 Mi9fXgVNcBESJsCwIBP8dmxjH99jP8LlIaP9lNhj2pgm0XTwNJ780WfQh7E/YGHbUu
	 DDiR1+iePN9xA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA19CCF2DE;
	Mon, 19 Oct 2026 13:40:46 +0000 (UTC)
From: Artem Suvorov via B4 Relay <devnull+oolaa.proton.me@kernel.org>
Date: Mon, 19 Oct 2026 16:37:19 +0300
Subject: [PATCH] HID: amd_sfh: Add DMI quirk for ASUS VivoBook Flip 14
 TP420IA
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-amd-sfh-tp420ia-v1-1-eb5d0b5cc89e@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsGVjOor0UFyzT1koRFB+Pek4
 zDMvJA5CWeYmhcS35LliBWobWANNm6M4iqDVronRSPa3WH2Aa+z00osGmW0r9YTDVCrM7GX5z/
 OSykfdxer1WEAAAA=
X-Change-ID: 20261019-amd-sfh-tp420ia-5052f202f118
To: basavaraj.natikar@amd.com, jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792417245; l=2693;
 i=oolaa@proton.me; s=20261019; h=from:subject:message-id;
 bh=+6jaqWHfATk3CUcx+736KkfAIa9Iv/DxVwEauuPU1B0=;
 b=5Rt9eqc8aP4W8EE87gnfJ9e+uWd3lwQ84behNJ/3D306eiUx0kqZbj4gA03NUpBbbDcY/aiRD
 CVlml/BmqgwC68bMmxX0LVo348Ez4xW/7F6Y1Bz3V9fhiLeA9/1RNdd
X-Developer-Key: i=oolaa@proton.me; a=ed25519;
 pk=ZkhU9yHTkiQgLUJNSovzWqS7/j7aCZmKqqGnXevGic8=
X-Endpoint-Received: by B4 Relay for oolaa@proton.me/20261019 with
 auth_id=1239
X-Original-From: Artem Suvorov <oolaa@proton.me>
Reply-To: oolaa@proton.me

From: Artem Suvorov <oolaa@proton.me>

On the ASUS VivoBook Flip 14 TP420IA (Ryzen 5 4500U, BIOS TP420IA.305)
the MP2 firmware does not answer sensor commands sent with interrupts
disabled, so the sensor hub finds no sensors and the accelerometer is
missing (no screen auto-rotation):

  pcie_mp2_amd 0000:03:00.7: Failed to discover, sensors not enabled is 0

This is the same problem as on the HP ProBook x360 435 G7 and the ASUS
TP420UA/TM420UA, which already have a DMI quirk for it. The TP420IA
reports the DMI product name "VivoBook_ASUSLaptop TP420IA", so the
existing TP420UA_TM420UA entry does not match it.

Add a DMI quirk for the TP420IA so that interrupts stay enabled.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222143
Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Artem Suvorov <oolaa@proton.me>
---
Tested on a TP420IA (Fedora 44, kernels 7.2.10 and 7.2.11) with the
amd_sfh driver from v7.2.10 built out of tree with the same DMI entry:
the sensor hub is found, accel_3d shows up as an IIO device,
iio-sensor-proxy reports all four orientations and GNOME rotates the
screen. Without the entry the probe fails as quoted above.

This patch itself is against hid.git for-next, where the TP420UA_TM420UA
entry was added; there amd_sfh_pcie.c builds without warnings (W=1). I
have not booted a for-next kernel on the laptop.

With the quirk the log also shows repeated

  hid-sensor-hub 0020:1022:0001.0001: Event data for report 1 was too short (15 vs 14)

but the accelerometer data is correct.

AI disclosure: Claude (claude-opus-5-5, in Claude Code) helped me find
the cause by comparing with bug 218104, wrote the DMI entry and drafted
the changelog. I reviewed it and did all testing on my own laptop.
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index b3cb13b8c5e8..a88867075291 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -322,6 +322,13 @@ static const struct dmi_system_id dmi_sfh_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420UA_TM420UA"),
 		},
 	},
+	{
+		.callback = mp2_disable_intr,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VivoBook_ASUSLaptop TP420IA"),
+		},
+	},
 	{}
 };
 

---
base-commit: 92d5263296a43f3808926b11848832bddf2590aa
change-id: 20261019-amd-sfh-tp420ia-5052f202f118

Best regards,
-- 
Artem Suvorov <oolaa@proton.me>


