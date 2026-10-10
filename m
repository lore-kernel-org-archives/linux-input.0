Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914139CD0B
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673094; cv=none; b=X/YPB26WYfoWKFyW39QhACmBP1t2wb6gG/Kwa3vj286Ivfu6/JnJk2iXcUCMkuQML5bXi6djC0+5Q8paJKdys/6txeR7aDsjTavVm5BdapD1Q0esZ5fg+tibtMG4fZnCa2+/W5qu2+AvnT/kPl0DTNgjBw3gFAP1e03tcupb4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673094; c=relaxed/simple;
	bh=a3o4+h0aIyuPfIMWpB+WMMdkFGVQzVcX12UNoZmJDqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkIbVFNIwQ7kjjHMLSLpP2Tr1/+/ix56/maRRKcV7i12p8muRYgtHlmrGGzPpL/4/637YLb96Fe5Khc9PpCEQ0VOYMKTosLlZHDK9PDEEPY0NC2jfUp7267rYgJZDTsI43P2seNLR5xiO8Lzgw4jXKaKmtlaLWQJFdd5qHB8sM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=D3ZYqMYL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="D3ZYqMYL"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-917a6dccc60so11137346d6.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 15:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791673091; x=1792277891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eq3BGcj94f52kevMdVzNWJuAe2KKsdp6kTmWDqj11yo=;
        b=D3ZYqMYLK7AoGNx8QW0Ysv1xZVKc9dGXyGlL0enbITzdl4h1Fy3rwNtp151l6ryeuF
         VOCCkXfnsTw20/3sUo2SoEcg5xObhoaKbLJjVhWA2cOCl1KHQalY/Cee3ISjfx2vfMB7
         kdFwuhCp4dAeMiQIQETQ4yaAjmipwBfV8qW+InyWqUaqbaUWhbqlLWb4Y8c1yOTzD3FI
         DnCAWL5axq9k/Wi+iuxHb2Y6tcw8Gl3a7Qh/miiJJL/fpNa+0Y4BwlysRICLrUwBXoIb
         6Axk7C5GH+HVQ3G6Gxy8Xctx1WCoyLDBrMcKjljFg8epY+ArDjVdgD9rB9SRCC28sq47
         sLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673091; x=1792277891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eq3BGcj94f52kevMdVzNWJuAe2KKsdp6kTmWDqj11yo=;
        b=i7zKrBT6t8jW9iwsaEm1dyd7PW3y29/BLkDEFzHqBUfXucILU0ibVeBzGBdtmEQLHq
         KjIcz8hZnOfSqUry60WP14NEbxUtrnFHbvdEotPCJX83AcoZBKhu0z5UXVJ6lqDhHCh6
         9ZkLvS94wUDCar3EIJJ0bZiWPS877ezXZklDkjUNyct0V/HFFclrpFXDVPGfScT52jZn
         FbZ7hICAFdPT/JjL8jOrLue9OSr/YZD0wmSj03peAZG+tTGCo9sciUWoZFq9o9T/BYuU
         5FPjIq2Xc6KjLz9xi+ufte5GAqRqs7jxseGeP/VkUul7ep+DujqkN6bkrSUvkccJVbCS
         CTDQ==
X-Gm-Message-State: AFq9FYIonRyecx+Nfj0TJbcGnASiv39BPDt5y3N1c+GF1oMe6svPQEiH
	HWScXIrYDIwoM3A345vK/AGXX/jGWEqQLVDqslRWIa6m4dceYibWpmJGc7/HIz/LRa8=
X-Gm-Gg: AYBFou0SUNCFz+vGvOrMnplG/da2s+aHri3sl6DjOwqizwia8de9xnnrqhy1taJ5DOD
	Fe33Q7lXviPTFChpyECKf5ShAffvNOzCLBc5QQVlkYB7LYiY+erxJgQzHozbJEolsaFyEZB3W+u
	Bjr2VvVL0+a3OeIX12nUTiYibd/hPjMr++eJbJXX109SyyzJjuHrt+Xa1kyBIgLk6s8WqoU9TGH
	77IWOhawwm043CtLSdydsm3/DoFCvOB///jRdK2ipOTozwDqQzcc1WuqJrVGvof6Ox/m8akzX5t
	UI2LOCR5cjhtzEXq2CbatZLxSK5Y5dB2jPnyCCSLJr/dBrQlU+zxFa8ZIbiuETwcqylIE3NbWs2
	Cxl0XQn4ITKQ50r5EDX2sRMusxHmcrtN8PlGm3l2eXptt0weSbzj8aqLY0JcQ46zoKDJYzdbYBi
	clEGiIeT+AnZ4D0zQtcCHahxQmMMnwReBP1fl+8Gm5ldX7eYWHRrVGwnZaSmOOjqNZndYQw6GHi
	JYLPHuwAD1AADUycgBFH17Tfj7J7qZNUzVpYAHmiw==
X-Received: by 2002:ad4:5def:0:b0:910:5bb4:8407 with SMTP id 6a1803df08f44-91b53592b3amr106822606d6.0.1791673091356;
        Sat, 10 Oct 2026 15:58:11 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55092ca8sm55498256d6.37.2026.10.10.15.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:58:10 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v3 1/2] Input: discard pre-registration events before attaching handlers
Date: Sat, 10 Oct 2026 18:58:07 -0400
Message-ID: <20261010225808.36404-2-kabel@voidship.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010225808.36404-1-kabel@voidship.net>
References: <20261010225808.36404-1-kabel@voidship.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

input_event() permits drivers to seed switch and absolute-axis state
before registration without delivering those events to input handlers.
After event-buffer allocation moved to input_allocate_device(), such
initialization events can remain queued across input_register_device()
when the buffer does not need resizing.

A later injected LED event followed by SYN_REPORT then delivers the old
switch event to newly attached handlers. This was observed with the
initial SW_RFKILL_ALL event from thinkpad_acpi on a ThinkPad T14 Gen 6:
an LED update replayed the initial radio-switch event after registration.
Registration can also leave a pre-registration timestamp attached to the
first real event packet, including when the event buffer is resized.

Clear the pending event count and monotonic timestamp under event_lock
before attaching handlers. Keep the switch and absolute-axis state that
was seeded by those events. Resetting the monotonic timestamp follows the
existing flush path and lets the next packet obtain a fresh timestamp.

Fixes: 0cd587735205 ("Input: preallocate memory to hold event values")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karlos Abel <kabel@voidship.net>
---
 drivers/input/input.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 01c91fec9..a0ba3eb23 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/kstrtox.h>
 #include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include "input-compat.h"
 #include "input-core-private.h"
@@ -2445,6 +2446,12 @@ int input_register_device(struct input_dev *dev)
 
 	error = -EINTR;
 	scoped_cond_guard(mutex_intr, goto err_device_del, &input_mutex) {
+		/* Keep seeded state, but do not replay pre-registration events. */
+		spin_lock_irq(&dev->event_lock);
+		dev->num_vals = 0;
+		dev->timestamp[INPUT_CLK_MONO] = ktime_set(0, 0);
+		spin_unlock_irq(&dev->event_lock);
+
 		list_add_tail(&dev->node, &input_dev_list);
 
 		list_for_each_entry(handler, &input_handler_list, node)
