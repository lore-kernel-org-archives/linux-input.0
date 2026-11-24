Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495854;
	b=zjHpdrEwh0htTtHZaWuZJalSr2vTVxkhCxfymxFuor1GUv2ndTO7zw0XHqttHjuOng6X
	 Oclr6e4WXQpwQE5oHXMVjMfRC0Fn4XzIPuUkWY/a16S3PZR9QlTvkKLIwU1OAUavK4cLD
	 D7AA29bWyLYm1EDkXBGEJJpGi3Uh/3k1JhLxpnNTEKClG5O8pFAhwOEdq87AkTziz5jDR
	 DVRJhR0inNJQz1OqtoRXLLs6cr+MkXRcaFVlu5Tt9lv094v9IUVow2rcOjjJnDHIJh1j8
	 L13zaHPjBhewSJP/oz4oebbdGYu6iLjXTP8nPVNGDd+90CMXg2kz+IvF1Vx/tz5TGdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495854;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=DclO4PPjmHtnFXntHY4BqycynmIJZRy6m9U1ktY1Pws=;
	b=zNMi0n0GJAQiKs16nLBXIuVFUGq//1pCKnWv/J4V5uMkEcWRbkHYCvlH2oOD5oGi+9tB
	 5Fdu/NbSuMLfrvvCE9tjRf1pk74v+qpkKfBPrg/p3Q5bRRTN/tBQRv1lFKTvV9BcYh73+
	 OR1fi9XI2bPeN4QxXt/eqrvO56Gzoi/od2sCvvCLCiA2QxjOtGU8MPyrD9Rwo2BsrHoZe
	 V67UKnBUxbyUTGxoAnKYzJ1Zb2ohENe2yyksA8OOwxnvaIJApmPVaLY3jICRr1qjjpYHp
	 5jGsK1SXLk17tCyrVCCt7bffr5GYRufWp3z+HoJMT79Q2fJ0I5H0wAbBq38nKZga41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=C3RyTgts;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB8606A699;
	Tue, 24 Nov 2026 04:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9EB8606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=C3RyTgts
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=DclO4PPjmHtnFXntHY4BqycynmIJZRy6m9
	U1ktY1Pws=; b=C3RyTgts4WLw0BqBmUAtn8njS8KMDAyTVXfNAoE186OGMpKqHl
	jWMW05slbI8iO4fEzTs7RMTVzAF4hQGMgOuEyLk6FeMjvt+2ObsYAM/azb6agmuR
	ZYF6v35gBTgXg63HyG5FFBIg9/Iphnuzp074i1bTCDanQs0L9PEFUPIGE=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.185.179])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn2i6gFwVruBfwAA--.253S7;
	Tue, 24 Nov 2026 12:50:50 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dmitry.torokhov@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joonhoe Kim <26rote@gmail.com>
Subject: [PATCH v4 5/6] Input: aw86927 - handle the AW8693X play and boost register layout
Date: Tue, 24 Nov 2026 12:50:39 +0800
Message-ID: <20261124045040.559317-6-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBn2i6gFwVruBfwAA--.253S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW5Cr18Cr15JF4rXryfCrg_yoW7JFyrpF
	y5CFyUtrW2grWxK3WvyF1vvF1furnIgF42qr9Fg343J3W7Xw48KFn7tw40yryqyFyUKw15
	Ja1vvFyq9rsrWFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2
	xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07bFWrZUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREBB2sElFst2AApsq

AW86937 and AW86938 keep the same register map as the AW86927 but move
two bits and invert the stop handshake:

  - auto boost lives in bit 2 of PLAYCFG3 instead of bit 4, and the boost
    mode in PLAYCFG1 is a two-bit field at bit 5 instead of bit 7;
  - the VBAT mode bit taps the battery voltage instead of the software
    tracked value;
  - stopping is a two-step sequence: select PLAY_MODE_STOP in PLAYCFG3 and
    then issue GO in PLAYCFG4, as the dedicated STOP bit does not exist
    for these parts.  A standby timeout after that is a real failure, so
    return it instead of forcing the state machine.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Tested-by: Joonhoe Kim <26rote@gmail.com> # Lenovo Y700 Gen 5 (TB323FU)
---
 drivers/input/misc/aw86927.c | 65 +++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 699c92a1ce..1dbcba7988 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -49,6 +49,14 @@
 #define AW86938_PLAYCFG1_BST_VOUT_VREFSET_MASK	GENMASK(4, 0)
 #define AW86938_PLAYCFG1_BST_7000MV		0x09
 
+/*
+ * The AW8693x parts move auto-boost to bit 2 of PLAYCFG3 and stop playback
+ * by selecting the dedicated stop mode and then issuing a GO, unlike the
+ * AW86927 which has an explicit STOP bit in PLAYCFG4.
+ */
+#define AW8693X_PLAYCFG3_AUTO_BST_MASK		BIT(2)
+#define AW8693X_PLAYCFG3_PLAY_MODE_STOP		3
+
 #define AW86927_PLAYCFG2_REG			0x07
 
 #define AW86927_PLAYCFG3_REG			0x08
