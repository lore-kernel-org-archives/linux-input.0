Received: from out28-202.mail.aliyun.com (out28-202.mail.aliyun.com [115.124.28.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C92F3C3C
	for <linux-input@vger.kernel.org>; Fri,  4 Jul 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619423; cv=none; b=adDDhoiU6x5cyRkkkaRu/aoH2OcCR2pmTh7JvVX3ZC2XjiVyN2gqdtJMiVhPF6AmVQiJvw3T5pyna+yIiOUh5uXNviAFrfp9PT0uipV4R0hoYVAwPbNDP8c9nIs5PVOY2RhAlUdkOmXIFJptp32uh/64VXo0FKpdqa4P6xJ7tlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619423; c=relaxed/simple;
	bh=rRRcx4jCWMyBezwZNGGBqgoXT4A4/KPKZbpaax7Z5tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cU5jlpw5gnVPtAUrJkMVGmyShvk5oicXi90WRBfzgCt9/F9SrfdVudczHh8idL0ieZyI/1WuR/dID+azCtZGiAxQb3n+pRkFVVToeI/7xMjd9BZWg27Mo1NO8TVLrP6QVK0vhux1zlcf72ik4ijamTYzLkd1/ImvH9HFKd3Bsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=megoinno.com; spf=none smtp.mailfrom=megoinno.com; arc=none smtp.client-ip=115.124.28.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=megoinno.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=megoinno.com
Received: from debian.lan(mailfrom:wangpeng@megoinno.com fp:SMTPD_---.de1hsOt_1751617564 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 16:26:04 +0800
From: Wang Peng <wangpeng@megoinno.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Wang Peng <wangpeng@megoinno.com>
Subject: [PATCH 1/1] Input: rotary-encoder - fix direction for quarter-period
Date: Fri,  4 Jul 2025 16:25:51 +0800
Message-ID: <20250704082551.143107-1-wangpeng@megoinno.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The direction detection logic in quarter-period mode was inconsistent
 with half-period and full-period modes when using GRAY encoding.

According to the GRAY encoding state sequence for positive(clockwise)
rotation - 3->2->1->0 - in function get_state, the quarter-period mode
current interprets this as negative direction, while counter-clockwise
becomes positive. This leads to revesed interpretation compared to the
other 2 modes.

This patch corrects the quarter-period direction logic, maintaining
consistency across all encoding modes.

Tested on encoder with 2000 PPR, confirmed correct direction detection
after this patch.

Signed-off-by: Wang Peng <wangpeng@megoinno.com>
---
 drivers/input/misc/rotary_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index f706e1997..9be84380b 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -163,10 +163,10 @@ static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *dev_id)
 	state = rotary_encoder_get_state(encoder);
 
 	if ((encoder->last_stable + 1) % 4 == state) {
-		encoder->dir = 1;
+		encoder->dir = -1;
 		rotary_encoder_report_event(encoder);
 	} else if (encoder->last_stable == (state + 1) % 4) {
-		encoder->dir = -1;
+		encoder->dir = 1;
 		rotary_encoder_report_event(encoder);
 	}
 
-- 
2.50.0

