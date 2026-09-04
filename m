Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34423921CD
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532576; cv=none; b=Ll1OyWS8Nn/dgn+vQGVbip9PjEzDmZ7XA+Y0eudLGowEpg/T+xW5RNl2r0EVgdMD3003l2CyhKE4teMeNlYcL1NoS5BN2SB3757pynBRRp5YCpVmbAdFTPveLOAr3jDAA5kT4kOeHn7oOW4ozZWhmQbOxCsXGuNQ9PMUsZNBxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532576; c=relaxed/simple;
	bh=PWY3km9ar9a7dimSAUmiVRUvDX2p8whPPHsTRITwIwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8+f+DoNOjCyrYZckuwZX18MBvMz2fMqY+HUw9gJEUIki+PR4lDjBD4IveWyv3Gh2ANbudyXAfDe6I4sJJAZXxD/6LpphYVjNZymILF+zKDH1cm5lQYVBqhWn4/dNzGnJ5EMFsx+12PksDdDkd+BO4iH/3SoMRNNfQbJAp7zgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zsu9Z3Kk; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsu9Z3Kk"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4af81963f35so653881b6e.0
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788532573; x=1789137373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pihMfb33QLwKDJyjnDPrNw+DJpGm8Za4dV4SX6WTjj0=;
        b=Zsu9Z3KkZ2XQD1+X2jCm7YSJ7ZDhcBpI1e8HzF5++QjzXzxzJyE8M9RYMTH0nJtPDC
         jBIX12oZ9b7gOBf0qQ4xTtfwboIWppidrhlZb1x/5486U1g7cIF3YRmtiqRGAbKE6ycF
         HlTJKPesSHZtb4T6YYvn1Acsk3em9rIGWqzW+AD8Xt7S/NooE2ZRe9GpdKtGMUp+RP6h
         pNyfQVRyBtO1/ykqT4qAQGx82Ob7at+wNK/pFft2gmSzdT6NqEH5dhAbaly91bfAjWPq
         6Q3ilBnVB/+POYAOm5VPm0dAitB5tfYJAHAfODnbiWhIiNQDHtySSJYGuKE+dRznOGiL
         o06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532573; x=1789137373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pihMfb33QLwKDJyjnDPrNw+DJpGm8Za4dV4SX6WTjj0=;
        b=DezSSeHPQpvICvh9BsEOarA9/CMkjixT5WPvuNB2pHOo8eg9IH7iGi7F2/TFtgx9jB
         Ccl7Al5pfZWryec29IPQHAAGyftAeZ1YXFh0rJu4kOdDu37UZNh6T32MFdtuVtHk4tT7
         UUYRzTyruOt0bIY2u+M+OgQDUCiBcz9r+cicVfd7t5Cttt62IRi5Qc3aZwQHv2fe5NO/
         SqWxnXwPNdpk4oVEQnqc/mX32WKa5hbbAJQhGT0lxJQZVC3b5EwxQEAWBSoO6O5JP9rU
         q6xQcPlKkCS7cl7vw1CZFzyciPkwE1q6S4dRjoemUo0JZJk0BwxofbCAACg2bVQM1o3p
         aoNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWIOt8LKvg0zP5aIhOV+iuAuu5S26wohfUNh+jfjak8zdgpACJhWwLpchBU+mcyEv7ZG8qUhtr2oWdIg==@vger.kernel.org
X-Gm-Message-State: AFuF++mOZsY1NlroTp4vgmkE5RLcykqRjyp+SWIIihqXGNtAzlbL+LHd
	5zJqOoIzqe49YheO5RQjLrbL5uNzEwyTDic9PuI68qZS7Puz8AJpasMQfLjoq+n1nEE=
