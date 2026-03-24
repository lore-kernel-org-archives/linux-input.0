Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75230FC0F;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381238; cv=none; b=o3eskyVa/Lwd1RZDm/Z8x2VaUErEFmU2/3NZJuRDtkVozdeOfqkr6caStHWVgV6WBJD0DpfujyvvZ59RUtJN8OpZTKqkK15zjDYb5cAcmVXWR9aVaIMX71yHLKG3AOQsrK61hsCJOfUNK0/h4Z2K6/lY2vOE9TIGlN6iofZnpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381238; c=relaxed/simple;
	bh=BU6kdVo0x4D70Au3+d7B1+eMYVpO0+uLzE4YH6wdmWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFBTrEab0Ft7UDm1cgqk6AqQpRwY7vdCJ/RNi0WAGvtZlBlF4GVimohjeEmawSuDWAKx3RgvI1nrSNxw7TyReZsqYgnVfdtFVtRG/KBNM2yG8w68y/EQ7squ2tHs41F1g02WfP5uvMA5btYjA3Yip621ETpPN+t921o6oPPtL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6UacMPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6UacMPt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE00FC2BCB7;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381237;
	bh=BU6kdVo0x4D70Au3+d7B1+eMYVpO0+uLzE4YH6wdmWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H6UacMPtSdlGAM0kRe9ClzdtimofE6SaOzPGkr/5RNs5m2WMpwM1Xnf28Mvi5H0RG
	 PV7qefx5PEKHEinVmf8/j4lulU8HBvdtl9JDKUTeiEIi/7tqAFYTFObrmMk5MEW8Gb
	 eia+DVAGv6Ku8JyufUp7aB+9DihSZPZZS+oh4bKsXE1RFn9WzBjcIv5hbW1NEaC55P
	 AIL7xy1jE8cqF9HctYIvxqa7/24fZCdRU0hAg5wtTIvtesK1vuXGpSRj+74CbALPyC
	 V40OxxxmYLANDOm30hcv0XLpPKiP8F6yfzdDiTW3sZMXzQRFntYZak8dG4Omxhng9P
	 bc9vn9dIdvttQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41A4FEC100;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 24 Mar 2026 20:40:37 +0100
Subject: [PATCH v8 4/7] Input: synaptics-rmi4 - f55: handle zero electrode
 count
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-synaptics-rmi4-v8-4-2168d2df68f5@ixit.cz>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
In-Reply-To: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=AmUwE6dlCCX02pALY0B7wBasdQMVqYZC32vlnsSfL44=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpwuizsK4wbsCpKaelusCTqcOTmYH5iCrIp7Aaj
 bx1cvZplzeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacLoswAKCRBgAj/E00kg
 cpSfEAC1mYqRx9nANs4VvHg3Eodu4ms5VZyhlwzQYVSPPPnue7tDOLzk+GnBJiavMuS6tf5FeK6
 +JsCIKEXZ6in228e6fwxbvyxIbb3d8tQOfFMbS4yzW8tL1gXd+mf7MJ+JB2dWYoloGkRMZIuMY6
 Zyhs/WQgbas5SC2nfDrE7S9BTKQzcVp3mQDbuXcNu9N0TS8C/51+5GFxh/zsrxDh8h0N5i84LZQ
 FvKQ/1gbibyfeiAZC+AKPARe621vqtfkCxJir3rsuCDKt/XGXg5pm2iLdjmNTdi+Kn29EKi9BLm
 WYJnX3C2rw98aW4e3c4+BcUjF92sfzKJztkyYVhvJDuVZnMbz2uZegD3+BpF+m3+5xwAUMStKuh
 XLiIUDu0oz+p+qYD5OSZefbEZ6cxSxHjqw23sGInCkO8I4fIYB0niCwEgbwN2vRFUST3nZBpjNp
 Uke+iyjyuy2+tA9hTN36qCws079kjeJCWRjbZr0QgUodS1K0Ri6vgTm0HJizU0UCY45gUm3FBw2
 0dhtrs8RA6eykM4Zh/Nz+savsgycC9/r2Drp0cMt7Lx8eGqTJhpG3EbuKKLlrJynQZ+V/k/EQCK
 ezRy9uRvzDUy9TKEIFX2fRa+Eru4ogWIgPihx0We7ptGbIt99l3Ycu1Z30DaEXR20FRhg/aqjFQ
 Rz6Jhsw3CGpwn5A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Kaustabh Chakraborty <kauschluss@disroot.org>

Some third party ICs claim to support f55 but report an electrode count
of 0. Catch this and bail out early so that we don't confuse the i2c bus
with 0 sized reads.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
[simplify code, adjust wording]
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_f55.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
index 488adaca4dd00..776c915b82e72 100644
--- a/drivers/input/rmi4/rmi_f55.c
+++ b/drivers/input/rmi4/rmi_f55.c
@@ -52,6 +52,11 @@ static int rmi_f55_detect(struct rmi_function *fn)
 
 	f55->num_rx_electrodes = f55->qry[F55_NUM_RX_OFFSET];
 	f55->num_tx_electrodes = f55->qry[F55_NUM_TX_OFFSET];
+	if (!f55->num_rx_electrodes || !f55->num_tx_electrodes) {
+		dev_err(&fn->dev, "%s: F55 query returned no electrodes, giving up\n",
+			__func__);
+		return -EINVAL;
+	}
 
 	f55->cfg_num_rx_electrodes = f55->num_rx_electrodes;
 	f55->cfg_num_tx_electrodes = f55->num_rx_electrodes;

-- 
2.53.0


