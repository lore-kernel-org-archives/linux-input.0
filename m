Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E800471401;
	Thu, 10 Sep 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039437; cv=none; b=F7nRI6HSn8mR0uAx+A6QenkYpOgkp9NAqpgDW54KzVtrxYgCuEx7F9Sj6D/s2U8MdRk8uSm+ELFXuV+PKiNVxBBv3SOQ3yip6ZsFHaI01dmBkOl+eMbxCZIPwr89BAoCc+2cs1WsLcIbpwA6sIyXihEVOv3oEELEyeu8FmO9+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039437; c=relaxed/simple;
	bh=TbPcGhmhvAT+HJa1L0LlMMi+b1WBwQBL9mQBG7evoUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7DKuhYA93xWfT2BCk+WGI1fplcjTzB/NVHKREut2kzDDMKClgbO/5fYFVOH/mNdzVhGwXhSs70GUibGLaL7uejCHIym92kmeFFgxNV1GPCIHZyXmjc8uetgg4ya6tWNWTYaxZC1FvFcHl0okJta5U3hVCpjfJZrMnx1L/DLISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn; spf=pass smtp.mailfrom=tju.edu.cn; dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b=OTwclKvz; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tju.edu.cn header.i=@tju.edu.cn header.b="OTwclKvz"
Received: from tju.edu.cn (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [183.242.150.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d48b904a;
	Thu, 10 Sep 2026 19:23:43 +0800 (GMT+08:00)
From: Yibo Tan <lhfff@tju.edu.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] HID: sensor-hub: synchronize multi-value read cancellation
Date: Thu, 10 Sep 2026 19:23:38 +0800
Message-Id: <20260910112338.4171983-1-lhfff@tju.edu.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08b0f2ec903a1kunmc4544b99195297
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0xPVhlKSUsYHR1ITk4ZGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKQ0hVSU9JVUpOS1VCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
	9LVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=OTwclKvz66OqBCpX7SVMA1AQCiVSYfzZ79HddhpZthgAdsb+qmErSJERTb+NFRk/qHSrZ1kb2ja1DgjyuD++E9V2BlecA30uL+uv2MXCmMfSJ/djgx1tYBFbQjmKvUQYQfarBPNCL4qlo1b8j3FXVKhQ0hTd99uZUhCS6J5iG0g=; c=relaxed/relaxed; s=default; d=tju.edu.cn; v=1;
	bh=pKIciFMSv+IZt3QVmdUJPW2BaKBKIvGXVnkqwCkWS64=;
	h=date:mime-version:subject:message-id:from;

sensor_hub_input_attr_read_values() publishes a caller-owned buffer to the
raw-event path. If its interruptible wait times out or is interrupted, it
clears pending.status without taking data->lock and returns.

sensor_hub_raw_event() may already have observed pending.status while
holding that lock. The caller can then release its buffer before raw-event
finishes copying into it.

Take data->lock when cancelling the request. The raw-event path now either
sees the request retired or finishes the copy before cancellation can
return.

On an uninstrumented PREEMPT_RT kernel, a valid 16-byte quaternion report
overwrote a live futex waiter's plist node with the report's 0x41 payload.
Two vulnerable runs produced the same general protection fault in
plist_del(), after 471 and 91 completed trials. The locking fix completed
two 10,000-trial runs without an Oops, panic, warning or payload signature.

The virtual provider setup and FIFO assignment require privilege. The IIO
read, signal handling and futex operations run as uid 65534 without
effective capabilities. No physical-device or normal-priority hit was
tested.

A source reproducer, kernel configuration, complete serial logs and the
vulnerable/fixed result table are available at:

https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/main/cases/hid-sensor-quaternion-root-a

Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260610083849.067A11F00893@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
---
 drivers/hid/hid-sensor-hub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc..80f18aff6f1f 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -335,7 +335,9 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
 		else if (cycles < 0)
 			ret = cycles;
 
+		spin_lock_irqsave(&data->lock, flags);
 		hsdev->pending.status = false;
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 	mutex_unlock(hsdev->mutex_ptr);
 
-- 
2.39.5

