Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796943;
	b=W1WC5nBG7Wp+2kwtyYrhzrkOWezgCNtdTaERTGUhOCsejDQKmZrwPJI43UqdJfjBSg92
	 CYV4QTdXGT7aIHBP0GPYeDkwSmAeS1dRKItn1ji+L/xYnqpFAUt2SSeAGp0Qgl/tkLaTI
	 ikgKBb5OaGvuOSyZa+Dcp51CImSgeYoCO3snK1crSENY0Lv3K7rkhrWVdAYyKTVbp0ntL
	 s8I82DKmvlIf4lDoUm/mF3Sl541cbIjdg/2D1TOxIqvgs8rRacaM6b2ls7A7Xzywmm+gI
	 ojKmjbYN96CdqFSXXxWheXR3B8+sqWfG+oBACFUX7ugvbJsL67w37y2WBIX1nbRfgTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796943;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=zyr22CI2CmOFNj4yZHB6ux7UUbGZeisiaWsSJL9ai6E=;
	b=J1qTP/RrliVvfbPFQR1Rf8XbYkfJ6yEyAhd+fir+vklXPFe6BwD+2x/dRCJXLs5+fkbz
	 uspBs5H9pD+MXXV09VMVO6wnSeYSzvkDoI12XZWN4Du6sKfgOppRHgRwBukCmliB1/EJ4
	 NbkEqcwNiGZeD+aufgLlXATns0GvucJBjxPvGi9R8Feq8IXx36zD/TcJy2lo1wywm17ER
	 6wT3FEUBOrARcn4gFrc3Dnm2I+PWqPKtxYrYLu9GWEhL/WWBF/GWNcjtiIfhruI0utd8W
	 mSNZwbJQ0e4nWFE+eWjD3jz7oy23XdoLkBQNg/FKs/gnWEKQ1qEWkmumeLc/HAGOtrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJpRChMc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D61606A31B;
	Wed,  4 Nov 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJpRChMc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793796942;
	b=IiwfPC5Knh8ZMmbGjvdRp1oSF+oVReJD1UG8CQjvxfbgBYSXrhWY5BNtBAuH9Hvywezf
	 riOJqCb2HSieVQM7iBzjyzVBEt6r2IeSWh5iwlsbAGwsJONOR7CaeT76DylV5Bu86UDHM
	 QFpJBTvRgQi5JFD1JbxyIgBPApCknjeN+t2pugpRjf+6AzBvVuCgpjgMHVX1iGMu4ii2r
	 Ya8ZyjykprBsMGd+OPMQInBdhYqFxMXceRoiS95mkDVM6Vrr4zVOMkvAw635yPL5D8fZ+
	 PvONFdnlsUJN0u/Gu7RK2ogp8uijlof1UrEfV1yn4sThmFTfmj5CrBoDzMv0Y7P8EOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796942;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=zyr22CI2CmOFNj4yZHB6ux7UUbGZeisiaWsSJL9ai6E=;
	b=IIgAQ5/ZmC0cxoWB5Hl6rLMFJ/nq/ylnWC0+MqlCNwh3Ea2f+8ssQiU8vJa1adF6ENcH
	 noAmWuPcM9m4MeNN/HgHy5/v62RrWgmeZPmHM4gxk+eb0cHuPvZMSY2GCYAcJ+2RK6g75
	 oghEFf6NGF5zeKpd/hcdX8KTpmXncf6MZbTigHo2ZjURM3QX08GOdZH3sj0PwbivGO1gC
	 +YzSPWG+bjxa7NiEDLXprAH0wbARbcnMeIItTsN5zmNSE7gMCb0I+C0tbGHoBdGhzkktk
	 xiohstEr/Y+EgqJiBpVDdCciV0E0gV7m5YP10SDuFdpZ9QpDyUvz9JopnzgtnKNMEEA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 503471F0093A;
	Wed,  4 Nov 2026 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796942;
	bh=zyr22CI2CmOFNj4yZHB6ux7UUbGZeisiaWsSJL9ai6E=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KJpRChMcVbzmRlE+wlreOBcfm9NtES1wsEgtbfesqwQQRwL864GFq7GXF0SBH5oX8
	 bS8F0NLSe+R9wUOL9x0Xvalv1a2KFXmvYEVvXmDYmHh4B+kUqlOEDj6VDce3IO1Jv7
	 IDRY43Zxi0dW7x3Ze5xHFS9oi5dgNO+0OTwX11F+gp+dRRFMevHTBp7uoiE6SAOvkj
	 7haESdwgQR4kRK3gkrRyddzpnepPtPPAPU1lIqXEF0SWbbau+o33zkGIAxJTK/dXM7
	 PaWLr7tvcQQwlIU+Jjof5+DXOWKYyCH+4R7j24CAZMR1G7tX/GirCdnM1qJgGIsWep
	 +1UT8V7nRz/2A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A2DA046E35;
	Wed,  4 Nov 2026 12:55:41 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH RFC 0/3] Input - Tap to wake for FT5452
