Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176791;
	b=jiOES+jiYbLBkcsNOyuC9cdtoAiueBTcKwUVhmVzEsbUFc9o3TThjQprbRj1EPO9cT9X
	 cicff76mHirJaud1qzMuL1CbuNFCl3BFs1e1VFwlbLFrF0vmpW9VMqaPgz/yTDFXDKGon
	 EjqEDwR58z9liDgFwddh8im7zQPDfct3xzLRRgajDAUeUBLWKJCAwB7HWd2C2udE/EeGs
	 jncR/PoL0Jk2R/NVw68x3fWP91BfXgla8fEI8cCtgZ0KWhqV+LLY9ZJic6ZbbVKQZYkmr
	 C5X+zdByHRLAUxCJJXvPjFwJZftywQEdT+J5yHu8PuFg/SMkZN4YCCN92bIQ+emIBWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m6tPHsL9Rz9UVRE/EWNWK0Z61K0edsr5OFdC9JXo0fE=;
	b=I6hxvFHtA0IFazvHxePijcx1unZv2wPYX8Kt8o8ebPJ/wsEPHxFuYkrJ89ltotzu4Rg0
	 GGXFzYqKGvjA8Dl9EHuPbIPgj9Zm9B8JhyNJhOrl26iaK9495mPIm3h+dS7itPzjW++ec
	 8XuYV8Y0foVzo4EfRABCOhNmi3qwvx2TN4AJJ2fAlibUTANZMSBQ342EV6UD8G0WLIxao
	 yz9XuaLzc7mBU0cQ0W0BYzz5c1wupbSIqghql+nWCZVL1XqpCWnrCb3lfQO1uTn97qbxZ
	 mzvUNkpmr7nD1/oVybfIo+nwXU5SXjKvMoNkZ3zhN4Vto1ScmU8mGOieaw5pckfJbzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLP9QAoM;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691A606A325
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 12:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2691A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLP9QAoM
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso515247a91.2
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 04:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795176790; x=1795781590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6tPHsL9Rz9UVRE/EWNWK0Z61K0edsr5OFdC9JXo0fE=;
        b=RLP9QAoMuEkQUYfb3jApABtNveJJP3px+NbmiksGLdl7+ObkB3blouXLdlaJ4ZGC2Q
         bGDPEpn77aJoCskRVMhCc9R92Iq2o1bYVlQvyybKsWVSwqf1dAEWd3eeEgj+voIBBEPX
         voluYtglHq+oeedHwt6/G7mNy2cBDOxezVn/Z3Kqa3BxSte/hPKbARCslrKr9lLUQ4ka
         kMQRi6Qgn7umatfPKLzyWV/wL7BiuV8iR7DFA0xcZq/gtQUmukHdaJoh6CJHx7bNrl/n
         R+R10Gb1ILkf2ACeQVsaBNs9R4JgRvlpsPmpDr6tek/GZVBZHsH3FwxwjRHRagrzKhFQ
         Dddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176790; x=1795781590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6tPHsL9Rz9UVRE/EWNWK0Z61K0edsr5OFdC9JXo0fE=;
        b=aAJS+nsn6Ba//mPmJr/zaT6SkRZ7DTSVBFipC9HZ+xSv4/Fd4v28pOPLpndJAvTbM9
         hCCUwcVEBIUUwGCKvnAh6a4U9xZPlONoCU8QgL3rVQtX86TLBb0x74dhOGbAjocYb/7F
         Nno1V44DsScr/q1riHxCoHhe/7dwsoExjyrq3zoa8r4DkVJIDn32ZLhYs87m0S5I1Olj
         b2J+k+VHnv2Ly32B1THZ31ShZXF755gfmX+qCqURRayp+TsA8SCRbDcEpAc+deGMUCq7
         7YpcyymaHNg1veWLCN7TNYX5t+kuRzDGUF3WZ96KpbK+yGUHzZLSEoEC3vx6rJJAXCNO
         6Pig==
X-Forwarded-Encrypted: i=1; AL+hErHJh0Sr/MJvBxdObqzb2caRpnOs62PuKGMxrzyujkFAoUBkOLMae7g/p3H6q37/nxoDbHaS0PKV6JlBTw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9x+N2Kmg5uPrSvWiUu4ZjtZCTODShR3swkT95temtB44jrBtF4
	+jGmfgmIyH+GyIlPfS58Qkd8UApmjPs7K8jiEY5JcEBIHm7JBRbcs4F4
X-Gm-Gg: AZFdTZeZh/ze2fCskYFfbw07raD7zK12qN5X8ZZBypk8X/a4MqnCLPNAWpRxxVdMWSD
	qPgY7R9nqeCWt1xmgEdKA1A/i72Tx9OBAswjZ8fDwtp9wNtop2rrPB4hWopua4z5xUGW8TYMtAh
	T/kxEHjjq7l95hx2yDKTgDVzwhBjyCgvJaPhvkFzL2xtCtuYNed8Q15kjJvkkSUSUiVFPLGutEo
	Hu4BhcOeK2JryvRmlpYwGFXb3mqpet9xUo8Rzr1yVSffe1Jv24GKS6jS/l3iiDXtY7Z7agIZPoa
	ak3/KLmAnUkYGMgIPJ98o0fhUPo3tsAtd+fMO55GwLt09T6b+qidMMf7ONPkrZ/P/miiLrea1DJ
	LBJwv7JmySYo4Unkq8Z2/iKfyWIjIfa+N8VPAOlkkGyIEeeRq2qs8yiafWTkcfadP6ivemXPu8Y
	UgkP/sfi6VL9d99LhPshO1AEXcaDBXhG8bzcHyMtpkuvCWmouCMifNLhcRsw14bHgFYlkImCbVq
	4yr97c5+uWx+tYZGalkxaNqiYsM0dn8XF7PF5pIYd4J8u8/G89Srsa0i2q59VL6GXVI5+5nf6qT
	AZKUyV3zGFDye4ExohVSz9BXEIbdNjMS0Gm2NGBzu1reqapHjFBa9AeCPFIel+xqXThRlhDi
X-Received: by 2002:a17:90a:e7d0:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3b41c8d5a52mr2637365a91.17.1795176790444;
        Fri, 20 Nov 2026 04:13:10 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41cfb48basm1513592a91.2.2026.11.20.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:13:09 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Fri, 20 Nov 2026 17:42:56 +0530
Message-ID: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
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
Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on remove")

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
Changes in v2:
 - Pass 'data' instead of NUL to device_for_each_child() so
   sensor_hub_finalize_pending_fn() does not dereference a NULL sd pointer.

 Tested against the syzbot C reproducer on linux-next; it runs cleanly
 with no lockdep warnings or oopses.

 drivers/hid/hid-sensor-hub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 028e70ec7bac..4ade5b5ece56 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -836,9 +836,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+	struct sensor_hub_data *sd = data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&sd->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sd->lock, flags);
 
 	return 0;
 }
@@ -846,16 +850,13 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	spin_lock_irqsave(&data->lock, flags);
 	device_for_each_child(&hdev->dev, NULL,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);
-- 
2.56.1

