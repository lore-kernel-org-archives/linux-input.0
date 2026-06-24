Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079132570D
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280217; cv=none; b=r8LBTLnaQRN65dtM5Lc/jPsrVeaMnBEUunO96+v4Ia5Iz4wxzMmSRLOSg/0NA9NB1BjNz1GIQfegLCri1EwR6N13gXxJrnCVFR745moa6xHhIJlGxIMCvlQBzkb9Exf+jUaJHmY4xZF5A8nEE9IRVHsuWq6LEkV5FordvJzvhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280217; c=relaxed/simple;
	bh=TwiVGZE/cuOmWdJJ140dlIbrb3T4IAV5EW0SjxJneQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjKxuyB/G34okm8TnkGER98DDWVgrXUH7wwZvIYrmvszfz9tJCX3VsxL36gRZO8AjHfjSXvaVykAHdqVhpvG5NJ8sNgaLjI2yFafTOy/7WrMUJFSmVnVc239mG86926nmaW8CnzSTw75vLquUz05HcjIkG2NUC4+XzwMdA2+S8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaVw5Ps8; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaVw5Ps8"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so1121074eec.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 22:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782280215; x=1782885015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Mp2tjlqoqiSzDWEvjpQJpeD9swQKcxQhwmEs2BGYOM=;
        b=ZaVw5Ps8KlXsEv7kyu+YwAmOEgUPc1fcEnuHnuib+wzKvHccdvg44zCJums7FABzd6
         zd4vSmW8k/JJ/x+dL4U75NgHGVEkTr39om1nJdCHAAKgOtPT4GgTrcFz4iHKY1AsReVF
         OG499ISseuD875no3COYjW2ksW2daFd5inRZa+P37LPUCjaJtSJLtyReTZofV3rkIRGU
         XDCaUPBUNzcDS3x3LXhYw6nDLFB0rxVm07jTJzNs9irEbaOBySUZ7ZKWgwjpcIctl6Sg
         divKpOjWy0hO8KanVkDmhIkLqmf4I2qS+O0SCRGqQZ6t3sWmtRdOam2QwOLpxRguU9JF
         lA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782280215; x=1782885015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Mp2tjlqoqiSzDWEvjpQJpeD9swQKcxQhwmEs2BGYOM=;
        b=qFzGWbawQMLfqgXhQrsMciRETgjqLv1RbCKd8aYYEhyoATxcESNXd8cWrRsW5EmkFP
         q9NEwejaN9PtcwZcgOj0S6CQm+KHYeQYY1zUvBzkYn8uBI/LNAw+NJnolsNVr/KmFuxF
         jYYFZ+tdC3+Mb7LtyAQuZYx0Ar07SVRfHb+eyeVGQtCPyDmOb2c1jYWjny6FPNw/JWc8
         nGXKLxl5kBBMFUl1dc+zDscqTiekjER1/rruOMSMT/9gh9L8gqFnvWREVnn5p3Ww650c
         /+0c5hzvckSO7QsvLZSj7/RFR8g2CYIgZH48HoeGEO3YkmjoLtJl+WIBC7MCtFSvAKNx
         nhMg==
X-Gm-Message-State: AOJu0YxVH5MLNg6s0QhLtXup9/N7+rA3eikwu24t+Vr7qcdCEWgJAnA7
	T3Bobs+sjXmCtxi0o+X0L6BwOl5S3nEo6il3jeJqGSwTdJKavRZeWT3yIh8vRg==
X-Gm-Gg: AfdE7cm4mMUwg4l+gqn9VtWeBf1R3gE7R9so3B7ptRhrKE6VDztfX8LhHK/NC5TNbsE
	2ATeZDEEL0ETqleCZ88ulnfVSxiLsKST3nW+LlCuW8RcoA6W3Iwj5zEN5wM6VFYEX4TW7jaPzek
	TzavGpv8fUd8AtH9iavLZb1o57km/3qtN+s0cP8ZjZTtEd4qwlUr1VDBpjdPofqiC1klqv5PlgE
	dkqZi8ChuA3AzSYUDcgtrehhGQV+hD51GxY5NPpLWgT4jAP0fKWj3Sq1GGW4QqRnNUMBftJOIV2
	98NNbS4KVoirxbUC6H4OXa83AjDuM0It9sPCNCg261edkQdCXOzhQwoCN9+1Sm7XREecjGLSTsX
	/uoYvveg3yFd0hXtFya21epXllkEwc9xaXy5hr/VzZtIPJ3zjctMIG7jj6qg4aKfNPjdZUdI6pB
	d0bggQiW7qUAkAIGSBHPfKwwp5Mz4kPyEr5O8qdva3kerCCh31hPbLXWAyea5rv02VUzmT4AJ0Z
	4jo
