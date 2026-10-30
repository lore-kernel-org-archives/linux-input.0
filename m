Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793342249;
	b=kwQ2CihDgEpTkhEkLDa+Zgg/Y4vjgpj35/M+uYDJYeUNfPg/DqZfnL88mk4r2YyhvmnA
	 TNBAxSxglnDsWWlzDHfSPOLkALomfbj7CL2R0cZQsR1O9wSOOna9dq36rvgAYZgb+/h4r
	 6YZ5ii+MaiBANn/E7totoXF4s1A5YnAFgL6xrqx4daJBAV7gdZhmUAx4ExPVFw2LVURdE
	 2SROHlTekzp/NX2OIIRDM9hltBjfLEpGX5JvLcm1pGN+kl8Jc0dC/veHFtAHKpahPN7CU
	 REFKey1zPRFMIdvf1s0hWnOg3lSdk+Sgp6I36dj9az7U7QxP9VVLcfJrL3h48up5heQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342249;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s9tqv1PJrbPa5uxaAMuHXSLbue/u/Fa8owOwc84kj/o=;
	b=digf1nLR7jeLHdtOXxJfIjEoeDcQkIzPskRXlDPzJH5RAwaNHJhWurefCXYb+YI+ajzA
	 /HMwOfYS3mJXi4z8XTTQjoKncGFIOKeb9WXMaoQm7nUYOmDS0uhByYrtZ1qwyuR4L7a2o
	 BC96fFTWhN6+s+bSRsDDEbyEINFbdN8PXfX9G56e8x8ytKKnysPzB08ELGzvDxGX3vxvt
	 is/1+axxDdT0gfDd/a/KQFMG+EMICwT8E5VsFLgXsv69sSMxX7jjdpvAeNnVGIJJ6tfKL
	 C7HTGXg5wI6fpJh6LUOiVMdrjUdw87IZRc2pxTT2sLG25GZKlIm2u2Z04/eky/mMhlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsj9vcM2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFEF606A31C;
	Fri, 30 Oct 2026 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsj9vcM2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793342249;
	b=QMEBPtKY8dmKpsSlYyFxipbBQoB/b98qxpkFznZRJboDSwORbNDNstRcI97KTipwUJHJ
	 Dz4PDYcr31jqNyW2lWvDrYCvOFH4ZdJN5GeQ4uuo4nCyG+FAWtnwwtABFrDZ9ms2K4lji
	 WdTjOAEH0F2zWrbONEnBLBT4B+cYnx8Me9H+Xcq+Pc50rb6YatsB3bf8T1JPQcFX70Dtf
	 Ot0ZjQHMlwRWg8AHkCbhLzbsN7PMmdxE7XkZdgxwOZCqioiUy1FjJWIn2TvtifvcL6cLZ
	 MHJnrWG8oWBtmm4kgX7v9FUtXMNxAzRx5JwKtTa2ypyWtZWSpTZC32i+0DnRhKj5mzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793342249;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s9tqv1PJrbPa5uxaAMuHXSLbue/u/Fa8owOwc84kj/o=;
	b=SDI4cz0pH8hVbBRAT+Hsty7GUFxjrJ43oAR6+R+M1jCQPBgjLXQphqIMCc/HsniTeFrF
	 ZDN4aUySKzHOS1GC7Igekh4lp5IneNrce927TSTN0Dga3BwQi++1xMMJlzX05JIEatmAU
	 XaE+/kDEJq2Vc1ehZEEmA6Z0IxRKsBZ9B0uKj0iXAjIbVxlm6eghJsMySyoJLNNf80Gho
	 aIQsxEeshxAmmMr1GkN1QlViEx7AhIWJoEaAmOJECNJXbR9ZmyYoWsNujxCouiF7dv+vx
	 iFDjsBav9K80Q66EL25OqTW2OEI3c65/BSMnIiDZAWkrDduJs4tBrZhzSqbB20XJZQQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 23EA61F0093A;
	Fri, 30 Oct 2026 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793342249;
	bh=s9tqv1PJrbPa5uxaAMuHXSLbue/u/Fa8owOwc84kj/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gsj9vcM2UfF5t/5UbSarxoW1SicowCkeWDCsfcqLxpZ6Tn5s7iG7SEz9gqyghP1e2
	 y99DKvzBqm2nEn8B1cyTRmGceipB2puJbG3TP2MshbsdxvHQ2MPm+H6T9cBTnRk3CP
	 ZcA+BqavXT0J4OJyCcl3XvMK1wYOPiX/rhBE23OvpMZSGLZFSt3ZlW5ZHZHp74qtEW
	 GDjsX0mAAxYe1s8azu5F/KYS6JmAT6uJfk4Wp8i9BAFfRER6nxqDa+NXKSC1gk4QUK
	 40GyCfkhI5nsOeCulbbgrj1d06Wqbk+gL+NiKdB56DuoIJ3F2B/9rseCCElxe/nh/L
	 c18+MpkcGrVSw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 813B34365F;
	Fri, 30 Oct 2026 06:37:27 +0000 (UTC)
