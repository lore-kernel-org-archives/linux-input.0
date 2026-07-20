Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13043D50C
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564552; cv=none; b=i/HkCF+oZPuFWMpxg8q277jWHdIoxnx9cFeM4uASgyKf/s/4Nce2MKYFV4vw5VHPDTPiFFQPd+Tfezrdjidyfu+w223LAeytD13av7llZe3ldOC4W1rAxRTxAr04pO87rZXfECHkeL/Nth1czWzYNfNBJ1iKkqOOnMQT7VqEHow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564552; c=relaxed/simple;
	bh=dUMQFB2Z8XBwxm+Ex5oVkHqrvsU+GntbvkgsqLzWw58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkppQSwd/JwIwTsr7ExtePN/c554scraN7YdH5qBAEbqYqhPl40vRpNxqM8ooJh7oy7D3kudCWrPlWUsrTAFgBQ7BTvcG3jCq1eSoJOXeIbQc9Fglt2qYVc2bVw7+9LbGmi85uhtaFZl6KNeHg6BX5DNmodWWKeUvklCxCgDKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso8054676a91.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564544; x=1785169344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPuVUYzIwyEbuq5A3FBqqRsMv8Klcyr/+mTheieV1ls=;
        b=Z4g/acUsFa2TMCYKrnuhZ9rrgJwbtqT5CabE3z4lWX12zfixrhniR5EkaSErman6JG
         FXMpvxRxDrPp7tsjGd1pFa7kqTTCDY59ij01cOl6t0c4Td4+0Q7qq2OfShj94ghKC0LS
         MqwDbmsXL8aT6V2k9JLwjctveDZqWVjMAhBzZLXoGwXZDOjqAjKKcBBpRqOYT61OYGgg
         loA8j5UixiVuhQ4u19qHBl0FN6zQ5uu4pP803cnUddzxff3oeV0YbCFvN5bO6t6VmwLX
         Sn60VxuZFUwkoiy8mh6yLkFaqayiGnfqEtbvL56VuoBypct8uk85J33O1+vmPG16UJwk
         a+qg==
X-Forwarded-Encrypted: i=1; AHgh+RrHQ9Gyn6c31xtR9dfONpMRLBVbQa1/+pgUMs3l6Bzifw6HIN07cWIffYFD5KHnUjTbb7n8o/mexpaoNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3lFuqgrQv+lCFrybbP58LlJRFYmYslvsnF55dxcZNyXUHQN3
	0kjPs+iVgycqwUIxdsLnPgCa4x77GCnlChWqCBpTKWuRj6n3TWMyqww=
X-Gm-Gg: AR+sD11dEZmow+YC6dKPUgYAxRSs356XfNDab4WHKgzPPJ5gURRSlqOELVtLpUzoRZ6
	QEUIb3HyKnhcn7dhASxc8raoBiZvoOYjp8SOlmXSggTrSjWlQaPx3UfsjsWWclp9c+3umitg6xA
	8XJFPN/M5gO8JqZKewc/qG0gfEua3OnpxNTYsN7xoQYSdYOp0CVVRR2Z4noxWfmvYkI2Gb0eOnK
	2DatfuD7Wx6ZD2CGRsQDuig1jGbStBSS8p/+PcQHsRxTYOKVNX+Yf6zsEO7wxEhxvJc7NM9E6ax
	ZEsGJFzZ+hz1sEuevQzEQ9/Wcg/XeKk/7v/5xRdlezr20CArOXkCBKhpw2a8fqQ39wrGzBNjTQU
	r2zk5MC4dOvlMW08KAYwkpBkUgrtnfHDWtNZAdlYt70L4oSzE2E3KDQOLevNj08IsAKjUdRKF7w
	ziJW8m60/32+ER7XLrASAUn0dUQkQuRHvTE1hZt1CUH+ouYMmNeHtYEeG6pXdRp66THtqk+D+yf
	0D0Q4RRBnNE779KoQ==
