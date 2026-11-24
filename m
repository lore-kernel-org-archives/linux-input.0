Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485041;
	b=eqjsVSeB7NjotMV2HfEFRWDgQGPfaU4Gpmjr+cy6zStAoECJz4lzdyv0gCGSIKZn1dG6
	 QZS+9VDNUoE8jD8jX/JAmrT9worgDMBpd3M9GDdCTWpVYIZuG8UgNV1YbpdUk8EwxjIpT
	 fBUjhXxYY2AEp4XL1UipjVOvDNjmW+y7JBLkbndBIG/zwIbY+l+kK6BkYi0Xj4w18Tr8k
	 kxLM7HTX/7Klx8MbVKwB/1o9k4WGZD04HYJecnO0fm/lDN3tCTzF+J8/cJa0jKzadt6I5
	 zJ0DZFzpb6zp8IE19dlb0c/zOxNFcHcX2aWf2xsoU37h9CimvdzlhjmU4nVYv17en0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485041;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=mZAY9Vy41H04k11GC9NPaGnt3C64lLH0I81NfILxofI=;
	b=yHYsD81YaVy2Nh5lcQA9NzfCitaKxJ/XoWynMbRuNLL/tFZsRXyn0Nidb/2t5Msx6ZBh
	 wU58/ne8LGfJeaDmteaBX6NgUqTWa+PiSgpsImDgQUY3hDSKJV3cPY7JNvEUufYaVqAit
	 ZkMGIufcGwgs1S2rVF6LFM1kIw2thjbIptsKITzo2NYiL6A7SIsHAv3LvEEU3GYu7GhZ+
	 6oXOTo/5JCJMX5Fps2Uh/9IQ9pYGqXRIqoJSDmof+Z6JGFIc+8o5ZyBh5gUlxVSDD5kyG
	 HIc7xK6/KxueQ0+/bitXbqSe5ulHljjCl4ZMeNgh+bZeYITKnKyFl2p7wxHvXgucQLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b="EMR/Hsy5";
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4B606A338;
	Tue, 24 Nov 2026 01:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4C4B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=EMR/Hsy5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=mZAY9Vy41H04k11GC9NPaGnt3C64lLH0I8
	1NfILxofI=; b=EMR/Hsy59Prf2d9soDkJHWZpibPumPUD1BA3PdKbfZasvo5Zl8
	gWZ428OmNaHYyJtxCa2Ag3bMoaHC5NLRZsEC/vgKc9qhyMSk1c3vhOXr4tjVje1T
	GaEjnGyIbu03JcayhjePdH9Fz4AVOwbrykU5H50jaiVBO/8+Rp+imwYRA=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHPDFk7QRrHDHvAA--.1941S6;
	Tue, 24 Nov 2026 09:50:37 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] Input: aw86927 - add support for Awinic AW86937
Date: Tue, 24 Nov 2026 09:50:26 +0800
Message-ID: <20261124015028.1427420-5-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgDHPDFk7QRrHDHvAA--.1941S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fCF15Zr1kur15tFyrWFg_yoW8Gw18pF
	yDGr4DKFWYqFWUKws7tr1jvFy3C342grZrta9I93W2qwnxGw4rKF1vg3yxZr1UKrW5GF4f
	Ja97JF1Uuan7Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	kIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
	WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jn-BNUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREAB2sElFsCDQA0sM

The AW86937 reports CHIPID 0x9370 and is register compatible with the
AW86938 as far as the boost setup is concerned, so it joins that branch of
the haptic initialisation.  Detection stays by CHIPID, so the existing
AW86927 compatible keeps working as fallback.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index b9b7315a5dbe..699c92a1ce8c 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -146,6 +146,7 @@
 #define AW86927_CHIPIDH_REG			0x57
 #define AW86927_CHIPIDL_REG			0x58
 #define AW86927_CHIPID				0x9270
+#define AW86937_CHIPID				0x9370
 #define AW86938_CHIPID				0x9380
 
 #define AW86927_TMCFG_REG			0x5b
@@ -182,6 +183,7 @@ enum aw86927_work_mode {
 
 enum aw86927_model {
 	AW86927,
+	AW86937,
 	AW86938,
 };
 
@@ -588,6 +590,7 @@ static int aw86927_haptic_init(struct aw86927_data *haptics)
 		if (err)
 			return err;
 		break;
+	case AW86937:
 	case AW86938:
 		err = regmap_update_bits(haptics->regmap,
 					 AW86938_PLAYCFG1_REG,
@@ -750,6 +753,9 @@ static int aw86927_detect(struct aw86927_data *haptics)
 	case AW86927_CHIPID:
 		haptics->model = AW86927;
 		break;
+	case AW86937_CHIPID:
+		haptics->model = AW86937;
+		break;
 	case AW86938_CHIPID:
 		haptics->model = AW86938;
 		break;
-- 
2.53.0

