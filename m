Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942147FAE6
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519487; cv=none; b=kDPkAR0ehL2107rCed7PeVI+LPKSw5tVH5TD2YP+6BnAfHt70K0nc3HYl41XP2zxTMxormitnfm7M6djq1FUVUvv+XQIQgJyDu9PZiWHoz7ege9fqSC10BPGRG+/9Qum7ad6k3SprYSAwMvJc0b+P5JQhhfCqDGCZWBQcBdE9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519487; c=relaxed/simple;
	bh=VyW2ykj9ZSbRZsQBva5UnSiRQDPGAYdsViwT7RG+g7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvQXgQCyhDcod5fPQqmkgMaFT3hjDIdGNsrbIut/NNJ+UQ4pZcehJgIm3V/dgkT1iiTGKxkYD+l+eTMTBrZ8qBP75szV4VVqX7lTV31LJjHeP5SJPP3+E6jNM9hL7Dx6yVwLeMYVZSzwS+SuR3Tp5G5eOz7RQJBpr5nstCw9aVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9nDS3yF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9nDS3yF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so9137145e9.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519483; x=1789124283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUmW5DxVfT5IVMC+lGWdgosH/c2kEie81AvMEOjhwIM=;
        b=W9nDS3yFuA54xrk14jzLPrCGsJad+5K9rtiOilvvWV4hFJU4Wd04y5nNZHVPdM6rcW
         LYgAiStgWQ4vWdSoTXiMlXRZfpBKaWYy/iGegCCxEdJfOJ6lqn/kDHg+ikzl8hKFQ/LX
         5IbSQziN76ogl7Z5i9ASzO39tKua5sAmTCKdrVaX39qSRIxw80pGMQXee9jzZxTDjvII
         akS+9CMAz5N+kvx36g65wdq+g8mGsks/F70gytrZx5n1LhK1BpdVZl6MG8wusHZaqZjr
         yu6ySe5tV5LQXa1OiVzJ3fVPdgPedhXYRLoPMS+KRxWEUMNksZ10TRV8N9o48gC9pngF
         K3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519483; x=1789124283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUmW5DxVfT5IVMC+lGWdgosH/c2kEie81AvMEOjhwIM=;
        b=W7EVZHLkPSvF5kna/T9UMNEa+P3z0KJT3j8rPQInH5iPfi3u7pqILjALtXnFZLhEyR
         EfwKVb4KZdQNu2n1Pw9MZE7EmpnYdjoeBWHbSxxtzHUudQR02IqhjYnrpCIzeDtd+xNx
         iSdx08tuLCPO0sj7Zm2LwDFQr5Vm2iTlHLuRM5/5roaKCy607lFS2XkmiPxYcVYY3vIY
         1POMj8aWQYNh0+pi64KdIfp8wpr6TN6ezyIYgI0pLoTT4oAGJ+S80LLviNwCUcSSvC/y
         861L/MWHSvVJqiJFO7hAiH3xT+WIgo7O5UKTO+zA7eI3zBUK76pX7Oi2bhPynrNjXod9
         /hUw==
X-Gm-Message-State: AFuF++noZJQn5L25otc6G+nVPdMEpt1zfeiYTlp4J2378YqcJRi/yQi8
	FWSsDGNHdwVnrh5Ov8LKPOwt8lvCbQSmxh4jOwALEHT3OA+ygqVwnRY=
X-Gm-Gg: AYBFou3JxxPWqL9zUOa8JWX4G50bCFcfHwlV765DXun8TJcpJJ95ZMryq9sYY/icYuM
	URsJ5UQkvjWZbrdtGJyvBcMdPueGbWzF20MT23pBWEwJ0kfpUmQRGGvS6PLDcHTBYQnEJyeIlTS
	Ci97iWps1DbrYy+7hA9B/ishIEzNW77iRHwkCgSeD5XWQZjgXqrvLItGCINt0DXdKxxAhps/bnW
	DKRgn+8jwNVRcTdgTHKpPRoBY0Ahkdjcgfm2F4u9qNLPAoIo06vOKQvFtLWc0jsGqqkWBqmmKFl
	HDcw/as6bSPTInfWEp3qvDAAIDR8jHmi539ojfRbpDdymt5x8QnGXh1cokx/OqXtWsxhUe2hJKC
	+6zk9pCc0qlhFIpVUGdSdiWUaHnVtYtk4CQAX7zeVZq5+XT+ogt4P7d3UwuCfWUnETUDTJWtXJB
	2YOaAlTAGJI9xvzv5yCVCYtyMPtXBGXA==
X-Received: by 2002:a05:600c:c173:b0:49c:fc6c:be18 with SMTP id 5b1f17b1804b1-49cfc6cc0b8mr24611455e9.30.1788519483362;
        Fri, 04 Sep 2026 03:58:03 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4761dd1sm134023135e9.0.2026.09.04.03.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:02 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
Date: Fri,  4 Sep 2026 10:58:00 +0000
Message-ID: <20260904105800.3923987-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

oxp_hid_remove() uses cancel_delayed_work() for all three delayed work
items.  cancel_delayed_work() only dequeues a pending work item without
waiting for a currently executing callback to finish.  If any of the
work callbacks (oxp_rgb_queue_fn, oxp_btn_queue_fn, oxp_mcu_init_fn) is
running at the time of removal, the callback continues executing
concurrently with hid_hw_close() and hid_hw_stop(), accessing the HID
device after it has been closed and stopped.

Use cancel_delayed_work_sync() instead to ensure that any in-progress
work callback completes before device teardown proceeds.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-oxp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index d2ded6b08ce9e..1e691ebc1199e 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
 
 static void oxp_hid_remove(struct hid_device *hdev)
 {
-	cancel_delayed_work(&drvdata.oxp_rgb_queue);
-	cancel_delayed_work(&drvdata.oxp_btn_queue);
-	cancel_delayed_work(&drvdata.oxp_mcu_init);
+	cancel_delayed_work_sync(&drvdata.oxp_rgb_queue);
+	cancel_delayed_work_sync(&drvdata.oxp_btn_queue);
+	cancel_delayed_work_sync(&drvdata.oxp_mcu_init);
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 }
-- 
2.47.3

