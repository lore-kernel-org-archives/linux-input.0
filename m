Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485040;
	b=OxTvLPOwe1+6BFQ/XglgSLR5dFcfqO+dIzZQa2jeMl4UAyNu5tZt79vdUN0IMPmdNcrI
	 LVPjE2I0zxba8teLewuwyXZiwvIiylMHkunppJw7W+WO6yH8228RYKzKi0MrPTp+jUsV0
	 wODnTh3tIcJmKGCDT9bJIKrfe9Qf5hWJIMvUI4COWxJSbTiDWYgqGxEGiwP8AdLUHLlsO
	 LZuZ0Sy8qRi6Lp0Ss1ChU28yGvR5zZMRqIQ6KX4We4nDmu5iq+AHijYRgGXJmrzNolk4P
	 I8OcMtlzzD+peNVCJBiXMgLIwqqXzPvbXwRYRYkQOJp79iZ+F+JQwbQiCPrKN0KEC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485040;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=xgwJi59qXxes10N4OGKnl91AGdF1QiWQsvKKz9/bnn4=;
	b=aiUWdsLu640JIRl4KJBthpuqTwl1Wkt6exuyCFJ3Ao71n12vXMCe2wV2ExSi4B2yWlak
	 Yaxrmib+QAJBCKFgtMZ+k0qfm7Wf/g5S0/3f9oaBiMeGji4+UZXqhteynq1LMtY6BX1M7
	 jB/WuySiOx+OU8eV1HcUXjA/HXHuVjCYaX3bsZlR4lqobwNNjb5p5df0SKRAh6ZLxscNu
	 Wx2GHAyaN12dTQF02Ysmp7EVZtEQMZmXKydW56GSULCxYKAl/Wf1EHIZ3wI2C5vM7C+sz
	 W3xnKD8mG+c4LqHePVTVrvbyDZDSDMtYjC3Yd32cF57tyGxd2K614/+Cb+UZQoh683w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=BLdXNl8p;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B6606A31E;
	Tue, 24 Nov 2026 01:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E29B6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=BLdXNl8p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=xgwJi59qXxes10N4OGKnl91AGdF1QiWQsv
	KKz9/bnn4=; b=BLdXNl8pEfDOBQkANIoYNhSBOiuoGHJWsUdhG5Jpu9NZu0HQNH
	MKXiK5ui5E+xMy2VfuPIYFOkIHneuwg0v8LCLb9h9Jjsycb6lSub4lowN8/XEot2
	3pbZFArZ9aMr7YQfBfivElnlpS8fLjvyXdh5Q5773e3DgEot2seHe6Iyc=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHPDFk7QRrHDHvAA--.1941S5;
	Tue, 24 Nov 2026 09:50:35 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 3/6] dt-bindings: input: awinic,aw86927: document the AW86937 variant
Date: Tue, 24 Nov 2026 09:50:25 +0800
Message-ID: <20261124015028.1427420-4-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDHPDFk7QRrHDHvAA--.1941S5
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xtF13KFWrWF17KF15Jwb_yoWDXFc_Za
	yxJw4v934UCF4FganYvFs7tF17Wa18AF9rZ3Z5AF4Dt3W0yrZrGaykJw13Ar1rGw4xurWU
	ur4kW347Wan3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqxYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4
	AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8nq
	XPUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREAB2sElFsCDQAzsL

The AW86937 is a sibling of the AW86938 with the same register layout and
a distinct CHIPID.  It is described the same way as the AW86938, with the
AW86927 compatible as fallback; software tells the parts apart by reading
the CHIPID registers.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
index bd74b81488f6..42b8f5f9e8e5 100644
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

