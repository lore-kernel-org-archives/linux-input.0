Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFC1BD9C9
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198588; cv=none; b=tDRGtcpQMSGe8jeC4YPUzQvFPGNULub0fVh6fQdCn2QyJJd01rocqrDnwvXyTUaO9tZNa+kQL+LJZ1nVbs1WkIvyPwfMe1uzIoMtizQoMhvza3mu5QdJUDqZxgOEgPlpzB4CgPWYJgoR78ztg5Ho4+Op1r5pjAPsXGUd/wHwoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198588; c=relaxed/simple;
	bh=BuQCrCf+mQSigNEIwwyGIr/Jb15zz9/6CrrJ2HCzriw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MCuirZ+tSk2YJO44joWwIWhR5kusL8UT8geuyjFylXTYnefYGw3i0WgYDwuLAIgprCfC2zc9JBo4Xl3EriyXzzjKzxBol68+sYQ4wV5N/+gC0L8iYrOyTs+ijIS6OHJ5TCjJ92bpa6A3gzGCtx7dOZvtIjNdOJ/OrBU3yYBV0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqdyXe0T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqdyXe0T"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49e717c9841so522585e9.0
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789198585; x=1789803385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmwdaFlGrRaB21X48sX6rYaTDcYS33SWDbPNO4WTsx4=;
        b=MqdyXe0TEJMHEehkfn4E2ajLVoaoCTsp5enZENkkj5MdhLOiNRObeT+RZMsebzQomS
         Hf6+LNeAQHaDxsvPDdOz71VG+BQ/AUMJMqg9vG4vozZCbigziWJ4/KkZ1eNKWO+R9ayK
         wx/6lfWbNpgOQ2kV0/CN/wnq0vV2epTGxf4//UImQtcV+XmDoZTCHVYGK5l6cK/pFj2x
         9DuxFR15Q2UcPVvKwlX6qxjoOEnPEdamQL6XfBiYML2z7SKr4ozUP/GZpdVd6X+txRbO
         4Sh5/hDx3uHYmzsfG3X3RaUyIVPlL/Eh6jhjBCJJu0VLi/+E8ShGhF62S0mAGeL/X9dn
         Tu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789198585; x=1789803385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmwdaFlGrRaB21X48sX6rYaTDcYS33SWDbPNO4WTsx4=;
        b=SdK8H7Xn5dv0asRXNjHACB5LfLdqsTzDNZFR3/aB38T7rpU/u2WA0f3JzE3C4rZedK
         9dPdTJNMSoVMbzXBGu8qA+xCLWvRT1rLyW6KbBv6tOP1ipynNeCBCsFHxJMv/hDBUMYz
         2ZC+myDfJiP+kC0eMVhsjgCZl4yvFiK+bMsvXqIqmvb6Zk1aB/yPCiv3I2pOKlMbvwam
         S+NMhkzeVZtkhg5RQTc+DCMYQLq4cUcUGvJ3FN50i8fKjToyLzDR2lCdhetgWydh9Siw
         5KqHGbc2Xo+/2zDIluEhM0GLVa2sjJHcar8v8FkozR1UeEgz4rpeYCRW/ece5rYpo/vO
         2FJg==
X-Forwarded-Encrypted: i=1; AKwUvBy2uiDYK80ab4x6VWucWNyhC3e/g8TPaWv4HDcxb4wLtuRIhB3YeCON5+jPXPxpXCEqPOrF31eSaCiFmA==@vger.kernel.org
X-Gm-Message-State: AFuF++lN2zfxw58Ng3p+Lig4JudGLi5mvYRl1NkX/RvGChdk48/KRUZw
	sOgaMtaD4nGVm5K7j3MhfSg8WVrbnrHSubywIB/LQ1aE5BSbBBkeeeFP
X-Gm-Gg: AYBFou2zglhTsM6hWwVmwSbXiYYG16q5GRJDiaiOLTDDJE73/8VubiKigfJswJNQHXE
	4fBsCZYN5Cm/8gIduDyJcC2l4z8RGIZzGzc157LQUmP0Q4eMR2eqah3ECqL962j7MKGmMN7B5df
	pGFucD3PUjinlJHIF++X1aXeJPPXzoE/qGw97ygk+zLsAxCdjoOT8B8Wte1AeFZ5RExj+UuGlpq
	rXpa9+zWmVsbrXpKdYzlFiNmJCXQ96q8nOSH7hd+JW3QjqRby1F8ckaXw5R27J2fg3ifmIWVlGs
	kJej9gc4Vs1CZ5SdzbIp2yqwE/m3cIEAyBHGA8MssURYS6XwdJbT26NdWCfYBzXjX5M5SR18FW1
	hNuPKCOVi8XrZZ9B19Ni3LKXSvVE1gQp11JqNODcdBk/lX1y9YPzYI5B5WwBB9QtYVDQXydDRne
	7ghC1BT2O9heK8b3Sx0paCpcdIcRlpP2bcVxTHVQxs/Y9tG7RoQZdZFdWwUbq0tSLboSY27GtlS
	lynPe99Lzt8rvuOOXzgbps7wpX2+AdTCcGktuKrvMaqqmfN5bf+k0wMMT8raiC5MOQFULSONLhw
	uWSp2at+EEcAmElUAYCU7HiWNdFbkvLnP+VIOkCKoVrrDgQp0RP+/BCkU1urCLxU/R7LNyTa7LU
	/zMga/Y0=
X-Received: by 2002:a05:600c:3513:b0:49c:fc6e:a3d2 with SMTP id 5b1f17b1804b1-49e619bfdc8mr81901125e9.17.1789198584578;
        Sat, 12 Sep 2026 00:36:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60acff8bsm139876525e9.9.2026.09.12.00.36.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 00:36:24 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-thc: Fix the return value in thc_dev_init() kernel-doc
Date: Sat, 12 Sep 2026 09:36:20 +0200
Message-Id: <20260912073620.51223-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thc_dev_init() returns an ERR_PTR() on failure, never NULL, but its
kernel-doc says "NULL on failed". Say ERR_PTR().

Fixes: 1b2d05384c29 ("HID: intel-thc-hid: Add basic THC driver skeleton")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 7b4a58e1416d685186ef4bb222b882fab130a4e2..02ec5db9ad26977e72a7c8026b1796bc5d83bd6c 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -190,7 +190,7 @@ static void thc_clear_state(const struct thc_device *dev)
  * @device: The pointer of device structure
  * @mem_addr: The pointer of MMIO memory address
  *
- * Return: The thc_device pointer on success, NULL on failed.
+ * Return: The thc_device pointer on success, an ERR_PTR() on failure.
  */
 struct thc_device *thc_dev_init(struct device *device, void __iomem *mem_addr)
 {
-- 
2.39.5 (Apple Git-154)

