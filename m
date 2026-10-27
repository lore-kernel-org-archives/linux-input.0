Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107783;
	b=1GXgKW4tF4oVVE9/qqGdatr8Sb0IKdCkIy+5uRp2L1zEUYu4LzjoeRNHOmmbpMYpRPl0
	 Z6SajVfPNHHbpOIQPdy78q52rxQpO4baNkKNJamvxcYwgLNOviKtHaHWQP1uoIBZHNbmA
	 wj54ZqpOhYxrOqwW+17pRX4xUbwGjapKYAj5dnIE8GdDR2GnV9FXviRBLpptBeLgJqLB/
	 7whIpibybic4GkC6wYShradKQGd1W7NVMzDiu0YA7xqZ5kruFUaQcvQa55eqVQQTrTMly
	 7VEgjQq4WxMRBjt4mwkP0QFXhZeHr+C5/jREPQoY81ERYfqFS4BMeMT4rf2xPRKcZ8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107783;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=NHCBL/meR3MXjPPg5+OgvFp1eZQNF+dGBfUAsQhoxRE=;
	b=QPXlokKC6NQTh1IN/jKP8nRGsXOZg/L6izGZslPhszEMKTxxZk0/9HXMaeH2Iusp4PaB
	 qrp2i8THXA4h3D98XOWUJISDglhzxRi0CyEO4Pm+Q6To9lLcaN5hvy3loJP8XJl4aR+Gs
	 EZGbszYXU/2dvdZgBwtMYqVJYvgqHAtuk+t3rK8NkAam+a1c9O7qhbyFqsroMnz0b7U10
	 wPBFQrFgShOhBgoccgHW6z5mi0Y0qm5OpNC3gcEFOxxSW3FxrfBbK9CktkBzRWgMriu0V
	 iTm9VqGtnphlYMs6BGef+zkFTnjaqb0CGUf+J3b9gKgBsrt1HQBRKtQvTfZRqEr44yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=pvswCEJE;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641EC606A338;
	Tue, 27 Oct 2026 13:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 641EC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=pvswCEJE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=NHCBL/meR3MXjPPg5+OgvFp1eZQNF+dGBf
	UAsQhoxRE=; b=pvswCEJEsRYL5x1mi3cuZfYDvb8g7yGClVEC+hsWEDkuLbFzqg
	KON6T/JgXDxJ3OOcFU9WZ1YkGIsYDtpgzRuTUZRtX8UuVjRZ11C0pXp0zbvYyV6d
	T+4pOhrxy/x2WiN/i30sM3aTRI4hhCHt5NrVVaNVwoQuLqQMA7AStXles=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.11])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHhDg5p+BqGGxRAA--.1917S5;
	Tue, 27 Oct 2026 21:29:31 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: aw86927 - add support for Awinic AW86937
Date: Tue, 27 Oct 2026 21:29:27 +0800
Message-ID: <20261027132929.242158-4-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgAHhDg5p+BqGGxRAA--.1917S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fCF15Zr1kur15KrykKrg_yoW8GFWxpF
	yDGr4DtFWYqFWUKws7tr1jvFy3C342gFZrKrZI93W2qwnxGw4rKFnYg3yfZFyUKrW5GF4f
	Ja97JF15uan7Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcD73DUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARENB2rfqlZqOAAsst

The AW86937 reports CHIPID 0x9370 and is register compatible with the
AW86938 as far as the boost setup is concerned, so it joins that branch of
the haptic initialisation.  Detection stays by CHIPID, so the existing
AW86927 compatible keeps working as fallback.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 813f3591b..42eb531c7 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -147,6 +147,7 @@
 #define AW86927_CHIPIDH_REG			0x57
 #define AW86927_CHIPIDL_REG			0x58
 #define AW86927_CHIPID				0x9270
+#define AW86937_CHIPID				0x9370
 #define AW86938_CHIPID				0x9380
 
 #define AW86927_TMCFG_REG			0x5b
@@ -183,6 +184,7 @@ enum aw86927_work_mode {
 
 enum aw86927_model {
 	AW86927,
+	AW86937,
 	AW86938,
 };
 
@@ -589,6 +591,7 @@ static int aw86927_haptic_init(struct aw86927_data *haptics)
 		if (err)
 			return err;
 		break;
+	case AW86937:
 	case AW86938:
 		err = regmap_update_bits(haptics->regmap,
 					 AW86938_PLAYCFG1_REG,
@@ -751,6 +754,9 @@ static int aw86927_detect(struct aw86927_data *haptics)
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

