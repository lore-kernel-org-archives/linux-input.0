Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793771471;
	b=SJnoxdrYmtqfx3rbiNdAulHNEe2tdHxYAFNBGtR5zJK+b9ErV51C/n5AhvDFoZo8td74
	 wjaabDu05g100YEiz6/oNgnlglZJJqy3sDPGlwksS10QNEMdzZt22g5aVCuKYaFU+iQjs
	 VReZPGdBD6zvdkTlrquYUHgEUKvTXwq/0QnAl5pTFUDlogdKT67ttoViNBvvCgBypPRx6
	 OCYidZKZoYZUH9HPFLToQ7d9ig3/F/cIk9irnlvmxW7jgRpKJlfhfWCJzDSX5CQzDLM6s
	 aI656ip84zUK8O2ABcXbs0GfTG8kDQ+MDuxfOrHulEn5cIgYtmNj6FS7JAy2JKU0m0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793771471;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S+mM/uvHchJpy5RILeu/6Qy3f5QlQZs4wkdpY11SZQY=;
	b=Pq2+QD+3d5NjaLRHAdhGCJWAKYUYjK6ANwDtFutHI2O6g4RTk5n3BrELqTqyj164/xhH
	 egAQMxPpIWJH2jJxhggEV8b+fEpD1aZJ4GTKAgATpRlv53K3niNnYvBL+QykmK4aC+RUr
	 6Y09OqPx+LIiD7zkBwnzI7qlAPQzp01AVWBPJazIp/5IJXdpPksYhl0/aXGQDq7VJXTyw
	 HKMsuWBR73bLhewI51GLOByVCl0Peo6enxRBgjkF52sXlpLgDqlTKSuR1tbtlcU8nfVRE
	 rXDDpMsRNbCPZjV/nrjd24lo7ew+24FYipsRQzIL95wGqZ/FCf0neXxLgQfcgrDP0pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=j0ffVq8e;
	arc=none smtp.remote-ip=115.124.28.221
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C6606A31B;
	Wed,  4 Nov 2026 05:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=j0ffVq8e
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793771460; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=S+mM/uvHchJpy5RILeu/6Qy3f5QlQZs4wkdpY11SZQY=;
	b=j0ffVq8eDK4Bi30pbSQYN+FloJ1zt3Tcv48vpqNQ4wVr0MVqViQZaoO0ot9JqYE+x22CcRUS4UzHvKqFHO4vubwjxaZbqTlVmcvqYcZErrjmVv4QRUQu9fpZW57dWAwHXcCTvyp6mmgv70s3O+/wJlTngsfIi44GRAIEL7W9BjE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1031426|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0410637-0.00147259-0.957464;FP=4426455823654488208|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jwIiyw6_1793771459;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jwIiyw6_1793771459 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 13:50:59 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com
Subject: [PATCH v3] Input: joydev - avoid signed overflow in the broken-axis correction
Date: Wed,  4 Nov 2026 13:50:58 +0800
Message-ID: <20261104055058.854710-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8063a24bb9f75bb9096c947d8ffa7123@gmail.com>
References: <8063a24bb9f75bb9096c947d8ffa7123@gmail.com>
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

The JS_CORR_BROKEN correction multiplies two 32-bit values taken
from user space via JSIOCSCORR before shifting and clamping:

	value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
			((corr->coef[2] * (value - corr->coef[0])) >> 14);

Nothing bounds the coefficients, so with large enough values the
products wrap around and the correction returns bogus axis values
for the rest of the session.

Compute the correction in 64 bits and clamp once, and flatten the
nested ternary so the dead zone returns 0 directly.

Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v3: rework per review - pre-convert value to s64 and use if/else
    instead of the nested ternary with explicit casts, return 0
    directly from the dead zone, and clamp once instead of passing
    the value through the trailing clamp a second time; drop Fixes
    and the stable backport request since the kernel is built with
    -fno-strict-overflow and this only affects synthetic
    coefficients passed via JSIOCSCORR.

 drivers/input/joydev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 32459fd..fbc6e77 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -67,22 +67,27 @@ struct joydev_client {
 
 static int joydev_correct(int value, struct js_corr *corr)
 {
+	s64 v64;
+
 	switch (corr->type) {
 
 	case JS_CORR_NONE:
-		break;
+		return clamp(value, -32767, 32767);
 
 	case JS_CORR_BROKEN:
-		value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
-			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
-			((corr->coef[2] * (value - corr->coef[0])) >> 14);
-		break;
+		v64 = value;
+		if (value < corr->coef[0])
+			v64 = (v64 - corr->coef[0]) * corr->coef[2];
+		else if (value > corr->coef[0] && value > corr->coef[1])
+			v64 = (v64 - corr->coef[1]) * corr->coef[3];
+		else
+			return 0;
+
+		return clamp_val(v64 >> 14, -32767, 32767);
 
 	default:
 		return 0;
 	}
-
-	return clamp(value, -32767, 32767);
 }
 
 static void joydev_pass_event(struct joydev_client *client,
-- 
2.43.0

