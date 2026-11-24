Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495854;
	b=R2qdzSFjEmMLx6RL4s0hfXHRQBQQjX/VzKgHm5nh5Y3PXuzxFn77Iqgo3bJP13ZuUNOM
	 ipAJH0EV6T9vifBfPlbwQbjmIgCi7EZ7wh+aDYrWho0DXCEEpZW8K0iyUIHJxGhGtETRa
	 vVS4JJJ/izKEHlAQgKqHx/oD5jnuUeCuvAn1Q7pgq0HCDiIJplfNRQyswVsj3EfDkIqID
	 ZkfKgrdvqcriUl3iIIyDib4i13OiUD3l53H3SbB6M2H+z/8t2J9FWbmqEouwer8UNgibu
	 /qVrfcubq4Sp0wuoEAjYlDRzh0nUO7DO14rJXRuRyHnc31rtVTcXeygTYGtquk23K2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495854;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Wo/kjvUwoSjZPJhPX67mYlmWkMKH/RzTWthjz9yXcCc=;
	b=Msv07toR4bfMRbb5/zs68zmKcedjnjsmvlBGzQg71jXN25sUrXuk8zFc0BnK9cq84Lgc
	 8NDVRifgnRC5M6zQRSTXxRBueWrzYFoZI5Ro0/LfeUL5MBK2/fQxhf71pGlcAySsmPa4R
	 /BMfXWfcXljhZurPjYg0DwYN/1GThpMENz2o9WCOkr3LHB/vXFj+x6+KaHISdDA6/bOfJ
	 J2AFfB2T+oM5xCOW042wLN+of++qAIRggT9v6/OhKwFTZR/2zKE+4D1l0eEnmR3p4rlWK
	 tqJpVBJiA5MhcmBunxD7xS9s3FDPGixrrriCe44XcKdpgR1ypCu70MUT/Zfg7Rlghpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=PXh+BN6z;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687CC606A683;
	Tue, 24 Nov 2026 04:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687CC606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=PXh+BN6z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Wo/kjvUwoSjZPJhPX67mYlmWkMKH/RzTWt
	hjz9yXcCc=; b=PXh+BN6z4DyQbZ1OwN+HrIf/XbpU1ugmostHq5k/6MUVad/6LF
	Dih6ImMEGmfB1V2s6qft767uwhblavdpdOVLqCjA3nZ7hCDPzyiFmcahji222mCf
	KNbrVkjqVBQZOxG1yojRnk4cd78dq/7xUdT8QwugjqRcAYb4w6RYAUWxY=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn2i6gFwVruBfwAA--.253S6;
	Tue, 24 Nov 2026 12:50:49 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joonhoe Kim <26rote@gmail.com>
Subject: [PATCH v4 4/6] Input: aw86927 - add support for Awinic AW86937
Date: Tue, 24 Nov 2026 12:50:38 +0800
Message-ID: <20261124045040.559317-5-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBn2i6gFwVruBfwAA--.253S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fCF15Zr1kuw1UCF18AFb_yoW8XrWkpF
	yDGr4DKFWYqFW3Kws7tr1jvFy3C347WFZrt39I93W2qwnxWw4rKF1vg3yxZr1UKryrGF4f
	Ja97GF1Uuan7Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2
	xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07j4UDJUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFst2AAosr

The AW86937 reports CHIPID 0x9370 and is register compatible with the
AW86938 as far as the boost setup is concerned, so it joins that branch of
the haptic initialisation.  Detection stays by CHIPID, so the existing
AW86927 compatible keeps working as fallback.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Tested-by: Joonhoe Kim <26rote@gmail.com> # Lenovo Y700 Gen 5 (TB323FU)
---
 drivers/input/misc/aw86927.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index b9b7315a5d..699c92a1ce 100644
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

