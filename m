Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107782;
	b=xbUCakxFTmiDGyvrUrf5aM9mQqT8G1g+0CsKHK3L6jQOv4qTBpTiioQn1HgAR839NvzO
	 wYiq0ryctnENrYnzYNQacjL5xMCUozHrEY8vxWbTzEyGBm27IyyFJoYD9SF/cdq0obLf9
	 QaVPTLiu20WWDt7lhET5upCc+EGNq0xU8kIXx+hwmWoiO8/dYRQaqkYTaTROsDxhuBKcl
	 JSD6rcIpPFy+KWUD9bbMuuyyr0f37gE1YdR5Ylf5GX+dfy6iOCKl+5OXOvXLX2tWs0+Yp
	 LHz6Enb5zCyVrH2pHA7g0On9ED80H0NCNEq2NGys/lKCdaRXH5mOJuRre4vsIHhKXHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107782;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=KYl97dZXIPj3+usyFPRdhNrRc4cg66rIZdGuOzGDQko=;
	b=pWibsiIpCofF0Ok7y6a9Pun2zj89k+/zXYac6ACmpPXvVApsa/y/pbEP6CCvfFiwGBV0
	 E9+cdEeAFkRrzl7lZQ0XkQa9cF+98r2ezOhv7XYMcxzDpNKrPrsiIHlY5UO71+kXfO54U
	 cSa2+P9VXObY7385AHhU0gu2A/DXj+LGgBMm2t+XQ9sBb3dU18acltSFAsFzmEoQUGZZS
	 nrbw7hMq6QiMRIJtEZFDK3HB067MZ2L12gFsW5ChasHcPc3FP5UhBXHKAZV28WSOAv/Gx
	 yK/F6ZIbHjSfr70+XvXUsWKydXxY+QxuP3b4Gp1OA1giksZeUEXUVvifGgGkdZ4pn2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=iMtSAuIA;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC223606A9D7;
	Tue, 27 Oct 2026 13:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC223606A9D7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=iMtSAuIA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=KYl97dZXIPj3+usyFPRdhNrRc4cg66rIZd
	GuOzGDQko=; b=iMtSAuIAhkqlYMIs0lNpxCqZocXqz4iJfgIKM8CBnbOuAOhy/c
	ttV/aGfisOkOmxXXo8jPPj6OH4CSyWp7IDsRkA2PMZq/OYsWamnnCbfZFVSm5wiy
	mzqdpyrsZh/60Fl0euGUMjq2Ggu5ltJ4NKAGsUku/gEw08kVn32I9Gj+Y=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.11])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHhDg5p+BqGGxRAA--.1917S3;
	Tue, 27 Oct 2026 21:29:30 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Input: aw86927 - fix the 7 V boost reference for AW86938
Date: Tue, 27 Oct 2026 21:29:25 +0800
Message-ID: <20261027132929.242158-2-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgAHhDg5p+BqGGxRAA--.1917S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr15Zr1DGrW3ur1ftF1fZwb_yoWkWFb_Cr
	y8Zwn3Z340kF1kKw4DJwsIvrZIqrn5Wa43Zwnavr15KFyxtFsrJa18Xr4UXwn7ArWDJw1U
	Kr4UAasa9a4FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSAYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwnYrUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARENB2rfqlZqOAAqsr

AW86938_PLAYCFG1_BST_7000MV names 7 V, but the register encodes the boost
voltage as ((mV - 6000) / 2 * 0x8313) >> 22 + 5, so the value used since
AW86938 support was added, 0x11, selects 9 V.  Program 0x09 for 7 V, the
value the vendor driver uses for these actuators.

Found while adding the AW86937 variant, which shares the register layout
and the same wrong value.

Fixes: df53055c540f ("Input: aw86927 - add support for Awinic AW86938")
Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 1f73f0636..813f3591b 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -48,7 +48,7 @@
 #define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(5, 5)
 #define AW86938_PLAYCFG1_BST_MODE_BYPASS	0
 #define AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(4, 0)
-#define AW86938_PLAYCFG1_BST_7000MV		0x11
+#define AW86938_PLAYCFG1_BST_7000MV		0x09
 
 #define AW86927_PLAYCFG2_REG			0x07
 
-- 
2.53.0

