Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246E3F86F7
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859365; cv=none; b=g3eF42RNeqT+s1/pF+okBylQcor4i7eh+pas2swP7aB2CqnFzmpEaVsrPo6zxvfLRptn0Xu9vMAtFriWLLwzZS9RBXkYopfJZ7L5ffs2siNX3lv34up9ghJAL8F+BpjbyGy6tlQXzTQ3ykbGIA3DpFtszfyX7Smvn24vcg9DA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859365; c=relaxed/simple;
	bh=8ZIiG4QkZ7bU+mQ5t/NMjwLNbTZ2gKKVF6YlzBMYzOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URBpcNzYBDooamKhs/pWaiRo+DzJtEpY2RrXrzZ/QLQy8kDJJl4u1p1OMpWzQaOIGc9B8E9uotmBpkK7Mi8dwrsKDZRbHP6uVKSdxAYdpMVdF9wOZFpAYd65s5R57T//sJ9AbVpuoMnrgnxcml4UgsGIRMGIgGR22B0lBMk1d8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQjYqK0V; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQjYqK0V"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1329507c387so9039134c88.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778859360; x=1779464160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ybqKlOC3Bh3goj5nzASeA5Yp9eQPqHKclc4m6rOFdg=;
        b=DQjYqK0VV65eazyglyakMYZ2gfdk+EeGG/I7zDOoV2oFQOdW/mwqoDIeqqLF9QInxn
         WO8LByR3OLPZ4D717EEty3iutiGuyCOEsiOC8iHNM46OvPMHQ7P9DSa8VvT9R85isPiE
         F90ySCdKk38vm7dEz/jtc/DgX31f5ruVOAbblxIyh+aBnMPONBFQ7Nm/pxr/eNK2f+YZ
         r4UKExUfYcYDNidiRMqNR8mj4RsAGuJf0QcuyO6zQXHwBAqZ2tZLE7xsUPkcwF4OjOOq
         A64afZEZjZzLPFHD55/zTi2QtWGuxFumasKM2M9DTXITcnpxvhQSr3lYpsLosGQISq25
         ZL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859360; x=1779464160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ybqKlOC3Bh3goj5nzASeA5Yp9eQPqHKclc4m6rOFdg=;
        b=i+ysYM1O69PCtXQQfaVwm2nMSvFB8xagQ7Gd10bCla5Ix3grsS7RelnN7znQ7BnP9I
         2l0aU3VTISlHUo17YRJUdBSmW9vMc7MylK62HC+gZZtXKPKxbYKNU31F10xg0Z8G/Ic/
         M5iJDzxspykl87Gwxxa2eiUl2LlSMHORdQ3c0TxunFEPhuB+LFzlhube2Tu+JgytwZHc
         XjWmeRBTW0OW5M7GZU9ek3KFhMBpVfnmOEyQHKoo0LHenOMxbOfUMN97ZXgE9F96rW/Y
         xe7SNGQBciex3jR0pbK9KQ3b/zjjhhSKrpQf8kfsv8CN3y/p8y5+UVPFGy0PnOKWqXcl
         tWGQ==
X-Gm-Message-State: AOJu0Yyg9svoJKysckGnGTwUTsIsYngVqXSH5rC87XCeynao3fqHCT3b
	bPLpdfDL34HRiBRKAg94p/zguqvGw6reUTD5hhc4qhCmCZLTLszXPCCUSaCnubvRJOE=
X-Gm-Gg: Acq92OElygl2UDrpFl8/7XjjbdGF7PX3lBHmJX3fx8dccTQEEx0kdqiWj+Cb5HBWNBE
	TlVy2hbGtonDUHDX163oVoy2kR0v446sNuKN9TFlEPdRiwt47rq85xnhKYvvXDgOeEMwpotPp3A
	0pZijsZcHjDe7/pb4IrwLBRT17sKGZKGyQgU4rqbuPPtgoMdX8vNYhw+4qUWjW1hlRRHNHWu5kX
	ireP0TJ/T0GBaEwVvguQovGT6E8TgrZaEGzBaLiwhc+uE+I1zTUg6ojQH0w69SqNupFpKDRTd1C
	AxXbcVKNs7GvWr+PSxilH4rdDYLfnnH90nZe7Q/ITmM/7Radk2rxXTtNOTsUpstVxpu6xWmLVt/
	Crgwhmg4NocD+/y7UsinJMtHpin38VC3kgDdZ208LcBTkKn/vyNaO5wI1KFJjM/H2kPkdaeA9r0
	Ko/3uyKqCDOiPkpoBetyDOPod9J3DK5UJ5BPoC+rLZj8K4O/IBVrSI2+L2DZDeRt9LT4yLFvN6J
	CDi/QoBtthlvFYv1h83IvSk2oQoAMUsOLSrBo5GxZq5/a8gYvdCoLwugrBf5uxC+7WcZj7lB1nS
	1/cBbvTZ7wnwNLj/bQp3U2lBSnzxKZQ=
X-Received: by 2002:a05:7022:2586:b0:12b:ebb9:1c18 with SMTP id a92af1059eb24-135048421b1mr2449169c88.31.1778859359501;
        Fri, 15 May 2026 08:35:59 -0700 (PDT)
