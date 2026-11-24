Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495849;
	b=ctXmoBjaS4TuU+ZENQpHKzDSJw3q2hDboH1jlUtuifY0eyG6cFpCspJvPs/sa1wVuf6A
	 TRh8GZILzOgxFmRk5E23wuAWW6PTVj+mMzhpliK5aANXN7/m2jReV+uA10pnhKokrFV+6
	 wPUp0gdIkupMI9OLNwISLOfOUU79aBqqkuGKZpQM006si44gFrE12jXVdVmmlgrkiDjuA
	 /vqtjBxuwlMzeFfzLVMiA3Y2DM9x/adoCRgM3g+3n1sZKNt0mDteZRX+4LVFAyu9eRjSJ
	 cRnLF8ZNyPB98DbWDb0LXT6Zvu5z8i5NeABVbzSVd2I9Vs7nYaGYIjb5bPUhuNQZ/TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495849;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=pO1n33MIlivhplMTiEveWZuYlsdnfPuFo43G4PA7bug=;
	b=4Yy5rQNNx9RE9UTrcbd0N3drqNqNcTwidGpbmF6TI/hThLnOB4LImC7SmoLHsVJE2gB/
	 osyVaBx6NvCnx+RcyH/w95j87Ee/lGqXAKN5/3geQ3eoQQxXyU4AaQxOkto8UE0YDVZyc
	 GQ4pr/SFraPHlc29Bw2fMz+XgNhpwpXJywva4Qzr3yFa4pBnN8LdqbrRIta9QXJ8KyuBU
	 Rs49ktv73EIUMYwsGGh+zztLj08JFDTybmvRhvuhi77F8PLna9GQ3HSkl0HFLbDMTyxoD
	 mDWLcrBaCb9YGmgRWNXADN8uSq3j97jh2dIQy06lNjrjXFLysC4/QtsVbqUB732G4yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b="Fi/9vHDG";
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6440606A31E;
	Tue, 24 Nov 2026 04:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6440606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Fi/9vHDG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=pO1n33MIlivhplMTiEveWZuYlsdnfPuFo4
	3G4PA7bug=; b=Fi/9vHDGWOp7ZveC0w6HVG9nSZ7t8bSnFMW72CINprkGC9DZ1o
	QW0uxd0QP8RZXn0CkSjsk4f9b2iFCZy7tWZY8r5z8PTNUCUQ/lfT4211sKx6HFQq
	YYahPv0mY2K4cKxfVk2Cb2015OkJ8/LypA0pSs6xhMPCSHhQ8aKC9ED28=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn2i6gFwVruBfwAA--.253S3;
	Tue, 24 Nov 2026 12:50:44 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] Input: aw86927 - fix the 7 V boost reference for AW86938
Date: Tue, 24 Nov 2026 12:50:35 +0800
Message-ID: <20261124045040.559317-2-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBn2i6gFwVruBfwAA--.253S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr15Zr1DGrW3ur1ftF1fZwb_yoWkWFg_C3
	4rZwn7Z340kF1kKw4DtwsxurZIqrn5Wa47Z3Zavw15KFyIyFsrta18Xr4UXwn7ArWDAw1U
	tr4UAasa9a4FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
	1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIecxEwV
	AFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIk9N
	UUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFst2AAlsm

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
index 0657c52b4c..6d09e5e96b 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -47,7 +47,7 @@
 #define AW86938_PLAYCFG1_BST_MODE_MASK		GENMASK(5, 5)
 #define AW86938_PLAYCFG1_BST_MODE_BYPASS	0
 #define AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(4, 0)
-#define AW86938_PLAYCFG1_BST_7000MV		0x11
+#define AW86938_PLAYCFG1_BST_7000MV		0x09
 
 #define AW86927_PLAYCFG2_REG			0x07
 
-- 
2.53.0

