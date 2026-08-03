Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA629AAFA
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718340; cv=none; b=D9vpwim5osaOmihBGy3f+iuAJriJGjYVoYcyYqry6MKGNw4cyybzXJVIpFBo6tGMVMfExHSbeW5QvkBMzvnFAR4WlAHLE5I1mhWA7/4OwvRWHehCS62y7HLjuMCT0nlAFEEutO6XPX/MgY9P48lnYY6ohvAQmF5PRtVLs2inegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718340; c=relaxed/simple;
	bh=0c3OZv8IM2ygn2JtwUJREa5OWqE9kU+FUwZHGRlNvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0aFNySPzlNSUla2WF1VPuL+DN96Snjzt4Mc1JIrjZrUrMdy+jrXjvZx1nkc3k3ZN84uuNdPg/9OZYizBk6np9mEdOYr/lbJn3Jhjw0etWGMGRVeqnoqpEguzAKcGsY6+bjsFwM5U++OKww6tKdahQM4oANBRec9le8bYGervj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlwt4Qjy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlwt4Qjy"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso2356880a91.1
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785718338; x=1786323138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0CuQtvjIY+0K/5xye0ASJPCsWfTWQPYv1Q/SePREztQ=;
        b=Nlwt4QjyCrB2a0dVkaEcregrbRyO1DuNbmYgUWfSWgtH/O5E2kgLgsoz8vFga8xM7I
         eGphQpXrlr5xvcEm02lDh5spAJSlmsvZCckXTh/ovYXdSVVgxZKi89JtUxhMPOtME38j
         ziJIf1eip4sVfCzWQM3XY/x3lY6UArh+8QSKI7QtBw6ktYerKXNFQHt401lYbka13TpY
         I6U0ekqZH7UB/lXjYh1bMIl4aog6kRGOsxSA4VJmGfJjQ51PA/hkEfPg1T+Cnxnfjx70
         XlB1j3ebfMigSelhQ5+rZ+OGw6gQ8eGc3OfQIvm7FyD3jjTToHRtMgQDfNg2bM6DdaAp
         +Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785718338; x=1786323138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0CuQtvjIY+0K/5xye0ASJPCsWfTWQPYv1Q/SePREztQ=;
        b=OtawYuV460PaRn7Q4eW8IqUHvWGfLOioBlt4YJkeQMqZVV/FsjR68FSozfVpVfSQy7
         uMCQCUsQl+spwVfNb+s3GvsAY7klkLYVk39e2kuRcmllRyYMRLwmpnvdyuzCAcz7+0pZ
         nDIKgN3GzO+8vatcBqgyUdu02ijZPHph8Qe4TUQ4efuABWsGtxsIpzl3UbtmEokqILAM
         dBBQ0NtOQohCVLDIQ+aCwkXEqKfMAncptr6CcXq8lz7Kkz6VHhvk7pIXaScR/VsvGam4
         rXbRm5hW6qe1/cMhhlkUKK4G86IReoefZPze7kPc7hiG9oqhsWK/iUftuax+w5h0cs1I
         dIhg==
X-Gm-Message-State: AOJu0Yw2beuQDnn+QFA7qF6SQkCnJz/Yj4JE+BOBCBhfCcmsKaxchbI3
	ahcAzNM5YB6CNh9LX6PHWumfR1rbN6mf4HLRHvpAQQhaDDGUi61gRfd7HEOI1g==
X-Gm-Gg: AR+sD11DaO1V1Gf4EKpoX3s/v0tl8Jpcd+fPzkD2aSi+XNOxBVRIkQ3VopiHBn7Qen9
	2kNQYUPGwied0QvQ7Yl2WkSPmdHGTDjtTVUOSW9JUbaJBnjQvOdEH7sr3LTjShPdrGgyDBobWOR
	IGFC49aCZWZl0Np2hi9iCLw4Sq3VHTsoP56ANOZq/pAmyC9YX5A/ICxKKjr69d1JQhVUcVSRvfx
	SWK0WOrIfQ3Z3tTqGuSV/75vICeWOTwqkRFfuJHjG3UoLN4rg7nSZrcNGLaIprFBKhXOdKl4Ad/
	K2F9vfc3i7yhHR7g+/4eK5fn9i2Vo3v8PggAwSerCQpvFKjBHbWSjf4jt0VveY1e1OgH1xCCgJY
	ZeGWQL4KxCguWvvuUtXh1nzRlv8fiyZGHLT9Ercj/z8EIaHWDoeOhoazLfseIgyrEH60tdsYRmL
	1UM6g5IQi+LBnj7E7P2zHzaqakJR79aF8D96ivvcswWpEbPMQTacZxvaJqib66c4zKRaSqRGCcF
	VGX9UQHTlCb+tvxpkNBAE7m+IVwm5brgcK3UKA9tnuYVswwPiTMnWDyTH2W0h0e
X-Received: by 2002:a17:90b:520d:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38fb2409b7dmr9693434a91.3.1785718338316;
        Sun, 02 Aug 2026 17:52:18 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4d10bbsm24374079c88.11.2026.08.02.17.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:52:17 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] Input: defer handler's start() until device is opened
Date: Sun,  2 Aug 2026 17:52:04 -0700
Message-ID: <20260803005210.1251102-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
References: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
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
 drivers/input/input.c | 55 ++++++++++++++++++++++++-------------------
 include/linux/input.h |  5 ++--
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 47886a394c6b..c9f480629099 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -610,6 +610,33 @@ static void input_dev_toggle(struct input_dev *dev, bool activate)
 	}
 }
 
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
+		scoped_guard(spinlock_irq, &dev->event_lock) {
+			dev->ready = true;
+			input_dev_toggle(dev, true);
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
@@ -628,21 +655,9 @@ int input_open_device(struct input_handle *handle)
 
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
@@ -653,13 +668,8 @@ int input_open_device(struct input_handle *handle)
 			}
 		}
 
-		scoped_guard(spinlock_irq, &dev->event_lock) {
-			dev->ready = true;
-			input_dev_toggle(dev, true);
-		}
-
-		if (dev->poller)
-			input_dev_poller_start(dev->poller);
+		if (handle->open == 1 && handle->handler->start)
+			handle->handler->start(handle);
 	}
 
 	return 0;
@@ -2692,9 +2702,6 @@ int input_register_handle(struct input_handle *handle)
 	 */
 	list_add_tail_rcu(&handle->h_node, &handler->h_list);
 
-	if (handler->start)
-		handler->start(handle);
-
 	return 0;
 }
 EXPORT_SYMBOL(input_register_handle);
diff --git a/include/linux/input.h b/include/linux/input.h
index f147d27e6d1d..0ee5f32de08a 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -288,8 +288,9 @@ struct input_handle;
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
2.55.0.508.g3f0d502094-goog

