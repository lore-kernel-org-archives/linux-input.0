Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892877;
	b=AdA78Mj5Yulx1yqNZxhMZl37DaAz43kVjoTnwI+X44nL2ZOPgbQn5tPLsXMwRuIc26tJ
	 IpsH+GEA7hAXM5+CE+4aKylA7Qyqo4aNzL+F8HBETKLx9Z0ORJVcy1cf7y4QhdzC0L/2S
	 VHlR3Nw8NYu7Qx/R+1IdFPFOLN6pHx8O35wn2fkc3FAlOCjCFmf46Aya7RQFapMmsLCqJ
	 DB8RB7tv2zkq3wIWpSlP0juIY4aHUaS9pY6SVwRXKkhyPeqxvhIgGUajFgcIB4YRG0t18
	 0lj/AEGUFJ8QYx62hQi50jqNFIYnuj/+CaARQxJPy+z2P9RAa4sHWMVOFMebf75/8OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892877;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=CN8qCHNp6vSfuktUN0aiSHKTfGdFK3VGfTc23pETWn8=;
	b=d2whqJ25o5+QRfoDTxdHCXxZBx3EoYcs6U/z5a2ZQruLiyYyUghK9/BAdSL+nzTf4b2x
	 Pz69jbHvgdhxBzoZ0OHZv8Ivp7tCOHUHtJ9DMfs9aYEjVGAg5a9rgfKByOYKmQnEoJG/V
	 DKPVLKMByyuMAMwDXG/MoJemed/dD3GR7t7MP/bYJw7LtDCQwWf+McD8oKGHBJQBhK2e5
	 f4aEbMe5OPcCQ2p2h/sC3rccqWO7nInJcOAb3G4U3nqP4lZ/vl+svrLoJYlBh0ZXGRBdv
	 G1W2T0UVLH6fo14jaq/ry0PI/eZZBdnTQpJyxgyotbg0ZGyXvv60fAEFRdu4/UQXuCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=NMFtL55+;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E94606A333;
	Tue, 17 Nov 2026 05:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E94606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=NMFtL55+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=CN8qCHNp6vSfuktUN0aiSHKTfGdFK3VGfT
	c23pETWn8=; b=NMFtL55+e5EvQnPNcShBvEbejNuy5AGFxBOZJYv4igDexGxdel
	PkjN3IaM6acXiWhG4GoDYPeLB2uiCO8UyXVtpqjj4J5GlfAZoA2YvTIjQCU21xv2
	h6bXp3ctWO0XaJIh+wVRhSow6NHBAmr46ICn+hbIPp66DJB7LZC/iU+o4=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTlI5Ptqc0LLAA--.214S7;
	Tue, 17 Nov 2026 13:21:14 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 5/6] Input: aw86927 - handle the AW8693X play and boost register layout
Date: Tue, 17 Nov 2026 13:21:11 +0800
Message-ID: <20261117052112.32527-6-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHxTlI5Ptqc0LLAA--.214S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW5Cr18Cr15JF4rXryfCrg_yoWrKw4xpF
	15CFyUtrW2grWxKw1vyF1vvF1furnIgF42qr9Fg343J3W7Xw48KFn7tw40yFyjyFyUKw15
	Ja1vvFyq9rsrWFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2
	xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
	WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07bO5lnUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwAVsq

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
---
 drivers/input/misc/aw86927.c | 65 +++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 690726a..aa69994 100644
--- a/drivers/input/misc/aw86927.c
+++ b/drivers/input/misc/aw86927.c
@@ -50,6 +50,14 @@
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
@@ -291,9 +299,14 @@ static int aw86927_play_mode(struct aw86927_data *haptics, u8 play_mode)
 
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
 
@@ -301,7 +314,8 @@ static int aw86927_play_mode(struct aw86927_data *haptics, u8 play_mode)
 					 AW86927_VBATCTRL_REG,
 					 AW86927_VBATCTRL_VBAT_MODE_MASK,
 					 FIELD_PREP(AW86927_VBATCTRL_VBAT_MODE_MASK,
-						    AW86927_VBATCTRL_VBAT_MODE_SW));
+						    haptics->model == AW86927 ?
+						    AW86927_VBATCTRL_VBAT_MODE_SW : 1));
 		if (err)
 			return err;
 
@@ -313,23 +327,38 @@ static int aw86927_play_mode(struct aw86927_data *haptics, u8 play_mode)
 
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
@@ -365,9 +394,13 @@ static int aw86927_play_sine(struct aw86927_data *haptics)
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
 
@@ -605,9 +638,9 @@ static int aw86927_haptic_init(struct aw86927_data *haptics)
 
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