X-Received: by 2002:a17:90b:3d4f:b0:381:bc4c:da74 with SMTP id 98e67ed59e1d1-38e4b594ea6mr15397998a91.32.1784564544181;
        Mon, 20 Jul 2026 09:22:24 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9205d358sm29366a91.3.2026.07.20.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:22:23 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 0/5] Input: applespi - Fix probe timeout and use-after-free bugs
Date: Tue, 21 Jul 2026 00:22:14 +0800
Message-Id: <20260720162219.32324-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This 5-patch series refactors the applespi driver for Apple SPI keyboards and touchpads,
eliminating use-after-free (UAF) race conditions during driver unbind, kernel panics
in debugfs, level-triggered ACPI GPE interrupt storms, and data races.

Specifically, this series:
  - Replaces separate drain helpers with a unified wait queue and 3-second timeout barrier,
    falling back to unconditional completion waiting if transfers remain active to prevent
    premature driver unbind and DMA memory corruption.
  - Tracks in-flight asynchronous SPI transfers using a completion tracking array and
    cancel_spi flag, ensuring inner completion callbacks execute prior to waking wait
    queue waiters to guarantee teardown safety.
  - Converts touchpad detection and registration from an asynchronous workqueue worker
    to a synchronous probe sequence, while protecting against NULL pointer dereferences in
    debugfs during keyboard-only fallback mode.
  - Corrects driver unbind sequence by disabling ACPI GPE handlers before marking the driver
    as shutting down, avoiding level-triggered interrupt storms on unhandled reads.

Changes in v3:
  - Addressed feedback from Sashiko review on the v2 patchset:
  - Fixed Use-After-Free in applespi_drain_writes() and applespi_drain_reads()
    on timeout by falling back to unconditional wait (wait_event_lock_irq()) if
    transfers are still active upon 3-second timeout expiry.
  - Activated cancel_spi tracking flag by setting cancel_spi = true in drain functions
    under cmd_msg_lock to reject new async requests (-ESHUTDOWN) and trigger wait
    queue wakeups.
  - Fixed completion callback race in applespi_async_complete() by invoking inner
    complete(applespi) callback BEFORE clearing tracking slot and waking waiters
    on wait_queue.
  - Fixed NULL pointer dereference in applespi_tp_dim_open() when touchpad registration
    fails or times out, returning -ENODEV if touchpad_input_dev is NULL.
  - Protected rcvd_tp_info from data races in probe by making a safe local copy under
    cmd_msg_lock before passing to applespi_register_touchpad_device().
  - Fixed GPE Interrupt Storm during unbind in applespi_remove() by disabling and
    removing GPE handler BEFORE setting cancel_spi = true and waiting for transfers to drain.

Changes since v1:
  - Split the large touchpad registration patch into 4 distinct, single-purpose
    commits (wait queue consolidation & timeouts, async queue slots tracking,
    synchronous registration, and async probe preference) for better readability.
  - Fixed a self-deadlock in applespi_async() where it attempted to acquire
    cmd_msg_lock while already held by applespi_notify() and other callers.
  - Updated applespi_async() to assert the lock is held by the caller.
  - Protected touchpad info flags under cmd_msg_lock in response handling.
  - Simplified applespi_tp_dim_open() by removing redundant NULL checks.
  - Overhauled GPE disabling and teardown order in applespi_remove() to prevent
    GPE interrupt storms and unbind deadlocks.
  - Addressed reviewer feedback from Sashiko.

Shih-Yuan Lee (5):
  Input: applespi - use unified wait queue with timeouts for drain
  Input: applespi - track asynchronous SPI transfers in flight
  Input: applespi - register touchpad synchronously in probe
  Input: applespi - prefer asynchronous driver probing
  Input: applespi - fix use-after-free in applespi_remove()

 drivers/input/keyboard/applespi.c | 208 +++++++++++++++++++++++++-----
 1 file changed, 175 insertions(+), 33 deletions(-)

-- 
2.39.5