X-Gm-Gg: AYBFou10mh71TgdxLx7rtPTYgIJ1B7whDjFNbwzmy07I/CWu36gLvuWpHhX6rOpzh8S
	e1SmkzrkQvYKbTnjf/VvyAtLSDUK0YtreH+klaJv8sZW6u5RicUuXCyLGdg7cK/vpkRYlyZ1v2v
	mh51/L/npMDWEAA+6dd8V3p+ei2vclmXopFblbQBl+hJ43pX5P8gHZGg14olTFyXof3opN3oxUU
	wT23CMLBYSzNdZqchBogLsZgcwl9kRJ4x4gFQpROckAVW6waz7c3MEZ1Cn/7AjF/ItUWtOi78VB
	JbHrvN+LH36W5QTdJ3W3Or1jBSH5qH8yEoKRLLTIk9D8wwOyERJow397mlXMyPvaxI5jw1JNGVJ
	mNmsZz0kABhCvL3xktbyoOCS7f1KtQ6rG9bFnOqKfEgw66qOHqsWO30mkTSN522DQvjWo9WWh1G
	6zdJ28ewQbDGxirfFGXGxVbpGb13zzCtUxMx3X6c25rsaXKJMjrheJF6XnbZdiUtvgj5dgM+gaj
	QDadRhjR5Qg9dPTyyjj+XESLHuhnsDsYgkGM2sU28g=
X-Received: by 2002:a05:6808:4fcb:b0:4b3:8ff9:72b3 with SMTP id 5614622812f47-4b95fd5b2e4mr6721009b6e.2.1788532573522;
        Fri, 04 Sep 2026 07:36:13 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971675f82sm2169396b6e.12.2026.09.04.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:36:12 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: corsair: cancel worker after unregistering LED, not before
Date: Fri,  4 Sep 2026 09:36:10 -0500
Message-ID: <20260904143610.119808-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

corsair_remove() tears down each LED with:

	removed = true;
	cancel_work_sync(&led->work);
	led_classdev_unregister(&led->cdev);
	kfree(...);

led_classdev_unregister() calls led_set_brightness(led_cdev, LED_OFF),
which reaches the driver's k90_brightness_set() and re-arms the worker
with schedule_work(). That happens after cancel_work_sync() has already
run, so the work item is queued again and the structure holding it is
then freed while it is still linked into the worklist.

The corruption surfaces on the next worklist insertion rather than in
the driver itself:

  BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x186/0x210
  Read of size 8 at addr ffff888102a1ead0 by task kworker/0:1/11
    __queue_work+0xade/0x1350
    queue_work_on+0xb6/0xc0
    led_classdev_unregister+0x26b/0x340
    corsair_remove+0x1c2/0x2d0
    hid_device_remove+0xba/0x1e0
    usbhid_disconnect+0xa0/0xe0
  Allocated by task 129:
    corsair_probe+0x560/0xd50
  Freed by task 11:
    corsair_remove+0xec/0x2d0

k90 is freed in k90_cleanup_macro_functions(), and the stale
record_led.work entry left on the worklist is then tripped over by the
queue_work() that k90_cleanup_backlight() performs immediately
afterwards. The syzbot report appears to be the same bug on the other
LED, surfacing later when the worker itself runs and reads led->removed
from freed memory, but that variant was not reproduced here.

