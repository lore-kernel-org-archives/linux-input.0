Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892877;
	b=rcdeCLxjTKoM6KiRRHGCQhU85khNQBBbwEEhw0vVjr0ZrCk5YiZeVFxvx6TpHqx34981
	 ndu4jc/txrzxM1d89254hfGi+EJHE3ekT61GJ9MkioJOfK0yOWSdPgVQ9QEQGCTppYuDm
	 Gk9nTWTzmgx/6jl4IUvtxeOXk7paTc2paxG2xsxO/viBMDm45/FTbMClGB7EGISZAPSnC
	 O6y87Ndr2epClMIDQU7SC+0AP3Vhro17GhFdvPIBYY2tUiRvGdUD+5lMEg8LAyMlSn/kt
	 jRC6fjn4qjuRoArXcmBgTksKdBUlxRpv6+NxlzmkA2g6k2fvv9hMW0oHEux+NKHOrSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892877;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=pHAujE1Ath5iRxmpv3rGkwlvlFQgNk5kTuTPa7ERj80=;
	b=TFK5gAp9mAXzxExiX75UHm3mJyfiR0Epfn5TJ203i1TwKLy1c+VzEzwyU5tagJgBwK2y
	 DVHcPsOCpfoOVeHXksWdoI6s3eA03GBCFtZI21LUpfeILPDjX5Gfx2xoXKhwjJjlUrjHi
	 ECtW0mlhWtz3WHFfZkQE/Z6p+A78C6IHjHyxYWfG9+8ZS5AGURcAXRveZ3LBWrZcgh0VD
	 c7+ipRAE0HJuIjMXX3ienMUPD/bIBk9HRlNC6hFCC3udWmWHMFyN0vqm7QW6VZQDqg5La
	 p+Wj9jMfJEWdOThkjdhBoNEY4oW2F+8p9SO9B2Ahn5EEzR08gsd0DUy+cTHDjTeNfgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=d2UmH5Ak;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D325606A332;
	Tue, 17 Nov 2026 05:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D325606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=d2UmH5Ak
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=pHAujE1Ath5iRxmpv3rGkwlvlFQgNk5kTu
	TPa7ERj80=; b=d2UmH5AkcjVmhuG3XkTZ3gh53ilO3fNZDBEeSViQOeZJ2nKhR0
	TdS3NNSJ8NPi+s6HxnIVzLK3cK88C2uh4z2836mD+nxTgS1XOqv39DW9lb2YiA/U
	Vsy/8mDeqJ+ijzao6PxkBL9tP2Gt1Y2k7R0gNX/VwiAXY/2qPi2BdgtqE=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTlI5Ptqc0LLAA--.214S5;
	Tue, 17 Nov 2026 13:21:13 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 3/6] dt-bindings: input: awinic,aw86927: document the AW86937 variant
Date: Tue, 17 Nov 2026 13:21:09 +0800
Message-ID: <20261117052112.32527-4-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHxTlI5Ptqc0LLAA--.214S5
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xtF13KFWrWF17KF15Jwb_yoWDGFc_Za
	yxJw48u34UGF4FganYvrs7tF17Wa18Ar9rZ3WrAF4kt3W0yrZrGaykJw17Ar1rGw4xurWU
	ur4kW347Gan3GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
	1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIecxEwV
	AFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2LID
	DUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwATss

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
index bd74b81..42b8f5f 100644
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

