Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1392749CF;
	Tue,  7 Apr 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527833; cv=none; b=I5bQuoWtdWrkohrSV2+7H8Z4uAPrc4irxD3fi0l9hse+kFR4NsSYer900EF7SlNQlJs7htl91XYtN/bMCh2wYargnQnB5aIp7R7ZZR957TbzDB7c11Y+wgpl2T/2alx9skm8eRhdmAzS//Bl2eZiuQrWB+FIZg3DV3uqBcc3RnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527833; c=relaxed/simple;
	bh=WRM8/ZSaDFdrVOgwEAv+ENjJOaaNontPOpbZfc3JGpY=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=LMDcHw/dPtzJA3hphnCEzhs0CFIxCMkFKK9+wmH6AHLKZTha0nSipN9VNN2PdSs7e9RcjYzD/qX1Cl9AxmM1A1pNwp3bvl3fcKHvLtQ3LDvnT9cUK6t+D3FihJSZtQRrXg258hvbki3OUbwjx5HUyH/ctoQvkC0rKrzdZDBCWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-gf2k-v2.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowACnTGiRZ9RptLR2DA--.30307S2;
	Tue, 07 Apr 2026 10:10:25 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 09:56:52 +0800
Message-ID: <20260407120001.1-gf2k-v2-pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260323074541.93413-1-pengpeng@iscas.ac.cn>
References: <20260323074541.93413-1-pengpeng@iscas.ac.cn>
Subject: [PATCH v2] Input: gf2k: skip invalid hat lookup values
X-CM-TRANSID:qwCowACnTGiRZ9RptLR2DA--.30307S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1xCrWUur17JF48Gr45KFg_yoW8Gr1UpF
	W5XFyq9F98tF1jy3Wxt3WUury5Ka4Dtay3CFyUC3sIv3Z8tFyfXr90qFyjgFs7Ww18tFWD
	tF4DtFs8CF18C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiID7UUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

gf2k_read() decodes the hat position from a 4-bit field and uses it
directly to index gf2k_hat_to_axis[]. The lookup table only has nine
entries, so malformed packets can read past the end of the fixed table.

Skip hat reporting when the decoded value falls outside the lookup
table instead of forcing it to the neutral position. This keeps the
fix local and avoids reporting a made-up axis state for malformed
packets.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- skip reporting invalid hat values instead of clamping them to the
  neutral entry

drivers/input/joystick/gf2k.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
index 5a1cdce0bc48..1d843115d674 100644
--- a/drivers/input/joystick/gf2k.c
+++ b/drivers/input/joystick/gf2k.c
@@ -165,8 +165,10 @@ static void gf2k_read(struct gf2k *gf2k, unsigned char *data)
 
 	t = GB(40,4,0);
 
-	for (i = 0; i < gf2k_hats[gf2k->id]; i++)
-		input_report_abs(dev, ABS_HAT0X + i, gf2k_hat_to_axis[t][i]);
+	if (t < ARRAY_SIZE(gf2k_hat_to_axis))
+		for (i = 0; i < gf2k_hats[gf2k->id]; i++)
+			input_report_abs(dev, ABS_HAT0X + i,
+					 gf2k_hat_to_axis[t][i]);
 
 	t = GB(44,2,0) | GB(32,8,2) | GB(78,2,10);
 
-- 
2.50.1 (Apple Git-155)