@@ -290,9 +298,14 @@ static int aw86927_play_mode(struct aw86927_data *haptics, u8 play_mode)
 
 		err = regmap_update_bits(haptics->regmap,
 					 AW86927_PLAYCFG1_REG,
-					 AW86927_PLAYCFG1_BST_MODE_MASK,
+					 haptics->model == AW86927 ?
+					 AW86927_PLAYCFG1_BST_MODE_MASK :
+					 AW86938_PLAYCFG1_BST_MODE_MASK,
+					 haptics->model == AW86927 ?
 					 FIELD_PREP(AW86927_PLAYCFG1_BST_MODE_MASK,
-						    AW86927_PLAYCFG1_BST_MODE_BYPASS));
+						    AW86927_PLAYCFG1_BST_MODE_BYPASS) :
+					 FIELD_PREP(AW86938_PLAYCFG1_BST_MODE_MASK,
+						    AW86938_PLAYCFG1_BST_MODE_BYPASS));
 		if (err)
 			return err;
 
@@ -300,7 +313,8 @@ static int aw86927_play_mode(struct aw86927_data *haptics, u8 play_mode)
 					 AW86927_VBATCTRL_REG,
 					 AW86927_VBATCTRL_VBAT_MODE_MASK,
 					 FIELD_PREP(AW86927_VBATCTRL_VBAT_MODE_MASK,
-						    AW86927_VBATCTRL_VBAT_MODE_SW));
+						    haptics->model == AW86927 ?
+						    AW86927_VBATCTRL_VBAT_MODE_SW : 1));
 		if (err)
 			return err;
 
@@ -312,23 +326,38 @@ static int aw86927_play_mode(struct aw86927_data *haptics, u8 play_mode)
 
 static int aw86927_stop(struct aw86927_data *haptics)
 {
+	bool aw8693x = haptics->model != AW86927;
 	int err;
 
-	err = regmap_write(haptics->regmap, AW86927_PLAYCFG4_REG, AW86927_PLAYCFG4_STOP);
+	if (aw8693x) {
+		err = regmap_update_bits(haptics->regmap, AW86927_PLAYCFG3_REG,
+					 AW86927_PLAYCFG3_PLAY_MODE_MASK,
+					 AW8693X_PLAYCFG3_PLAY_MODE_STOP);
+		if (err)
+			return err;
+	}
+
+	err = regmap_write(haptics->regmap, AW86927_PLAYCFG4_REG,
+			   aw8693x ? AW86927_PLAYCFG4_GO : AW86927_PLAYCFG4_STOP);
 	if (err) {
 		dev_err(haptics->dev, "Failed to stop playback: %d\n", err);
 		return err;
 	}
 
 	err = aw86927_wait_enter_standby(haptics);
-	if (err) {
-		dev_err(haptics->dev, "Failed to enter standby, trying to force it\n");
-		err = aw86927_play_mode(haptics, AW86927_STANDBY_MODE);
-		if (err)
-			return err;
-	}
+	if (!err)
+		return 0;
 
-	return 0;
+	/*
+	 * The AW8693x reliably reaches standby through the stop mode above, so a
+	 * timeout there is fatal; the AW86927 sometimes needs the nudge.
+	 */
+	if (aw8693x)
+		return err;
+
+	dev_err(haptics->dev, "Failed to enter standby, trying to force it\n");
+
+	return aw86927_play_mode(haptics, AW86927_STANDBY_MODE);
 }
 
 static int aw86927_haptics_play(struct input_dev *dev, void *data, struct ff_effect *effect)
@@ -364,9 +393,13 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
 		return err;
 
 	err = regmap_update_bits(haptics->regmap, AW86927_PLAYCFG3_REG,
-				 AW86927_PLAYCFG3_AUTO_BST_MASK,
+				 haptics->model == AW86927 ?
+				 AW86927_PLAYCFG3_AUTO_BST_MASK :
+				 AW8693X_PLAYCFG3_AUTO_BST_MASK,
+				 haptics->model == AW86927 ?
 				 FIELD_PREP(AW86927_PLAYCFG3_AUTO_BST_MASK,
-					    AW86927_PLAYCFG3_AUTO_BST_ENABLE));
+					    AW86927_PLAYCFG3_AUTO_BST_ENABLE) :
+				 AW8693X_PLAYCFG3_AUTO_BST_MASK);
 	if (err)
 		return err;
 
@@ -604,9 +637,9 @@ static int aw86927_haptic_init(struct aw86927_data *haptics)
 
 	err = regmap_update_bits(haptics->regmap,
 				 AW86927_PLAYCFG3_REG,
-				 AW86927_PLAYCFG3_AUTO_BST_MASK,
-				 FIELD_PREP(AW86927_PLAYCFG3_AUTO_BST_MASK,
-					    AW86927_PLAYCFG3_AUTO_BST_DISABLE));
+				 haptics->model == AW86927 ?
+				 AW86927_PLAYCFG3_AUTO_BST_MASK :
+				 AW8693X_PLAYCFG3_AUTO_BST_MASK, 0);
 	if (err)
 		return err;
 
-- 
2.53.0

