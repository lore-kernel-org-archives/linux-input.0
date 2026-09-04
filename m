Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A63E6DD5
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538562; cv=none; b=X7IAtQxLnMP81GXxq5xXbUswNyI2OiiQaiXNKH+eXE+PaN49xFdvh/MNQ2MupZFBlvbsSe7j/iNFq0bgS1ch3UaQRTrV/mPCFqxweb00/qYpTpk9T7ECUWKlO3ACDbNagH0sRPYthcjSDlgapr4ZPgM8blFe3t6JOodqDzuCF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538562; c=relaxed/simple;
	bh=RcAGFUg1z+YcHee5CAWGvwD5i9w/2k+xAov1aHj+l2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/bNRFBUL1qqPXWeSGvDNm/LMulbu2eK5zAqWkw4y6eyvKobMU+pfvTgEQYH+gNfifORmsRIklN8qmO/hRhyFEvvul7rEUVn1eto0DPOHpdCsutrkK9TMDnHNoV2HQcWq7pfQHdnHeuxDy6V7IGUdldzmZVRvbBSsL9C/RK4uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpWGLava; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpWGLava"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f0167e59a3so986169a34.0
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788538558; x=1789143358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1hemwYtwG/7uIhW+qr1t1TgzDnEp44et00l3jfA9Gc=;
        b=PpWGLavasMJIbRdZrf6vNvPrZeQUXSecZeucaH1B8OwWTWEJ5jacssR1FybuAZnZ4R
         XRXnHYVHzbQlVl4fq7NUcOyHlql1T9Dml9QC8sV3i+7vQN6Z+TDnuk7xPGZyJHioaAMW
         1VJ2UuYr2K7SeENwndwJdB4TSS+CxHKamp/S7uw4NzvDcKr1MIMnV6vG9Ql7nMOreF9L
         0w/DVWmVOuS6SVCi1YPfLHZTodfjAju37MkMyP+v+r9Qj1owRoEnPoSws+gWWgVNMwbg
         VDB+5rk3wrq/oOpBYD9k6rJvirQEYLEFZW2kx2qmbmBiYb196e/+CpNJBpAJeU1eS2Zv
         QDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538558; x=1789143358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1hemwYtwG/7uIhW+qr1t1TgzDnEp44et00l3jfA9Gc=;
        b=EpslJo97AA3NFsasuPoZpnSM/oVW//XAwGUrAa+7RuDX2oHoCEKmcnVEmT36mYIUQ+
         y9OJAhFNPtTwGd0nmKbKKkwqMs5HPB9u+JXJTNXdbmmyTLGgTx4LPC2Nbiq5orSLKRMk
         1C7wSdFNklHiOQanpkMNj52kXqFUep64SDsysCHTuMr9FNjowE0QStlHiiTI8+l3ljzN
         AKLajtAuZrsAVfo+XDY3fVHaX7h7NuubEmAD7v7iDlTZKQva4qvusCMD4f5Zlrdcee6L
         zHUs+GMzlaDDBh6dlmvgWTs4eVvNbYBEcmjEk76nV9liT17eR3VWWdbCmoAfjGKvWQI9
         CypQ==
X-Forwarded-Encrypted: i=1; AKwUvByJgdOY/IZKgVgNiAN+UCNzoI2SghzgAPAuTjmRnG70RA37kEOWLzgFDMn8bkMtHHJLv394aul+S4Zruw==@vger.kernel.org
X-Gm-Message-State: AFuF++k3qg8pX0IAukcfj81n5uT/PsrJRrS+E+ax2KUpfi6XUmvffpb/
	lqRNpnxLFHAPQ/Bgf+b89rRcPimgZnL8NGZRe3X0ulNQzl2LfQq6DQGM
X-Gm-Gg: AYBFou3jLB/3Z7Eps/PfyKgwinOJ1EaA8N13ok8Cme/9GGIwaQPIOB9LEv4Kfwb27uG
	5u/nyGIWDcWk1bSlXjubEHQ65G5X//z7VWigOmEtjm20HfpOwgAjL2fdl2XGb7pwSqyVuyk1ETq
	DGotoXUQyGTpFjBKUXI0MS4Uw0nU90mZ5DuKDj9+05ceoU/aSFI8FcBdUOhwJ7PMeUlaZ55IwUm
	sVRoCtN1ZA1Uuzp1NQRbgGs+AOoYO05y6xi56W/GLuRPr7G9KPNL7uVRUVIMWTlR6LKQ2nGIibV
	yfsncNSm0t1N/SJGvC0RpXiHSxSIi/YWjkZBtUiw076hvhiynPvKAXBHOUAp7qf1RgStytAasLo
	PAuqIuHi5WGmXwQS8DmFD6EoX/RVD3doD9MmsPmm1umnuKY0C3KHqd58lIUjIzt1ASOXAzprFDA
	M/sqd9ci9surf4FsQR6IFmcUyMSfwL+sJzyQgEUcUIEOGUOcQqxsJKofTBhOnCSXvowD/wD/wp2
	YoAiYDR3bf27r7keDtEhbbB02NGDdg=
