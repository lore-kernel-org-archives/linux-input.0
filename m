Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340050;
	b=4G69icCtj5XpngnrcH1RUlPToN/u+3ZR8o3xowKIsYt65BrXDuC7lVh5lzkuZv0sTLRk
	 nrqvp4G0ns3cefxo+Px+bFWFfMzHDyH4oQJGpNPiibvzGo6kOuxgJ7F3EbZWj6110tWEJ
	 dQG1tDqR1Vv59zvCbgsGMyNiTrVrweznfM8mdfDDMxCuPSfNoI/L913wCJRIAUMdLVnH1
	 EnkX2n9nV2eIx/ByXLEpeqFpT4J5/77agG+XnBdr+uoDA/2GqKfRF1Vn/a3i68B8LtDWx
	 z0vuTchrB2RyK+fxfFALb/M6ctSQX/tRLnCM6gI5OU3Ut8s34cCEq/QGlgLu9cA8C9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IrMZtfuhPLKrTJMZV1yGooyCnLt3B177b/b9eOACZeQ=;
	b=2dO3ssJK/zMjs1klZWivcMZb5pSj1tiqU+cg/oi4tAv9zQ3tRvH9g3v/GzbHAQeF8qvS
	 5nfeEKKyGlDRilx+nhgo8AHifM8L5UJT8i8+iU8rX0fEVyNq30lDt9NG/iBoaPArCycg9
	 ce0Hgy325kCR8Xi2M7IR+53wvExdwNBcXtLrgzyFDGaXHXd/72om1+W/JfwxgVAqAS0r5
	 DOVQkMa7y+OdiftBzThqq/UZNfasPHh1A5jb0eBi8I/OgkFnhCEruU6mCrU1bzE/8B3Fc
	 3ACVwdCvJjfPKizVrlV6bWn5i/AZvzeEuaB7K3VPC2Ab2DfAkUTDh1lpSDvG/cTGCVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="K4XtxOw/";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83949606A686
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 09:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83949606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K4XtxOw/
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e47347279so1290454f8f.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 01:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795340049; x=1795944849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrMZtfuhPLKrTJMZV1yGooyCnLt3B177b/b9eOACZeQ=;
        b=K4XtxOw/m3oTYM8K+2snn0yKeJl0Cn+vHRsltBx05OWm31DTAXFf21XksJT0/6lRGT
         HBK3zz8D4PbgC4fgNqDKKFuWLoDn7eggmEedL3xFeVeOwYQp+YvPEEmamZMDvSWYD4ws
         rqOKq7IEVVIBul2NGb9aaG4OinozifvIXf39m/+eN98UQYcl8LkJyEP/U1rmkxql08I3
         YhWP5DXAWiIJe8VUVHOsne0WqZ01MkF9eoe+8Jr+VTZvGZaqDLvx8kyqKFpLXrJ5kJhZ
         4fpJz2iWHDv+SFWzDTkxNgT5KcRCJLcvRRUxaEQ3y+oFlCY3og3stHXnwaFnCp/3x2a9
         f1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795340049; x=1795944849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrMZtfuhPLKrTJMZV1yGooyCnLt3B177b/b9eOACZeQ=;
        b=HJ5CW/YtbVnJECivnkC2pVv/jxuM69B5iezMcUM/gLU+Nr45lbg4RlyrfBmhOuPFpN
         8CNEJXksHi0V9St5dLQku6MwLwAW4IpCPDxXrYKHv/PSf+HuK+BD0GuJfcpgvpMlgJlT
         Y16QAQWfVfxRN9rcEVqDYyHo343QhmsRHCbQ4ryHr5c1WyyTv1xs5oXuc1zzX7Cww1vY
         2fuOWhMRvoh7UoDUKkmlESvUmUUU9nfgWAuupVbJwRwDWJj4CPpN2gdzalKs2N9XrbHx
         409QQ39bc9uyoFWUXClYmfM/+2noHLBYLZDvMPQwCZEHLzBYuT6MB9mdCjYm/R+kM+Vs
         HUww==
X-Gm-Message-State: APuU4Z++WmZScdaQwFaDTbPEjlUZGXhXiqF4EHk8FF3RmLQwUH55SHUd
	cfl0+qKyhwSV5RBAQgXoT9fVQLkK+XWpQ/T16p7/5ZkC0gFGvQ1j8EMyrVHsm/5WeZs=
X-Gm-Gg: AZFdTZdeLddAA82vVpcI+rZ3Wf7K2rJr0CN7xg45E7RhDwiePpGBTmZylQHX4NVKJCA
	DqJ+mazJPLXz8CoeqvXlWKpIXxuICYnAnKL2ECuCiqWF1E+xPIEc+tLZnZFc7u6jxQcM7OX9P89
	WVpnMtbOqqtjmMMztUhbCoD0GgUCwWc1gZhK5chjEdUS2o9KZJldCdm5PoHo184wiw0Y1sqEv2a
	3T3Mb/Yq03PDERQKZritj9kYkcAKPjrdDYARqMc9NG+uAzUnbrEAYRmx/27o1LVWSZ8cVzZoHpS
	YPU4XsLxc29t+4K/unR8WmIWc91ec8EM2nx+1al6FeACwepxsr1xk9lFlzpEvyoj5nUOZdSNX6v
	GKTzEUntAEDn/l28nzJwupSVKwUB3jjHdM2PkPsc1ZAvtRtYEP/SD8WxMOh9IOM2rk7G9TT1Uu4
	cvZwFAb8OIDWuNn48lb3yqCReOLGGBYYcW6cHpl1+YKGTp3QWRGYvtEqfVnt3MNyoNiKPDAoZci
	p+HQssRz+cglD/eymsr194g6yp9iQujvk8hSF+5JTeh/EVXdqDXVo89QppUyf8Hf+cfb/zzNjGn
	LUrqKG2XLi1ZJEs32PVV6sbE3yLrGbms93ZJF+dAlhTUtgcEf12IQH7YBqifm8h01O8FtaJfOcq
	yEOy/RY9ArmI=
X-Received: by 2002:a05:6000:490b:b0:491:f77d:47e4 with SMTP id ffacd0b85a97d-4abb7f2ee8emr13478828f8f.49.1795340048964;
        Sun, 22 Nov 2026 01:34:08 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm1552848f8f.43.2026.11.22.01.34.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 01:34:08 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: input: touchscreen: hynitron,cst816x: Add supply
Date: Sun, 22 Nov 2026 10:34:05 +0100
Message-ID: <20261122093405.70406-3-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261122093405.70406-1-gerard@teslabs.com>
References: <20261122093405.70406-1-gerard@teslabs.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controllers run from a single 2.8 V to 3.6 V supply. Boards may
switch it, for example along with the display panel the touchscreen is
laminated to, so document it.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---

Notes:
    Checked with dtschema 2026.9: the steps of dt_binding_check run by hand (host make too old), yamllint and dt-check-style --mode=strict.

 .../bindings/input/touchscreen/hynitron,cst816x.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
index df52431b1d49..ae8424693534 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
@@ -30,6 +30,9 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  vdd-supply:
+    description: Power supply of the controller.
+
   linux,keycodes:
     minItems: 1
     items:
@@ -60,6 +63,7 @@ examples:
             interrupt-parent = <&gpio0>;
             interrupts = <4 IRQ_TYPE_EDGE_RISING>;
             reset-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vdd_ts>;
             touchscreen-size-x = <240>;
             touchscreen-size-y = <240>;
             linux,keycodes = <KEY_UP>, <KEY_DOWN>, <KEY_LEFT>, <KEY_RIGHT>,
-- 
2.45.2

