Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697731;
	b=1RqyJ/5Tr5QHbmUOJkTdeRPsMQNJ7tDx45WrQWfDDPcgIF+U7XtXTaaZIXP/WEf+E0wh
	 NVcYN3arpfqeuQCpKiFY/1KU7EcH2Pfa9BGVTPTHrLXapNPuix1ftv+8AgM3e0aqorOGa
	 KlyolX4APM7CG1xT61YCcps+Yic5nEmmZThYIO/wRwyO7WldpgfU2O6LXDpSNt/nuUXUd
	 vNLjIFXPfyVHDbvtEi3LhFskTv70zCSBtOuHPu9kI8z7j7OcoasYQANmlc3shVWzvS0Lx
	 vSxRyLHQ9nF9H8YRQ5YwNI3FoMQn5a3rJOjerdhvUWjmLfff+5ub0vQncpMjrSYCwow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=73TIHSCN+qxiI12mkdUErzzAUF8R8pzSjPphT4gjK/I=;
	b=pm+MVSep+uOjbmUIS7Rox5WLaIgp+xCzrqSsenb0BmHiWpBijpLdOBDY28IZ4+TaeZRX
	 njdJROrYZgwBYdwtTWJNFt+KLpQ7jKo911kcalZ+upOXMJadfuZw0TDTtQttQiSXlRjZh
	 5HeVeURb/gLnll8Iv+7ThMD2qZatf6Q4JCd56fcdj5AE8rUqoyGz8wERiduwzhX3tWYg2
	 ROlgADg+kkSL0jkSmV6h9oVyjJAb/UZ0/ndGsM1UbuvCR4h//yePT9xU8a8aH49WNdjfO
	 IlseR0GuTYdRdqlzVlzcEzEJv94/9UB77Xa5bHPf3VvF3Oeznh8wmESAuzBvBg3fPIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ClraR5jS;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36C60A5BE3
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 23:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF36C60A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ClraR5jS
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e47347279so848007f8f.1
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 15:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697729; x=1795302529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73TIHSCN+qxiI12mkdUErzzAUF8R8pzSjPphT4gjK/I=;
        b=ClraR5jSwcHjByOmeuBJDLMqtEkSSqGBiTmkiEdT1AXMWjIE5qESQO4qDqIOS220ab
         5gi+8x5v2SNL5eO0MoKFVR12NQbozBaKf5g7FtJ01zOKVPBtKlYa7RJzcZLu0q2YuejP
         xNM+1jzIzytvpmUQgCzdFtDKt7Yw8hdTXWkEL21eI2+888rzaTYCVSU8j70emTRbRShs
         xhZnSwj9GfABWrnZ+eytBpWGWNKTGDmngwau1keK67Tc6ULOSy10Sr/LgGHcO/IaAWOp
         SagUg4ZmDdJc306Xp9yMrD2pt7kX8KkyAH76IutPtCnWWWlZHvXf2CbQYUnVa6R/QkjE
         24oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697729; x=1795302529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=73TIHSCN+qxiI12mkdUErzzAUF8R8pzSjPphT4gjK/I=;
        b=BOfrNdHaBbUw7TueZbrveJVh5TZEVVKNlS6PvTD5eX4KhTCgfBIr5D8u3v48lPcbT6
         P/aB29zpM7hTirKOWkcjsey5Pgn38mFrpM4hpCW2XBBrb8FaOja8HHH0XDrdZKMRwXP2
         n1t1n2Legh6l8Cb2bCt61G6oQmSG2Kxtxyj1DfcTqEXHh237qNYJZ/bhP3IVeokrPPOJ
         u25GlO/DJjsVB3cKHyKmtSsu57htgYbu6X+gdzzJeOZS0LTFZWdvu25ZWgaRs2aIic2U
         mMymP6fwMpDap0X2QQf8m/SI1QlUJdkDD4L4NNCQgIsomJV6m6nAI6j1AAYHCpNLm2Tv
         e34A==
X-Forwarded-Encrypted: i=1; AL+hErG0VbQjuyrvKcImhhPXAholEa2/WnuXMdZw8PgO8SwLVzuUNm9ZXmWt7gZjRRKAXVZ94CjTsNy3wBmzcQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+J3RIOBG2feCbH/0oVHWO6I9ka9E1WbP5Ho8ur6jo61dXAUDcy
	J/TwhDGhANa7xkiCtxe9NFm9sesbIYuZa7qRVzuY2RaEg/fGY4rDL2FY
