Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794390237;
	b=I/7ZoZ4zSZlDEfczMGqpOyY8tCVGjTD1mLf+M49zXQ6JjMW1AxOaagLji/+ANrtY5Vkx
	 q5Y3823eDc1WGduLEp0rbpKTb+uEe2YmgidZFeKl5CGtZQL0AgXprxr9mqYP8tggMDOSH
	 OpPdRdVXr4QRKg2k9BcLs3rAJuUMqzw9dChpDNaPLPsUdi+qFrUw/A9yRAwTS979D2R1b
	 l+mbH+FVap9WM7SIE9qj/LWzcO82ASSh5gi1XuaklXFtNO5GmY3WbV8b4AOSro5awrvM7
	 guouur1+NC6CvaHZ9UqldLIBydwMuVapfOZ1UYeJqqnPoNG15CO2xEQPpuzBRJ7kzDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390237;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tBrvuQofsQVHTjRZ0TF/zfIfiQgVG3VQ2Vk1K2LUXrc=;
	b=xBbH2LHeFqQCjEv71OQZ3hGDDbvNdYXHu70UzkzyxzmBfNM/0DVrYM6CdmfhqwVD/eXu
	 wfzEYInQrptbwUl1Z/ce4TnpyLux69IU6q1A/6BIHFe7vVTeXrMx22mOZh0PNTSWMPhBh
	 N35l5x2oxzxHCUhfYojhFPlgYTHY5k/3p7xzT718Ee2UigyXJcGLyaPQCSkxMUhyla+8H
	 Bmp2zHV86Xl21zHQArtyMKnfQBV7w8IxHRvv1Ev0N+6N8cNXgAdFf2cZy34RF1RXa5ses
	 tjputmcWl/ZRy8TRhHWrU+BnFMlp8fuoYFB7fvov+Gx9jFMj2SxXGFSWzOyuseEApTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jy5lMV9B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3526606A31C;
	Wed, 11 Nov 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jy5lMV9B
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794390237;
	b=VFCB6GEWvU3s2kR2YgLiaqIfSKDcf6yS3eJXJh+TIEderaFkuxpIfJXJF72CbL0MS5+Q
	 xeqXgFJoo/fwliBVr0FAISdb4RE3UQIFKA+ns/cboUD+scElC4mL9JWzauh5rYEItio5g
	 7tUzK4Xk3oS3j8MmzSg0L6q9frool20zBHxc1v2w5yGw95su0Qgz2DBw3ohcIlc5+P2Hj
	 Qdok92MzBakeBE+8NhwU23uEVN2X5hec0FObkJ110sZBzetu+ui2+L5dOn29zwxj4pBwK
	 oncqFPZ/8NEwjfN9+8TAEeAXTWDH4GxPWDVu4ajxkGwLIbQwWpdrK4vyquttH7+PoHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794390237;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tBrvuQofsQVHTjRZ0TF/zfIfiQgVG3VQ2Vk1K2LUXrc=;
	b=nw9s7RKMFWKK0lZdSwtCKOOjwleasPI5US6jHzeYXdBytYi128tbUqJ/n7rs/m201frH
	 L6ArIXHxvbqIvTApRhaUx83HbunBpSOd04u43Y0oDAmSCp4r1JxPDfzV3XpZGwvEjHdk/
	 0W1GrNCEkOcWvPGuPOjPaBy4CWPvnc6wc9oKvZpwXPuCJsaCW2X38opDEKEKc5f8rl6o+
	 +Gm8SDuSLevGITivkRpyT4aycL/SKXsbzq+0G/+gJy2JKMq6wBT+BNF15LLVYDp+JKW6m
	 hET4DfFzihEkcQ4lEUbLFaBR3SJfI233PahftZQhdeiTq8ptpOBjdKDKVzgnExl/iSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0C5741F00A05;
	Wed, 11 Nov 2026 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794390237;
	bh=tBrvuQofsQVHTjRZ0TF/zfIfiQgVG3VQ2Vk1K2LUXrc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jy5lMV9B+B9/fevZoDeDJeyrbHFvDJp6j0p8vElfGMZAlRHNkm6yPhep7GnyXu70r
	 v30WflON6cYJb3PH9K+TmMSSUi9hprhn3/S/V/VRHPCUtovXwf3WM7EYU/Odm8PVTH
	 6Fta3f3Vg9FAY7SRDcCkL04c0oH/KdQB1DRAIc133/wUkDxxy7R4Ovn9k5oBR4TRqA
	 vQcDZKZGF7dUOcJZd9GJoffSf+CAdMZFA5hqvSo/K34zhrlH9Pc+h8e5vQIVqZaoTV
	 LrgsOvEZVgymMiKCFqDhS+Ocf7YfsQ/+7DNLtPtjN6M9qjd/KieobQq9uV2hpM/PJR
	 drVCO5bDDakug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7B43F48F08;
	Wed, 11 Nov 2026 09:43:56 +0000 (UTC)
