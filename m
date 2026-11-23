Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445716;
	b=Wy+mZPSzO+vUxqWpcN2cDzgMgNezMgMW8aodiPIgTnYWFvkrxUNhaHOhHOFpAWdyTgYZ
	 B++4/ugazY857epQlrZ0QEma/IjiaGxGH3OE39WkrirVGFIB4j9g/5V6n04of0Kyu1pqk
	 2OhGR2IaljuddTxNuI1tsn4RrVCP0q6ND35T7neQVLS/vU3FbtwXU1CHb+etMrQ7FGOO5
	 swMX0oz8e6Wlf9ZTo+nzaIojNyd2ky8iDLah6R2i9VjyfYg8DaKyOgCzobYaPCHHb2eJX
	 zTBb8BZjnI4202Bzfhxl1J6e5wTVVfybYR6HfbZl7u34oC82eobe1dYm4j1nwpYQ2OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=56730xMYZebP2gQVmKnamiuKT7NX1L/jSC1LBCJIUSI=;
	b=ssQGfjnb6ugcX0rn0gmPTb/4GZxqH6+7jOyJFhGocEGVUNaIzZ8Qx5tfhnlycgyAnQVP
	 wI1xoteH3blX5hd8K1vj5xLvImB/RYpzpN+ZBvWMAq6PIwoJvHHqOl15ckmMio2rd78KU
	 Pd9zLphrnUBDfGyGVG/9rAeh6wRfo6JcfwRzHV7fR7Wb3lQ7OAX/eLP4DvM+7YnmQp1F+
	 1NOmJpv/ZKhVs9l8VEvIepWmO/AEGUAhy8FiSw7hZj7N97wl6Sf5rD8Dy8GO6OjqJgG/V
	 Xi3UXSX+P+eyq4BTs2Lje9W8HUN+DKKt5KsXkkQ4EA7BedCXYHuy4JPL5seCyPlGLJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A31L7zOw;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B18606B089
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 14:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B18606B089
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A31L7zOw
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f045b921caso18757255ad.3
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445715; x=1796050515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=56730xMYZebP2gQVmKnamiuKT7NX1L/jSC1LBCJIUSI=;
        b=A31L7zOwCtdkbcLTXJ6Tu0igRIE6xljUg0BfKhdnPk8VrHvNJYFF2gCcjt+AcgvWmh
         I7H0tdsN9mJG7nm9PsUCZxL2uwjsVEunggNJqOruLnSpXfeMAfNCqQzsscxYHhHcaV4y
         k7U7n1jYNDhDo9NEQGT9Od3b0sJ4x17ekUDCI/XNfJjooP8ziSBRE5684s2MuFY6H4eH
         drIzKgeaehh2VK6/JhnqE7vDwPiKs7j/GBD+5LMQabmkLhPThKOOsWIlAekVjNFSy6MQ
         cjC1TUzk4x8Zu3DoydirW1+iXkUa0qtekWXzI2L8yvTrW+CJYr3a27xLAvZXYhy+guj1
         zZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445715; x=1796050515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56730xMYZebP2gQVmKnamiuKT7NX1L/jSC1LBCJIUSI=;
        b=MsBqwQw8looum/CfBX988oWH53LPkfARlmd2oRrHdg6dn8QFMAKZR5WAZ8bS1BwYz8
         E7y+1qAlhR57nQXwQkd2SyvnH1pbLDrOvzj2VX9ZzzHcwctK+89w0/q/ci0L0D7mGu99
         V+0N7Ayu063bH/iaP+q6HGPwf986i1SmPY5IO9BUzzDw9+L5QihUXjx10pN+Sv0EbZeW
         JG3fAAMC7nOUtGbRMqVIEPFUjGWhZ4nT146OYl6/W2wOYIcFZO5Za4YLOYFNFz2BYemc
         aEmTMAoyboKGCzViFaC8D0OnOjU1c7prOIsBMLGCfOG3X+KRbp8niGS/gvbaXKJIxVzX
         YonQ==
X-Forwarded-Encrypted: i=1; AL+hErGaxe5JV/NftiHNCQ2vSPQEE/9+dCUr0MRXtckiVFiQlnCa8M/1p0MDtvqGgF6WCtPlhl0UXnad8BHrpw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2z0Ze+uJg6xa4ASDtSOokFHnmwlKy0ofa1ZzmxwVHLSrWMBeA
	oAqgEA5ozo+pbs6hWAlmHlJyBeaEOLJlHa5eRsj6/BrJh9YIr2A/nb/x
