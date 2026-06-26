Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0A3A1D14
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451094; cv=none; b=oID+UTcoig3xukinFeDsPEW3DXkWNoE8ZlbxWztWrViDRhLFPxkkiPo4tv5j1elQ2LijQlXbvLvQQxoSMTEieyUHMKbZDGaFb9Ox9Fh8kPj2SM7UjrTRReoLOQp/qJT6Uz7mfK520TwWO+4QCp7VWuSHEeDnAVyRfmdzLLySafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451094; c=relaxed/simple;
	bh=oI305MqoOf4OcBFfWfvo2q/rW61nNlADLsX9gv75Y20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDJaDTxdhcUoTckXLw/I8yx/OZIBQEb6SZJ9i/nw84/FDS7RWSML6dWr3c4GhgSdYaSbPIhakRIk8+9HqB38lg3VTq8nEeGLuFNvULCt1SczZqMyEihvkC2np+gKHCuVP9t3D0LZCH1cS3qTMpG8NroIoWTO20WTe4d/vHRS2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rg5epz9C; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg5epz9C"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30c944aacbaso874009eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451092; x=1783055892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9f5K0F89CIVZXgY481pC2XHEuVEtLfkjz9FoRFy/os=;
        b=rg5epz9ClOHBKynSxajNKm8CtwuG9za0SM4YheYjsiHpY94kFPBOb7q96mQMl28Tdg
         yFcln44B5px8dKDFKF9eBhPiwazL6xlzcY/HzZQ+62tEtO+AMDdG7Omv7q5O0EO4Lg8a
         3+LATSJC+CLg7eebTwp43fkeeOw5cKX2BxWcq7K4izKzbyz8Lnvtkglw+iOsWaCMfjyi
         /w/KoFwlYA5dH1MlvOdLKmIBqNZwbla6twUKaHy8pLzYEPQSh7A4GNUwkFLuZYDMI9pd
         R9vi4gCKpX2Pd5KTHtEq5bdQdwVzeSNoe/4Qg2xvdoDgNPuvrXCXhbDD4aMCfB/uFWbp
         PHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451092; x=1783055892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9f5K0F89CIVZXgY481pC2XHEuVEtLfkjz9FoRFy/os=;
        b=hTKJZKK1uHxH2GXEK/vdX7H/8IEDMWVlHEB/grVU2cgnvjNpyV9wghVB7k9A59UQLX
         FFem+RIxKs0i8iCdiI/YPgfV8eegyzx+3Eu1mGBiZAFSNYHdSjfJjXneVKMQuCyYFGBw
         +XMz0aDrmmfn4q1xnRVoq6ITeuaOaUcb/+Zs/cHpaEzUvj4NPjP+Iwrj7uecADGsCTdi
         Z4SB+DSk5GLzZnuZmM9bGh2eI0bA1/zLJfIAcxs+2/RnQ6kFj/i92sjoWLQAVQa79QZc
         ONlnd+Kg/WEKA+B4XEAmnrSpBI2ctWEjIMZy2N5rAk3uUBWQJ+g2411MQfNDrfZ4e5Za
         QhBg==
X-Gm-Message-State: AOJu0Yw25bxy5uYSr0BUU11l3cC1jGYyw8Ehs3r4sPhO7l966Kahh0X9
	HCemUqVuaiaqzb7tfmlcX0pQD/vIcPqSafpfpS0zodCImhqi7tXspF9n
X-Gm-Gg: AfdE7cklY76lzM4uh2yZX9rkIGSBYIIpdB6qxuugQ9NkzcF4XtoeRXZ49ytwVANTFDl
	PepnhVvO5cR2AyrJlXxuPgZG0QmvGNFeBiYrJ6cMkBxK6AX3eW8HZ7NvCIZcTGCBKEICZXww38Q
	QQul2gFh5tqaEPcvaSum8RRFkF81DQ71GAp7HsuHFziZ1w1knb39ttnfdUsN7932g2sEUApSY5s
	2xm1yobssy9gQrtZ+gHi7U6KPdf35IW8AQEp7aHoDNQ/V0F3wcNX3809qdJsSkk1q11zqrNMvgk
	JX6FZa/9RwL95k5Xjdu+n+koMHPGhGs4zNrvHBDpx2COLdGGLV4Ia2YMBqbexSlXpLsUc6begje
	jtIW0+DA9ojlvsUlepWH0klKZvWlAFHu8Nr/JqTB0NWfrbIqnY0rR7Po7Xjfodbo0M0DKZaVDVf
	7Z13mlRbkBVGFHIahddgN8gg6k2up7chXshjLBt1zKzMR/2tFLRa5h+EQgj7Y8b2mSWJ7aLBGd0
	Ja+
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id 5a478bee46e88-30c84a265a1mr5890749eec.0.1782451092285;
        Thu, 25 Jun 2026 22:18:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:11 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 05/10] Input: synaptics-rmi4 - block s_input when F54 queue is busy
Date: Thu, 25 Jun 2026 22:17:54 -0700
Message-ID: <20260626051802.4033172-5-dmitry.torokhov@gmail.com>
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

Changing the input (diagnostic report type) mid-stream changes the
report size. Since V4L2 buffers are allocated based on the size at
stream start, changing the input while streaming could lead to a
heap buffer overflow if the new size is larger than the allocated
buffers.

Prevent this by blocking VIDIOC_S_INPUT with -EBUSY if the V4L2 queue
is busy (streaming).

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index aebe74d2032c..e86dfc9ce7d9 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -445,7 +445,12 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
 
 static int rmi_f54_vidioc_s_input(struct file *file, void *priv, unsigned int i)
 {
-	return rmi_f54_set_input(video_drvdata(file), i);
+	struct f54_data *f54 = video_drvdata(file);
+
+	if (vb2_is_busy(&f54->queue))
+		return -EBUSY;
+
+	return rmi_f54_set_input(f54, i);
 }
 
 static int rmi_f54_vidioc_g_input(struct file *file, void *priv,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

