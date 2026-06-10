Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B0175A6B
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071549; cv=none; b=Omf4ssII6nPKhmUlKPRnxuyoZ+N0auQ/mYJJ3EjQUKUK5XDzkrLzHTjK0YSTRUXpTGtgtXhsBSOClvULiYgH021sI2R6Vuf7t+Xfl3A5QDviCiQpnkJAl9dBIrIkO8oXpflNOWBmnieYQz+arhEDboOoeXZI8BrjrXc8ZaPOzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071549; c=relaxed/simple;
	bh=4DAsPMVkh4oQeQ05EK1ta10gJKKSQlpDiuLEOkY2ufs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qqKv41Ax3hArKlioUZCaNAYYAE+qspOwmPhop0wXBFQX/3sAo9axdaOWun529F45cvGUAWyUWWy0L4uO97n/9Zx3QJ6IhAhvrjcohMVSAUz7zt1wS1QfezV0K3VldNgEEQOG0YJhRHYubRKkll1rHNh7Xw0QT93F5l+WuDbmwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNMRyl2x; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNMRyl2x"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3042a388168so3315783eec.1
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071546; x=1781676346; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXN/kfJxVQl141P+5ZZqn7P2Sah7OB1OF27XFNIsBU8=;
        b=hNMRyl2x//KRPeViDGX9TNIDVNeDstLWEcBHqKVPOLF8GlBClybBNRMwSIu5JTREcH
         rGVMx/+59HnSOfD8tofMNBRUJsB7ZEoMJLi0UQfdIbUDUuvtQ/zTu6RKiE2zaObfuslg
         p01Bov1AO0AK+EIpKrqiQE+hDViR+NUbsn0uVOp7ZgSC/DbT0KMpu8PCv8fwcETyOCSa
         kcuB5HCjG+WNxsBiDIpvl1b13C+cr0HFPog+dskM0VrCBgiR+z3wvrFkeGj4OJ54IQX7
         31zWoE52xRkF4oU4eEwR8zJaI/cR0IvM5O97glnLwWnHxWaVBNl1aHApoMNKfwHnSXcC
         pLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071546; x=1781676346;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXN/kfJxVQl141P+5ZZqn7P2Sah7OB1OF27XFNIsBU8=;
        b=NjpMxofBAJs4mTwYh0hNy548pG+JuWWPTGJ1cJE4TqFFiaPKL+vGoBwujJVcsqIZnM
         BN/iNKByDyqSz74bdhKQlQjRdPqttHJv/TdbaYkONN+fSg2JdGwcAnnUYEt30FLMqdVr
         VD+UdDAI7TOkiN3cq679cunM/xNxov1/lGkTp501F7CF97Mdi5rPxgYAQicuJk6ZSXvK
         BwS7ygeSrmhwc+Q5dIlaFuqfXgLQKlnnntCRa+Yh1YzSnIly6JlYb48kDaliDUw6o6x7
         7Wn/EZcXA2UlbfNgKxJjpKe96zoap0iU2+seWemKXdLLfvQiyedHGNYMIlXcJrjrtjht
         6jYw==
X-Gm-Message-State: AOJu0YyLiwmVFUTkf0c2o7LYGz27Z2PF1VMBAuda8SNMfuLQkFtNgpC0
	/kbFv1xvYhCrjprGIy+bqAFoOkLBI5PJ9lccTJjrCb8K1CLsD9+10byOgICPaA==
X-Gm-Gg: Acq92OEx0Yty8KTB/0BSYGTxEM9hmvWegLLMGi6MFSEWcwtQPrMsU2fLj3zYs3+JQo7
	znzX6tST2BSkU4HXEg+DRCvKY4w28Otym8I+AONN8p/v26qxFST/Q1gF8C3UbAaNQeDcOgioYni
	XgEiWN2+IxZ2+ejgdayXxEYs9jqFFgXt/ql0Yg0f1ea6wyinwEeMwQMR7CxMc6Mgz0fSRjwyrtU
	QHrlsjlYbeonTpaM1V3/O81Lq8uNT8XTYp1hbrXAxnZHFGS7jUSB1gdEs4sAn3MMUjC2UQnoJDN
	LGoJq6RWBXgZNaQO2RDJQdMGjp1bPRGRe3YsNcf/818mt8NcNlqzsP6wxmOC3ha6SOtr8p0CVsL
	q83oPjgvwVXxwPDBAoLKGa4kII/mIANbuw3nLzK3tPF8EmDKoRlgKkzdlLlk3fsdP1cfNPjXRTP
	jJAXm7g0rwsQ6cs4Bb2K16GU6NWmbE2viqSZ5ddFsQ23O9pLlwozsoi6OZbYUFBDc1yYgDzoyd3
	WY=
X-Received: by 2002:a05:7300:8184:b0:2c5:c532:1fe1 with SMTP id 5a478bee46e88-3077fd7aa85mr12204814eec.3.1781071545478;
        Tue, 09 Jun 2026 23:05:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2bbf:a9b1:a73e:3f6f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30777ecf9e9sm19240291eec.28.2026.06.09.23.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:05:44 -0700 (PDT)
Date: Tue, 9 Jun 2026 23:05:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ipaq-micro-keys - fix potential deadlock
Message-ID: <aij-pfaKK-Nna7wf@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver acquires the micro->lock spinlock in process context (in
micro_key_start() and micro_key_stop()) without disabling interrupts.
However, this lock is also acquired in hardirq context by the MFD core
rx handler (micro_rx_msg()) which is called from the serial ISR.

This can lead to a lock inversion deadlock if the interrupt fires on the
same CPU while the process context holds the lock.

Fix this by using guard(spinlock_irq) instead of guard(spinlock) in
micro_key_start() and micro_key_stop() to disable interrupts while
holding the lock.

Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/ipaq-micro-keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index ca7ec054b1ce..63d589253e46 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -54,7 +54,7 @@ static void micro_key_receive(void *data, int len, unsigned char *msg)
 
 static void micro_key_start(struct ipaq_micro_keys *keys)
 {
-	guard(spinlock)(&keys->micro->lock);
+	guard(spinlock_irq)(&keys->micro->lock);
 
 	keys->micro->key = micro_key_receive;
 	keys->micro->key_data = keys;
@@ -62,7 +62,7 @@ static void micro_key_start(struct ipaq_micro_keys *keys)
 
 static void micro_key_stop(struct ipaq_micro_keys *keys)
 {
-	guard(spinlock)(&keys->micro->lock);
+	guard(spinlock_irq)(&keys->micro->lock);
 
 	keys->micro->key = NULL;
 	keys->micro->key_data = NULL;
-- 
2.54.0.1099.g489fc7bff1-goog


-- 
Dmitry
