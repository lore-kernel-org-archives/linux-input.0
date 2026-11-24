Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485035;
	b=rfcYwf2kuN8Sw9ejzlrPvwUOFb0Md+VkJMbTfXxuHclK41FFv3L5vTnBMPWCgb1Cat6I
	 ZQqmHLBS7n872/WYw+lUiwreV8hggrnrqpxj9ZgQOyW+Q8S0hDJ2QLMLSsZaNbTuYOS98
	 juR5+RARDLiktWVSZFNnHSRlZV8Pdd6sEjvgzzsgRl9SDIZ/0lxXjyBs0gI+WZjWqmk5W
	 oUgvlptkWhSAl18O3Itx/jhbs7vh3Ptk1ctvOK6wq+4JxB1DB5lE80mk0swWEaeXp6Vbt
	 qay3nrwErTLlqNTIy/Lz9sUnmWZ6CTDURzzMXca7VE9nxP8mjyhrphzU+lTj2GSRLlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485035;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=8stPd0BvbVB4nZtLZxMRHJFqc7x8Surgk6m4yiTBfog=;
	b=Bu/5hlYp60Qi1coN6ZGXLV2sLrM+rdRqMk4PpYITb0A/FdAPKDt5lZP1wuM/2V3e7WMX
	 Kiv1ArVnizJxOLoWckJswNn15AFXs3YE3bYwq4PmWdk6CHqnTdLB77ZUd92eoiC5Ng5Et
	 KySWhR5IFU1mBZuwopazt/6RP700Zh2dv2E/WjQ7Q8i9IIByyQk7Vp1lzDmbeavbqdMc2
	 BvQLr7ba9aLpBVO6Ph9BOCuxzBDhd8je8B8uDTpCEsJTd3VdRSgoW5IK3e506w8EIdpMG
	 79fRRhdhJf5kT6J1Yzufgo48hYls5UwX1SwNHZtSDAxYDEdH4I8lbwGeluVsOUG3sEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=VEf391pB;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD20606A31E;
	Tue, 24 Nov 2026 01:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD20606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=VEf391pB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=8stPd0BvbVB4nZtLZxMRHJFqc7x8Surgk6
	m4yiTBfog=; b=VEf391pBXqHKEtkEam/JWIeNSceFA8QDAtoXiNDfqvy9p50XFK
	5Eh8OyYU5FRJovX1I40wKVM7kkFq0fmluMAqhfejtP+ituS5iowWDWoJuRlc88W7
	JjxfCJREkOQugGdIxDROP6zIz/cyqULf5h9pg/nD6UK+mUmNF9jU9jXcM=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHPDFk7QRrHDHvAA--.1941S3;
	Tue, 24 Nov 2026 09:50:31 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] Input: aw86927 - fix the 7 V boost reference for AW86938
Date: Tue, 24 Nov 2026 09:50:23 +0800
Message-ID: <20261124015028.1427420-2-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDHPDFk7QRrHDHvAA--.1941S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr15Zr1DGrW3ur1ftF1fZwb_yoWkArb_C3
	4rZwn7Z340kF1kKw4DtwsxZrZIqrn5Wa48Z3Zavw15KFyIyFsrta18Xr4UXwn7ArWDAw1U
	tw4UAasa9a4FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
	IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CE
	w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4
	AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcT5d
	DUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREAB2sElFsCDQAwsI

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
index 0657c52b4c79..6d09e5e96b2a 100644
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

