Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739C3264C4
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786201206; cv=none; b=WZynHi972QkfUxx14FWjDu5Ko+92Tvl/NRddQadjYokJfKgXbZl0iN4fhCoVj0LR403KDEvzikblrPEnjg/AWm2wtpsYPlSEeN6QgKmOokzTHeIdVGLqQE/YVEueUa8wDVxH5JsmJgS1kl/xqSdTKQJW9wjdmh+Nu2YMoOMDog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786201206; c=relaxed/simple;
	bh=GfW2YEBWG6q+0lA0pPenck81sZPjv90TsJei2jwNBls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWDYgg3+mpRn9SPWqe7hH6dpze0CIK7dncjHdtbsEceuU5o0X0s++2pw+13sVPXQlCJDs9ajH6K+D3ISxDvEB4RVFLHQseYQW+UhmY+/w4nrkH1qkHuAOrq2GNQLAiX8VrZLVSCuhcHjJzfLRq9DJtUGJkuINqek36W7awcJSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAFbbBrr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAFbbBrr"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso407120a91.1
        for <linux-input@vger.kernel.org>; Sat, 08 Aug 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786201205; x=1786806005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oOONO+kZ83xynxRyUTPEoSdvpl1Q3Luqgq4ZyfoVH8o=;
        b=jAFbbBrrja3AI2d3/h4bTqZuDrqhui73COWcWo83t7STmUinCVT1pq6QKlsoBDCq0e
         CZV9DdSilcSi+fAAWxZo+bFn9lvhTbsvJqw3GA83wyoBPvhAaGhASgpNKpjf9Djrf6s5
         wEA3QcvXj4/e/glGutvvTPUaHIv7yciB7GjyFdTX3x/A6Q1YbIhaQLhfRGur8ilZFp4E
         8w1y5HlPItpIJWt23yYDTwH+LBMlPDyGp1A2bsXFO78wagnpJQmIAkSVaGTKiWv7t3S8
         gKiPH4pyDolzsREzb8xHvrJODvyD/zwoYbtNyZ20+dCf+sh6O/7XLPUZWXUVvnFfMcYJ
         e8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786201205; x=1786806005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOONO+kZ83xynxRyUTPEoSdvpl1Q3Luqgq4ZyfoVH8o=;
        b=YRVJx39NGqlIRBqrnwrADkmvjUcJVdBDIs5PR3nRWCAejGo7Fqx037qCcshKPgs8KU
         RGqOfw35aOCkJi7MwEYeMgU9d05+5DGkXdOLGT121Xf3aiu/9anplXmZbgMdXdXCuzww
         42KObkNZmk82RXwfzsUZTVJWeZB5XhhD3KJPPX5DErkyNlRN+z6TYWpP+KWiLFx8gQ7y
         hSBHCe9M+J55HG0ofpV/DhxLabMaMBkm5Ejcc43aHjPD79znRs8zVHMkFguQytGrenwj
         2/N40jS7kX7YHQkCr8GLfVTgyiGe3ZUPVJAxRc6WEHD5UntigbIkv+3E2nmczxDqsXY1
         QYKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrmt4O8gbnwp2eB8U99Lq0//vEgTUdi80X6+pYh3m/FpSkHi1ap7xxZjUq0WnIoZv3IrNannoMvNzeB2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MQUsf27IW5XfIHiBNiQoWfpx9s9HldEBmlXLQCTUQhSoQXGA
	W8fzvZNkDTOFFgfU09MG11g6u4d8qAxgEN1+B/y0TnpKVlCnvlfs0IqT
X-Gm-Gg: AR+sD12hpPOvoIUo/LKOOW+HS/poWaqWRmQswKvci41MZUdqZ2ytOtGER8c2Fc1zRrH
	eI5uudXFDji9vdgHi7wR3ejGNBqOyImzH9FAkoF0q7hCD22l8t+5D47RIo/ZrHAJKVISkkrb7/6
	B59GvgBDrJVOr9MO+Si/5Z8LGs7FXgPGzxQJXZkSTxM8NcPPGjbndxysastMJw71gYhJxBxoGqK
	iM23hvKPQo2QNwmIQueJTBvtHKylMtJJLbmtcw/bo7A9Ss7vJw0vJq9dUVMZvOw5Wk5DcBJYfhD
	KNN5/3VxLamqEC7GNXdM1zv09pOqoKr+UZ2r9foinLV8Oa7o78qazbZvIR5N2zBCvLsifK2Ebrj
	v3R/LYdNEg6IvPyqnDF8CEesWOGqrSk6E+POKLBYhGIe/iaEvFY2KMML3ryHaHNfqiOKOlZqjxI
	ggSEBJh2iRCaKff4K7N8KF2Dfv2SJdhnhd62gzhyDg/8w=
X-Received: by 2002:a17:90b:528c:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-3903c5993cemr32295133a91.5.1786201204670;
        Sat, 08 Aug 2026 08:00:04 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6f13dsm6447642a91.1.2026.08.08.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:00:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:57:48 +0800
Message-ID: <20260808145748.2926096-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quicki2c_probe() calls pm_runtime_use_autosuspend(), but
quicki2c_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 5f420e8215c6 ("HID: intel-thc-hid: intel-quicki2c: Add PM implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..4126c2408d98 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -774,6 +774,7 @@ static void quicki2c_remove(struct pci_dev *pdev)
 	quicki2c_hid_remove(qcdev);
 	quicki2c_dma_deinit(qcdev);
 
+	pm_runtime_dont_use_autosuspend(qcdev->dev);
 	pm_runtime_get_noresume(qcdev->dev);
 
 	quicki2c_dev_deinit(qcdev);
-- 
2.43.0

