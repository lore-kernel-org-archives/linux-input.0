Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D533B634E;
	Fri, 10 Jul 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679016; cv=none; b=bMVSbeIotsV0/F4t6Qzu7xYxXF7fLYq2En/kPmHbS7H4RGkB5fGElpdlyMClRvTKWEI90Xsbe5dv1gCkyWj6qAE6fgNpYDdaOvOLQg6QeVXV8iRDF3oj1/CpP4gnFBqasrPSHQL7FxTFvgehZZpSIR+EkX0GJv/PPDxF8Dzo19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679016; c=relaxed/simple;
	bh=eaqjZNWU1dTFXXg2CTOsiCkM24TMyv7nKU02rh6z1ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oDZRrFvL+EFaMBTbroVLjczGiZZK1stNZ+0n0gqdpdnxnNnVlZ9lTQnTzfqX0FX0RRx2nm6UQX9KyK4sBYaZNzfRTTYwTYJg3LOnO8ymqkdlDuhhjRC/QzlAsCUFw6V40wgWa5nPT6ljK/mNnyMxRAd6RBMYv0QkOR4bBi3Fc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5f17062a7c4911f1aa26b74ffac11d73-20260710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:843861be-8154-4c3c-83b7-ed14e430a480,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:05a4f6e93f591b58ff37e3cd10f56cf9,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5f17062a7c4911f1aa26b74ffac11d73-20260710
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1941023367; Fri, 10 Jul 2026 18:23:19 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Anssi Hannula <anssi.hannula@bitwise.fi>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] HID: tmff: Use 64-bit arithmetic for force feedback scaling
Date: Fri, 10 Jul 2026 18:23:14 +0800
Message-Id: <20260710102314.190094-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logical minimum and maximum values come from the HID report
descriptor and cover the full signed 32-bit range.  Subtracting them in
an int can overflow before the force feedback value is scaled.  The
subsequent multiplication can overflow as well, producing an incorrect
value despite the final range checks.

Use 64-bit intermediates for both scaling helpers, as done by commit
48d1677779ad ("HID: pidff: Fix integer overflow in pidff_rescale") for
the same arithmetic in the PID driver.  This keeps the arithmetic
defined for the complete descriptor range before the result is clamped.

Fixes: dc76c912145f ("Input: use new FF interface in the HID force feedback drivers")
Fixes: b27c9590ca0f ("HID: add support for Thrustmaster FGT Force Feedback wheel")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/hid/hid-tmff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index 423f395d01ac..319e7b670384 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -17,6 +17,7 @@
 
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
@@ -47,9 +48,9 @@ struct tmff_device {
 /* Changes values from 0 to 0xffff into values from minimum to maximum */
 static inline int tmff_scale_u16(unsigned int in, int minimum, int maximum)
 {
-	int ret;
+	s64 ret;
 
-	ret = (in * (maximum - minimum) / 0xffff) + minimum;
+	ret = div_s64((s64)in * ((s64)maximum - minimum), 0xffff) + minimum;
 	if (ret < minimum)
 		return minimum;
 	if (ret > maximum)
@@ -60,9 +61,9 @@ static inline int tmff_scale_u16(unsigned int in, int minimum, int maximum)
 /* Changes values from -0x80 to 0x7f into values from minimum to maximum */
 static inline int tmff_scale_s8(int in, int minimum, int maximum)
 {
-	int ret;
+	s64 ret;
 
-	ret = (((in + 0x80) * (maximum - minimum)) / 0xff) + minimum;
+	ret = div_s64((s64)(in + 0x80) * ((s64)maximum - minimum), 0xff) + minimum;
 	if (ret < minimum)
 		return minimum;
 	if (ret > maximum)
-- 
2.25.1