Cancel the worker after led_classdev_unregister() so that nothing can
re-arm it before the memory goes away. The removed flag is still set
first, so a worker already past the flag check returns without
dereferencing led->cdev.dev, which is what commit eb51c9f8cb4f ("HID:
corsair: cancel worker before unregistering LED to fix use-after-free")
set out to prevent. The fail_sysfs error path in
k90_init_macro_functions() already uses this ordering.

Reproduced by binding a configfs USB gadget carrying the K90's IDs
(1b1c:1b02) to dummy_hcd and then unbinding it; the splat above is from
the first unbind. With this patch the same sequence runs cleanly under
KASAN.

Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
Reported-by: syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=abcedffc9201f2bb66c2
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Reproducer, for anyone wanting to confirm the fix. Needs CONFIG_HID_CORSAIR,
CONFIG_USB_DUMMY_HCD, CONFIG_USB_CONFIGFS_F_HID and KASAN. It fakes a K90 with
a configfs gadget on dummy_hcd and unbinds it; unpatched, the splat above fires
on the first unbind. syzbot has no reproducer for this one.

  #!/bin/sh
  # Reproducer for the hid-corsair teardown use-after-free.
  #
  # Emulates a Corsair K90 (1b1c:1b02) with a configfs USB gadget bound to
  # dummy_hcd, so hid-corsair probes and registers its two LEDs. Unbinding the
  # gadget drives corsair_remove(), which is the path under test:
  #
  #	removed = true;
  #	cancel_work_sync(&work);        <- work cancelled
  #	led_classdev_unregister(&cdev); <- led_set_brightness(LED_OFF) re-queues it
  #	kfree(k90);                     <- freed while still on the worklist
  #
  # The splat surfaces on the *next* worklist insertion, as a KASAN
  # slab-use-after-free in __list_add_valid_or_report() under __queue_work().
  #
  # Run inside a KASAN guest. Fires on the first unbind.
  set -e

  G=/sys/kernel/config/usb_gadget/k90

  mountpoint -q /sys/kernel/config || mount -t configfs none /sys/kernel/config

  UDC=$(ls /sys/class/udc | head -1)
  [ -n "$UDC" ] || { echo "no UDC found (need CONFIG_USB_DUMMY_HCD)"; exit 1; }
  echo "using UDC: $UDC"

  cleanup() {
  	[ -d "$G" ] || return 0
  	echo "" > "$G/UDC" 2>/dev/null || true
  	rm -f "$G"/configs/c.1/hid.usb0 2>/dev/null || true
  	rmdir "$G"/configs/c.1/strings/0x409 "$G"/configs/c.1 2>/dev/null || true
  	rmdir "$G"/functions/hid.usb0 "$G"/strings/0x409 "$G" 2>/dev/null || true
  }
  cleanup

  mkdir -p "$G"
  cd "$G"
  echo 0x1b1c > idVendor          # USB_VENDOR_ID_CORSAIR
  echo 0x1b02 > idProduct         # USB_DEVICE_ID_CORSAIR_K90

  mkdir -p strings/0x409
  echo "0001"    > strings/0x409/serialnumber
  echo "Corsair" > strings/0x409/manufacturer
  echo "K90"     > strings/0x409/product

  mkdir -p functions/hid.usb0
  echo 1 > functions/hid.usb0/protocol      # keyboard
  echo 1 > functions/hid.usb0/subclass
  echo 8 > functions/hid.usb0/report_length
  # Standard HID boot-keyboard report descriptor, 63 bytes.
  # NOTE: octal escapes, not \xHH -- Debian's /bin/sh is dash, whose printf does
  # not implement \xHH and would write the escapes out as literal ASCII text.
  printf '\005\001\011\006\241\001\005\007\031\340\051\347\025\000\045\001\165\001\225\010\201\002\225\001\165\010\201\003\225\005\165\001\005\010\031\001\051\005\221\002\225\001\165\003\221\003\225\006\165\010\025\000\045\145\005\007\031\000\051\145\201\000\300' \
  	> functions/hid.usb0/report_desc

  desc_sz=$(wc -c < functions/hid.usb0/report_desc)
  [ "$desc_sz" -eq 63 ] || { echo "BAD DESCRIPTOR ($desc_sz bytes, want 63)"; exit 1; }

  mkdir -p configs/c.1/strings/0x409
  echo "c1" > configs/c.1/strings/0x409/configuration
  ln -s functions/hid.usb0 configs/c.1/

  echo "binding gadget..."
  echo "$UDC" > UDC
  sleep 2

  dev=$(ls /sys/bus/hid/drivers/corsair/ 2>/dev/null | grep ':' || true)
  [ -n "$dev" ] || { echo "hid-corsair did not bind - check dmesg"; cleanup; exit 1; }
  echo "bound: $dev"
  echo "LEDs: $(ls /sys/class/leds 2>/dev/null | grep "$dev" | tr '\n' ' ')"

  echo "--- unbinding (triggers corsair_remove) ---"
  echo "" > UDC
  sleep 2

  cleanup
  echo "done (no splat)"

 drivers/hid/hid-corsair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb565d..ac12877a6db7 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -524,8 +524,8 @@ static void k90_cleanup_backlight(struct hid_device *dev)
 
 	if (drvdata->backlight) {
 		drvdata->backlight->removed = true;
-		cancel_work_sync(&drvdata->backlight->work);
 		led_classdev_unregister(&drvdata->backlight->cdev);
+		cancel_work_sync(&drvdata->backlight->work);
 		kfree(drvdata->backlight->cdev.name);
 		kfree(drvdata->backlight);
 	}
@@ -540,8 +540,8 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		sysfs_remove_group(&dev->dev.kobj, &k90_attr_group);
 
 		k90->record_led.removed = true;
-		cancel_work_sync(&k90->record_led.work);
 		led_classdev_unregister(&k90->record_led.cdev);
+		cancel_work_sync(&k90->record_led.work);
 		kfree(k90->record_led.cdev.name);
 
 		kfree(k90);
-- 
2.55.0

