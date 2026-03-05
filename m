Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE429B8D9;
	Thu,  5 Mar 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738478; cv=none; b=VTxqBd6BN25iC0gUT4IlCozVqV5PFsjOlCjm/sSTIfkoebvivicSmJ+yRazz1oFdQ7wZP+a0LTlncbPXuZ3gMFW9fWWCjVT61gSZsVveTyHmLQYkeJzOwKl1z5hFWNW1cf+CevNlMBi5k1vwlloAq3oDf6/B/aSdZzPUkjt2n+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738478; c=relaxed/simple;
	bh=b933h/BSDWZOg2FIRIcEBVYPS0fPuOoZrGvm9DHgaJE=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=KfbBhdxEKLPKUczsDl6omIs5YTH1FzAIgcaX/VnphCEyR6sZY/LBsw70I5HjYLEoNEnfHy/VFx5/IK07wVWx9et22Picy+mVMaXR2zJHeVumN/sL01BmpxMYwxDpglDo43YMq2UNbpRCJv/YSm1LPwLuUUugOXlmYEpShdd/gas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=qrXLBrMz; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="qrXLBrMz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=0EmVK1O8vS2pNuH1H9FX4ZrTOCmkJPV9Chkuru+yan4=; b=qrXLBrMzS+tt5iAZnh5zjlGd87
	0jj/cCkq/CwQ2vUuwt6H6T3o8rEly4nKuPCtVuKZOqqzxSTGGrjxC6ep5UVfqRRng2BjdFGTOurIl
	nx3j0AUWdmmp/caYDGOFsPgzjpgQ7NIUi+QYL2Kcy96RHMZfmRAvqpbf2Vr9TN+XzKAU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42592 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vyEFy-0002na-Jo; Thu, 05 Mar 2026 14:21:10 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robin@protonic.nl,
	andy@kernel.org,
	geert@linux-m68k.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	hvilleneuve@dimonoff.com,
	mkorpershoek@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	alexander.sverdlin@gmail.com,
	marek.vasut@gmail.com,
	akurz@blala.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	hugo@hugovil.com
Date: Thu,  5 Mar 2026 14:20:48 -0500
Message-ID: <20260305192101.2125660-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305192101.2125660-1-hugo@hugovil.com>
References: <20260305192101.2125660-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
Subject: [PATCH v4 2/4] dt-bindings: input: add settling-time-us common property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add common property that can be reused by other bindings.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Note: a similar property is used by gpio-matrix-keypad.yaml:
  col-scan-delay-us
---
 Documentation/devicetree/bindings/input/input.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index 502e0b7eb500a..14652d324e2ca 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -66,6 +66,14 @@ properties:
       reset automatically. Device with key pressed reset feature can specify
       this property.
 
+  settling-time-us:
+    description:
+      Delay, in microseconds, when activating an output line/col/row GPIO
+      before we can reliably read other input GPIOs that maybe affected by this
+      output. This can be the case for an output with a RC circuit that affects
+      ramp-up/down times.
+    default: 0
+
 dependencies:
   linux,input-type: [ "linux,code" ]
 
-- 
2.47.3

