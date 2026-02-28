Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66317A2E8;
	Sat, 28 Feb 2026 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772243861; cv=none; b=CsfsA5N5Ay2vNETaP79Zt/1e2Of9SloYG89LTL8OePQGe2T9rK6n48qtM4PExCjSM3NVQuSemTkEbKyKdZBkoYu8T9/nIF2ixOVNiMqgPvAmBKzDazoJk6R47vJZeqj5og6YDbavalZsCF9RhBKPKUIalR8wH+r40DMAbazyMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772243861; c=relaxed/simple;
	bh=mqgh3KinL8lR1abG10D3/1AkSqQqDN7cUVnCfUjIrMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ys8bljMDSCdzmspvuhoAAMP8WjAliUGC/5h+59DXQRoKgQFmy3TlMHdwpxy6P4RVLMvPKx/1Kn4LBr9f3HzKSrOF+y+OFmuO39FeLgtavBbSA/SVkrUlN4bsWfAfwWyUXL4HnKNToO0CvxPgQCm2CrYJlGT484aZRdUZjoj3UrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=H7t7r3lP; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RzD43SKF; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="H7t7r3lP";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RzD43SKF"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1772243806; bh=AUlBsE2lv1qFAMOJ2b89Ub+
	ErBhxWmCUaBMB+doDrJo=; b=H7t7r3lPPRBDb6qSRAX1bxmoYFzI4/ZWtASkui5DWEt8Vsf9jn
	EPpLTmD7ykAV5lyvELt5Z9o4q2iaTNK6b4pcwpaCc0KRSfbyFvh8zw+of8+4ZGXoxYzJBfCZexM
	v9DjQNpsCg79ddfELi3+t6sgWygVC1e1aKEr9zb3N7f/r+ZqTV3KCwrW4quTPntz8jv/AnpBvQ6
	ueJJmw5g6hnGMzTMi2lveVEgESnDrBkXskjICdq9z+19xZR8ycVzqKKqVqIL5xM7Jye1Ms9/LXv
	MFeIDtybT1/GGLff6An7SrKqZI2qE/+6Dmv3TwQ6MTSZ1ZJiH9s/Lc+lFxc0Oom1IIQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1772243806; bh=AUlBsE2lv1qFAMOJ2b89Ub+
	ErBhxWmCUaBMB+doDrJo=; b=RzD43SKFn7EO0XqcIKpQfsWJhKMs2OGOkwbs/p0MFgaFM+wG0l
	6ryVaWk4sY1hBvYmFWjTMo0Gj05cFLXrGSDA==;
From: Aelin Reidel <aelin@mainlining.org>
Date: Sat, 28 Feb 2026 02:56:12 +0100
Subject: [PATCH v2 3/3] MAINTAINERS: add an entry for Goodix GTX8
 Touchscreen driver
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-gtx8-v2-3-3a408c365f6c@mainlining.org>
References: <20260228-gtx8-v2-0-3a408c365f6c@mainlining.org>
In-Reply-To: <20260228-gtx8-v2-0-3a408c365f6c@mainlining.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@mainlining.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 Aelin Reidel <aelin@mainlining.org>
X-Mailer: b4 0.14.2

Add MAINTAINERS entry for the Goodix GTX8 Touchscreen IC driver.

Signed-off-by: Aelin Reidel <aelin@mainlining.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14899f1de77ed2e8a583cf7b0fea25725c8534cb..c76f9fbe51f929f7eded37760cb5c83dfa337d0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10849,6 +10849,13 @@ M:	Maud Spierings <maudspierings@gocontroll.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
 
+GOODIX GTX8 TOUCHSCREEN
+M:	Aelin Reidel <aelin@mainlining.org>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/goodix,gt9886.yaml
+F:	drivers/input/touchscreen/goodix_gtx8*
+
 GOODIX TOUCHSCREEN
 M:	Hans de Goede <hansg@kernel.org>
 L:	linux-input@vger.kernel.org

-- 
2.53.0

