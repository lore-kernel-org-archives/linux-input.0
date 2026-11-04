Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796943;
	b=X37dai5K7T7vGfO2P2ANv+8xcal91YSwQGCvG4yru8JaQ0PueDcWvMy61SbnzeySUhBX
	 Fo7mdWGc7iMb1Y9kA+h4O6IYhqGXdA5O4VMsd75zN7ghli2pvYQKqh+tTSCNgn+E+a+4X
	 h5FEhkT48DPAdQqW5UCxPuLGYELHWUJ2R5LwvgeIYo3qsNjb3Z6AMO8y8BRvZVeZXhsZj
	 3fLaNDQ+U4HSZSIA3VCuID/xhX1wvmAT2lgCsWcAebN8W5PITDPy0EXlUsVAdPryCk58I
	 eUzRhgoARLfFPYARgXbC/6RqZmPpimeU5pnLr4LJQMyhjbeWxo4Iur/bXTs61qyVW4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796943;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qi8G9UvFtYoe7/NNMKSW69kt3Fc1EXVO1pwg69nVuFo=;
	b=hEyufO3c+2jjf+p/+8R3nMztRlUA7g3Uqmj0JHM7bdR04C4tFq/FnwF8AEEyrBax2Ws3
	 5j5tmcP+WVSKzXYP1uro8Fnmq/Yqwc6GBCg87T5wgyblE5rwcUUjLG3Q5TAYL7u44IDB9
	 Lei61pm7dVEzeXjRAvWNY7QxOEIkDWo7SUlTU9O2NWv59Zs7eXlEIetx0sCR4QzSek4Qj
	 CFvoTMHmjFjU7MvkBwuELLHewE5nscu846gvQAQYyBMMSpDJPAhqGaV5xLXu3+Ddwm4Ck
	 yX3jE7tGAmlinCGvUsbgyQTjl5GQbKKVomJEKefEeSZ3Xik/Ma5TDG+1RxGeo0/p9Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVdFEz7d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056E606A329;
	Wed,  4 Nov 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVdFEz7d
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793796943;
	b=gAjlQyQKkYX3VZt594y6wxQGhNFE4NBjj9hTdXX5nRe8lD4kfD5lr9kG1pGLG4UkOWD7
	 yV2Aq0LpNf696j/IYXn8aMM70iAFtGygLvmFrQVynAt+3V2+v65ceRt8xad7AjD/A72pF
	 YoQgvEqbMVY1lH3PisulhlQVaRX7cI+o4+nDrYKe79eVWkY0VC26Mi/0inD61jm4nOX2B
	 JNDBmHSYlnzIKN7HWZcoN2v3q6B0Id797U9V1NAjc5h3j9jkrmfhlBdy16TpLcD3/XZD9
	 SoLc/28cAqSvLgQLos7gGv54tqH6tiADCYXmtLM+C0kmDuR1OgjN//LeVLbVbk8BBvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796943;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qi8G9UvFtYoe7/NNMKSW69kt3Fc1EXVO1pwg69nVuFo=;
	b=MNsLESujETidpsWGLoGZ2oKtTKcEm5Fkfm5raBkcnZ0KUscHgp1eONLqVG8SL8hLPh30
	 LMorCwev8rREH2BAZZRetBe/DViwePVol2F9zHy9H68Ek+me/KGijaXIMzXpQZioQW1c3
	 kvibBTPpYv/CAXvTGLpJeTGPogtLLCONdi11YtNJYxeozkerP1cJqNsEiBxMbA0qhUwJS
	 xEs6aEaw/bJK9/+q0HbWKzHZVvAqdSkFHHcjkGR/V1aEHBeL1kN56/Q12sAL+oK7SHb1y
	 pJWiujwWqkn1P0aVa7UU4UYc3G0FrSPfnk6IyMkCB87qq+wG4tMstlwvCY5wmfBdgtw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5537D1F00A02;
	Wed,  4 Nov 2026 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796943;
	bh=qi8G9UvFtYoe7/NNMKSW69kt3Fc1EXVO1pwg69nVuFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MVdFEz7dYH0yB+r3y2TT/KjcqCXOoaPFdgMDpJwU0JP1q8jOgMH7JLHklZMXpI2w8
	 qVfixBnjyHUe1K9ZiLOqBrM50ciffBz8+897/GuX7gQ9ZWo7tvYDsYtx+vpdZ+B3z+
	 4GljQfYdceHkzz66fP7EYw9yt52EJ0sK/LByJr9ff6+MdkStlCwzuXddoTXmMBlQrH
	 3EJD9Qxcvv2qWmyXILQO8kxvxYrM85NoB/84+oqxqBsCHC8Pt6YJEjoMt4WWh5dHqT
	 B8o/8uhvTjszZrRF/4lDvHyTg4qnU+UrKfCDsoH8pDo4UIySb4dtcYpHvtgc0pu/qb
	 seQ8KH76Jx8wg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D4CE946E3D;
	Wed,  4 Nov 2026 12:55:41 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 04 Nov 2026 13:54:45 +0100
