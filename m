Received: from mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7B4BD7B7
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495934; cv=none; b=uh/BmSis4E5ORbvxZ920KNAkksZ8TfhGIfRzsosG103//ApA3Lo7RePqY+YBN5pgd1VkYClA7nRAdEJ+0XQLXs8vDzu0kBix+VTb4WraaeslnNfhFcZUD7chV+6KtZgRcUBm8oFvT+qNDSNOMfUMiUrGj5/URhqW/76bz7V3rIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495934; c=relaxed/simple;
	bh=E7RbFhHLJt+DOrkD7WYgzOURJt/v0VVzoD4303hHwYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vu3PrE66zGrBPJautnkj6taLP3jT/knlNsI3tmzpfjpubM89I4EhFy2YMVTVKSSV56BvYsgNXn4DlqCNDIh2YIP4P9TanSWb2W/8XxW9frRPmyZYHYgMm1MogoutJvCqzIu5nUH2d5NZiH3rU2NtuEXSfCYEtyAjdTH3t9gqPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PxzM4MGz; arc=none smtp.client-ip=91.218.175.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PxzM4MGz"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E7RbFhHLJt+DOrkD7WYgzOURJt/v0VVzoD4303hHwYo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789495930; v=1; x=1790100730;
 b=PxzM4MGzjHjvvhO5mDwekHbqCR7bspr9IJuM+TqTu8M/HTF1CT6yu2Rk4xRp9KOmI7wO0zm5
 KtoNXqE/e5dWMlI3x5KgjuV3Y/TZlyv564uwwx5BZAdDiss2zv8FghPrFof/ULfdtMVsbNSc82J
 s0ofPH55dtXeIi0e5czFEjPg=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a5ce936d8455cf12;
	Tue, 15 Sep 2026 18:12:10 +0000
X-Mizu-Trace-ID: a5ce936d8455cf12
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH 1/3] HID: asus: document and harden the worker teardown
Date: Tue, 15 Sep 2026 18:11:58 +0000
Message-ID: <20260915181200.18086-2-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915181200.18086-1-denis.benato@linux.dev>
References: <20260915181200.18086-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asus_work() executes actions against the device: they send feature
reports with hid_hw_raw_request() and, for the Fn+F5 fan key fallback,
re-inject the raw report into the HID core with hid_report_raw_event().

For this reason the worker must be quiesced before hid_hw_stop(): after
the low level driver has stopped, the transport is gone (usbhid_stop()
frees the URBs and the I/O buffers) and re-injected reports would race
against the input devices being unregistered by hid_disconnect().

Make so that the teardown cannot race to a use-after-free: every site
queueing an action holds worker->lock across the .removed check, the
list insertion and schedule_work(), and asus_worker_stop() sets .removed
and drains the queue under that same lock before calling
cancel_work_sync(). An action that passed the check is caught by the
latter while any later attempt is discarded by asus_worker_schedule().

Closes: https://lore.kernel.org/all/20260908180032.34C2D1F00A3A@smtp.kernel.org/
Fixes: 47669bec44fe ("HID: asus: refactor the two workqueues and init sequence")
Assisted-by: zcode:glm-5.3-flash
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index bd46aba6622a..3a8b8b7e90f7 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -765,9 +765,14 @@ static void asus_work(struct work_struct *work)
 	struct asus_work_action *action = NULL;
 	unsigned long flags;
 
-	/* Save the action to be performed and clear the flag */
+	/*
+	 * Dequeue the next action, if any. Once teardown has begun .removed
+	 * is set and asus_worker_stop() drains the queue: leave the queued
+	 * actions alone, they are dropped instead of being executed against
+	 * a device that is being removed.
+	 */
 	spin_lock_irqsave(&worker->lock, flags);
-	if (!list_empty(&worker->actions)) {
+	if (!worker->removed && !list_empty(&worker->actions)) {
 		action = list_first_entry(&worker->actions,
 					  struct asus_work_action, node);
 		list_del(&action->node);
@@ -817,6 +822,25 @@ static int asus_worker_create(struct hid_device *hdev, struct asus_drvdata *drvd
 	return 0;
 }
 
+/**
+ * asus_worker_stop - quiesce the worker
+ * @worker: the worker to quiesce
+ *
+ * Once this function returns no more actions can be queued and no instance
+ * of asus_work() is running or pending.
+ *
+ * Callers must do this before hid_hw_stop(): actions are executed while the
+ * device is fully operational, since they send raw requests to it and, in
+ * the fan-key fallback path, re-inject raw reports into the HID core. After
+ * hid_hw_stop() the transport is gone (usbhid_stop() frees the URBs and the
+ * I/O buffers) and the input devices have been unregistered.
+ *
+ * The quiescing is race free because every site that queues an action holds
+ * worker->lock across the .removed check, the list insertion and
+ * schedule_work(): anything scheduled before .removed is set here is caught
+ * by the cancel_work_sync() below, anything after it is discarded by
+ * asus_worker_schedule().
+ */
 static void asus_worker_stop(struct asus_worker *worker)
 {
 	struct asus_work_action *action, *tmp;
-- 
2.47.3

