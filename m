Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF33A59A8
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451099; cv=none; b=dLjBhskRPCUp8hUD5Fllaai9Gi4I2X51bwFiQ6LWiNK5ZyDg7Ho+ZXlAT9SVFHv8FnPwm7xIrNdSjGZ82VuU3CIpuu2TTUO4+qfPEhUKNqyFSxKPmFGl18e7wLF0n6MnMBo4fsNVvf1XLPKBttFdN0S9bqp+L+eSeezp4amgMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451099; c=relaxed/simple;
	bh=yMXPdGDW2lfGhnHWFTL7FoN3LjO+95A3FRC+1uOxj7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcN2KpVbF01HspjXi1Oowbf1bZRKLAprwsT9zlLYYYPKnPX14eJM6pcz36LyICR8jgRsfhmxeGFn39RSsvNPPumHJOKZLU4Ho5x+fPh6bQ269aiY5C+iMw43hoQ58pYYgB0edDfPW9YtciejkHoMxyXPVaLFjyNUegnGOL1sSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSvzPTye; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSvzPTye"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bc806fcf8so781017eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451098; x=1783055898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POLQLR6buhFN05Ket/1VgymD6hL5YrZUJpiEgczNqtQ=;
        b=VSvzPTyeQ1wp/UTJ1iLMdfqFlMLFPQ3jlLm+P0JcwL4MtofDTPNxENjAkMhmXCcHnO
         JspvQwKWurD3SnxYqkTnK/ljo1hZ/jbbpnF0TNoJxPgWEvUkzlc080DL5s3fCiRf44bH
         GQ0suBj5Ir/NKBz2QI0/imuYRa6t3Nk91S6cUyY6baFgzxWDhlEoVu+VsqZ7yFYntK4p
         c0PCCeHf6y0IgsjlvIoNZYew6EiHhiGcUAcpqMzABNPb+6f5X3dA/27EwoQga/nLFaVH
         fCt48M1GcCvA+eLNRs0JcMepG3r2NCBdDMrQXC3zM4X0ZI7MBsQ42TbPFriovkNJsHw2
         wXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451098; x=1783055898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=POLQLR6buhFN05Ket/1VgymD6hL5YrZUJpiEgczNqtQ=;
        b=JtqE5fq1I7Eh6rVPRYHVQXXuCCHTcq4Dxn707X9/SSv8suucZkYMsSVlp3lzDfxzOC
         j0NignOyHRwp51j8HQeXBFFRzA2oC0LtSaHBdlDIScHNrysOAb9wdI3LYvDHk+nHTfj8
         DSqmu8q6qHLUH9N+TEs4lvPjhk2+olYMykmMK2KK8Pgg/CGseoPxDtS1q8srC1dNC33c
         ZQc/eDQxuNSeY2DFCnei/37KCw4Ji/bdNVqUL97BSKzgo2gbPCEnZ3MQ9enKodPBBX8o
         mazGWePCZbITk3Y7/4nGuf2x4Ciwt+bZ1/Nvb++80HoD+hLKHG0FwH+Z76JRmpUfUN48
         wmiA==
X-Gm-Message-State: AOJu0YwIq8Qs1INnvMn36d441m8JpkOcJkmCZ2H+olrryAGHJjnn/XMG
	ioqiwfeCplRDSNy/kj6wYHB/1RJgxWMsvovbZZ5M7h0CRPBWerh4K5mO