X-Gm-Gg: AZFdTZdZKPdu3Fdu8cUIWSoyV1G7mRbM1MNRUsjd4rggwF/4s0+0Vc+7zt0rIDLOJlC
	CVu0HpRY8qpus7ymbh1OCS68O8eXmYdHdwOKWiCEoEGITwk41QqsRvUa7KfKmnXXkBUw/HieYso
	rrK3iaSFXFwIWtB16zWw71E4tRBdQh21pfaCV6jo01IXOy5vj/qgvTgQbDmgEiKKMh37MWPSOA3
	hptY9xssFQvRqz3at2lBAjOSs6NeCXB9iIl4liQgYohfZ6cpC2YkdFFD/xvtt5/NCoDyFI9OjXr
	2ILakGJ2nClpWqB41EITywkKjo6lqCwSYWWgcUkX/TV1bzQDKpdnfB1h72qNcs20ybgCYUUWuqa
	lJaB/d4mFR3J6o/hUU0u6OlyBQk48f+gM3A3lug8EeLc6a2BsgHOgWw0WXfAFTCeJQnv4LHuZOE
	HUU4POrsPsR4Z58u9JM8OMr7nppqyKVo1EulHeaIjmMX5hY26jSYpxtdJ+9XIy730CQji60wOvS
	sAS3kQKb9me+C9D4h74VXNzV56ZnsRAy6zlj/P0ameV+GS3/fhsZagnaJcW64X7AgJbHmjBsNT4
	h0SQbIKskI64w7oO+IFm2eYxvRJXyujvFE5CuZxarhPrxt/N+fM=
X-Received: by 2002:a17:902:e811:b0:2ed:697:884b with SMTP id d9443c01a7336-2f03f156073mr120276035ad.12.1795445714916;
        Mon, 23 Nov 2026 06:55:14 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c88sm55480085ad.56.2026.11.23.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:55:14 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Zheng Shuhao <viennaoffh@gmail.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH v4] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Mon, 23 Nov 2026 20:25:05 +0530
Message-ID: <20261123145505.1295929-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sensor_hub_remove(), spin_lock_irqsave(&data->lock, flags) is held
while calling device_for_each_child(), which iterates child devices via
klist_next() and acquires the driver core's &k->k_lock.

Because &data->lock is acquired in softirq context by
sensor_hub_raw_event() while &k->k_lock is acquired elsewhere with
softirqs enabled, nesting &k->k_lock under &data->lock triggers a
SOFTIRQ-safe -> SOFTIRQ-unsafe lockdep warning and risks an ABBA
deadlock between process context and softirq context.

Move spin_lock_irqsave()/spin_unlock_irqrestore() into
sensor_hub_finalize_pending_fn() and pass data through
device_for_each_child(), so &data->lock is only held while inspecting
and completing each child's pending state after klist_next() releases
&k->k_lock.

Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.com/T/
Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
Changes in v4:
 - Actually pass 'data' instead of NULL to device_for_each_child() in
   sensor_hub_remove() (inadvertently omitted in v3).

Changes in v3:
 - Rebase onto hid/for-next over commit 41cb3076a221 ("HID: sensor-hub:
   Remove clients before stopping hardware").
 - Drop the NULL platform_data guard since hid/for-next already checks
   dev_is_platform() and !hsdev.

Changes in v2:
 - Attempted to pass 'data' instead of NULL to device_for_each_child().
 drivers/hid/hid-sensor-hub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e9d6eb3b3831..ce9602945586 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -808,6 +808,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev;
+	struct sensor_hub_data *sd = data;
+	unsigned long flags;
 
 	if (!dev_is_platform(dev))
 		return 0;
@@ -816,8 +818,10 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 	if (!hsdev)
 		return 0;
 
+	spin_lock_irqsave(&sd->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sd->lock, flags);
 
 	return 0;
 }
@@ -825,14 +829,11 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 
-	spin_lock_irqsave(&data->lock, flags);
-	device_for_each_child(&hdev->dev, NULL,
+	device_for_each_child(&hdev->dev, data,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	/* Clients share one HID open; release it if references remain. */
-- 
2.56.1

