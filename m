Received: from mta0.migadu.com (out-73.mta0.migadu.com [91.218.175.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73F4D489C
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546578; cv=none; b=kTHa5PSWdeOo2w/M5DugMYWm2DOHZhcYCAw2eZHo3xiFbKTG8qHMtxgUUXExL2TcUrqw/HIcbGL4fcdV6wf6zBT/jTl6QqNDTB51i1W6gJRjhz/SZoJob/FGM4pG49Fb9HGvsOdu/QUaOHQoEZV7Tx38AFirWPwYM5rCd3v2Gn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546578; c=relaxed/simple;
	bh=E7RbFhHLJt+DOrkD7WYgzOURJt/v0VVzoD4303hHwYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9rcp/XhaDFhtudplQbrccG7II6nUc2tLGgYa/oSJwLABEBjd+IBDPbIiIs14FDot08I6RzimDSdKdDQeYkZMPqp6GDcr7pFc+M8BftDfxfYDppHwodJ+fXxoxxvRN7f60iDcbwa2dIvGxxxBWQiWW/X44gTAOdHO4Uk1fG/W0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jaamszii; arc=none smtp.client-ip=91.218.175.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jaamszii"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E7RbFhHLJt+DOrkD7WYgzOURJt/v0VVzoD4303hHwYo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791546568; v=1; x=1792151368;
 b=jaamsziigbBwMorjHYWpZ58AVWdI227HEEes9CnUoquozPJ+jUndn/XuX0hXHGXUVskyyY31
 RKEp0tuk2ZTk9kd6DcQ6OxmnKuQBQfVB5AeSo93aH4pk0/2fYLntWkRq3XxhzN73092WEnI9lcW
 FPlhmu1NuY+i6GRtYstWtcUw=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8eab7a79cf940fd4;
	Fri, 09 Oct 2026 11:49:28 +0000
X-Mizu-Trace-ID: 8eab7a79cf940fd4
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
Subject: [PATCH v2 1/3] HID: asus: document and harden the worker teardown
Date: Fri,  9 Oct 2026 11:49:19 +0000
Message-ID: <20261009114921.5242-2-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009114921.5242-1-denis.benato@linux.dev>
References: <20261009114921.5242-1-denis.benato@linux.dev>
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

