Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0437C0F6
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375512; cv=none; b=fqeTJADXN82zdI6hlVURRM0KMTvom77HTEU1ssrQ/JJsc8cTk8C2836M7G+76tuvdl9VPVAY9JFvpVQmp2+7MsWPhYvN2KNCn30fvM9q7DZ5L84iT18PjFklclwLN2gZOB1EjWa2NsDMuSCfCSXVJ3f94q/nVmguzs4dITWotHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375512; c=relaxed/simple;
	bh=J4ST441g4GcL9Qf2m4E79qGEfDOnvVL9JwIy2R9JJ48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIolILleK8Z85AvnhwhXkLJQ1+xEygyPmnGZo1sUSU6Lleyk/iDXPAAoYERv+nHuPh72bZR0mUxSr0m1QEkGV88vYsgjH1eeq1l14g4dTPR1UtKYuahP2G73dOxJ1KCUAR0e1HnbENrfkLMbHg6xj3HsFlfQbj+zG19vDIKPS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne0Bzf2P; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne0Bzf2P"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aea1776279so389953e87.2
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375507; x=1782980307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihKUarJUZQ4s5QQSEeZE4451TwDBF8kmyP9i/ksYTag=;
        b=ne0Bzf2PUc0naVwlW+xiieoMeD/JbIvMJbegoMJOB55Awv2EaqRXnsGYY6EbYe66EH
         KDJps+6Y3Vl/bhIx00XXmKFmsi64+WvGt6Xc/ngWVKKH/uGNa5lxvJr4GUHSynroEbh+
         L/FYFKN+Yyj2lxRPkMLUf9PFaeTbWKh/VrniOCy5dRfmTMKChSyCOJM1K7pf2XJ1dmhD
         igiTinOOF8lHrNbQCCZu1RxfZH7uzQVxhRLYgfakKV6BlhtBN33/kJvm06i1x2rGo6W5
         nZ07FALbbX5Br9F+fzHUK5uK3ms/U2ehyBp/3ETbQAodBw0BO9PRGT5AbMpBGNOhfcbN
         yYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375507; x=1782980307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihKUarJUZQ4s5QQSEeZE4451TwDBF8kmyP9i/ksYTag=;
        b=M3o6ks5JKNjQh5YiATxI3UIw7sXCiKhQLd5C/ArwihH9bUPsP8AE8ngvVctGPyUYdw
         pBGUQ0WhJYaCWUUGsOq7kcADRZ8ka80FobQWLDz8FLdsbAYn9WrhwFSv5/sLEXRGoyNh
         CE2xUzDbmbWs1GdoWBsV3CWJjNc53+jIkS9NlCjKI4LgiYIGyZBocQN6YyLvWSw6vBjk
         JJp4S9Ywqig769YleFvmaVg2lt9zF6pvYcElTas+czTWZNePtkFUMBYs5DCpVnd0K5EV
         h5BENE0ttnsd81vwjkjayLlaKSy2g6y6759+9wfiTVbhUde5x8CCYsqVJOvPgwTpk1uz
         8vkw==
X-Gm-Message-State: AOJu0Yx57Cd7oe+RAkBJKWFS8qpETTt+dWvi9XNOTYECK9La20oG0h5P
	aQAH+rj87UWAp4/yywANzpGN/AkMJE5R2z/O8GzkQgzhz5aVrEa9p8G4
X-Gm-Gg: AfdE7cmimTWZnyNmpNBVq2VVEDxTr9ZZ8dwCNdRD4gjN90ADYLKjRenAAQZA2aK3roD
	+QQmUX5kmjvq4nw8HSG0VwpkYtfl/jeQYEowM5X37u+lO+bwCCW72ajlfIwk7jfAX1tP+3E8BOu
	Uc87Am820KvZ8POK9QHTr6686XgrC7xPfNh4SM00H0w6oroMmxL4DXq0IxemdwF/mfxwFHakuoU
	x6i3rfB58es5gjLe2cqdnykmWcJxERFOreDMdISmNRvs3ObkXaDtKHFbPgpZcyWjCukrA7EVmj0
	ns5QcIq5FfC3QMpIvJppxur4M7n/oQ6zycqD62oPEpwiA8YxZa9slcI6CxSwHuKcN/JMlXFeShj
	1MJ8WQyWI0yHx5qJDLlQhFSZh3vs8WociNtuLrf3J6zwdI2YPyIq8v/ae5vQrFiWQbyylGWsIQA
	8BNd/Aq80i7IUZsl/yo9e2UkbCBBlVvJTVtvt9j3SwvnIW
X-Received: by 2002:a05:6512:6cd:b0:5aa:b6b:93c3 with SMTP id 2adb3069b0e04-5aea1f695abmr512925e87.45.1782375506860;
        Thu, 25 Jun 2026 01:18:26 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a268sm2464601e87.38.2026.06.25.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:18:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v6 4/6 RESEND] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Thu, 25 Jun 2026 11:18:10 +0300
Message-ID: <20260625081812.33474-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625081812.33474-1-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mfd/motorola,cpcap.yaml       | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
index 76705ea56805..da7abe2ec912 100644
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

