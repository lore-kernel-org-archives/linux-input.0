Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284B3E1227
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366047; cv=none; b=osl+bFhOLQhj50zdFvsuTwnzaRI2yvWebAdNSDMNwwsZGjZXSizFnWd3NweK8glSgphay4A7UWiLis3giYe8EmP5hZwxw/W+DCzs3QCUDJ+1U3nvlnkWnIxOMQvVQVs3/KTSg59pmLviL9N1gOBuB5Nj7dRorpWLCQ6mElwm25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366047; c=relaxed/simple;
	bh=msWSNku5OlvN9yv4YElxcsCldoxv5uxWn4tihBzqttA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5QPZR9tbCcQw8HY2cZhCz409Mpn5vrakhnfKz0UJEncrmevRuEBjSlBc6uK/xtmmPI/D6b3MS+1cpW+QDQzJtwgu9Ud5Cg6wMaHZ42+vK6XVonMcCh98BCa0D6Hta33Sx+L1BKEHmb9CMCUwUEZSD2rMrqw1n3Rh/VCiBr8q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7fp7/PM; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7fp7/PM"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35c76e9614aso2903779eec.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792366044; x=1792970844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWVaE8AeAPWzwHM66+gk5xCbOk1oz8k7V+7bfxLXR7E=;
        b=a7fp7/PMW7dyJJaLc3CeyMOrSriumvyDYjJW9EUgLorAR1rm7Ur3Utr8rTz5X1up0t
         Pu/O/06VINamH2dsz70P2j6pecyQUI1Q6eP0kUnVdC4w0lrLM9WxWberGxYCkVbOQjEo
         0pGyVh1N65cWJDB5c3eqYGDFiyr1nlmwJ8kBG5R9rWBhr0uLenQx5pGCadU7cAGfw4bI
         BJ7fvq5XuqnfNqqOG76dMX+4IOXr7u4acA4syrsIgbYOHlt5jSLKYlx2LvdZDnuyUvbg
         X8LzzPiFOhxbGaJb2R+ifQBSm3mvyf5eL4BuAUI0m7ZzGRhJLvJzLhUyi8u4cgnNScqn
         Im3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792366044; x=1792970844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWVaE8AeAPWzwHM66+gk5xCbOk1oz8k7V+7bfxLXR7E=;
        b=aW6+C3VmuIlbLfvpTmnw6OcAbb3XWtmwKAmvIeGOQFG1zzpJM9sJzhuJrsCSWCjH1y
         kCLfVSfqjz/K8AwHV2vCmNKZ/hrsv8N3x2svb3Vp/JxUfPmxiFXhbl6YT9R0IxlyBCti
         MD3+8ktgk//daia+7dHGnzXbLPIVsf4jd5RRllgqDS/8B1AS+niD2+x/RUb0UwNx/0n6
         68CBkFoiyjm9pTkK39ZaEJipBWuzUjQJJbHtTGD8dcPcKowblba+UoFuxqpzm/JCQuXQ
         vYIzEguIewa9Cy7GpFQtHUPFibxEQ09F+6YWn2taHU94annwGoxuGy2/mFB6FaxnUUQK
         VG3w==
X-Forwarded-Encrypted: i=1; AKwUvBzGooy9K2gBXbhH84K73V4Va1/O6DQpJtrxS9ZErZR/hnoUYUFv49NETVqxE+KvE0ibqwrJubf34Bk0pg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLwJhraA+i2sfxfFwFGGyay2YPJeCVpVZ34lFhqx3YxSyp++jaw
	lYViYoNFhEMZwLhyGdQlfsi9wci+kS12mazQ4F01rteNE/c1Lkqsp5NM
