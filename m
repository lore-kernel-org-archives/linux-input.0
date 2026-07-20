Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC443E483
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564557; cv=none; b=XHEbUblRq/Tlfa0jYPKVTHQSZfwcqLWsjS32nR0sv09ml8jmGxrO8YaXjcU6QvtIJYRuPdn6r8Q5VaQmEKDaLu8UvWhv4+DxYkzXpm+X3fSLtM2IFfoMlbEYaZsCShYwDDWv1TVYRKzcoE23dbZr8RWVH0bVyVWTBvRmK8eohrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564557; c=relaxed/simple;
	bh=zy4q27u28EugEL37kMmqTNjOTMm3mvjNDOjY1JWr3Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xhjit3yichxKEm7xMrMHwqh+KCHpsJau1yhDLiEhakG6KMOHyyXXrLMDo8EBBj3cQO9n2ThBst8WlQL0Q/7PiN/2x5XqciF8LqR42kP13gq9b1Khnzvm1bXB555BRruL5FY22MLwLGXRecxoFM6bQhf+Dv7yTyiyq/2n3ZxSG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e041ea211so8163080a91.0
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564548; x=1785169348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/cxff2lJvCCxKqfkd39UqOApEAlOgurgz84vO2zlLo=;
        b=HKcg/wqB2Wi/VDdI94Ckw1bc7TbDyxbnyOz+tl9vXdoJeoCEzJ0ssaywk7Fh8QCpg5
         ysdQS80m+ObpdIX5e4tnjvnwZPz9czhru5BIdx+2I4rIor3IL/nx+W3KFxu1r/Gqi3t0
         Fpp2WyV5jPcpkC/zMe9yzgCWZmfVHz4+IAXyvh64S5p4TfX0gN/DlSFC6x3cWDCDz1IA
         AOu8jaSDMRXySxbBt66//TkGG8uowr6nze2Rgbl2Ni15QUA2Jlm1J3TEFi57p9N6s8CM
         cEH2fWsVuRRpvcWo3FqwqRiwEjYdMmmwA0wKu4cfzG5sAnN6Om3lMhghHtEod45sYYFa
         Ywvw==
X-Forwarded-Encrypted: i=1; AHgh+Rpb/CHkAy+YoFN8ta05uXLtuGPg/m33PbOH3S82LjzsigV2ptgZ/RnZdQSP5IMOMfanc1/tmH2qK4FrnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+5/wgMpED/Bm+pA46Uw3b3EhjM99KNtuMzxoOqlIx0JW00Qy
	mG+IUglPyn3pvyiddK5BJhXuH3UrC4+kHfIpq2FEHOr2r/I62ZWziD8=
X-Gm-Gg: AR+sD10h8rpR0b8YHmH6m+aFWv0NCYH9VAygfe6bT9t37sip8yZaK/m4yB7GiprbuIN
	eR6P44te4G7oLF2Mh0/av7/dYjADutLXmpCJ+1sHLUJCsRk2+2CQFsBAToYeSRzbUTF4ihqSD22
	MddfZIrUE5UWXQWlOb/atHdqExg2KBb/IvqtYDkxTOCCv6ewgrmbHZtoRjaeCbfcO3tRglobdy1
	4/f6zuKKsVh4A8oSIzjNNmSGoEiQjDJSvaXRFaOMiZbfKJLm6wyPpjaK1IHYw3KNkKoJbsVi3d6
	2YeIPO0Lugnm9giCTUpIvwVMiafPWZbojZg/ItZxPidXXkbR3v0qqXiH1YJ5EzyN6psZApHtUfZ
	0rb53ge6lHLTgUfs2//xMqyVTNTffrNBrFTBd3ARAx66lyK+pw/GdnAibRDefJqOF2puJpNaNvx
	7r1hnqPpZvmR8FrmPSCoHBd9C8OIad+D+Px6dMU47lVn49YbKx/fp9/p4Yer3pJF3yigY+4RWub
	v4zF7LmbyHiyUGxrg==
X-Received: by 2002:a17:90b:1d0b:b0:38e:76f8:fcb1 with SMTP id 98e67ed59e1d1-38e76f91c4bmr6456556a91.32.1784564547618;
        Mon, 20 Jul 2026 09:22:27 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9205d358sm29366a91.3.2026.07.20.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:22:27 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 2/5] Input: applespi - track asynchronous SPI transfers in flight