Subject: [PATCH RFC 3/3] arm64: dts: qcom: sdm845-shift-axolotl: Wake the
 system on a touchscreen double tap
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
Message-Id: <20261104-ft5x06-double-tap-v1-3-5a1bd80449cc@ixit.cz>
References: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
In-Reply-To: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=gVCDyYfuQzZ+YQquXafcJW7FFenl4GNi6oZKBwhfrWI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq6ytMe815RX1a0N0eshGYgGeLRlEwiMcSDon56
 mBRBAXxnT6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCausrTAAKCRBgAj/E00kg
 cqm4D/9hDSLf2LwEVC9LRzcuRML9wLXa9giF1R67yIzc+wlg0RuW6V+WNfwYs2VAWREjIsYemqx
 1RwzoA46JMZEhNgxSxM8hGauxekMiuuJ76lBpBg2hiRIo78V8sdjiR3S2VftxQUzry2IhDlDO5X
 q4yRTKnaknvOTBIy/dQsldPRWqusokHEf6Fif/HnE3MUxSDcApky/o+ZaEZvgr4k1ODn3DbQVZ/
 ygwhqwH0HmP382ABkLUfQ0LEV+Ml2W1mv//ftrj78qlcpMFAKbixuM6Ssz4vR+JssMW110XmgYZ
 Z6t/7zwotfdbfd61wLiGnLeyGlRhNEhMn6elfCiFXR0HEUW0YVyz9SCNv0h7tEnTP/fXV0sh+DD
 wIDpNF73S6xMNjZ1giIi+BFu2G1cI8HwUdHnDoZtImte4AtfDhoUi9ECq4a6DOmjf0U1KLiQ47h
 NBWSPPWMqbi7IFxlEK/B8AyqNhy4GTcvYBa3DJ6zDci72pmftDYF1adtMVT545gnXcxkP1BpQCD
 sGvCAU8c1xhr6TF6lWPBTEexm6axM/9Xr8Hc+1pLmNgwjTFURn3zXCowdiBL3+Fidi2263oKA3T
 GtgQOdnsDHJF0lMg7owte2up+yHxR6txVhA+Hit+o6UxTYeudJM+nH6qfSzsIcNS9E1uJXTqy8P
 xdTasBdQuiARQPg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

The touch interrupt on GPIO 125 is routed to the PDC, so the panel can
wake the phone. Report the controller's double tap gesture as
KEY_WAKEUP.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 1b0eaeafbd517..e4eef60271c55 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -504,16 +504,22 @@ touchscreen@38 {
 		iovcc-supply = <&vreg_l14a_1p88>;
 
 		pinctrl-0 = <&ts_int_active &ts_reset_active>;
 		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
 		pinctrl-names = "default", "sleep";
 
 		touchscreen-size-x = <1080>;
 		touchscreen-size-y = <2160>;
+
+		wakeup-source;
+
+		event-tap-double {
+			linux,code = <KEY_WAKEUP>;
+		};
 	};
 };
 
 &i2c10 {
 	/* SMB1355@0x0C */
 };
 
 &i2c11 {

-- 
2.55.0