X-Received: by 2002:a05:7300:3242:b0:2be:833c:149d with SMTP id 5a478bee46e88-30c58cde733mr5020377eec.28.1782280215291;
        Tue, 23 Jun 2026 22:50:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:6026:1e6d:4a80:9bd0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c430553d1sm14073419eec.11.2026.06.23.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 22:50:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Input: defer handler's start() until device is opened
Date: Tue, 23 Jun 2026 22:50:06 -0700
Message-ID: <20260624055008.2494980-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
References: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When registering an input handle, handler->start() is currently called
immediately. However, the input device might not be fully opened or
ready to process events at this stage, meaning any state synchronization
events (like setting LED states) injected by the handler's start method
might be dropped.

Move the handler->start() invocation to input_open_device(). If it is
the first handle opening the device, start() is called after the driver's
open() method has successfully completed and the device is fully prepared.

To facilitate this, factor out the device startup logic (calling driver's
open and starting polling) into input_start_device().

For passive observer handlers, their start() method is also deferred
until the handle is opened. Since opening a passive observer handle does
not start the underlying hardware device, their start() method is called
immediately upon opening, regardless of whether the device is active.

Fixes: c7e8dc6ee6d5 ("Input: add start() method to input handlers")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 45 +++++++++++++++++++++++++------------------
 include/linux/input.h |  5 +++--
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c2a038d31beb..0a95cbdc467e 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -568,6 +568,28 @@ void input_release_device(struct input_handle *handle)
 }
 EXPORT_SYMBOL(input_release_device);
 
+static int input_start_device(struct input_dev *dev)
+{
+	int error;
+
+	lockdep_assert_held(&dev->mutex);
+
+	if (dev->users++ == 0 && !dev->inhibited) {
+		if (dev->open) {
+			error = dev->open(dev);
+			if (error) {
+				dev->users--;
+				return error;
+			}
+		}
+
+		if (dev->poller)
+			input_dev_poller_start(dev->poller);
+	}
+
+	return 0;
+}
+
 /**
  * input_open_device - open input device
  * @handle: handle through which device is being accessed
@@ -586,21 +608,9 @@ int input_open_device(struct input_handle *handle)
 
 		handle->open++;
 
-		if (handle->handler->passive_observer)
-			return 0;
-
-		if (dev->users++ || dev->inhibited) {
-			/*
-			 * Device is already opened and/or inhibited,
-			 * so we can exit immediately and report success.
-			 */
-			return 0;
-		}
-
-		if (dev->open) {
-			error = dev->open(dev);
+		if (!handle->handler->passive_observer) {
+			error = input_start_device(dev);
 			if (error) {
-				dev->users--;
 				handle->open--;
 				/*
 				 * Make sure we are not delivering any more
@@ -611,8 +621,8 @@ int input_open_device(struct input_handle *handle)
 			}
 		}
 
-		if (dev->poller)
-			input_dev_poller_start(dev->poller);
+		if (handle->open == 1 && handle->handler->start)
+			handle->handler->start(handle);
 	}
 
 	return 0;
@@ -2662,9 +2672,6 @@ int input_register_handle(struct input_handle *handle)
 	 */
 	list_add_tail_rcu(&handle->h_node, &handler->h_list);
 
-	if (handler->start)
-		handler->start(handle);
-
 	return 0;
 }
 EXPORT_SYMBOL(input_register_handle);
diff --git a/include/linux/input.h b/include/linux/input.h
index 3022bb730898..f7a2cfad5448 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -284,8 +284,9 @@ struct input_handle;
  * @connect: called when attaching a handler to an input device
  * @disconnect: disconnects a handler from input device
  * @start: starts handler for given handle. This function is called by
- *	input core right after connect() method and also when a process
- *	that "grabbed" a device releases it
+ *	input core when device is open and ready to process events,
+ *	and also when device is uninhibited or when a process that "grabbed"
+ *	a device releases it
  * @passive_observer: set to %true by drivers only interested in observing
  *	data stream from devices if there are other users present. Such
  *	drivers will not result in starting underlying hardware device
-- 
2.55.0.rc0.799.gd6f94ed593-goog

