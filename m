Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C02BE035
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440829; cv=none; b=MrgzbTajSTTgq3P1igkiOhJanBB7pKzUCU1l7VKKAnK1jXQQTtWL/pizJP7Em3dj2mLtZ9kvuZGCl96cyWlA/rM5yAClUWzLfBiD8ZbEd8MSkDmYsV1RHTcwJaWfsLvHwNt2W1Dr7GXeqZh3zImQPXiqGU59kPQXrxBcIlgS+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440829; c=relaxed/simple;
	bh=OOBXkL6e5lGReKsh2G2rUacRN5BRmdQ6UJPWCdKo7rQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OJRbyUcHXyrLRKhyOGLfWcpHJRjEu9cXqC7WneBS9HtZrJpRzDyCu+X+T9fHXIRhx7UZ0Ry9n8MPRXoTT6RNuYuV5Ii1IBHlhd9hKZlfC/XdbFJtdACBHPBwspdpE4egjoUP5wKI1JufRRM0dqwf+s0xA8xRbX9UGdPbofEsbGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZhzPPzE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZhzPPzE"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35449510446so1070553a91.0
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776440827; x=1777045627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sn0iymoZMFrhHdIio6IfCKaXrnb3ooLaXVVViF/0l44=;
        b=dZhzPPzEJ9NnvIqmSfPnPeqZ1ROxSUJ0azZID43OjFWVMqsWrTQwil1iH+rkmttPYD
         SMhJX0CXjrMAQvnlfXjD8rfjnPJJdytHGQIfFj7BmABJe4SLYJpAOEDS+9mrFN2L9XLA
         yDEEF45lKyb/GgY/hIrNl+BR+SowzPK8RmcDW4JgkabiFzcY9h4laxjbojrqLSU70GDo
         5KfjxCmlodMd7B15rMZrEDQ08NZDxxd46scO5BmJeLPC8krMLydV/rqXZ1lJwvMAk5t9
         G3mD0EEjCKmz8OcG9o1dTFMffhtpC9U80ejM0QuVGK7NZShlrANgl2ln4hQjq6z+5MN/
         4U+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440827; x=1777045627;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sn0iymoZMFrhHdIio6IfCKaXrnb3ooLaXVVViF/0l44=;
        b=YocwFigyChwtapDoPFzztB47IZ3RinUSQMxv1oXBiESs8iJBDdKT/zQPLxC9iuaLO6
         efTmiXHy/MixIao5a/DRr9c427+Ba/F49tf+m6zy4obabW3A7zPn72qXlMFzyCaA48fw
         gTLwLUTKpGeHkC1J+/u7j51kY/7XDX9gRE6DKRJbTH6WoS5fPRlqS8WYEwdFGGoHmY1B
         0k3TW8nWnMg8eVJdNzVkt7hB00dMA8zjuRWpuo0Tzi3QNoNCJ4HMRvHBCusECrRp5SN1
         wlLF80yue0rMZvZoXJY2Mhj2DmDm2IrvdCW+sJnfXDpqA8X+Na2KDZag5O4IgHuUvk/H
         FUzg==
X-Forwarded-Encrypted: i=1; AFNElJ9ByVVFfE4kyQuXYQOUoV53LOByvNkRmKZLnFuazvYcPzup3De+OHEUju9dRrhKa5RXEdMMgILiUYeqjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNUfj9+iIC2c4gCTmlpdtKHO5VBuZxhgE+xs/7AMEJ2qB+kOW
	81g0rIBQQL4WOR5Om2iSW/3nMqwxn8/BB+E3PglA6A5hud1UShga/WHB2u7qMuqN21LoQfYbX/z
	XZejhMTHs1ISnYRe+bw==
X-Received: from pjzi1.prod.google.com ([2002:a17:90a:ee81:b0:35e:5853:1ca2])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5543:b0:35f:bddd:3860 with SMTP id 98e67ed59e1d1-361403b18f5mr3679233a91.6.1776440827092;
 Fri, 17 Apr 2026 08:47:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:47:02 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260417154704.1186803-1-tjmercier@google.com>
Subject: [PATCH] HID: playstation: Clamp num_touch_reports
From: "T.J. Mercier" <tjmercier@google.com>
To: roderick.colenbrander@sony.com, linux-input@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, stable@vger.kernel.org, 
	Xingyu Jin <xingyuj@google.com>, Roderick Colenbrander <roderick@gaikai.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A device would never lie about the number of touch reports would it?

If it does the loop in dualshock4_parse_report will read off the end of
the touch_reports array, up to about 2 KiB for the maximum number of 256
loop iteraions. The data that is read is emitted via evdev if the
DS4_TOUCH_POINT_INACTIVE bit happens to be set. Protect against this by
clamping the num_touch_reports value provided by the device to the
maximum size of the touch_reports array.

Fixes: 752038248808 ("HID: playstation: add DualShock4 touchpad support.")
Cc: stable@vger.kernel.org
Reported-by: Xingyu Jin <xingyuj@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/hid/hid-playstation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 3c0db8f93c82..8d06ddff356a 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2378,7 +2378,8 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 			(struct dualshock4_input_report_usb *)data;
 
 		ds4_report = &usb->common;
-		num_touch_reports = usb->num_touch_reports;
+		num_touch_reports = min_t(u8, usb->num_touch_reports,
+					  ARRAY_SIZE(usb->touch_reports));
 		touch_reports = usb->touch_reports;
 	} else if (hdev->bus == BUS_BLUETOOTH && report->id == DS4_INPUT_REPORT_BT &&
 		   size == DS4_INPUT_REPORT_BT_SIZE) {
@@ -2392,7 +2393,8 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 		}
 
 		ds4_report = &bt->common;
-		num_touch_reports = bt->num_touch_reports;
+		num_touch_reports = min_t(u8, bt->num_touch_reports,
+					  ARRAY_SIZE(bt->touch_reports));
 		touch_reports = bt->touch_reports;
 	} else if (hdev->bus == BUS_BLUETOOTH &&
 		   report->id == DS4_INPUT_REPORT_BT_MINIMAL &&

base-commit: 3cd8b194bf3428dfa53120fee47e827a7c495815
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