From: Martin Oberleiter via B4 Relay <devnull+martin.oberleiter.netixx.it@kernel.org>
Date: Fri, 30 Oct 2026 07:37:24 +0100
Subject: [PATCH 1/2] HID: steelseries: Select POWER_SUPPLY
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
Message-Id: <20261030-rival3-battery-v1-1-6b1feeaf1f52@netixx.it>
References: <20261030-rival3-battery-v1-0-6b1feeaf1f52@netixx.it>
In-Reply-To: <20261030-rival3-battery-v1-0-6b1feeaf1f52@netixx.it>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Martin Oberleiter <martin.oberleiter@netixx.it>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793342246; l=945;
 i=martin.oberleiter@netixx.it; s=20261029; h=from:subject:message-id;
 bh=mD34hfkgljPtL0ztTPCZwhP7a85OFYLVEn7tOj4h2oE=;
 b=yiFVCIo61O3xYrYicW6dd217F11YOIYGxEqo+4RVAoRFxPVQWvhFSMLj4XvWRGo1Ut6/2keSD
 xEypVyi/rnqDKE/zRcgl7ky9sw+eQhx0HzQgLGy/jE/XQG+4Q4WWryM
X-Developer-Key: i=martin.oberleiter@netixx.it; a=ed25519;
 pk=yZvkAuAsIiJ76LEGGTR3TI7+Xjw7lGN1dK6jcv72XZo=
X-Endpoint-Received: by B4 Relay for martin.oberleiter@netixx.it/20261029
 with auth_id=1358
X-Original-From: Martin Oberleiter <martin.oberleiter@netixx.it>
Reply-To: martin.oberleiter@netixx.it
Content-Transfer-Encoding: 7bit

From: Martin Oberleiter <martin.oberleiter@netixx.it>

The Arctis headset support registers a power supply for the headset
battery, but HID_STEELSERIES does not select POWER_SUPPLY, and
power_supply_register() has no stub, so a build with POWER_SUPPLY=n
fails to link. Select it, like the other HID drivers that report a
battery.

Fixes: a0c76896c3fb ("HID: steelseries: Add support for Arctis 1 XBox")
Signed-off-by: Martin Oberleiter <martin.oberleiter@netixx.it>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c..4d48da4f5 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1214,6 +1214,7 @@ config STEAM_FF
 config HID_STEELSERIES
 	tristate "Steelseries devices support"
 	depends on USB_HID
+	select POWER_SUPPLY
 	help
 	Support for Steelseries SRW-S1 steering wheel, and the Steelseries
 	Arctis 1 Wireless for XBox, Arctis 7 (2018), Arctis 9, and Arctis

-- 
2.56.0


