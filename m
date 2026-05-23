Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36493264EB
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512811; cv=none; b=by97Aa11T1hCMXCsybuUvvcwSPJXqlVPvmTn4YWx6UhSodxaD05kEW39EiFufXPCX/wGVNSZBiQg7v4zrxqxh72ktOm2vEQjT9DVthS90iNw7uQ5FABmQqnSTJsuSarYjrpjeiPi2TX0Dk5X8qjSV8aautM+ehbxLJu4tsjpzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512811; c=relaxed/simple;
	bh=wFfcrC6+quti4awUdpIOtG9tFUevx0TecZKQaKI4tv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM32IRh8uMhYZxI0aivzidkimsFq0yDi/NYJpslKY/3KS0v8GUjoP5X82iqg5Xm29ibesKhulllS9/+ymfkNKrpZcR2nGVx+1nEA9cEwLzPnhs6Rt0AxPWpY7kkA8YdfOTFWk3Ynfo+jm/uQgztAGsN3YzOATeV6FlEv8IVcHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xosj1dd4; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xosj1dd4"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30246cfd41aso1421204eec.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512809; x=1780117609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghXdVwh/ggIDUMJwerhmJOVNlYeh4b/xLTuz0F1xTdk=;
        b=Xosj1dd48ZMdESGKBbjrApr302XvRY/invtdzQYSZ2iJbtySj1iUHSq8EL0Ws+rpxH
         lX/Ax4Iz0TjcM+ou3rs9nbmG6WnapCGvjr+aRZatgdCUxXi8+6ADBO3d+TzZG3EfmRuD
         SL69IDz7MgR2mFInue4sxhGdSKcQlz2zk2UyOGGKUGeim/3rElH7XT3jhEiorwkACo/0
         5mkgsWDKpLhguHzRVExdcxwrEZVzwuMxXYVQHd7Gjt8/niCjwFHzceZ9Bw49T7+kWEPb
         d+ImU9RE/AQbDUh5KtTuRQ7o22gYv9MGtmDxEOLERGMF8FoN46eRTxYI0OloW6sSoh6/
         s/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512809; x=1780117609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghXdVwh/ggIDUMJwerhmJOVNlYeh4b/xLTuz0F1xTdk=;
        b=tSM0+UCTF4fbGU95Wqyoc2sGufMP3hNYBJDzKApFlcKi0/ifYrJQ9R8pop3bGevHr2
         O2T3QOX1Mpo3OKdy0qzlAEJhVOTtN/lgq+cDCgYhqsQwJZyOoMDvLkKaBSu5kQs68c/D
         UA8514oD4Zm7v3eCCvJak3Dc4F78jrCTaQRiGiWq9bJu5if67O9B9iFnA+SXkuH9QdS6
         nRVcFtUY73OhiKhGmsfwp6I9EnkyKQPjgNocFbxJFYxLO6DvZMu5XpoeiZQJg+YC+ojp
         3l8urM1k2HzvYdBqRcNUVBRYG3Fo2V5hilXJ2lqRdK2QZMeHyV1xeLf8yV6Fp7RHMcJr
         Ymjg==
X-Gm-Message-State: AOJu0Yz/8biDX/Kpl84HZEBVYO5HgiF0Y+j1kmHcRsTaik7F2jTXaSPx
	BqLA2PJtFginjdfxFuuhMbvh0Tlv4kbsu2sDSZqdAfWE0iBfZTdMkoHFhKO/5Q==
X-Gm-Gg: Acq92OHg6j+earoq4pkkgT7VhkBEoVQBSi+NsIZPpWqikJKESULaYIaYxo2dRhkZyLx
	CYZPkZa8q4MSrNgqvZaDLsUVX/XAvDeriMEBmyHb3o0kOW+idWSOQKlzsSkMJwi5NO143tkcGnu
	FS9FCUQ3Tmj5Zu8PWuXIAfQw5SrFN92+pWNhP77FrGzSkIDiAg6SraBCqDm/YPIrbi8zFOHfgI1
	aWLv6nulIbTktexB75+KvzmsGXPZwLpP2TDPvnqmwJKPTUN8YQhb/cBGs2XR9eacHYBn29dd0UN
	jWFcCPjjJgB60dmOzf7gThqOBIjze4VmA5tMJ8usN+5Gvuphz39cK+dpBAXs/0na71fD7tvDz4l
	+jIaxo4zujEaTZRFm9CzWm7oyNG7uJB4p+fUFmBQDfBcgGgGxHktMi1dIg5Jbjlh4smYvATxOH/
	bwXeqX0pscxjMskdsVYuzjY4EChPM1tPs/OfdlnU9Fo6kVGi+oNfSCfF4iaKGPbodMoiVdxm9oQ
	Q8jCb5Z0kqtvw==
X-Received: by 2002:a05:7301:9c88:b0:2ed:ff78:2c12 with SMTP id 5a478bee46e88-304491f6bb2mr3781274eec.34.1779512808947;
        Fri, 22 May 2026 22:06:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:47 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 06/11] Input: ims-pcu - validate control endpoint type
Date: Fri, 22 May 2026 22:06:24 -0700
Message-ID: <20260523050634.501509-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently assumes that the first endpoint of the control
interface is an interrupt IN endpoint without verifying it. A malicious
device could provide a different endpoint type, which would then be
passed to usb_fill_int_urb(), potentially leading to kernel warnings
or undefined behavior.

Verify that the control endpoint is an interrupt IN endpoint.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 7fdff9dd1b5f..0e7a783526e6 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1703,6 +1703,12 @@ static int ims_pcu_parse_cdc_data(struct usb_interface *intf, struct ims_pcu *pc
 		return -ENODEV;
 
 	pcu->ep_ctrl = &alt->endpoint[0].desc;
+	if (!usb_endpoint_is_int_in(pcu->ep_ctrl)) {
+		dev_err(pcu->dev,
+			"Control endpoint is not INTERRUPT IN\n");
+		return -EINVAL;
+	}
+
 	pcu->max_ctrl_size = usb_endpoint_maxp(pcu->ep_ctrl);
 
 	pcu->data_intf = usb_ifnum_to_if(pcu->udev,
-- 
2.54.0.746.g67dd491aae-goog