Received: from lima-kernel-dev.google.com (ec2-13-52-214-175.us-west-1.compute.amazonaws.com. [13.52.214.175])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a67csm10106132c88.13.2026.05.15.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:35:59 -0700 (PDT)
From: Manish Khadka <maskmemanish@gmail.com>
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: letsketch: fix UAF on inrange_timer at driver unbind
Date: Fri, 15 May 2026 21:20:51 +0545
Message-ID: <20260515153551.76162-1-maskmemanish@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

letsketch_driver does not provide a .remove callback, but
letsketch_probe() arms a per-device timer:

    timer_setup(&data->inrange_timer, letsketch_inrange_timeout, 0);

The timer is re-armed from letsketch_raw_event() with a 100 ms
timeout on every pen-in-range report, and its callback dereferences
data->input_tablet to deliver a synthetic BTN_TOOL_PEN release:

    static void letsketch_inrange_timeout(struct timer_list *t)
    {
            struct letsketch_data *data =
                    timer_container_of(data, t, inrange_timer);
            struct input_dev *input = data->input_tablet;

            input_report_key(input, BTN_TOOL_PEN, 0);
            input_sync(input);
    }

letsketch_data is allocated with devm_kzalloc(), and its input_dev
fields are devm-allocated via letsketch_setup_input_tablet().  On
device unbind (USB unplug or rmmod), the HID core runs its default
teardown and devm cleanup frees both letsketch_data and the input
devices.  Because no .remove callback exists, nothing drains the
timer first: if raw_event armed it within ~100 ms of the unbind, the
pending timer fires on freed memory.  This is a UAF read of data and
of data->input_tablet, followed by input_report_key() / input_sync()
into the freed input_dev.

Fix by adding a .remove callback that drains the timer before
hid_hw_stop().  timer_delete_sync() on its own is not sufficient: a
URB completion still in flight during hid_hw_stop() can call
mod_timer() and re-arm the timer after the drain.

Introduce a spinlock and a 'removing' flag on letsketch_data.
letsketch_remove() sets the flag under the lock, then drains the
timer, then stops the hardware.  letsketch_raw_event() now arms
mod_timer() under the same lock and skips arming if the flag is set,
so no path can re-arm the timer after remove() has drained it.

Fixes: 33a5c2793451 ("HID: Add new Letsketch tablet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Manish Khadka <maskmemanish@gmail.com>
---
 drivers/hid/hid-letsketch.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-letsketch.c b/drivers/hid/hid-letsketch.c
index 11e21f988723..0dc9496d05f8 100644
--- a/drivers/hid/hid-letsketch.c
+++ b/drivers/hid/hid-letsketch.c
@@ -36,6 +36,7 @@
  */
 #include <linux/device.h>
 #include <linux/input.h>
+#include <linux/cleanup.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/timer.h>
@@ -62,6 +63,8 @@ struct letsketch_data {
 	struct input_dev *input_tablet;
 	struct input_dev *input_tablet_pad;
 	struct timer_list inrange_timer;
+	spinlock_t lock;	/* serialises arming inrange_timer vs. teardown */
+	bool removing;		/* set during teardown; gates mod_timer */
 };
 
 static int letsketch_open(struct input_dev *dev)
@@ -189,9 +192,15 @@ static int letsketch_raw_event(struct hid_device *hdev,
 				 get_unaligned_le16(raw_data + 6));
 		/*
 		 * There is no out of range event, so use a timer for this
-		 * when in range we get an event approx. every 8 ms.
+		 * when in range we get an event approx. every 8 ms.  Skip
+		 * arming if the driver is being torn down so the timer
+		 * cannot outlive devm-freed data after letsketch_remove().
 		 */
-		mod_timer(&data->inrange_timer, jiffies + msecs_to_jiffies(100));
+		scoped_guard(spinlock_irqsave, &data->lock) {
+			if (!data->removing)
+				mod_timer(&data->inrange_timer,
+					  jiffies + msecs_to_jiffies(100));
+		}
 		break;
 	case 0xe0: /* Pad data */
 		input = data->input_tablet_pad;
@@ -291,6 +300,7 @@ static int letsketch_probe(struct hid_device *hdev, const struct hid_device_id *
 		return -ENOMEM;
 
 	data->hdev = hdev;
+	spin_lock_init(&data->lock);
 	timer_setup(&data->inrange_timer, letsketch_inrange_timeout, 0);
 	hid_set_drvdata(hdev, data);
 
@@ -305,6 +315,23 @@ static int letsketch_probe(struct hid_device *hdev, const struct hid_device_id *
 	return hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 }
 
+static void letsketch_remove(struct hid_device *hdev)
+{
+	struct letsketch_data *data = hid_get_drvdata(hdev);
+
+	/*
+	 * Block raw_event from arming inrange_timer during teardown so
+	 * timer_delete_sync() below cannot race with a fresh mod_timer()
+	 * issued from a URB completion handler still in flight while
+	 * hid_hw_stop() is running.
+	 */
+	scoped_guard(spinlock_irqsave, &data->lock)
+		data->removing = true;
+
+	timer_delete_sync(&data->inrange_timer);
+	hid_hw_stop(hdev);
+}
+
 static const struct hid_device_id letsketch_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LETSKETCH, USB_DEVICE_ID_WP9620N) },
 	{ }
@@ -315,6 +342,7 @@ static struct hid_driver letsketch_driver = {
 	.name = "letsketch",
 	.id_table = letsketch_devices,
 	.probe = letsketch_probe,
+	.remove = letsketch_remove,
 	.raw_event = letsketch_raw_event,
 };
 module_hid_driver(letsketch_driver);
-- 
2.43.0

