Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979932;
	b=nQ2/9kf86RL8SIwYAAp8uzObTkikub/FbZLSI7zlO997h7Lqy+mDwAeOnLbPfPkvEdcl
	 M1Ch6GnAQE17SR/vAAHCeLHzvq7I+f/9HOlzZUnprZ731PsBepkHNTZLn5VjMx2yPrgMd
	 wdmgoNHfmwrHEVMT1R3lQMm18E2YhIrWSUkXsh2TMYaU3QLtDhMA4dM2igApnEb7WPZ9d
	 0+FvSjffVE9pxt/XAkXRXsKLCc0EImclvML199AEJpka2qMZQIPXHtfamCHl3+ym3Q+Lp
	 BCchXqUOGano2i5VhlnWOr641k7/fwCm7sPdMPboEdbtXqGpiY5LZFIF3rZWzIk/vmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979932;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=F1abZW9KdHqAJb6r2vfcjqGF17wKq2fQTvN2iS747O0=;
	b=or+aeSk9JMC7v27ZYHWKR3kv8OAIDlvciESWRIL54IsvYm7rbV9hpex0lGGDo2BFNexN
	 VbhJ0k7ML5hDgFWTkZmkhk2Ng52sdnytF7Hyc2P04eiA0ANnFjY9k6E3K7iDuCoeXg7aG
	 9qY/sh/SLCtRIl3M98qXKpy18jSMQXMAq2swFV+rz5UVn0+H15S/R5wrEcymHd/pTpSU6
	 m3RfbQB7Xgi1xmKZKqLe9l2CJU9aEz/NqIbWBsd390lOQuvN44Aw6TcNYTPlJ2DUUQEaF
	 c2Bld6PBtT4QTV1H4qJo6YoX7DThpQ0/+TqXwA8RqDnlZbBOtDgFNCfQ3cO1hmiNlww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=lPdrJfnS;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BE606A339;
	Wed, 18 Nov 2026 05:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 444BE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=lPdrJfnS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=F1abZW9KdHqAJb6r2vfcjqGF17wKq2fQTvN2iS747O0=; b=lPdrJfnSz8XLqJpXPoxkUmzSap
	kc41m07HY+IbN61ntZzfa/rJTZtCbtlyWT7OQuyDItYvtO9cHUEv33z8QgGoj0krbVJNB9ETYeDk1
	9/80Ax1AI7fxiqat4APeCaX9TOHCZa+YSPN5bD5/v9Oa5j6QN7Ajj9OSd6KBMjWwgTBbnxk0lXhY0
	cLuk3jgiggMjieMrwWWvOmwlpfBhdGRO7UNsXkmVR8H5/wuenYAb4Do0axT1UrRKpE7+c+4clNjw4
	By+EHktVjosddLv70idZ7TD/4uWofHh47HLmJL6WI6/QWtFu/S7G/qvyNt5YX6TgZ6q6aNRSdqhSR
	XgAAn93g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYH4-00151W-07;
	Wed, 18 Nov 2026 05:32:02 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] HID: intel-thc-hid: intel-thc: keep TxDMA write errors
Date: Wed, 18 Nov 2026 13:31:28 +0800
Message-ID: <20261118053132.253448-2-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118053132.253448-1-emfox@debian.org>
References: <20261118053132.253448-1-emfox@debian.org>
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
index 7feda4160..7429f851c 100644
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
index c80ef8c20..c0dc44e26 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -1045,8 +1045,9 @@ int thc_dma_write(struct thc_device *dev, void *buffer, size_t buf_len)
 
 	dma_set_start_bit(dev, &dev->dma_ctx->dma_config[THC_TXDMA]);
 
-	ret = wait_event_interruptible_timeout(dev->write_complete_wait, dev->write_done, 1 * HZ);
-	if (ret <= 0 || !dev->write_done) {
+	ret = wait_event_timeout(dev->write_complete_wait,
+				 dev->write_done, 1 * HZ);
+	if (!ret || !dev->write_done) {
 		dev_err_once(dev->dev, "timeout for waiting TxDMA completion\n");
 		ret = -ETIMEDOUT;
 		goto end;
@@ -1059,8 +1060,8 @@ int thc_dma_write(struct thc_device *dev, void *buffer, size_t buf_len)
 end:
 	mutex_unlock(&dev->thc_bus_lock);
 
-	if (restore_interrupts)
-		ret = thc_interrupt_quiesce(dev, false);
+	if (restore_interrupts && thc_interrupt_quiesce(dev, false))
+		dev_err(dev->dev, "failed to restore interrupts after TxDMA write\n");
 
 	return ret;
 }
