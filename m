Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334C34B678
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828759; cv=none; b=knWmxBCOu7uu3z0gFQeJR/e+3z2mhNsQWSTOuwqwKhZq1dAxfRjPaRWf6A50wPRqAYvkDsjhJ4vAKM+QM6IXACLakZXGF1oM9DDE+qUrNd+XDUSgggIxhUHIaXcCjoGAlaYwKevFW3p91MkezwMIvPaxuSLSz6U/M/tXVyVNV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828759; c=relaxed/simple;
	bh=qn/yoppFnHPkm/7wMIi4OZx3NpWnZmmaThF93Fmizvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m15q5M3oQ2Y/BthPj93ROQW2MvDtA1HS510iXkKWZ8KtuOMGWffJQXmnPknIM+8EY40mQFjfCL8eX+PIu/bBTBh0C0xAqBlHIpLE1QPSfQcCBBxzRtuvOaCgNHAwC5zo7t3cAFdTSvzQqi7dabZC3cbz6ot2WYR7kR86YfLjUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW72BrgC; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW72BrgC"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-59e4989dacdso4136050e87.1
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828757; x=1772433557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFYrOujfibvGrP3Q7JjlnOcmVI0rxGplc79nBkkyDuI=;
        b=UW72BrgCnJ12CdbRMvS/xHDXKYZHBOI++zoxD7FmupgbYT74oQJSiIHkf8nHJjBO5U
         sfLTNNuoo7bVKYSHQiMDHeet2kcpmjjtkxQuhrs0kmHHxq42H0tppESlzo2NnQbd7ze6
         Wx4hOobeaAeHqWc/qVhIMFyM3928xiyAakcXGb8HjHMp3NiQ5Ijmt4BDOS+B3pktfq1b
         WEJM+v0CkvRghPFp5yOD9qlx8DfjD8T/+lUWQvVkuOfl1BFb114zHaTdlnGBd8jJSZYQ
         jlFzZ0jMkdHMW0Kb3gifNQB3Gl0alTI0ZvRfyhZhhAJ89Q6qDGUONLcldyQhnqlpCQ8c
         PoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828757; x=1772433557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eFYrOujfibvGrP3Q7JjlnOcmVI0rxGplc79nBkkyDuI=;
        b=tlf7T4i8AlS54DyHcZyvvnzK4cz7e3Z5bkdDj2F/+nGDH2eK7yKqbCEFv2v7euGjki
         m0xNYsMQrp9yJvU+j7iu/owON1b2ERYoMwA9LtPvFal1agnPULF7b3SsoMzjNL8lLuaG
         vL/03IWcwacaECGM6KkOgrfOGKMLnnoTzsoqG4JB0JOUWCP8o8OcaDs790EDNJQNSm/h
         iTdErrQqIHjnpJ+2J5lfmDfhC6OGPw9A+Wcsy3WOj85OdglYHIHSUoftgM4U/z+gBm25
         OExLI1gho9nmfOyBpiZM+6nsE+1uxsxQPa8Ucg2ovgyhT5qZ1S69ulp9R5hChIvBIkmO
         IMig==
X-Gm-Message-State: AOJu0Yx0hkE0he+eZ+SanitBKEAtARaZCFw8N2UCEge6uEWp8yIs+5cj
	S7uM9Njf3FtD1kWXyLJaxZPDBXuYHWCCvW9O2Omys0KMoJld3FX9HAfx
X-Gm-Gg: AZuq6aKsg3ljwSD8TRx/+UUAuldv+DsVbjGlfk0zObKXxnwlbFzCMohBhXDWdK9BzEK
	ppTwFJ0UNjbT5L2ia45PJL6BG4zbROW7qvZzGysTPLWb8kKi1BCEW86MllaDHOPdjPIDNYd4a5Z
	KIpiDNO5mJFmzGepMimNCauQWmnZ6kXfh/WLWJ9s9haA13bOawWbgR7PyXcszagh9cnID3zBkUT
	eAzDM5nINI8+HoXRl0/aYi8uONyhcOijkU3lBs9Mioi+eDu60Rev4QWBwAYfKhmhCQC1fGVHsSi
	LDs377C8sAhISigQWeNDNFSqImPTNW3rmUkS2WKIb183/5I+Wr9+L58pBv9o84qUf5pXa7DDBi1
	5N3RJLkHFr7klYTbprxAg72C3n3wRr4RQZ9SgUaTfSIUbFMf1BNL3xsxtv0zCsw3FU//HWAP23z
	Ech2lwnM1r7y2dad165WELpDI=
X-Received: by 2002:ac2:4e12:0:b0:59e:39af:a710 with SMTP id 2adb3069b0e04-5a0ed99e11emr2406522e87.34.1771828756677;
        Sun, 22 Feb 2026 22:39:16 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13abbsm1369626e87.23.2026.02.22.22.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:39:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v3 7/9] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Mon, 23 Feb 2026 08:38:56 +0200
Message-ID: <20260223063858.12208-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063858.12208-1-clamor95@gmail.com>
References: <20260223063858.12208-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
variations cannot use st,6556002 fallback since they may be based on
different controllers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/mfd/motorola,cpcap.yaml       | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
index eea5b2efa80c..487e5456864b 100644
--- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
+++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: motorola,cpcap
-      - const: st,6556002
+    oneOf:
+      - enum:
+          - motorola,mapphone-cpcap
+          - motorola,mot-cpcap
+
+      - items:
+          - const: motorola,cpcap
+          - const: st,6556002
 
   reg:
     maxItems: 1
-- 
2.51.0

