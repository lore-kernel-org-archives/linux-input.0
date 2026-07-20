Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF293DB303
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542496; cv=none; b=Amg0J1xkSYGozv4Cvnmu2X4rqAdYjtcoIr/g+eVMt/WVMDEMPZdrr98auWl37KPDZ7bQRXuihzsuQk/qKwLkyBWL79yzMGuVdbCItA0/0zXFv71/f7Of1GBeBdfOsi+LxSrjMVkA1PvvVZkGVRls968BjeQsQgkcSLNYK3v+vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542496; c=relaxed/simple;
	bh=0aiI1f6vHsTeiGWLu/hog9EOHsxEKlYzD2ZIFajrF80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTf1fbyqoYy06vh/p2LL6OhxpegzoNWRVucMSg0BT6nkd8bbRPkxJPx8mv40T34rtkeH1/arDguRq+vcQKIEJm1zqKj9MEhcqvkM5XwNkIVNz0EUzkWe/sZyo1S/1tvmD//kLUzZIGHKXPTXLViPulf6/0zYYz8FdgY/fibDskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc891373e0so121244475ad.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542485; x=1785147285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+KR23a5utjuBAUGcUFKPLl7/miZdWqDcdDLPWy8Jfvk=;
        b=HJd2CsjVSBwwpKDu+QAx67zRPNrJ/IxBynDt85oUm/XrWLnouzJuQL1kj3uHg8GFfT
         65V4azJRcjqNIOWm/VDub+oNseYQRmHhrSF0x4j0svaXZiQCj2OR4AzGiESgQuAWH+wd
         GwL7VSDSePm1IvoSOb8RhB07UEO3w6X7f4xU2W4kmFEXXabDjvwV7jIgGlVHv+Y1jVpR
         Isekv8aW6jV3r/1/0Dkr6gbg8oxHoTEeQjaH8rh+TwKHIzCZvuRzm0oUhRO6DoW/db22
         pgeQhFuzVQifNKtBBFjWf//dCf/i79CATs4PGziedE3hEXpgvyP1mDe9KOxljrpRLDZM
         XTaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtJ4NzZraCK/Zlu1mTni6D8RLRoq+UvDIqP5/PZw3OuJA3BH3pIygBWN19epMy8fFt4h8twfk3IzKQlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9jNZammoAFs7n2nxcJtCyPZLAxJDtwF8KptIwfF7R2mijTx5
	XyfC/YeFGQ3U8g+UwMT/CpQzrhj2W952lrazmo2fcuqju8HV2/7+rmU=
X-Gm-Gg: AfdE7cn75P/AzCIING63bU+Ymhnm8HVBhToBBOSAgUkaXKQGCdc52N49ZO2spbM0qJ8
	Ei5s/iSx5guCrRiLThkZutnOHhZscVDh1o+SQKL+6W2iXV+um2OU4Agaw6aUNMM/7F99iI1wfuj
	qHL4vAaqe1g2QMIDmlCpwLcMWckLCC6Kt27ZjWo0KLqsk9EZPmPs4vvOD52bi/jv72NptxvmgjO
	z+WoiEot6Wp7C0uKvTnIbHSP97pBNAQU76ggHA3JkJyikA4zb5phiMoBCZ4pNbne3MpKW/8jr+f
	pLUhYaHl4j21AEV5d1173ZLOrtPx8Nd/vtXZevvPoppnLVPDAZij+FIHgIfNPVJLVxWrUlopeBC
	zKY5Uhy4yHnpuPEUcaxI8UPoOkIYq+wUNOVv8xvKMeaWyO3kmmMWNtntUx/wbbuRaIfuUTxqFaq
	5TLjACg8oXwkwQdEc1N31NouaCcnLbhFlRPjlxGuUyfZs3jk38n3/jb23ucfGHK+dlORXnCFvns
	9/rsI4mPHSWPU7Wkg==
X-Received: by 2002:a05:6a20:244c:b0:3c3:7fff:ba77 with SMTP id adf61e73a8af0-3c3ad973f68mr13774806637.42.1784542484649;
        Mon, 20 Jul 2026 03:14:44 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f94c31sm4411321a12.13.2026.07.20.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:14:44 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 2/5] Input: applespi - track asynchronous SPI transfers in flight
Date: Mon, 20 Jul 2026 18:14:32 +0800
Message-Id: <20260720101435.13612-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720101435.13612-1-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
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

Modify applespi_async() to allocate a completion slot and assert that the
caller holds the required cmd_msg_lock. This ensures robust and lock-safe
tracking of all asynchronous SPI transactions.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 70 +++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 64bbeba85ea9..a8f8d5370e95 100644
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
 
@@ -607,13 +613,71 @@ static void applespi_setup_write_txfrs(struct applespi_data *applespi)
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
+
+	complete = info->complete;
+	info->complete = NULL;
+
+	if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
+		wake_up_all(&applespi->wait_queue);
+
+	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
+
+	if (complete)
+		complete(applespi);
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
+
+	message->complete = applespi_async_complete;
+	message->context = info;
+
+	sts = spi_async(applespi->spi, message);
+	if (sts)
+		info->complete = NULL;
 
-	return spi_async(applespi->spi, message);
+	return sts;
 }
 
 static inline bool applespi_check_write_status(struct applespi_data *applespi,
-- 
2.39.5

