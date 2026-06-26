Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A13A6B67
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451100; cv=none; b=YrxS5eF1hGuwNb23yIZGXpOwLmXpDtuskUHgTd8iuhZfmeeR8Uo3xcXjvVozJFXoFmRqECwH/LfDo6RnbUoq7WkPS68QQOw8uo/DTQkRoU0t9C9Aw27S7S5yl45k5WKHXMCpisoKQJdJ8nixfJ8+Zf8h5nLnaEfblxWg1ui+P2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451100; c=relaxed/simple;
	bh=S7VgKpfTgBnjIiGJp9xV7qsZ8eY/ftmXoOJ79RnATH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVfCGls+p11NXeTC1Mvkg09mSruTNPfPrOEzibrfMSLXT+001VS+joissSdzN74yPRAw7B7cuUwhY3kRHGb/GV+FwqPQA1o/ol/7VsBXGgdcebLE7JhdgzjI2cj43dxjM7i3dtI5Q0zuiFthI269FixWN9ZhL9QtiFSbO44PQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzlih0Yf; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzlih0Yf"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30c591fb1cbso890302eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451099; x=1783055899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvogOYoQA8k/YjrXfsKH1k1eYaj9ZaJ63lBakDvIi20=;
        b=Wzlih0YfkY4ks6ybRL5TjcVX3UcJNt1EwS2sez0d++ncFEX87FezpJJuyOhW49xZn7
         7/QahloI2hLel9rsR+/faD26QVTKfwadKarab53LbTBkdOhu2jPWDBvvaRn4Qc/qEntG
         FEHI8gvP+EQJJia1VtgtE2DZ8f/lK3x6Gxkh0C25myeZYvwhTmCMhgg1HlRZnAwlyxlr
         nGYR5DOlClTbs2/FQC0nA0gDKvU9aDvku0CnJbkz5oizDm3o0DIox6p5cVzsknlkCD74
         HKYCgMlNhb79Qm69tarJET4CHSOD2v/Nj5mAJCOfjjb9St02KNwDV889Ev1KCFe7ul/M
         ElkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451099; x=1783055899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvogOYoQA8k/YjrXfsKH1k1eYaj9ZaJ63lBakDvIi20=;
        b=qQJHRwB+OYGyTbd8Wxt93i1OPHE1zQnZ9cMr8+s/kL63F7W7z0KblPrMpwCohpZ8fZ
         vJJB1wjxfAs6KLG5Tqsbm11GZRkWsgEDqPY0x3A/AIB5FWMCDJABYAFKKAK9XjDL895p
         vQYuaWtrb9bIBTSFIe+lNs01SQPghEDHXll3HRYdZAOfjXITCOvLjQszd4/77KY+2Qhz
         fIa4qqAhIZt3DDuDkH/VHI1gUidkHYpFzq9i8ILlHP/HiQJ3M3lM3PWOr/fyec5uhCDg
         NJtde/EYzuOX7efhImit/z63iAONuhuFoS9DHQUxzsPHOPk81BIqRq9+zM81jBHtNR1e
         MhJA==
X-Gm-Message-State: AOJu0Yzshh9ZdF86AZpWC0azC6iQnjXHkLy1B9NbY2M+L5JnA8i0Bknf
	eMyDXuFYFdaAs6mfbzXfdJUuegQ4v/ylfLdjl/agrCrxR1+ZjIb7+GqF
X-Gm-Gg: AfdE7cnBxazw5c2HmUOgFmcxSSXFjXSAMkm0sAr/RARlNJ/cn847OCOMITejPcLG4Xu
	CETukFr7KoddW8MwAsHeGS8wNqLpj2MVM/NRCmS6lPeCQgk/DylG5D/pQ460ljlJQPREHEuayal
	/vgGBtQLEUl5Xs6ja+mCwfE6YDScdQyqygs6uE/TrlHMNOkGsATzF98q5lLpc0qVzk+PoDjDmNm
	uwtpqyn0J2gm+vc0cK3Vb8sVVAU3WB8C4hSxnKSsHM0aUZbtT5HFEHyy7g2/PdCRvfXfr009CdL
	HCCvAYTmVbnFvgUeuZpQ+On/OnEXLCElgemhDUtol1PoMQq55wKt6KuCQpiOcOwdqPLE5T1gSGR
	jpYnPTW87aHY2WN9ty2zioG5gb2tjezyaCuT/gtygMzzK7j2X1oFmEdYP42hJaL4r3NwmNUUHiV
	OUGBaCuYIwgBGA0BSJbiI+AM80gjFW/SnMgp8ji3a5n+o3O518r7n408Jh3ZroPDa3PO311Yl03
	R52
X-Received: by 2002:a05:7300:2321:b0:30a:e52d:fb27 with SMTP id 5a478bee46e88-30c84b84f6dmr5504142eec.11.1782451098857;
        Thu, 25 Jun 2026 22:18:18 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:18 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] Input: synaptics-rmi4 - use __le16 for FIFO offset in F54
Date: Thu, 25 Jun 2026 22:17:59 -0700
Message-ID: <20260626051802.4033172-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of manually splitting the 16-bit offset into a 2-byte array,
use __le16 and cpu_to_le16() to serialize the FIFO offset in
rmi_f54_work(). This is cleaner and more portable.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 5d045ece3c2f..3eeb189be18b 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -15,6 +15,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-vmalloc.h>
+#include <asm/byteorder.h>
 #include "rmi_driver.h"
 
 #define F54_NAME		"rmi4_f54"
@@ -552,7 +553,6 @@ static void rmi_f54_work(struct work_struct *work)
 {
 	struct f54_data *f54 = container_of(work, struct f54_data, work.work);
 	struct rmi_function *fn = f54->fn;
-	u8 fifo[2];
 	size_t report_size;
 	u8 command;
 	int error;
@@ -597,12 +597,11 @@ static void rmi_f54_work(struct work_struct *work)
 
 	for (size_t i = 0; i < report_size; i += F54_REPORT_DATA_SIZE) {
 		size_t size = min_t(size_t, F54_REPORT_DATA_SIZE, report_size - i);
+		__le16 fifo = cpu_to_le16(i);
 
-		fifo[0] = i & 0xff;
-		fifo[1] = i >> 8;
 		error = rmi_write_block(fn->rmi_dev,
 					fn->fd.data_base_addr + F54_FIFO_OFFSET,
-					fifo, sizeof(fifo));
+					&fifo, sizeof(fifo));
 		if (error) {
 			dev_err(&fn->dev, "Failed to set fifo start offset\n");
 			goto out;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

