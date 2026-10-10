Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D5331209
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655237; cv=none; b=fszdKuUHsCIEiqMPb9H67wy6/x9oLlw6x39WCJjTnOrftRl4ousNc8Gsjm9rt6csil8+4+mC791SgE1hLPUO9Y4w0tyQXDIZ7ILLIeHjf2kLl7zF7t0Y2V3jdhTa4Dtswr77GD04wM4AeAkVDkHBVMFcitcJ41fbcmE33ge+TQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655237; c=relaxed/simple;
	bh=nq2M5xW2fxIZLcvXpCROZkWVmTxCmiexhtFVPMX+4E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iISA8mNlhNPxsoHa5OnbKsu3F+1rf9jw5auN/EP92dWZzrzCQjhGz20VWLYqxWk9+oPxM9gJXu+Nm2TJbV90s0aTeUmGm9OaayFfK6ZAmBH5e/ahDFWaCeN66kmBZtAB9DOdk93Mh6dzWro+rqIvK+Js60S32Kza5J8DbpO7+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=VSDxD+wo; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="VSDxD+wo"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b52ba422cso10322746d6.2
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791655235; x=1792260035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NC4wjVkYj33ouDrpIw20yvXN7Xm00WRsU6XHf7agKPU=;
        b=VSDxD+wohXyD4ZBFdk1rb4Rpqrq+jBJAEjEz/sXfu7aUQMynbcXOEZawr3VKSkKNnj
         ynl8PUwtrRQKZO7MF54oZZGgZHZ92jiwLkmjV+nyU2c5jlpjIbGFBno7+7YhaXSX1iWo
         FZeDApZwGU1guoQ1VcmFF1zlXzXIvvHuiEH2KA6RV6Tk+KYUVR3+M3qfBDCBNMBDFZCN
         0mMkjrzKNbqcUc3p1rHTuyg8yEkQxPxPt7eoh0wNoV6xCABa/swuFEm287AlND3rlTNk
         WUQLHIiVusDN19xYcGcjoOM8UGZz4pPG5IETMbtoDQ9AduItTbmbtk/uHtSnKrakq7Y7
         6+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791655235; x=1792260035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NC4wjVkYj33ouDrpIw20yvXN7Xm00WRsU6XHf7agKPU=;
        b=FCD6Qt8WKX7HoyXqDgrBctJ0cblP87TgXpzkmzuXT3koeuh94xjjEvOwYTUiaOoWBp
         nHmPBxEYnFlJRrJUkjXHsVkvehLjZGeTN6AcWVT5+fqX4ZRPo7a0m4AndqOXdTVXp2VK
         8VRnYbKrxfGKmiz5evCtP2Lc1AyQ7d8v92XLAqKB3tDXk9hGTBFj3dbYDrcrbKGRJsV1
         7O4A2Mn0mCDxqIVFll3pe+uz6lTA/uGventwjUxF+50GLsygEuvcjaCMBTNmErMCE6jQ
         tLKUtdMKyNw99Tv/t7D0/bFs44OU3kSe64X71j+fuZeMi2pn1pW3JWFnVh8gt/pTNQVe
         M3og==
X-Gm-Message-State: AFq9FYLFg+3F/+KUBOMDoCoAB/sqKVcficAZiCi5HxrwkoO3UkQX53Rr
	EUTd8BOKQJdujog5l7YRfGslmYsn6OXi/h6WjGuuXuav5fR3Lk14rP2qb/M0erho/raGgXPrCCL
	4qZDiUFU=
X-Gm-Gg: AYBFou1up38+kQxsgOELyTACzbOyFkK4RaXjDk1aZ7TGE7FKKJBao4tgMmf5lQj95fr
	7l20AXrWOF7ean5FE4MwWDIiCJ7kPe0JUyh7wB+K0j74Cru1zK9EXq22a/jQOjuKQww7Y6WkLvA
	Iu5OIOC47osnDAjleQ3UFgpSklcNHpJQY22gkOFZYlXpkRDA/g7bGxaIPOCBBK+8gcZvVGXuqf2
	GUiLN7caag+KTHphDsGXEFzNA5pvv18l1oGhzAjl285sj+dWZkUDY6lSXJozfKNXpusRgC/RI0F
	8f78j66F0q1q2TIjUkQyIZYuGrR/KWDMQTweao+OOIjMW5yfUUt5qeLsFitxVS1oDn6RC2gsC/j
	TOSVCjOTNqG3/tKJqWpc2nFupsVcvH3lFmpcGPfNI+iNKuzI14uqXmnvl+QtS31YPh4oGKXcWON
	Rs2hdGs746mg0i74mtuC202koCCvVrPOXwdPoMNWgvCr0LB1loWlW6xQhcmu+ZhqnW+M+d6kCfk
	IvZmF6EfxhyDLJIzGSFVDpYWr8mRmX8drw2T+zm
X-Received: by 2002:ad4:5c69:0:b0:919:8358:a18d with SMTP id 6a1803df08f44-91b554c3186mr100818906d6.13.1791655234205;
        Sat, 10 Oct 2026 11:00:34 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550175e3sm50339326d6.11.2026.10.10.11.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 11:00:33 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: discard pre-registration events before attaching handlers
Date: Sat, 10 Oct 2026 14:00:30 -0400
Message-ID: <20261010180031.7-2-kabel@voidship.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010180031.7-1-kabel@voidship.net>
References: <20261010180031.7-1-kabel@voidship.net>
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
 drivers/input/input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 01c91fec9..d59d62caa 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2445,6 +2445,12 @@ int input_register_device(struct input_dev *dev)
 
 	error = -EINTR;
 	scoped_cond_guard(mutex_intr, goto err_device_del, &input_mutex) {
+		/* Keep seeded state, but do not replay pre-registration events. */
+		scoped_guard(spinlock_irq, &dev->event_lock) {
+			dev->num_vals = 0;
+			dev->timestamp[INPUT_CLK_MONO] = ktime_set(0, 0);
+		}
+
 		list_add_tail(&dev->node, &input_dev_list);
 
 		list_for_each_entry(handler, &input_handler_list, node)
