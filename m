Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791584;
	b=RVwWgcTlO0UgWP2+ULxh8Um24Gv98/I7oEZaEGEKk1ERZ8DzynkOqggEwKgGoW676sAl
	 373csr7JJ3P2nob9rOBLhxhq1owQ/waTh48NYwrAFxYtjRm+4WDpXtu60iCYcSgTByPVy
	 VyvBkk8CsjOGWThPV+rbNbEbDdhHvbzLfO2xMO053yCnwSrqcVKtsC3suGIyZyRgIlXIP
	 vs9K11LhWsnT2LVM537EyRbZMbXh3A868UWgdPfcgzfNlaTKqAE5E/k/p9kKTbDDBD3YR
	 o39+GZq3lEvJgqb3C+Nolf5kzKYz3NZMalaVXm4Wr560Y2Y3tYSLxkVRJOkRIRoCetw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791584;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=G6nmI1esn6WqAJSqK9nbEywrguUGUjxMuFO6eoPSY8M=;
	b=wGqpj+jch03XrtST/pNN6qTUQQJN3pkCYyKEREtOdKSXdAPFG8Q++NaGKTwIN+5bLLG/
	 uZ+lFKjsjM2BKuPuii+ELdlfpBKxOSu+/Gdfp/eYOaMT3HcPSPsy7ffjlGg2/L2bvtS6x
	 5+F8EdgYGXQSNOUINsjWZxUWBL5nPNxXJWIs72fNAaFl2FJ7cLoLyEhO4QC5qDlmYKxvq
	 7h+vtIzG+IH671syD+M/Y2Yh5/QBnxguH0yItNaSi0PWCMM3SH8S2N9Yw//a2n9Rc9xAr
	 OAiFoyVnCptW3MO69ETOp01XE+xoDTjwSZDZRUdw4IK+BxW+fxNc9nJRs9nA9K22bRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gkpHhWs0;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A81606A324;
	Fri, 27 Nov 2026 14:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A81606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gkpHhWs0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=G6nmI1esn6WqAJSqK9nbEywrguUGUjxMuFO6eoPSY8M=; b=gkpHhWs0345lL9cnCvsvh+NGhr
	+cYhoS8w4c1fny47+tRChotXt1hKWA5laRsE5vhmPBTT0qdCRcpzUXnUbt7muV454CzWFxCzEQ2nr
	lGRBNTD4d4ywianWEl2dQvmJm45Swyo7RNu1CGv5rtaec6JGdf3wc0xCn1kFyt7moHQ9mPZ/wRL6T
	k7A+7dPqOq783BcVrNCWfsb7vzniUt7cTcvZLGCC+5/8la/wNY/aNx5ZUShBPp0Iglmxyw+PrJ/7c
	28wsvq7ZxOx+KwdIRzMcQuDXkqco4B6pVkl2gQqG8MsS/n9geyakhW4jXJkotyJXZo3JypHqBTbKR
	IMrAqo/w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWxQI-008Q0A-2Z;
	Fri, 27 Nov 2026 14:59:39 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] HID: intel-thc-hid: intel-thc: keep TxDMA write errors
Date: Fri, 27 Nov 2026 22:59:17 +0800
Message-ID: <a988216047e315de2d3550ff112c8458091e8402.1795791500.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795791500.git.emfox@debian.org>
References: <cover.1795791500.git.emfox@debian.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: emfox

thc_dma_write() reports success after a timeout: the cleanup at the end
overwrites the error with the result of thc_interrupt_quiesce(), so a
frame that never left the device is taken as sent.

That wait also ends on a signal, and the no-completion branch folds the
result into -ETIMEDOUT. There is nothing to restart here: the frame is
already in the engine, so a restarted write() would hand the same report
to the controller twice. Wait without interruption, the window is one
second, and report a failing interrupt restore instead of dropping it.

The completion interrupt wakes the queue with wake_up_interruptible(),
whose mask does not intersect TASK_UNINTERRUPTIBLE: a completion that
arrives after the task sleeps is dropped, and the write waits out its
timer with the bus lock held. Wake all waiters instead.

Fixes: a688404b2e20 ("HID: intel-thc-hid: intel-thc: Add THC DMA interfaces")
Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c | 2 +-
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 7b4a58e14..75b63a3b9 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -990,7 +990,7 @@ int thc_interrupt_handler(struct thc_device *dev)
 			     THC_M_PRT_WRITE_INT_STS_OFFSET, write_sts);
 
 		dev->write_done = true;
-		wake_up_interruptible(&dev->write_complete_wait);
+		wake_up(&dev->write_complete_wait);
 
 		interrupt_type |= BIT(THC_TXDMA_INT);
 	}
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index ff5d145b4..3093524f3 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -1110,8 +1110,9 @@ int thc_dma_write(struct thc_device *dev, void *buffer, size_t buf_len)
 
 	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_TXDMA]);
 
-	ret = wait_event_interruptible_timeout(dev->write_complete_wait, dev->write_done, 1 * HZ);
-	if (ret <= 0 || !dev->write_done) {
+	ret = wait_event_timeout(dev->write_complete_wait,
+				 dev->write_done, 1 * HZ);
+	if (!ret || !dev->write_done) {
 		dev_err_once(dev->dev, "timeout for waiting TxDMA completion\n");
 		ret = -ETIMEDOUT;
 		goto end;
@@ -1124,8 +1125,8 @@ int thc_dma_write(struct thc_device *dev, void *buffer, size_t buf_len)
 end:
 	mutex_unlock(&dev->thc_bus_lock);
 
-	if (restore_interrupts)
-		ret = thc_interrupt_quiesce(dev, false);
+	if (restore_interrupts && thc_interrupt_quiesce(dev, false))
+		dev_err(dev->dev, "failed to restore interrupts after TxDMA write\n");
 
 	return ret;
 }
