Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892877;
	b=t7yJ0PKdZGXs7Uq7TGnVhXkS5yUxEh/goLfmhmN0Syus3crkAJRTbd0uV9opWLwwmh/R
	 RBiv+b2if5uuha3BTHzjfY0QytIFa52sFxTh0++CGaz9lIcRQdpEkJnduY/fOjuKA7U7/
	 xKLXXN9/hpFj8JxKU3/QHd2fJ0Gi9JFlTT0TGWjlAUGHKejzsclpxSVoasWIO1sS7H0EF
	 BI/1khBJDWmiACLQEmOLIX1cHEq8PtgJBjgbLZ3xdoVDH33hAKBOiCEea29NCE2HyE6u/
	 /cKsOkqlho74QVjqJagGSkwaKThyHiU3CdcXdmuiYZKo539jD8p1QK1uwblVV6MOWhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892877;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=6zRJ+UUYcI1M1J+0zvWC1eyTD4Wl/xFBBOIvtWTygCg=;
	b=VBs036KTMHU1pvutNww9ENe8f0cR8iighcHZHaZ/YL4KgoZ3+T8RcYMfSTCDA88fheZG
	 h6Zycgk5r2qa/W3rF8Cv5EUke7BGETNmmOo5rqiBOKaMgGw+XnURVd98uYZjRmDqRB3C4
	 XOITuP5ltVeg/yd3S1BzlYFEoISPHnp3COINttlUl6eaNsiCvtaMIyJrRU51wM69qrCJj
	 UpHAsyGa6wHviR9Z5fImrzrqvZf0oZIpNSbz+D+FEfqP2WDAgRVRyI7adfsr9OAbuG/wp
	 tst1qlBRHwHi9yIgxYxfEUMWRPKnvYeLPV2yDh0a84IiQmYb23nJDuFg7gr3Dm6hWFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=li4+X7aB;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5E606A331;
	Tue, 17 Nov 2026 05:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D5E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=li4+X7aB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=6zRJ+UUYcI1M1J+0zvWC1eyTD4Wl/xFBBO
	IvtWTygCg=; b=li4+X7aBb/zg9MhrugbBA3j1lQ/+q7HuSJfEV36lpi1ThscdL5
	4JYGvLGKLYq+d3svFzbHSrBkl7rPpJLfXM4kUgWEAoMNRH7CPS+4QfU7cRE3khu1
	u3Tcl2Yz5PNQ/fp6HBkUwL//smb1X+GiUC8CC45B/d+H/OM+NLwMS1dHs=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHxTlI5Ptqc0LLAA--.214S6;
	Tue, 17 Nov 2026 13:21:14 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 4/6] Input: aw86927 - add support for Awinic AW86937
Date: Tue, 17 Nov 2026 13:21:10 +0800
Message-ID: <20261117052112.32527-5-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHxTlI5Ptqc0LLAA--.214S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fCF15Zr1kur15Kw1Dtrb_yoW8GFW8pF
	yDGr4DtFWYqFW7Kws7tr1jvFy3C347WFZrKrZI93W2qwnxGa1rKFnYg3yfZFyUKrW5GF4f
	Ja97JF15uanrJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCY02
	Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8LL05UUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwAUsr

The AW86937 reports CHIPID 0x9370 and is register compatible with the
AW86938 as far as the boost setup is concerned, so it joins that branch of
the haptic initialisation.  Detection stays by CHIPID, so the existing
AW86927 compatible keeps working as fallback.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/input/misc/aw86927.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
index 9dda96c..690726a 100644
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

