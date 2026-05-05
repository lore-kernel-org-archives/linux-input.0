Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054E3C6A2B
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957234; cv=none; b=LHIyrXSvMAd8xuMIH+OL5jSo2AaB9s3HYSpyd+Fbzs23ePikz/pM2PtGNhvhuRnTQnFeHcScS10rJyL8yvKVPPbqgiZLJ+kN5rdeActpx7ijXZw/4AJLu2ulUOkPOgQ0szT+ggcAGhl03BTG6xQpGsK9ZKRmzYruaZ50lQzPSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957234; c=relaxed/simple;
	bh=nnvi31riH1G9v8r8ZETGWZl064XIY1R+443Ve15JF+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+KdSx016ujU0YjSEb5oOcimlSauRbIkLLOHBzRRN60kVc7NKnhzcPJafCWFEhe/z9I0MHoSu+H7VOFWhnI0Z/FTfc4cO6PKXURDHAQ4eV9DC5P/21StPWHwvMq4uL0LCIWh/+q4AHWXUJQ967FS6KZ5/04xDa6olrHT4fNi89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0FsADzM; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0FsADzM"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c45281a06so7490926c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957231; x=1778562031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUFP0ClBVPwyBO4ZKu9uXCfmRxglSQ3lWA8R1UrvOpw=;
        b=S0FsADzMGqrRe5Ea6Q2q9Obsgj48+srczJl4m9/DD7a6qML6+266gIOBFE6PGM8pgX
         oAXkHHS58cuT1HgTuFvoP1f1haq4BXrVsfjVKnRS9vPk+IQBMQM/2xQIulYjmUFISGaU
         gyRXYRh4LxVC0gFgpWYu5I3ichx0sotCHOO8+mkeLhiJ/kGJjtSmE4v9YlFQZORYdd+n
         7GPX+wkAnE4nFaD2KIldUQb+NM4oShKMTa37iMVXk6vSdwEMljmdClwwZakDIxeNe1ks
         nEZIzVpyMx+0bx+yUcuK56yq2AQDWoWtHen7LIgaDh885M7LiMox8u0dV3tKmaqXGnVB
         ZZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957231; x=1778562031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TUFP0ClBVPwyBO4ZKu9uXCfmRxglSQ3lWA8R1UrvOpw=;
        b=XPWZY9PLrmWF634CLecybSDedkCblgoeu5j+76tHSA8Gfo9JhaTgMWCr/bn6Nv74p5
         xpd+CsyX+xrcuSZsH+wLVCsP7syuFTQRyZTqJWZiwZzKSwiPgDC40RKAeOornx92j4Bw
         msqXYb6iEtJ9eoDTdtsTuDHuxGt8FpJh67V6yDoc93baIP1PB6pkWk6mozxxsIUTNxDa
         /rhwgE2MlFlevQGLLH4GE6++fBpDx/I/Q6CZQlq0oVtJw3ZZ2EmZQZGM+hby2j0QJrpp
         H0uYnSSF4ClJn8JS75CXb9EQcBY/Ty4F2zHB6TXzBw5uD6p5uNORt2yu0GbImr8GjF/p
         QN3w==
X-Gm-Message-State: AOJu0YwvG1kvq8vY8zcwUaUhUQkpfIhB/DaYGkbD3qX2/2bJmrJvAuyA
	xmIPn4Mt6A4H+asgCFPjc1CKMMN+uP9HESJgF9MYYnEx3F930sI6ibmcgwz6Ug==
X-Gm-Gg: AeBDievj+xjGkpqRv3BAaEQo3TcIVycIlOp2MYPd8QqV8QGE43efeLIjEY1sn7o/yKD
	lBHTihnXvV0iU9q+CrrKOP6O0qrZNP+Y8ib45eKShR7Gp+drlZ4BgGmEJSEb1i+pVOFwHOglDW5
	Jxm1zCkCfZnf4ENNTi67fEuP5RttksVL0WOg0h6LOCqDFNIuKpbdtjhYKLASR88+1kpd5n3SAJ8
	7Vl+wx8Rpza6ZTNZR6yVEY0NxdcC5a+bks8Dar3VCZ34g1V8FtERb5vKE45qayEieIeMXXnOOEZ
	CSYwbl1xaQj+R5y6dOcZQQQBdezxHg6r5pWB6hV+Jl3pPyPExPBl/AMX8OORR9aCt6mwvozQbmn
	9YPF347NVkAOvQY9D8u55+Zu0QUyp0J7X1ju7eefYUqaRvtS+ncZOAl4XNTIM8WBmnaB3YZ5SjK
	yJaYjOesmY+fCGp2TVwUAFKAE+Atc6R/0Pbx9t/3P+nanHc5IcK4yjvCB5lLrRkA9wgsqOhjGth
	YOuX79k1FgdbNO2HEmZUzkB7g==
X-Received: by 2002:a05:7022:ec11:b0:128:d5f1:d595 with SMTP id a92af1059eb24-130b1744e7fmr875111c88.10.1777957231080;
        Mon, 04 May 2026 22:00:31 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:29 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/20] Input: rmi4 - simplify size calculations in F12
Date: Mon,  4 May 2026 21:59:48 -0700
Message-ID: <20260505045952.1570713-18-dmitry.torokhov@gmail.com>
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

Use min_t() to simplify the clamping logic when calculating the
number of objects to process and the number of valid bytes in the
attention handler.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 34ed02b7f30f..ea72d5ce8050 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -195,14 +195,11 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 	return 0;
 }
 
-static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, int size)
+static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, u32 size)
 {
-	int i;
 	struct rmi_2d_sensor *sensor = &f12->sensor;
-	int objects = f12->data1->num_subpackets;
-
-	if ((f12->data1->num_subpackets * F12_DATA1_BYTES_PER_OBJ) > size)
-		objects = size / F12_DATA1_BYTES_PER_OBJ;
+	u32 objects = min(f12->data1->num_subpackets, size / F12_DATA1_BYTES_PER_OBJ);
+	int i;
 
 	for (i = 0; i < objects; i++) {
 		struct rmi_2d_sensor_abs_object *obj = &sensor->objs[i];
@@ -260,10 +257,7 @@ static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 	u32 valid_bytes = sensor->pkt_size;
 
 	if (drvdata->attn_data.data) {
-		if (sensor->attn_size > drvdata->attn_data.size)
-			valid_bytes = drvdata->attn_data.size;
-		else
-			valid_bytes = sensor->attn_size;
+		valid_bytes = min_t(u32, sensor->attn_size, drvdata->attn_data.size);
 		memcpy(sensor->data_pkt, drvdata->attn_data.data,
 			valid_bytes);
 		drvdata->attn_data.data += valid_bytes;
-- 
2.54.0.545.g6539524ca2-goog