X-Gm-Gg: AYBFou1OOgwQxt6NSmMIaH0+50kA9Vp0itp7jSsBFzw8imwg6VyPAx7dpkfu78jxwNs
	or9CGpo5YnmKoKxAS5jb6W+GGaTo7Z7eLqvJ8/q0H3E/uxz7d1gVygJ/9Y5HW0fP6Gg4dOq+VAe
	qLmDABPb/+8dOtzXtqHd05PC4g0OdmLyORDHiTT2TGI2yTvBIU1Pvf9CbSTCaK/1LNssgAopLOP
	3+ldvn4L9VDcnZZL3FHTEkmFkwYrX9auHeW9sflTM8XiUyCMFr5GGswXD5U9M5Smk8SHBuAIZvi
	27fKx8/L85qGok/OLr0L2z1Zi4tKUC9RYH5+sDGvkIdxVhWQqfRut+49W5OBPN/W3GL+IOoAPFt
	TWmrZD+iL4mXFe8FISXZ2AiweUSggCK6L5thlh6AfVDUT+5C5/MaeuyQcWoa4W+em0vgKHPNMQ2
	hiBkYBDGdeUobUofTzG99ylum9SQORgpmtbel4Zqj220iTTquKZRVuX2jaAOJ3zBptsMCzaREeM
	1ynaX7d6s0GqakvjGX5EJUg2ReuznLNdkAMUgvDIYxG8aOibqVnt4QBUUyOcF7c1RtFgVuWvyja
	oaISIY46Mbtj3AztPsacQm5+a+EO
X-Received: by 2002:a05:6000:268a:b0:48f:d3ba:7314 with SMTP id ffacd0b85a97d-49c7178383emr13853250f8f.21.1794697729296;
        Sat, 14 Nov 2026 15:08:49 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:48 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Andreas Boose <Andreas.Boose@almex.de>
Subject: [PATCH v3 11/16] HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration
Date: Sun, 15 Nov 2026 01:07:55 +0200
Message-ID: <20261114230800.1344401-12-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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

FTDI errata TN_189 (Section 2.1) documents a silicon bug where the
FT260's USB interrupt endpoints are occasionally halted right after
enumeration. When this happens, Clear-Feature ENDPOINT_HALT does not
recover the endpoint and the only known recovery is a USB device reset.

Implement a workaround:

  1. ft260_check_intr_ep_health() observes the STALL by attempting an
     actual interrupt IN transfer. The FT260 does not honestly report
     its halt state via USB_REQ_GET_STATUS (returns 0 even when
     STALLed; confirmed separately by FTDI engineering [1] with a
     USB analyzer trace), so we cannot rely on it; instead we let the
     host controller return -EPIPE when it sees the STALL handshake.

  2. ft260_check_dev_responsive() catches the broader broken state
     where the interrupt endpoint may look healthy but the device
     still fails to respond to control transfers. A USB_REQ_GET_STATUS
     to the device with a short 500 ms timeout fails fast on a broken
     device, preventing later probe stages from hanging on usbhid's
     default 10 s timeouts and starving the usb_hub_wq workqueue.

  3. When either check fails, probe schedules a deferred work item
     and returns -ENODEV so that hub_event releases the device lock
     quickly. Both interfaces of a stalled chip fail their probe, so
     they share a per-chip struct ft260_chip, and only the first
     failing probe queues the work. The work item retries
     usb_lock_device_for_reset() up to 10 times (~10 s; each attempt
     already polls for up to one second) before giving up, then
     unbinds all USB interfaces, calls usb_reset_device() and binds
     them again, to force usbhid to recreate the HID devices and
     trigger a fresh ft260_probe(). The unbind+rebind step is needed
     because usbhid's pre_reset and post_reset both return 0, so
     usb_reset_device() alone keeps usbhid bound to stale HID device
     state. The work clears the pending flag after the unbind, so a
     probe that fails after the reset can queue the next one.

