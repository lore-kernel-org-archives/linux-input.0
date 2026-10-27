Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107782;
	b=pXSS6LvQ2zbjFAso+vUKIS/SuK/gYez/99f7bAKTnNW8qQIr47+OvemV6q88YB+JUOdQ
	 2JbI730sQ/rDfjnDC2gr4N4Kv5kcayig7odxaVPaKfw8+A8xzTr2f9bTxrZavLTCjRWSs
	 iooOimeOXAg/nUiwkspoGxYHFmQfD1qFZcPqy4xNSyvlAbUqm+7yt+xBYFWFlkG+k9HSJ
	 n3FHStFJh4iWJUmcKJQHutWRxWGLdVuFQRpMHOh7flWYp30lay+GSDs8Kq0aR7NJZeLGT
	 cUbmp75rKcCji7dnuaPsPH76pCUFHBvjqSTLJj53NHNDfkkwGcfz97OPqcjPylxa4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107782;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=usk93bEIPutx+3MHpDSumCJyW1kLRM+PSjY5FrtPGEo=;
	b=KUEKMJ1mp86G17wNGoVSg0dDTDYoHMK+1F3L9kPBB77EsBPuorubczN2LzgtKVTWJOna
	 QR0mAUBn+JJmQ2H4pxOVcMIXxtkxFbTKjh5COR2RH6LAooM/KCH10v2yez8rdr9Pt7YHo
	 5bRsvB64zTvQwaYB4v9scbJmUBOiThUJL97IK8dn/TMIc75X1k2l+8nWFsXuqV+75AiDu
	 SpB6dgIvh4YWRbF4ziotdkTyrtHVHlOQlMoQLlY+vpYifMZWyroKQA1Y9bAAePqleBjZt
	 GjpWaHLCfC8AqWfIIYdSwuOK/jfXE7bmaqpVwJoUeeNL3d3EpGzOEEtpaYrr6njow5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=T8GvAM+o;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64182606A31F;
	Tue, 27 Oct 2026 13:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64182606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=T8GvAM+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=usk93bEIPutx+3MHpDSumCJyW1kLRM+PSj
	Y5FrtPGEo=; b=T8GvAM+onZmdzn22hZemcL2b7hgNjDFvMAMjO3hAAuyYDmESMd
	koL9LHPQge0lM9Ql9PR7dAgYOn0THNZAN3WskfqBtqplxZtmCA9vM4vwC8533V9Z
	h7FY6hZ5ES0jt2nsVAih6nx0A+UtRwYbubjbyC7UkqRLMnKoMeKb/kL3k=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.11])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHhDg5p+BqGGxRAA--.1917S4;
	Tue, 27 Oct 2026 21:29:30 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: input: awinic,aw86927: document the AW86937 variant
Date: Tue, 27 Oct 2026 21:29:26 +0800
Message-ID: <20261027132929.242158-3-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027132929.242158-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261027132929.242158-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgAHhDg5p+BqGGxRAA--.1917S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xtF13KFWrWF17KFW5trb_yoWfCFb_Za
	yxJr4ku3s8CF4Fg3ZYvrs7tF17Xa18AF97Z3WrAF4kt3W8ArZrGayktw17Ar1rGw4xurW3
	ur4kW3srWan3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4yIUUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARENB2rfqlZqOAArsq

The AW86937 is a sibling of the AW86938 with the same register layout and
a distinct CHIPID.  It is described the same way as the AW86938, with the
AW86927 compatible as fallback; software tells the parts apart by reading
the CHIPID registers.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b8148..42b8f5f9e 100644
--- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -15,6 +15,7 @@ properties:
       - const: awinic,aw86927
       - items:
           - enum:
+              - awinic,aw86937
               - awinic,aw86938
           - const: awinic,aw86927
 
-- 
2.53.0