X-Received: by 2002:a05:6830:211a:b0:7fa:ab72:9dfa with SMTP id 46e09a7af769-7faab72a5c0mr3279420a34.18.1788538557859;
        Fri, 04 Sep 2026 09:15:57 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fa02cddc41sm3275988a34.22.2026.09.04.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:15:57 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com
Subject: [PATCH v2] HID: corsair: use disable_work_sync() to tear down the LED workers
Date: Fri,  4 Sep 2026 11:15:31 -0500
Message-ID: <20260904161531.160118-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904143610.119808-1-danishkhateeb03@gmail.com>
References: <20260904143610.119808-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tearing down the K90 LEDs races with their brightness workers in two
different ways, and swapping cancel_work_sync() and
led_classdev_unregister() around only trades one for the other.

Cancelling before the unregister, as k90_cleanup_backlight() and
k90_cleanup_macro_functions() have done since
commit eb51c9f8cb4f ("HID: corsair: cancel worker before
unregistering LED to fix use-after-free"), leaves
led_classdev_unregister() free to re-arm the worker: it calls
led_set_brightness(led_cdev, LED_OFF), which reaches
k90_brightness_set() and schedule_work()s the item again. The structure
holding that work is then freed while it is still linked into the
worklist:

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

Cancelling after the unregister avoids that, but reintroduces precisely
the use-after-free that commit set out to fix: a worker that has
already tested led->removed and found it false goes on to dereference
led->cdev.dev, which led_classdev_unregister() has meanwhile freed via
device_unregister().

Use disable_work_sync(), which provides both halves at once. It waits
for a worker that is already executing, so nothing can be sitting
between the led->removed test and the led->cdev.dev dereference when the
device goes away, and it makes the subsequent schedule_work() from the
LED_OFF callback fail rather than queue, so nothing is left on the
worklist to be freed. The ordering then stops mattering. The removed
flag is left alone; it is redundant for these paths now but harmless.

The fail_sysfs error path in k90_init_macro_functions() unregisters
before cancelling, and so still carries the dereference-after-free that
was fixed in the teardown paths, so convert it too.

Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
Reported-by: syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=abcedffc9201f2bb66c2
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Changes in v2:
- v1 moved cancel_work_sync() after led_classdev_unregister(). That was
  in effect a revert of the commit in the Fixes: tag and reintroduced
  the use-after-free it fixed; thanks to the Sashiko review on the v1
  thread for catching it.
- Use disable_work_sync() instead, which closes both races without
  depending on the ordering at all.
- Also convert the fail_sysfs error path in k90_init_macro_functions(),
  which v1 left alone and which still had the same use-after-free.

Tested with the reproducer below on a KASAN kernel with panic_on_warn=1,
so any report would have been fatal: 15 probe/remove cycles, no reports.
Unpatched it panics on the first unbind. That exercises the re-arm race
only. The dereference-after-free race is a few instructions wide and I
was not able to trigger it, so that half rests on the disable_work_sync()
semantics and on the analysis in the Fixes: commit.

Reproducer. Needs CONFIG_HID_CORSAIR, CONFIG_USB_DUMMY_HCD,
CONFIG_USB_CONFIGFS_F_HID and KASAN. It fakes a K90 with a configfs
gadget on dummy_hcd and unbinds it. syzbot has no reproducer for this one.

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
 drivers/hid/hid-corsair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb565d..f966005d69dd 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -507,8 +507,8 @@ static int k90_init_macro_functions(struct hid_device *dev)
 
 fail_sysfs:
 	k90->record_led.removed = true;
+	disable_work_sync(&k90->record_led.work);
 	led_classdev_unregister(&k90->record_led.cdev);
-	cancel_work_sync(&k90->record_led.work);
 fail_record_led:
 	kfree(k90->record_led.cdev.name);
 fail_record_led_alloc:
@@ -524,7 +524,7 @@ static void k90_cleanup_backlight(struct hid_device *dev)
 
 	if (drvdata->backlight) {
 		drvdata->backlight->removed = true;
-		cancel_work_sync(&drvdata->backlight->work);
+		disable_work_sync(&drvdata->backlight->work);
 		led_classdev_unregister(&drvdata->backlight->cdev);
 		kfree(drvdata->backlight->cdev.name);
 		kfree(drvdata->backlight);
@@ -540,7 +540,7 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		sysfs_remove_group(&dev->dev.kobj, &k90_attr_group);
 
 		k90->record_led.removed = true;
-		cancel_work_sync(&k90->record_led.work);
+		disable_work_sync(&k90->record_led.work);
 		led_classdev_unregister(&k90->record_led.cdev);
 		kfree(k90->record_led.cdev.name);
 
-- 
2.55.0

