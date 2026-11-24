Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495853;
	b=Tf7IEE/JaWmDvniyKyLHUWwFLPDsYW3lZFgq2+pmiVEyUAiLH4SUy5bFmHcqEY7raGwx
	 fSckfPV7wRTXDwzcDV7TCs/GnkwoQxyePjGBEPU03hN32OJ9Dp7grK0BJ2D3v9Y7PnBON
	 +wnW8BU6M89C1XtNkLH+kSzOMI0mNjJ3W7T7K8OrvVVJxD+MlbqnanAPKZfqsZS3VsvVd
	 FkJLKbcVUMW6bbLBXI5QEJScRRU5dyZzQag6+NMKE4ofIZYeg9+BKG41qkuzlytBILh+S
	 mJED+LJmLDtEyANRCJ2OgEtmX71ufC6tIl1kDb9zmkLoi9YcDBZ70bYEoW0kFWebUaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495853;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=tVjZr3yquW/PiypLn4/D8Ykqv016vgN53MzLr+VK9AY=;
	b=L+Z5IKTIh9dII1CwlAiJpuwuLgpbvgshTL6WfzPPoZTiGAIBj2W/klElMTBglFTfOZvA
	 5FmIV28oKS6At+IUbGF1HkUDU8/gLOWEP2nBjOzhO9kY0Xoz4sUc5ZlLCyquk+Nd1+M6r
	 At/gXQWelwTCyLfzLN3jolZkG2eYIKf3RhuyNbbOPFSGIP978qD05gqF29XHC0N1zmD+W
	 ze8jeg+mrxKEC4CvLx4gUqiY0DIML2rjJcfImLXZsy/u/7Z4LTK5UvZqm3qbUyeCr0qbf
	 c65CmPuAWfYx3dCXU3Ney56yX2R9icU4aBIW34yx7p3dd6NhFjV6UJY+TcHFocry4fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Hyc0cCzJ;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7255606A338;
	Tue, 24 Nov 2026 04:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7255606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Hyc0cCzJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=tVjZr3yquW/PiypLn4/D8Ykqv016vgN53M
	zLr+VK9AY=; b=Hyc0cCzJlOhWpcyglPA24ya/1HhmzwBa76dKyAySCl3eW4NWIV
	lW1rco7hWOpSeY2mV19SDt60ryFT/28gWCQkoOHmnpgl3RYfouh1j37y1zKzPQDv
	25DSASfWJguBcdBHbKR2bmgL807NmpOwP+EnapMXauOfagcV/v+cRbcRE=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn2i6gFwVruBfwAA--.253S5;
	Tue, 24 Nov 2026 12:50:47 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 3/6] dt-bindings: input: awinic,aw86927: document the AW86937 variant
Date: Tue, 24 Nov 2026 12:50:37 +0800
Message-ID: <20261124045040.559317-4-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124045040.559317-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261124045040.559317-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBn2i6gFwVruBfwAA--.253S5
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xtF13KFWrWF17KF15Jwb_yoWDXrc_Za
	yxJw4ku34UCF4FganYvrs7tF17Wa18Ar9rZ3Z5AF4Dt3W0yrZrGayktw17Ar1rGw4xurWU
	ur4kW347Wan3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
	1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIecxEwV
	AFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU4yv3
	UUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFst2AAnsk

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
index bd74b81488..42b8f5f9e8 100644
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

