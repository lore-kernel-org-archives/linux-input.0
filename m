Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A086341
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280214; cv=none; b=Oqn1ZmhfwR6ni7WWHj1RtYZMDJfwmmbl9hC1zy87uVCrjVLzHtbr+bgcZoTNUNevkI2hdGSt6oU6u9OBpCGjly5YTqsVBW41Dy4KvAXSwPydHNJBajWelzIVAhSZBIUMpKM4yhunibzDi1e6CqXmcsWey2h1tQYfaTo0GBc4h9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280214; c=relaxed/simple;
	bh=CcE0Dudb2hSXk3MW3lbVX9y1nyCymX9IQ3oylOG0uAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkiSginGfYNI7kvby9oXLlpxtMPMRu6kHdkv9xm9XrM4Cgu+rEcwz0y9hNtkBiWm3ByjYS0z5DWPry9iAIQ24uDJTP/maqeA4gyQ2xpl25l+FYaSc073Fs+7BGpLoRACDHiE791AZAJsIwAvkObfKDmaMYtCQfEup1qAZ44osvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtKU6CNZ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtKU6CNZ"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c55adcf66so648018eec.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782280213; x=1782885013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLN0p0Yy0XlqcAwEHaNOA0OsCLj+6eIMg15TnW4L3IA=;
        b=rtKU6CNZpkMAdtURsaYQL2AkoKao+RzQEltBYts8DdnPPPA4mxN8x77Umuja1j/GT7
         7mA1b4NnkYU1WSrz+up9NRqd3/MVX2XWJLcMkkTOLzMciyKcQ8QEh12aF74JRCFoRZEW
         MOtfYkUlv1ON6gy1lrJ3a1KF2kbpplFLLa1VKRo7fwKGQaPRwZsD6bqPRgoTFoodI3/Y
         9b16Mha8mXsxS3QdyjWxkX6SXpIEXsuCT4lUEjEP+1MM/Q2F3mF8zaN+CJA8K0YEXMCH
         vI7OVU1DAsOJVLmUvc3/GCm+3P7YkMx+iOet469bY7q9sG+U8o6QIbCiAYvYnKFAMl0+
         9uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782280213; x=1782885013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLN0p0Yy0XlqcAwEHaNOA0OsCLj+6eIMg15TnW4L3IA=;
        b=IQF4O3pCOUAh7bX22xp9ESklMlkeTr40rISDZGUfpIC6D3t7kfQpHGx7Ugw6htrI2K
         EparRyDw6I3WUaoYOOCJIk9/9+aNp9dsALilEzj6IhIIVejlIhfGX30r9UUebnicPq6/
         24r3c/g4Ng1LfHYBuTuHD6bpdINavXeseEHwXgxwU1hgu0qVyZq6nVuTROHohqkiJ7LP
         VGTNK2iX0Wo1UEzTK2vbgrOxQH8KoEEi63SL28nCVK/xZyGzhQoMKmx7GSdSYsanzQvS
         A22fV8S6mvZgh9C89Dkcy3RtNAXvOyy9yzQWuE08t8j9iSwDyyncwJpK77wuitMqXY96
         isgg==
X-Gm-Message-State: AOJu0YxYiKAQXrxpwyl6aejSocqXbFGHOoFqACACLfQMm3EEGDUbEhPP
	CP3J8aEJR3CQXmNvTsAla7EJXQ83uFq4lWU4qBEZcZtvfhkafsmyU6IeYki6ag==
X-Gm-Gg: AfdE7cmfYanbzuS/VfPR6SDfDDzvUXLQlECZ6zAe5Xd8WhvUAblvo9BLwIMLYvuRKcS
	apomltZmFyDJs7pWe+/pZon+FXfoNs8uncfVO20puHZDJ4X1CHxAy6501yY6TUA6Fj35gV28q7x
	OU4U+iTTJMjtrDd66lqoWyERu5u20O21RILbTuILp7SpblcXWuX0zk5x4nQPeKaGTiIJrO90StH
	kjcmhJg6c4GKKAX/23LEr9kASNMzHlvfWLLBoJGchuU3JZGhimSBfuCDp9fb4in31YA8rj7aOeg
	9QxtKfLX4e3lVthM3SPtb/qys4vW9hoTzJeUWNBT3Jwp0f7isdjqVaH12qh4df6dKYDSJQQnjgK
	EinlsbAQoUvSm4ApgeTUT4lTBTb/OSp5mZg5PKu5heUHLFPDRhX3iiBXckzXM6VIqhRBm4LhSDQ
	GX+Z0ifW3wRiG5VjGiIt9iQ8U5MwiQhbo/F5JtotwleOB8ZLE2sbyw62UVMPDRXKF44n0eNDzhy
	79Y
X-Received: by 2002:a05:693c:638c:10b0:30c:6a50:3805 with SMTP id 5a478bee46e88-30c6a5039f6mr1070499eec.28.1782280212604;
        Tue, 23 Jun 2026 22:50:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:6026:1e6d:4a80:9bd0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c430553d1sm14073419eec.11.2026.06.23.22.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 22:50:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Input: fix poller start order on uninhibit
Date: Tue, 23 Jun 2026 22:50:04 -0700
Message-ID: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When uninhibiting a device, we start the poller before marking the
device as uninhibited (setting dev->inhibited = false). Since the
poller immediately polls the device and reports events via input_event(),
these initial events are dropped because dev->inhibited is still true.

Fix this by starting the poller only after the device is fully uninhibited
and its state is replayed.

Fixes: a181616487db ("Input: Add "inhibited" property")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cf6fecea79b8..d99dfe69e12d 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1793,8 +1793,6 @@ static int input_uninhibit_device(struct input_dev *dev)
 			if (error)
 				return error;
 		}
-		if (dev->poller)
-			input_dev_poller_start(dev->poller);
 	}
 
 	dev->inhibited = false;
@@ -1802,6 +1800,9 @@ static int input_uninhibit_device(struct input_dev *dev)
 	scoped_guard(spinlock_irq, &dev->event_lock)
 		input_dev_toggle(dev, true);
 
+	if (dev->users && dev->poller)
+		input_dev_poller_start(dev->poller);
+
 	return 0;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

