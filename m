Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793691131;
	b=Ce46HL2zxPy/l/gcZQSwMns8HSy0q4WFbKlERxXysParFaeYeKoKXwzcNq6zwkMv3nQz
	 h9Q/GMfaMg6Nkn9YCcPeJN9VeaYvd+zwpIyI3MaTaaVyPzsx1n/w7/wRSWc5Jp2KpjLrg
	 BEV6ni641SAI7B+YG5R3sYaPy6Z7F87Jgpnf/QDaB2NscWRyxEo6SFKfVW730av2kvYHl
	 KPmc9SBUWcy50455wFnEZm9OkyzXRCOuPOcjJi+dFfjWtE9eu27S/ei4/RL3V4QUE60Mh
	 AEy/36ordyMfIXiq+WnamQYYWdqbopRFpBsXdVkYjtOllFKcAXmAEriBpN+3ptCrYgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691131;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G45nmskJ7sMviljWOrUHgNwE0OkPZ7GPL2VOLCLxNEo=;
	b=XMDHT/vTn2pCr9MNVSaAQPdtjjyDAnfCAEhczsu+mxrDEfkOLcBfMw1GK7zUjSxlD0Yu
	 4S5NJxLC8KEkkiWuOD4+q8F4OWUIjcVJ+D7RbjfQTNxZXtygMJ6p5/Kzt8YN+p9yNXQkZ
	 VXBOdSuVGMf2/lR06g2Un5u/1XgkHtFN8uABez8WZ6nRlQJY/qJUNv7jy3Zr+qL1ltoi/
	 T0i7lfv11IK+UPovM8q9j4DpiU/rUINGOmNmYgzSvf5kBbP3W6bmQR6oppcBkA9b2OVVd
	 u8gZSwrTmtVndX817k5mActQpiIi2srQY/pfxkGRI7EKWdKvRPHsHOCraEi5vCiHI1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRMU5ttY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B4B606A324;
	Tue,  3 Nov 2026 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRMU5ttY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793691131;
	b=l1oePXsJcelIdmqETqQsEuo1fSoNDvdRMNWf7KdaM5ujgF/SikmBHav0O0yGHW3fBIYI
	 iZoBl2Q4tsrI8vOLwn1EjkACHlHLma2tSzs9TFB/asSO8alPTg/3UE5cxsgWD2Hho5TdY
	 zoi5rAY6QNAzfaJ1HUFxpFFdJhu1d+3OQiDlRqk6mf0nzM8PVN7iACNebNrXYh2tlehhI
	 flKa99pJJCZdMe8r6aL/wac6xwSXkfJf2fMaPiIObtfFC6FKcNTA41SeJWQYAwoUcCVoC
	 cvXTl8sjmuTck1ZQ7eBr6inFlkQX1MuaDPGWKNc5PKAlhXDr+YFIcx6alR/a+rhNP/A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793691131;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G45nmskJ7sMviljWOrUHgNwE0OkPZ7GPL2VOLCLxNEo=;
	b=zLoJniod7kZFoBC7wMkXyyoTk/9ZbjcXOsgZgxAv8I+FYd2SIT/JVzIhV2VSFoq1Jatn
	 EQyBV6PwpxZlrP/kSBDS+baxuH1LtXv7ivjpoY+cGgcdLt4T1ar3JSZ75O0eJMzeyztlR
	 ppx7m6i2DZrxUUkIwcQ8YIGbftdkXmUrCukf3/WSrNud4++fTJ+6eIZKLXCEZAf6vS4Bw
	 +brfJHVcnUWrXyxCl6imSy9Hb1fZ2yMUchF1qlAiB/8+cThzfnS5TLO2e8Y73QGICL41h
	 Hl0IVPg8yhInqmBj1gf2Qn3S7F1jA7xX2umlMSkREvwuDZ78gqAAODmTNBB6avAm6gw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 70F8D1F000C1;
	Tue,  3 Nov 2026 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793691131;
	bh=G45nmskJ7sMviljWOrUHgNwE0OkPZ7GPL2VOLCLxNEo=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=hRMU5ttY+zvjmSN4mrVeE+QYQG4qRPkEsb/cEqah3JrthZ7RXcF0NS1apW/a5fRKN
	 Bba8rjx8z03lk1e2adazXXcLe6jdCcm0wfjShx4ssMBGBMb/rUL6fjeTojNPRjX1DU
	 Y5+fzrPiTV3TAa1SsT9xsTM35nfcsC+s6Z9HfV6/p/vavdKFZpGskTRNZn7+IWinfF
	 XSlKnah9TZDLq6cwmzso92dlqXL5tqytBXWAERWv//3tXeLg8SfVj61pFREksKEsF7
	 zkI4x2NysElWKqXWAKeOpO5B0Wo7rK3dZ0EuDjDapfbx/xLDCNzWwp/K3h44MeHWSi
	 Oz/IRpstPTUbw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C2A7E46822;
	Tue,  3 Nov 2026 07:32:09 +0000 (UTC)