An earlier version of this workaround, which reset the chip once per
interface, was tested by FTDI engineering [1] on a Raspberry Pi 4
Model B Rev 1.5 running Linux 6.12.62-v8+ on an xhci_hcd host, with the
FT260 connected at full-speed through a downstream USB 2.0 hub. Across
28,684 re-enumeration cycles, 350 cycles triggered the recovery path.
Two of those required two consecutive USB resets before the device
returned. All 28,684 cycles recovered to a fully functional state with
I2C and UART working end-to-end. This version, with the fixes below,
was tested on an Intel 9 Series xHCI host running Linux 7.3 with KASAN,
the FT260 in mode 3 at full speed behind a USB 2.0 hub, reset by its
RESETN pin. 101 of 7,781 cycles triggered the recovery path. In each of
them both endpoints were halted and the chip was reset once. All cycles
recovered with I2C and UART working, and KASAN reported nothing.

Queue the work on a driver-owned ordered workqueue flushed on module
exit. Do not treat a GFP failure, in the driver or in usb_control_msg(),
as a TN_189 stall. Queue one reset per chip: a reset queued by the
second interface would tear down the chip that the first reset has
recovered, and a chip that never recovers would add two work items per
cycle. Do not cap the resets: a chip that stalls again after a reset
gets the next one. Unbind before the reset: the unbind waits for a
probe that still runs on either interface, so the reset does not run
while that probe stops usbhid and frees its URBs.

Reported-by: Andreas Boose <Andreas.Boose@almex.de>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/40 [1]
Link: https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-Technical-Note.pdf
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fixes for the issues reported by Sashiko:
- Reset work queued on a driver-owned workqueue that is flushed on
  module exit, so the work does not run after the module is unloaded.
- No USB reset on -ENOMEM, so an allocation failure in probe is not
  taken as a TN_189 stall.

Left as is, reported by Sashiko:
- The number of resets in a row is not capped, because a chip that
  stalls again after a reset needs the next one; in the FTDI test,
  two of the 350 recoveries needed two resets in a row.

v3:
Fixes for the issues reported by Sashiko:
- One reset per chip: struct ft260_chip, shared by the two interfaces,
  is added here, so a reset queued by the second interface does not
  tear down the chip that the first reset has recovered.
- Interfaces unbound before the USB reset, not after, so the reset
  does not run while a failing probe stops usbhid and frees its URBs.
- -ENOMEM from usb_control_msg() returned as it is, not turned into
  -ENODEV and a reset.
---
 drivers/hid/hid-ft260.c | 366 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 364 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f160b5360f89..f51ba3df8890 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -12,10 +12,12 @@
 #include <linux/hidraw.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/workqueue.h>
 #include <linux/usb.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/kfifo.h>
+#include <linux/kref.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/math.h>
@@ -495,8 +497,67 @@ struct ft260_device {
 	bool uart_dcd_ri;
 	/* Set under lock by ft260_remove(); tiocm calls then stop */
 	bool removed;
+	struct ft260_chip *chip;
 };
 
+/*
+ * The I2C and the UART interface of one chip are two HID devices, each
+ * with its own ft260_device. They share one ft260_chip, so that only
+ * one of them queues the TN_189 reset.
+ */
+struct ft260_chip {
+	struct list_head list;
+	struct kref kref;
+	struct usb_device *udev;
+	/* A TN_189 reset is queued; protected by ft260_chip_list_lock */
+	bool reset_pending;
+};
+
+static LIST_HEAD(ft260_chip_list);
+static DEFINE_MUTEX(ft260_chip_list_lock);
+
+static struct ft260_chip *ft260_chip_get(struct usb_device *udev)
+{
+	struct ft260_chip *chip;
+
+	mutex_lock(&ft260_chip_list_lock);
+	list_for_each_entry(chip, &ft260_chip_list, list) {
+		if (chip->udev == udev) {
+			kref_get(&chip->kref);
+			goto out;
+		}
+	}
+
+	chip = kzalloc_obj(*chip, GFP_KERNEL);
+	if (chip) {
+		kref_init(&chip->kref);
+		chip->udev = usb_get_dev(udev);
+		list_add_tail(&chip->list, &ft260_chip_list);
+	}
+out:
+	mutex_unlock(&ft260_chip_list_lock);
+	return chip;
+}
+
+static void ft260_chip_release(struct kref *kref)
+{
+	struct ft260_chip *chip = container_of(kref, struct ft260_chip, kref);
+
+	list_del(&chip->list);
+	usb_put_dev(chip->udev);
+	kfree(chip);
+}
+
+static void ft260_chip_put(struct ft260_chip *chip)
+{
+	if (!chip)
+		return;
+
+	mutex_lock(&ft260_chip_list_lock);
+	kref_put(&chip->kref, ft260_chip_release);
+	mutex_unlock(&ft260_chip_list_lock);
+}
+
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
 					u8 report_id, u8 *data, size_t len)
 {
@@ -2271,6 +2332,7 @@ static void ft260_uart_port_destroy(struct tty_port *tport)
 	struct ft260_device *port =
 		container_of(tport, struct ft260_device, port);
 
+	ft260_chip_put(port->chip);
 	kfree(port);
 }
 