X-Gm-Gg: AYBFou08/t1DnOK28Ei65siF5eSgAXQxrSf2F9LMVn3rIFpy740vosnBkVVQ8ruxPW2
	vONwKBsrtRaf+7L6TH2FDTs2WBOHEgGtOyZYYOTyGUzRTO7qdf+XYeSis3KbG0n2KPnfq3BSDrW
	9n+t2StdoIWDFCanmJzra3BYQhGXdvhPnvY4yXqKxmFjD3ODkLeoQaUhmwNWoY8ScZVou5dz0pb
	RCONzyo320p0nz0xzzxJ8GyYBJqeDPMVqq66E0Dl+O/8tRi2apZkL8PpaPZJqGjm22WdT464eeB
	8n+ycguFHU3JFsEWvZ6y53Mr/u7hUhVqZcP8yzCHRxjgKRpyz3uX5VINrnjA1ihfNooHEw/reHq
	RwDmyHA4MMT5oP+I/7ASp3TYoSTU83/gSmzbFKIKkVp0ktey9FYHVKbN1FvLEC3uks7s69GNfrL
	uSRcjRsZWvHASIhN90d1sK+3g4durgoJ1NBLi1UBlDTp7of5fJQwrFZUAHlcmi1n5VNKsMa8xgU
	BPM7yDqDi+iY62pNsvCVk9P9c9CZjPmEywqbZvQEi4=
X-Received: by 2002:a05:7300:7aa4:b0:35e:43fa:eea3 with SMTP id 5a478bee46e88-361a137072dmr9070108eec.8.1792366043791;
        Sun, 18 Oct 2026 16:27:23 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm25571908eec.9.2026.10.18.16.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:27:23 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mark Pariente <markpariente@gmail.com>
Subject: [PATCH v2 1/2] HID: logitech-dj: Don't add Unifying devices from HID++ notifications
Date: Sun, 18 Oct 2026 16:26:53 -0700
Message-ID: <20261018232654.70571-2-markpariente@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018232654.70571-1-markpariente@gmail.com>
References: <20261018224627.60328-1-markpariente@gmail.com>
 <20261018232654.70571-1-markpariente@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unifying receivers (recvr_type_dj) announce paired devices through DJ
"device paired" notifications, which carry the full bitmask of reports
the device supports. Before commit 74808f9115ce ("HID: logitech-dj: add
support for non unifying receivers"), HID++ reports for a slot without
a known device were dropped. That commit made HID++ 0x41 "device
connected" notifications for such slots create the device instead, so
that non-DJ receivers, which do not send DJ pairing notifications, can
be supported. This also applies to Unifying receivers.

For Unifying receivers this produces a broken device. The HID++
notification only identifies the device type, and
logi_hidpp_dev_conn_notif_equad() only sets reports for keyboards and
mice. Unifying trackballs, touchpads, numpads and presenters get an
empty report descriptor, so no driver can bind to them, and keyboards
with a built-in touchpad such as the K400 lose their mouse reports.
Since the slot is then populated, the correct DJ pairing notification
for it is ignored until the receiver is unplugged.

This happens whenever such a notification arrives for a slot the driver
does not know about yet, for example after the receiver was probed
while a KVM switch had focus on another host, or after a device was
paired while the receiver was switched away. HID++ connect
notifications are sent when a device reconnects, and when userspace
(e.g. Solaar on startup) asks the receiver to re-announce its devices.

On Unifying receivers, queue the unknown-device work instead, which
enumerates the paired devices through DJ notifications.

Fixes: 74808f9115ce ("HID: logitech-dj: add support for non unifying receivers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Mark Pariente <markpariente@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 6e8db01d27ec..383c762c503f 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1766,7 +1766,13 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 	if (dj_dev) {
 		logi_dj_recv_forward_report(dj_dev, data, size);
 	} else {
-		if (hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_CONNECTED)
+		/*
+		 * DJ receivers announce devices through DJ pairing
+		 * notifications, which carry the full list of supported
+		 * reports, so query those instead.
+		 */
+		if (djrcv_dev->type != recvr_type_dj &&
+		    hidpp_report->sub_id == REPORT_TYPE_NOTIF_DEVICE_CONNECTED)
 			logi_hidpp_recv_queue_notif(hdev, hidpp_report);
 		else
 			logi_dj_recv_queue_unknown_work(djrcv_dev);
-- 
2.56.0

