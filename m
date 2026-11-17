Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892880;
	b=2RNZtXD7GOdgsFBCT1KRrH6WvHQx4Y3BRwcTHWwfXIq5gdRw3yHOnHTDQwyXRZwa1DQm
	 CUuYo2uVAea+TxeJesQqW5C4Pxq1fuUPZ8mNP6LdFYNwuMN0D/CMApHASQ/1SCwardkBp
	 vBmXfGC85//RvHoEDzz+x0uzY2/F0/p6H2CTlRv/CYNVLk9GcknjS0QOspehDCVfb+VBs
	 qq/okEGenWHVpsOnXszKWYE33y339nxr2lw/5oE6KCgsInqBwOYeok2izCo+DdafMRVHb
	 qHhSzUUAiLJ6NTzZMc0apJ9ax8YYQ+KCuPuMHm46PWZSAJZntGMV4/Q1tvBHsItdJVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892880;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=eDQV/rDNj7Yb8pf/Zy9GR3KONoTlwlayGsHiXALYAJ0=;
	b=EzSAOr9nsyphdAGolriFxPZ+hlI1/JfYs0OtZCvc6ontv23plEaQnklBwWltv0PfHMiH
	 JScv6K65tC9MUoc/XYKP7vLK44F/ekXVUcx+nQgfLruMhTduJodx0pvp/TfWNznpaZSsL
	 5ED7Zfd0w77H28e5FOg32xZUT8QzTqPSlE+K9Nupz2hzJLEI9J9JrbmKZyBLXMQk2dwKX
	 +m19izro08hueRbyvc2aBLzYWJNsLVU8VB6HSj9s//7Jwwxk6Go6Q5RdqTXFTxYD9zggO
	 zFsV6cOwFYRU/GkSve1nw9YH1Pg+BcldmR1pCRZVwhqG5pgk8239rw8/029rPSQq2NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=fd5iuUHs;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBA606A330;
	Tue, 17 Nov 2026 05:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9CBA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=fd5iuUHs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=eDQV/rDNj7Yb8pf/Zy9GR3KONoTlwlayGs
	HiXALYAJ0=; b=fd5iuUHsYEj8VMvyQfBMknot1uC/s8CyKhqqGdt+GZ2c5RiPz+
	MDz1QLgrYGNloFPgnVs5l97qFmapIjRAZPaqJHnfqk3LBdBRFoorZD/fZdIGrF2r
	qvTEJ+DZGLDvkIEg9KoivD1fGPJA2yhb+NlFeQmLz9jBGdVllkJACi/XY=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTlI5Ptqc0LLAA--.214S3;
	Tue, 17 Nov 2026 13:21:13 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/6] Input: aw86927 - fix the 7 V boost reference for AW86938
Date: Tue, 17 Nov 2026 13:21:07 +0800
Message-ID: <20261117052112.32527-2-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHxTlI5Ptqc0LLAA--.214S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr15Zr1DGrW3ur1ftF1fZwb_yoWkWrb_C3
	4rZwn3Z340kF1kKw4DtwsIvrZIqrn5Wa43Z3Zavr15KFyIyFsrJa18Xr4UXwn7ArWDAa1j
	kr4UAasa9a4FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
	1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIecxEwV
	AFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwEfOU
	UUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwAQsv

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
index 1f73f06..813f359 100644
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

