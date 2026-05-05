Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957583D1CAD
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957224; cv=none; b=g9tei17Dq6o2R8E/iSuctxDJ2Hra5C7Tl8gtf55y+NfMoMKxzmxhF+fNTM1WKWhZASMXao7LSJpThbQKK6x2rbaF5jcM/B7DIrxCuPfwWItZJpH8j8cqewbx0vufpZEz5D8bb4S8XEcgxBHdxbB+U2TnR0JC4eFvapwRxMUdqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957224; c=relaxed/simple;
	bh=pnl8fTrSZsIu9uh5xHJYF1vbItqrgUzzgsalaQdTM1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D605847sT7wWDdRuE6msvsWbo6DUt3hMDWV7ZtQdw9OVw9Hbny6BoM2t9yucyJ9LsPK5AdL5/f/LWQuUg8FZyJGp4QArIr9a0DNzx/CXJxGhpfovHCMIXQCI1C7S8qkC4+Tr68+0gEcVysuHREN0KKBBO0p33nNjribjaetAXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5fVNfCN; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5fVNfCN"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-130a4aae5ccso2320433c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957222; x=1778562022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc5lipwKSOHVQCjph3oXiB4U82M/ZlFnOHa7vhpxMvI=;
        b=D5fVNfCNWd6/VsLVTMcA+GFcFB5Fw88K5IzCi8UYZjwMGUbIzbdU4qNcMYNajBgax8
         J7AIw9x/rSRDMQxA/khvrL9FhJG/Z8DFKnqa5D3cToAdcuVv2e4wQ8byo/Cof091lxpZ
         ltuL5RbNHeoGxx8izK6mS0Ujv5uzP63yrxhZz9frbI+yo6ufDOZF3ItQbih2nC2r1KNU
         8aOvmHEa0cofqQ5018YM1DbcwL4J79rCGBU35R9eNh3t0i+800wfpbM8fuMKLSlQd44T
         H7KbuOZJZORjtcAeciYmfFwVdPxmMq7HWuSEZo2Pt41rQKamf3HBttbSRqj1OnmwD1Ng
         MqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957222; x=1778562022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mc5lipwKSOHVQCjph3oXiB4U82M/ZlFnOHa7vhpxMvI=;
        b=IdNggrUPaWyHhqkyfM/ahfPotwK1eSSwQIHxs5XwFri3ChWXcNUia0+MnQ/nKiem5Q
         ok4wWHg1FCfSqRAbxWj6DJibocwgaYEVIWcSVRTio6ltYMqg7tAThA/6ZC877jcylNY8
         Q9NpIUD+dDacMYFZHDvLoqsrntPk8SJP9zuAiXgvRWOj4wzisVNyf9kNmoABRDInjzIP
         D1y64hNY5tSdXBvF193lHaGkVDu56nXz5fpYMYM7QkFeYaCIzoeWWO5kprt9RY/CHGaM
         a0OSEQ5D8TKyREnwrUgHmua8FmkMEfXao59LcqGKeWDqACDhYgrZkd/IQN6kFoadMdrO
         2Tyw==
X-Gm-Message-State: AOJu0YxDBV4iyLPjQlc7yRqxUXiUYoOcW2+EFC9VX6QIF3nEsDM5nW1X
	ihHJGXs2XYacGB8HmGMjo667jM/d92K8GwBHtsRREeTnJuImX0xN+7PuUB9AMg==
X-Gm-Gg: AeBDieuIj/nr27ZiTFfcwaMEu22Lf4/Vy+WNyzsCn342ZL6/elZaC5i67qXs5XnD7Si
	gOVY83paScQLeEJnd90AxehDfcVYI6VUqLkwLRcvgwx9seVMkVV2ZvRqA7LSKMgz3j7Fbd2xzbO
	t8yDRde1tSMbB9J7ZzmPGLJUIGH1QI/X2IRMUpDtkba3EK3+gQEiUQUq7aA81FV5jeBsxmE6lAS
	cZhQ/WFd1fn0hcfE2VaswbeUJcMckVJlc4twsJ2ppeABWzncg9NxcxRWUuXOtRp05jBb5cqlg83
	daVR56kNHDbfBEvIIKmPBrfXKDUZ0BPN7lQu41SK8g/LCUxRZof+b0s+JoK3CFqm/W2lVY1CoX1
	DjYxnZrAov8Ld/cG5pepwCyE3XXO+FXi4FUKHYNDcEefV954rdoOkvoJOsG/5fLhHXtPBJyg3tY
	CYPncQgtW44BjdndajGLM27IAdR+t8Gevsin7Xy/5fzyYkk+a1b/oluM9QZ42za8MIIdLW/Ze/Q
	MsxW8NYFiz4dkEoMQfLKnE7Ig==
X-Received: by 2002:a05:7022:b88:b0:12d:de3e:86a8 with SMTP id a92af1059eb24-12dfd86bc40mr6077800c88.38.1777957222088;
        Mon, 04 May 2026 22:00:22 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:20 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/20] Input: rmi4 - use unaligned access helpers in F12
Date: Mon,  4 May 2026 21:59:44 -0700
Message-ID: <20260505045952.1570713-14-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use get_unaligned_le16() instead of manual bit shifts to construct
16-bit values for max_x, max_y, pitch_x, pitch_y, and object
coordinates in the F12 parsing logic. This simplifies the code and
makes the endianness explicit.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index b179980003f1..752c1d137da0 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -6,6 +6,7 @@
 #include <linux/input/mt.h>
 #include <linux/rmi.h>
 #include <linux/sizes.h>
+#include <linux/unaligned.h>
 #include "rmi_driver.h"
 #include "rmi_2d_sensor.h"
 
@@ -131,8 +132,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 
 	offset = 0;
 	if (rmi_register_desc_has_subpacket(item, 0)) {
-		sensor->max_x = (buf[offset + 1] << 8) | buf[offset];
-		sensor->max_y = (buf[offset + 3] << 8) | buf[offset + 2];
+		sensor->max_x = get_unaligned_le16(&buf[offset]);
+		sensor->max_y = get_unaligned_le16(&buf[offset + 2]);
 		offset += 4;
 	}
 
@@ -140,8 +141,8 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 		sensor->max_x, sensor->max_y);
 
 	if (rmi_register_desc_has_subpacket(item, 1)) {
-		pitch_x = (buf[offset + 1] << 8) | buf[offset];
-		pitch_y	= (buf[offset + 3] << 8) | buf[offset + 2];
+		pitch_x = get_unaligned_le16(&buf[offset]);
+		pitch_y = get_unaligned_le16(&buf[offset + 2]);
 		offset += 4;
 	}
 
@@ -227,8 +228,8 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, int size)
 			break;
 		}
 
-		obj->x = (data1[2] << 8) | data1[1];
-		obj->y = (data1[4] << 8) | data1[3];
+		obj->x = get_unaligned_le16(&data1[1]);
+		obj->y = get_unaligned_le16(&data1[3]);
 		obj->z = data1[5];
 		obj->wx = data1[6];
 		obj->wy = data1[7];
-- 
2.54.0.545.g6539524ca2-goog

