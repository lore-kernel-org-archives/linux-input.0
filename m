Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572783F99CC;
	Thu, 12 Mar 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338595; cv=none; b=Nb+SeQKRDxgyirx8FiKm4KIJXf6hk5bGVCGobAhhJUdMXXgrOV8O7JgtxiDRQYoxLnHXUSUMEBG9qDi4iIIaKvnTn8Hf6e9XxYVzkoSlKBEYK9SFrAAk4ZAzb8ONghCBR3sSWNczhE5FTD0WrXxOUUvNTd4TlLSnIN8SC4YODdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338595; c=relaxed/simple;
	bh=IcACeMg0kt3M488B3RO6EQz0azJ/9JETPLl4xl/Uxok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5q+E/GRHB2Ml6VCfd28VMQhhOp97/1BVJGS8iF3IpY1hfVrKLT+Gfx0x2aBG5Lvnm9MTPqxgt06vnaISn3U4KMWlFn1Rw44gsvM/hIoXJLpaLivJtbM9TXDUQ+6el06rencZ/8K8Bi4U4Cp2uJ8jm7IlNN1xT6/tiwqAqMJeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=fail (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=UMh1lMPj reason="key not found in DNS"; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="UMh1lMPj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=771mNE44sHQhC5rmXckx2CaBH1T0oXxmMruW/wkQt0o=; b=UMh1lMPjQBQYsTSLf3MUG0Xw4x
	WRhhPsI3rPMDOqRsYjnSOjN1wY1GO/fVEVqIK8Vk6t5VNYQy+p16cQWyypzfq3sfP7xwhG4qBC8DH
	utCIax06mi4t97EmuCLymZIm4W3nY39hFod7MYvy2E+ni6WsY/EDQkG2oGoNuSPeoStg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1w0kNL-000000008Fl-0QLo;
	Thu, 12 Mar 2026 14:03:11 -0400
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
Subject: [PATCH v5 2/4] dt-bindings: input: add settling-time-us common property
Date: Thu, 12 Mar 2026 14:00:56 -0400
Message-ID: <20260312180304.3865850-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312180304.3865850-1-hugo@hugovil.com>
References: <20260312180304.3865850-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add common property that can be reused by other bindings.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 Documentation/devicetree/bindings/input/input.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index 502e0b7eb500a..64d1c46cb2f2a 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -66,6 +66,14 @@ properties:
       reset automatically. Device with key pressed reset feature can specify
       this property.
 
+  settling-time-us:
+    description:
+      Delay, in microseconds, when activating an output line/col/row before
+      we can reliably read other input lines that maybe affected by this
+      output. This can be the case for an output with a RC circuit that affects
+      ramp-up/down times.
+    default: 0
+
 dependencies:
   linux,input-type: [ "linux,code" ]
 
-- 
2.47.3