From: Jianjun Lang via B4 Relay <devnull+jianjun.lang.ntu.edu.sg@kernel.org>
Date: Tue, 03 Nov 2026 15:32:10 +0800
Subject: [PATCH] HID: steelseries: Add MSI Raider A18 HX A7VHG to RGB DMI
 table
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
Message-Id: <20261103-b4-a7vhg-dmi-v1-1-f57c90da16a9@ntu.edu.sg>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrE3SKhWuIhZVg5H4SYtIxN0Vy
 2/x3gWeHJOHMrrA0cGelzlAxhHYwcw9IbfBkIhESykUNima/Bh6bCdGk1mpVSE6nROEZHXU8fn
 tqvq335uR7PY+4L4f6XM/hXAAAAA=
X-Change-ID: 20261103-b4-a7vhg-dmi-a5c16390f67e
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Glushkov <david.glushkov@sntiq.com>, 
 Jianjun Lang <jianjun.lang@ntu.edu.sg>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793691129; l=1684;
 i=jianjun.lang@ntu.edu.sg; s=20261103; h=from:subject:message-id;
 bh=QBV4z5tHTq3HQzaDogtIEEXklWl0ixbFdqcyrPVQXWM=;
 b=LZVn64dFEkLDuKc4LFx+u2RtZi+3Oo+HJFwMuP0N094paiynJNgxJWrTxoqzIQdXfqUULz/xw
 1N+2xAJ1qksBldpfFkiWC7ksc+MRoPt9e35dJtUxS8Gl5MzDGvj3CHI
X-Developer-Key: i=jianjun.lang@ntu.edu.sg; a=ed25519;
 pk=e0Fl3OPgaBi/Tn+OeuP32QQtTZps9FERj4BBuR2nCZU=
X-Endpoint-Received: by B4 Relay for jianjun.lang@ntu.edu.sg/20261103 with
 auth_id=1389
X-Original-From: Jianjun Lang <jianjun.lang@ntu.edu.sg>
Reply-To: jianjun.lang@ntu.edu.sg
Content-Transfer-Encoding: 7bit

From: Jianjun Lang <jianjun.lang@ntu.edu.sg>

The MSI Raider A18 HX A7VHG (board MS-182K) uses the same internal
SteelSeries KLC (1038:1122) and ALC (1038:1161) RGB controllers as the
A9WJG, with the same 524-byte feature report layout and the same ALC
LED IDs (0x00-0x02 lightbar segments, 0x03 lid logo).

Add it to the DMI allow-list so the keyboard backlight and lightbar
LED class devices are registered on this model as well.

Tested on MSI Raider A18 HX A7VHG (BIOS E182KAMS.10D). Both devices
bind on interface 0 and create steelseries::kbd_backlight and
steelseries::lightbar. Writing multi_intensity and brightness changes
the keyboard, lightbar and logo colors and brightness as expected.

Signed-off-by: Jianjun Lang <jianjun.lang@ntu.edu.sg>
---
This extends the MSI KLC/ALC RGB support added for the Raider A18 HX
A9WJG to the A7VHG variant, which uses the same controllers and
protocol.
---
 drivers/hid/hid-steelseries.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 7292da031..116d5a01e 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -356,6 +356,13 @@ static const struct dmi_system_id steelseries_msi_rgb_dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "MS-182L"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Raider A18 HX A7VHG"),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-182K"),
+		},
+	},
 	{ }
 };
 

---
base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
change-id: 20261103-b4-a7vhg-dmi-a5c16390f67e

Best regards,
--  
Jianjun Lang <jianjun.lang@ntu.edu.sg>