Date: Wed, 04 Nov 2026 13:54:42 +0100
Message-Id: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMT3bQS0woDM92U/NKknFTdksQCXQsDI6CsQUqqsZGxElBfQVFqWmY
 F2MxopSA3Z6VYiGBxaVJWanIJyDSl2loACo0QQHoAAAA=
X-Change-ID: 20261104-ft5x06-double-tap-8022020de323
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pzSw6TKmONM6czBm61/vbfVAdGJHk+kTaSJEbz59twU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq6ytM/Owsjy5J6firfogdWwPvKt+ZEZb8PK7um
 529GuYtDsuJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCausrTAAKCRBgAj/E00kg
 chBsD/0YUwsWoetDiBLm9SRyuFDq/RO6ukE3DxRxLUgI7ht59clz+7UKoMKfrwC5SMJWI3CL4x+
 YujCy4QgbLfQW1KwV+tR8eZkoDf6Qy6okZbNBRR1qKQZBeE0cFdXPVXYVCQvPtT2gqwQtuUxkoq
 IZO9VNp5YBcuWMGcwJyh+quufE1lvkfOUQB4+gBtw6jRirm3gdAUOixoMZtvcHsuAnZYgKcv9ND
 rC8G/djBpzK3qOCwzGLXFYyedgl2/XbABbmKoIjiMDl6HdBiSateeZuphC/+GM/M8/cyVmPrfiO
 IPoO6sHE/EwA5HnERE6xd/czgqLqGruI6H5/4bNl5B+izcGLLt7ZLPOAZTBFEcaOfq/YfNYo7mB
 N6FiJdWQ6gkhD5Jw0HZB6ErihUpK5+LpXgBO4tAMJTUqzcA59HCRGeIAZ35t2zMz8or/9p9NfJU
 J1epB0Pq9BwUmqVrzejfiwS9uubHiLfzDj0GC8nCvamEbFLYxMGM19kQrLW0yG1ETbsxCjupZW/
 1blNrGbIggErc+bHW2etFmqL78GbMRqtInIS+WSUIdkjZ6DmNDrNPZBRki6jLsQ1L8UaUUIxRW9
 7jeZnFgiMhgQ4ZAGo+KbV/k3wDK1hva+sYq5PEd7OcPBTJrF309nNUM/7uteCDHJo3S9IaT4aYt
 r0EqJWOJzgyyMrA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

Sending RFC just to validate if this would be the correct approach to
implementing the tap toi wake functionality

I've tested this patch, it does wake up the phone.
The second assessment is let device shell to react to double-tap input
device when phone is only in screen-off mode, thus the second input
device to bind to (when touchscreen is in the runtime sleep).

Feel free to skip detailed review for RFC v1, I'll polish the code for
upcoming v2 submission, after design discussion and approval.

Thanks

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (3):
      dt-bindings: input: touchscreen: edt-ft5x06: Add wakeup gestures
      Input: edt-ft5x06 - Add wakeup gesture support for FT5452
      arm64: dts: qcom: sdm845-shift-axolotl: Wake the system on a touchscreen double tap

 .../bindings/input/touchscreen/edt-ft5x06.yaml     |  37 ++++
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |   6 +
 drivers/input/touchscreen/edt-ft5x06.c             | 205 ++++++++++++++++++++-
 3 files changed, 244 insertions(+), 4 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261104-ft5x06-double-tap-8022020de323

Best regards,
--  
David Heidelberg <david@ixit.cz>