X-Gm-Gg: AfdE7ckjtIb3ihqJM8N0onq0JR+xP0YGCqU5wAd6amB/S5q89APuN+WtRoIfXPWlWTJ
	z9YC4lC1pxayi5d01fp3SPFShx8WHtCLdBaGhGERJWWvbKGZKIdebT1wMwwC+BkGJFvs7XNTfQc
	/GT+1bUzunSfpKf7t1JFcdOtxCLZLpKGRXIcpbtYKZ5bNXShmoERygbk+kv3YKDuCDCMBZHwdTr
	ZrnPPbhvlgI6IpBetx7Vt/DRMa2zmg2IakwDTJ6i7yKfZkuRUEb7aX3RFzTZIMfwC3LerNVlFrD
	bR/E65BrOKprWprOz8GQPSZT8KcoiF9GGRhE7d9tszZeoYuyfUn2EfU5dRqO8lO8uGLo4qmJe0g
	B9mXtPUqUaCSUqPZurFpDAHzqflB6y16rirut7cFJNpCGS/QkipQkeS4q+I5qaKk7nSAK4mZpUo
	foXV5rYxxhd6RWhRYN+4NI1UWM3l44WlsYmHGFmnQO+dD4AUEKQdzLOFZjLz34FQ7VMIL3IEZ4i
	61p
X-Received: by 2002:a05:693c:2285:b0:30c:45de:8fbc with SMTP id 5a478bee46e88-30c84b64cb7mr5070108eec.9.1782451097513;
        Thu, 25 Jun 2026 22:18:17 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] Input: synaptics-rmi4 - change report_size to size_t in F54
Date: Thu, 25 Jun 2026 22:17:58 -0700
Message-ID: <20260626051802.4033172-9-dmitry.torokhov@gmail.com>
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

Change report_size from int to size_t in struct f54_data and update all
its usages. This avoids signed/unsigned comparison warnings when
comparing with size_t variables and matches the signature of
rmi_read_block() which takes size_t for length.

Also move the declaration of the loop variable 'i' into the 'for' loop
header.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 850e1742c480..5d045ece3c2f 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -105,7 +105,7 @@ struct f54_data {
 	enum rmi_f54_report_type report_type;
 	u8 *report_data;
 	size_t max_report_size;
-	int report_size;
+	size_t report_size;
 	int report_error;
 
 	bool is_busy;
@@ -355,7 +355,7 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 	}
 
 	if (f54->report_size > vb2_plane_size(vb, 0)) {
-		dev_err(&f54->fn->dev, "Buffer too small (%lu < %d)\n",
+		dev_err(&f54->fn->dev, "Buffer too small (%lu < %zu)\n",
 			vb2_plane_size(vb, 0), f54->report_size);
 		state = VB2_BUF_STATE_ERROR;
 		goto data_done;
@@ -553,10 +553,9 @@ static void rmi_f54_work(struct work_struct *work)
 	struct f54_data *f54 = container_of(work, struct f54_data, work.work);
 	struct rmi_function *fn = f54->fn;
 	u8 fifo[2];
-	int report_size;
+	size_t report_size;
 	u8 command;
 	int error;
-	int i;
 
 	mutex_lock(&f54->data_mutex);
 
@@ -569,7 +568,7 @@ static void rmi_f54_work(struct work_struct *work)
 	}
 
 	if (report_size > f54->max_report_size) {
-		dev_err(&fn->dev, "Report size %d exceeds buffer size %zu\n",
+		dev_err(&fn->dev, "Report size %zu exceeds buffer size %zu\n",
 			report_size, f54->max_report_size);
 		error = -EINVAL;
 		goto out;
@@ -596,8 +595,8 @@ static void rmi_f54_work(struct work_struct *work)
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Get report command completed, reading data\n");
 
-	for (i = 0; i < report_size; i += F54_REPORT_DATA_SIZE) {
-		int size = min(F54_REPORT_DATA_SIZE, report_size - i);
+	for (size_t i = 0; i < report_size; i += F54_REPORT_DATA_SIZE) {
+		size_t size = min_t(size_t, F54_REPORT_DATA_SIZE, report_size - i);
 
 		fifo[0] = i & 0xff;
 		fifo[1] = i >> 8;
@@ -613,7 +612,7 @@ static void rmi_f54_work(struct work_struct *work)
 				       F54_REPORT_DATA_OFFSET,
 				       f54->report_data + i, size);
 		if (error) {
-			dev_err(&fn->dev, "%s: read [%d bytes] returned %d\n",
+			dev_err(&fn->dev, "%s: read [%zu bytes] returned %d\n",
 				__func__, size, error);
 			goto out;
 		}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