Date: Tue, 21 Jul 2026 00:22:16 +0800
Message-Id: <20260720162219.32324-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162219.32324-1-fourdollars@debian.org>
References: <20260720162219.32324-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver queues read and write packets asynchronously. When shutting
down, removing, or suspending, the driver must guarantee that no
asynchronous transfers remain in flight to prevent memory corruption or
use-after-free conditions.

Introduce a 'spi_complete' slot tracking array in struct applespi_data
to represent the two concurrent transfers (one for reads, one for
writes). Implement applespi_async_outstanding() and
applespi_async_complete() to track transfers under cmd_msg_lock.

Set applespi->cancel_spi = true during drain operations to reject new
asynchronous transfer requests with -ESHUTDOWN and activate completion
tracking.

In applespi_async_complete(), invoke the inner completion callback BEFORE
clearing the tracking slot and waking waiters on wait_queue. This ensures
that teardown threads waiting for in-flight transfers to drain cannot wake up
and free the driver structure before the completion callback finishes execution,
preventing use-after-free conditions.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 75 +++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index c501bf7e517e..c9bbceaf0671 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -421,6 +421,12 @@ struct applespi_data {
 	bool				read_active;
 	bool				write_active;
 
+	struct applespi_complete_info {
+		void				(*complete)(void *context);
+		struct applespi_data		*applespi;
+	}				spi_complete[2];
+	bool				cancel_spi;
+
 	struct work_struct		work;
 	struct touchpad_info_protocol	rcvd_tp_info;
 
@@ -607,13 +613,73 @@ static void applespi_setup_write_txfrs(struct applespi_data *applespi)
 	spi_message_add_tail(st_t, msg);
 }
 
+static bool applespi_async_outstanding(struct applespi_data *applespi)
+{
+	return applespi->spi_complete[0].complete ||
+	       applespi->spi_complete[1].complete;
+}
+
+static void applespi_async_complete(void *context)
+{
+	struct applespi_complete_info *info = context;
+	struct applespi_data *applespi = info->applespi;
+	void (*complete)(void *context);
+	unsigned long flags;
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+	complete = info->complete;
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+
+	if (complete)
+		complete(applespi);
+
+	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
+	info->complete = NULL;
+
+	if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
+		wake_up_all(&applespi->wait_queue);
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+}
+
 static int applespi_async(struct applespi_data *applespi,
 			  struct spi_message *message, void (*complete)(void *))
 {
-	message->complete = complete;
-	message->context = applespi;
+	struct applespi_complete_info *info;
+	int sts;
+
+	assert_spin_locked(&applespi->cmd_msg_lock);
+
+	if (applespi->cancel_spi) {
+		if (!applespi_async_outstanding(applespi))
+			wake_up_all(&applespi->wait_queue);
+		return -ESHUTDOWN;
+	}
+
+	/*
+	 * There can only be at most 2 spi requests in flight, one for "reads"
+	 * and one for "writes".
+	 */
+	if (!applespi->spi_complete[0].complete)
+		info = &applespi->spi_complete[0];
+	else if (!applespi->spi_complete[1].complete)
+		info = &applespi->spi_complete[1];
+	else {
+		dev_warn(&applespi->spi->dev, "Both SPI async slots in use\n");
+		return -EBUSY;
+	}
+
+	info->complete = complete;
+	info->applespi = applespi;
 
-	return spi_async(applespi->spi, message);
+	message->complete = applespi_async_complete;
+	message->context = info;
+
+	sts = spi_async(applespi->spi, message);
+	if (sts)
+		info->complete = NULL;
+
+	return sts;
 }
 
 static inline bool applespi_check_write_status(struct applespi_data *applespi,
@@ -1799,6 +1865,7 @@ static void applespi_drain_writes(struct applespi_data *applespi)
 	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 
 	applespi->drain = true;
+	applespi->cancel_spi = true;
 	ret = wait_event_lock_irq_timeout(applespi->wait_queue,
 					  !applespi->write_active,
 					  applespi->cmd_msg_lock,
@@ -1821,6 +1888,8 @@ static void applespi_drain_reads(struct applespi_data *applespi)
 
 	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
 
+	applespi->cancel_spi = true;
+
 	ret = wait_event_lock_irq_timeout(applespi->wait_queue,
 					  !applespi->read_active,
 					  applespi->cmd_msg_lock,
-- 
2.39.5