From: Andreas Claesson via B4 Relay <devnull+andreas.aclaesson.com@kernel.org>
Date: Wed, 11 Nov 2026 09:43:56 +0000
Subject: [PATCH] HID: corsair: cancel record LED work before unregistering
 on probe error
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-hid-corsair-k90-fail-sysfs-v1-1-cc4e94fce0d7@aclaesson.com>
X-B4-Tracking: v=1; b=H4sIANs49GoC/yXMwQ6CMAyA4VchPdukcFgYr2I8zK2TAgHTCtEQ3
 p2p/+27/DsYq7BBV+2gvInJMhfUlwpiH+YHo6RiaKhxdQl7SRgXtSCKoyfMQSa0j2VDIuczUeK
 WPJTBUznL+ze/3v629T5wfH2PcBwnPpnfCX4AAAA=
X-Change-ID: 20261111-hid-corsair-k90-fail-sysfs-0069f00de809
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Chen Changcheng <chenchangcheng@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794390235; l=3216;
 i=andreas@aclaesson.com; s=20261109; h=from:subject:message-id;
 bh=AfZsCSc4vmh8r8ztMc4LlA/iXXjDtYgcw7FLeTP0TZ4=;
 b=9TRUvPQX7pyab172758im1GSniVTTXNwFXUY+kR4//I1tsTRUSsizsTzoIqidibHKqdgNTBx5
 Hhrh7fPINr+DvjmezlBQQzSKmB/RVx52GIG4if+MHcrwcwcMMq77Mx4
X-Developer-Key: i=andreas@aclaesson.com; a=ed25519;
 pk=oC+38UX0rqcrEjNMgnKAF1zmrTUMbQ2aH/P5Z4TZOIQ=
X-Endpoint-Received: by B4 Relay for andreas@aclaesson.com/20261109 with
 auth_id=1465
X-Original-From: Andreas Claesson <andreas@aclaesson.com>
Reply-To: andreas@aclaesson.com
Content-Transfer-Encoding: 7bit

From: Andreas Claesson <andreas@aclaesson.com>

Commit eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering
LED to fix use-after-free") moved cancel_work_sync() in front of
led_classdev_unregister() in the removal paths, because
k90_record_led_work() checks led->removed only once and then
dereferences led->cdev.dev:

	if (led->removed)
		return;

	dev = led->cdev.dev->parent;

The fail_sysfs error path in k90_init_macro_functions() was not
converted and still unregisters the LED before cancelling the work.
The record LED is registered, and its brightness attribute writable,
before sysfs_create_group() runs. If a brightness write queues the work
and sysfs_create_group() then fails, a work item that has already
passed the removed check can dereference led->cdev.dev after
led_classdev_unregister() has freed it:

  CPU0                                  CPU1
  k90_init_macro_functions()
    led_classdev_register()
                                        k90_brightness_set()
                                          schedule_work()
                                        k90_record_led_work()
                                          if (led->removed) return;
    sysfs_create_group() fails
    record_led.removed = true
    led_classdev_unregister()
      device_unregister(cdev.dev)
                                          led->cdev.dev->parent  <-- UAF
    cancel_work_sync()

Cancel the work before unregistering, as the removal paths do. Keep the
cancel after led_classdev_unregister() as well, since unregistering
turns the LED off and k90_brightness_set() queues the work again.

The problem was pointed out by the Sashiko AI review of a related
patch. It was confirmed on a KASAN kernel with a debug-only change that
forces the sysfs_create_group() failure and widens the race window:
without this patch KASAN reports a slab-use-after-free in
k90_record_led_work(), with it the error path completes cleanly.

Fixes: 6f78193ee9ea ("HID: corsair: Add Corsair Vengeance K90 driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/bug/linux-2f786541-d064-428e-a1ab-d203d4112002
Signed-off-by: Andreas Claesson <andreas@aclaesson.com>
---
The Sashiko AI review of my earlier hid-corsair patch [1] pointed out
this pre-existing race in the probe error path. This patch is
independent of that one and applies on its own; the two touch
different functions.

[1] https://lore.kernel.org/r/20261109-hid-corsair-k90-uaf-v1-1-0621c2c5c451@aclaesson.com
---
 drivers/hid/hid-corsair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb565d..768fbcafb3ad 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -507,6 +507,7 @@ static int k90_init_macro_functions(struct hid_device *dev)
 
 fail_sysfs:
 	k90->record_led.removed = true;
+	cancel_work_sync(&k90->record_led.work);
 	led_classdev_unregister(&k90->record_led.cdev);
 	cancel_work_sync(&k90->record_led.work);
 fail_record_led:

---
base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
change-id: 20261111-hid-corsair-k90-fail-sysfs-0069f00de809

Best regards,
--  
Andreas Claesson <andreas@aclaesson.com>