@@ -2427,15 +2489,276 @@ static int ft260_uart_probe(struct ft260_device *dev,
 	return ret;
 }
 
+/*
+ * FT260 errata TN_189 Section 2.1: the USB interrupt endpoints are
+ * occasionally halted right after enumeration. When this happens:
+ *  - Standard Clear-Feature ENDPOINT_HALT does not recover the endpoint
+ *  - Subsequent communication with the device is dead
+ *  - The only known recovery is a USB device reset
+ *
+ * A separate finding from FTDI engineering (confirmed by USB analyzer
+ * trace while testing this workaround) is that the FT260 does NOT
+ * honestly report the halt state via USB_REQ_GET_STATUS: it returns 0
+ * even when the endpoint is STALLed. Detection must therefore observe
+ * the STALL handshake at the host controller level rather than ask
+ * the device.
+ *
+ * Recovery is performed by a deferred work item that unbinds all
+ * interfaces, resets the USB device and binds the interfaces again to
+ * force usbhid to destroy stale HID devices and create fresh ones,
+ * which triggers a new ft260_probe() that succeeds.
+ *
+ * https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-Technical-Note.pdf
+ */
+struct ft260_reset_work {
+	struct work_struct work;
+	struct usb_interface *usbif;
+	struct ft260_chip *chip;
+};
+
+static struct workqueue_struct *ft260_reset_wq;
+
+static void ft260_chip_reset_done(struct ft260_chip *chip)
+{
+	mutex_lock(&ft260_chip_list_lock);
+	chip->reset_pending = false;
+	mutex_unlock(&ft260_chip_list_lock);
+}
+
+static void ft260_reset_and_rebind(struct work_struct *ws)
+{
+	struct ft260_reset_work *rw =
+		container_of(ws, struct ft260_reset_work, work);
+	struct usb_interface *usbif = rw->usbif;
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	struct usb_host_config *actconfig;
+	int ret, i, attempt;
+
+	/*
+	 * Retry the device lock for up to ~10 seconds. The lock is held
+	 * by hub_event for the duration of device enumeration; with the
+	 * fast-fail responsiveness check in probe, both interfaces should
+	 * abort within ~1-2 seconds, after which the lock becomes free.
+	 * Each usb_lock_device_for_reset() attempt already polls for up to
+	 * one second internally.
+	 */
+	for (attempt = 0; attempt < 10; attempt++) {
+		ret = usb_lock_device_for_reset(usbdev, NULL);
+		if (ret >= 0)
+			break;
+		if (ret == -ENODEV || ret == -EHOSTUNREACH) {
+			dev_dbg(&usbif->dev,
+				"device gone before reset (%d), abort\n", ret);
+			ft260_chip_reset_done(rw->chip);
+			goto out;
+		}
+		/* -EBUSY: someone else holds the lock; retry. */
+	}
+	if (ret < 0) {
+		dev_err(&usbif->dev,
+			"failed to acquire USB device lock for reset after %d attempts: %d\n",
+			attempt, ret);
+		ft260_chip_reset_done(rw->chip);
+		goto out;
+	}
+
+	/*
+	 * usb_reset_device() keeps usbhid bound (its pre_reset/post_reset
+	 * both return 0) and does not re-trigger HID-level driver probing.
+	 * Unbind all USB interfaces, reset, and bind them again to force
+	 * usbhid to destroy stale HID devices and create new ones, which
+	 * triggers fresh ft260_probe() calls. Unbind before the reset: it
+	 * waits for a probe still running on either interface, so the
+	 * reset does not run while that probe stops usbhid.
+	 */
+	actconfig = usbdev->actconfig;
+	for (i = 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = actconfig->interface[i];
+
+		if (intf && intf->dev.driver)
+			device_release_driver(&intf->dev);
+	}
+
+	/*
+	 * No probe of the old enumeration runs now. A probe that fails
+	 * after this reset may queue the next one.
+	 */
+	ft260_chip_reset_done(rw->chip);
+
+	ret = usb_reset_device(usbdev);
+	if (ret < 0) {
+		dev_err(&usbif->dev, "USB reset failed: %d\n", ret);
+		usb_unlock_device(usbdev);
+		goto out;
+	}
+
+	actconfig = usbdev->actconfig;
+	for (i = 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = actconfig->interface[i];
+
+		if (!intf)
+			continue;
+		ret = device_attach(&intf->dev);
+		if (ret < 0)
+			dev_err(&intf->dev,
+				"failed to rebind USB interface: %d\n", ret);
+	}
+
+	usb_unlock_device(usbdev);
+out:
+	ft260_chip_put(rw->chip);
+	usb_put_intf(usbif);
+	kfree(rw);
+}
+
+/*
+ * Both interfaces of a stalled chip fail their probe. Queue one reset
+ * per chip: a second one would tear down the chip that the first one
+ * has recovered.
+ */
+static int ft260_schedule_reset(struct usb_interface *usbif)
+{
+	struct ft260_reset_work *rw;
+	struct ft260_chip *chip;
+	bool pending;
+
+	rw = kmalloc_obj(*rw, GFP_KERNEL);
+	if (!rw)
+		return -ENOMEM;
+
+	chip = ft260_chip_get(interface_to_usbdev(usbif));
+	if (!chip) {
+		kfree(rw);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&ft260_chip_list_lock);
+	pending = chip->reset_pending;
+	chip->reset_pending = true;
+	mutex_unlock(&ft260_chip_list_lock);
+	if (pending) {
+		ft260_chip_put(chip);
+		kfree(rw);
+		return 0;
+	}
+
+	usb_get_intf(usbif);
+	rw->usbif = usbif;
+	rw->chip = chip;
+	INIT_WORK(&rw->work, ft260_reset_and_rebind);
+	queue_work(ft260_reset_wq, &rw->work);
+
+	return 0;
+}
+
+/*
+ * Detect whether the device's interrupt IN endpoint is in the STALL
+ * state described by TN_189. GET_STATUS is unreliable on the FT260
+ * (returns 0 even when halted, confirmed by FTDI with a USB analyzer
+ * trace), so observe the STALL handshake by attempting an actual
+ * interrupt IN transfer. The host controller returns -EPIPE when it
+ * receives a STALL handshake.
+ *
+ * Must be called before hid_hw_open() so it does not race against
+ * usbhid's own interrupt IN URB.
+ */
+static int ft260_check_intr_ep_health(struct hid_device *hdev)
+{
+	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	struct usb_host_interface *iface_desc = usbif->cur_altsetting;
+	struct usb_endpoint_descriptor *ep = NULL;
+	unsigned int pipe;
+	u8 *buf;
+	int ret, actual_length, i;
+
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		if (usb_endpoint_is_int_in(&iface_desc->endpoint[i].desc)) {
+			ep = &iface_desc->endpoint[i].desc;
+			break;
+		}
+	}
+	if (!ep)
+		return 0;
+
+	buf = kmalloc(FT260_REPORT_MAX_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvintpipe(usbdev, ep->bEndpointAddress);
+	ret = usb_interrupt_msg(usbdev, pipe, buf, FT260_REPORT_MAX_LEN,
+				&actual_length, 100);
+	kfree(buf);
+
+	if (ret == -EPIPE) {
+		hid_warn(hdev,
+			 "interrupt IN ep %#x halted (TN_189 errata), scheduling USB reset and rebind\n",
+			 ep->bEndpointAddress);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * Quick check that the device responds to a standard control transfer.
+ * When the FT260 is in the buggy post-enumeration state, control
+ * transfers initiated by later probe stages (chip version retrieval,
+ * UART/I2C configuration, etc.) can hang for very long periods,
+ * starving the usb_hub_wq workqueue and preventing the reset work
+ * from acquiring the device lock.
+ *
+ * Issue USB_REQ_GET_STATUS to the device (any compliant USB device
+ * must answer immediately) with a short explicit timeout. If it
+ * fails, treat the device as broken and bail out before reaching
+ * anything that can block.
+ *
+ * The interrupt-endpoint health check above only catches STALLs on
+ * the interrupt IN path; this check catches the broader broken state
+ * that affects the other interface even when its interrupt endpoint
+ * happens to look healthy.
+ */
+static int ft260_check_dev_responsive(struct hid_device *hdev)
+{
+	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	__le16 *status;
+	int ret;
+
+	status = kmalloc_obj(*status, GFP_KERNEL);
+	if (!status)
+		return -ENOMEM;
+
+	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
+			      USB_REQ_GET_STATUS,
+			      USB_DIR_IN | USB_RECIP_DEVICE,
+			      0, 0, status, sizeof(*status), 500);
+	kfree(status);
+	if (ret == -ENOMEM)
+		return ret;
+
+	if (ret < 0) {
+		hid_warn(hdev,
+			 "device unresponsive to GET_STATUS (%d), suspected TN_189 errata, scheduling USB reset and rebind\n",
+			 ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ft260_device *dev;
+	struct usb_interface *usbif;
 	struct ft260_get_chip_version_report version;
 	struct ft260_get_system_status_report cfg;
 	int ret;
 
 	if (!hid_is_usb(hdev))
 		return -EINVAL;
+
+	usbif = to_usb_interface(hdev->dev.parent);
 	/*
 	 * We cannot use devm_kzalloc here because the port has to survive
 	 * until destroy function call.
@@ -2451,6 +2774,12 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
+	dev->chip = ft260_chip_get(interface_to_usbdev(usbif));
+	if (!dev->chip) {
+		ret = -ENOMEM;
+		goto hid_fail;
+	}
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "failed to parse HID\n");
@@ -2463,6 +2792,27 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto hid_fail;
 	}
 
+	/*
+	 * TN_189 errata workaround: bail out fast on a broken device so
+	 * that hub_event releases the device lock quickly, allowing the
+	 * scheduled reset work to acquire it and recover the device.
+	 */
+	ret = ft260_check_intr_ep_health(hdev);
+	if (ret == -ENODEV) {
+		ft260_schedule_reset(usbif);
+		goto err_hid_stop;
+	}
+	if (ret)
+		goto err_hid_stop;
+
+	ret = ft260_check_dev_responsive(hdev);
+	if (ret == -ENODEV) {
+		ft260_schedule_reset(usbif);
+		goto err_hid_stop;
+	}
+	if (ret)
+		goto err_hid_stop;
+
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "failed to open HID HW\n");
@@ -2508,6 +2858,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_hid_stop:
 	hid_hw_stop(hdev);
 hid_fail:
+	ft260_chip_put(dev->chip);
 	kfree(dev);
 alloc_fail:
 	return ret;
@@ -2553,10 +2904,12 @@ static void ft260_remove(struct hid_device *hdev)
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	if (dev->iface_type == FT260_IFACE_UART)
+	if (dev->iface_type == FT260_IFACE_UART) {
 		ft260_uart_port_put(dev);
-	else
+	} else {
+		ft260_chip_put(dev->chip);
 		kfree(dev);
+	}
 }
 
 static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
@@ -2661,6 +3014,12 @@ static int __init ft260_driver_init(void)
 		goto err_reg_driver;
 	}
 
+	ft260_reset_wq = alloc_ordered_workqueue("hid-ft260-reset", 0);
+	if (!ft260_reset_wq) {
+		ret = -ENOMEM;
+		goto err_reg_driver_unreg;
+	}
+
 	ret = hid_register_driver(&ft260_driver);
 	if (ret) {
 		pr_err("hid_register_driver failed: %d\n", ret);
@@ -2670,6 +3029,8 @@ static int __init ft260_driver_init(void)
 	return 0;
 
 err_reg_hid:
+	destroy_workqueue(ft260_reset_wq);
+err_reg_driver_unreg:
 	tty_unregister_driver(ft260_tty_driver);
 err_reg_driver:
 	tty_driver_kref_put(ft260_tty_driver);
@@ -2680,6 +3041,7 @@ static int __init ft260_driver_init(void)
 static void __exit ft260_driver_exit(void)
 {
 	hid_unregister_driver(&ft260_driver);
+	destroy_workqueue(ft260_reset_wq);
 	tty_unregister_driver(ft260_tty_driver);
 	tty_driver_kref_put(ft260_tty_driver);
 }
-- 
2.43.0

