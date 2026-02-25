Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD72236F7;
	Wed, 25 Feb 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034866; cv=none; b=AU8PSXaJ2scdG6syYxmYkGlF8WszXkZL/4G0BYcXXhH39LArFZTHoztV7U0Lws/amuK/2ebxVWJURN4MlwCKDisXUObvkQeDBpMmN1Y4dQOnvhagmJ9VyRnQ6+dUUW5MWe1d2Vp55KzUch9f7IL8j9PUIYiKFysStrEaordn+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034866; c=relaxed/simple;
	bh=rSz6IXhh2QscmjUlh9jv5Yx4lx9IplfcfVw4rrzsgYQ=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=F5axlSu0rj7LP/jaFI/OG6NsPxJNdvDRLOK3VqqSeGoVGAjdXZPL17luALUdn0iF12zYWS0ZKHBuO/edpZHWT5n5fd8YLp14uWHAFJauJ6psMHHudRSQLBcpupaTnkf2QADjiB5KLyK7BZR/wMcQwQDtkOTDR1w5+tyUUJ5VzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=qbVbDMbq; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="qbVbDMbq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=XX4ai7/kA1JrfXNrpCNkIDlOwikwomvibsgv25K1pKk=; b=qbVbDMbq62dN6kBqo/s705o8sx
	MZVlDbsGuEoTefCcVIgHXONFOu3LqIOFWHL46zDjckzqVeoYAaHLTnfwZR+iXEf8zwEv1RHL+y/IU
	7aSB40UbxE+u5IwPBPtbw5b2zmmpJ2aAX7ZSbNdx6LBEJwveQ0cbjX8EZnZWvFV6Bsm4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47746 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vvHDL-0005uT-9J; Wed, 25 Feb 2026 10:54:15 -0500
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
Date: Wed, 25 Feb 2026 10:53:59 -0500
Message-ID: <20260225155409.612478-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225155409.612478-1-hugo@hugovil.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
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
Subject: [PATCH v3 2/4] dt-bindings: input: add settling-time-us common property
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
index 502e0b7eb500..14652d324e2c 100644
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

