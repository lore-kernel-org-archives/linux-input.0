Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F73D6CCE;
	Mon, 14 Sep 2026 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367211; cv=none; b=eI+oToH7GSM1qHPMp3+uQ3/1hQUuOw+zdmjZiARL4bIr3umWqZ5XwBNiWIXOjcLNWKV5IXtf4C3xTA0A1XtOJ8U/V7c2KehvJUjnq7g6LWY6iHCTG2M5JewmzZ1/6vyI1eOjDCaA2Nmm/vqZq/nE/fOaFp59aV2WktDFXv2z46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367211; c=relaxed/simple;
	bh=lV7i7GM+4oHchfk1MmSbyuQmlQHIcvjDAHx2VLvML+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LT8kBOCwgAk26DO9mey6UYM4HFV2aVuNIlTNoWbptAyMEVwAAjv/e4LS/TUSwb24ZCduDwj8xk1xtRtJYUgcJwkzzdkeRKsYkT0dWXGavBRerTYsI752jIZn/c2ZCFRyjVbYwDB/Tpslm28hrdJU6sAYVORsytidgyy4m19MSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f77eaecb00511f19a56ed5b684f684d-20260914
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:605aa1ad-1f6c-400c-b1ab-eac791696bc4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:0046c5caea5f9e1b0676a410cf6acc14,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|817|850|865|898,TC:nil,Content:-10
	|-8|-5|14|50|99,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3f77eaecb00511f19a56ed5b684f684d-20260914
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 621110634; Mon, 14 Sep 2026 14:26:41 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: danishkhateeb03@gmail.com
Cc: bentiss@kernel.org,
	chenchangcheng@kylinos.cn,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: corsair: use disable_work_sync() to tear down the LED workers
Date: Mon, 14 Sep 2026 14:26:21 +0800
Message-Id: <20260914062621.91336-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260904161531.160118-1-danishkhateeb03@gmail.com>
References: <20260904161531.160118-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Tearing down the K90 LEDs races with their brightness workers in two
> different ways, and swapping cancel_work_sync() and
> led_classdev_unregister() around only trades one for the other.
> 
> Cancelling before the unregister, as k90_cleanup_backlight() and
> k90_cleanup_macro_functions() have done since
> commit eb51c9f8cb4f ("HID: corsair: cancel worker before
> unregistering LED to fix use-after-free"), leaves
> led_classdev_unregister() free to re-arm the worker: it calls
> led_set_brightness(led_cdev, LED_OFF), which reaches
> k90_brightness_set() and schedule_work()s the item again. The structure
> holding that work is then freed while it is still linked into the
> worklist:
> 
>   BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x186/0x210
>   Read of size 8 at addr ffff888102a1ead0 by task kworker/0:1/11
>     __queue_work+0xade/0x1350
>     queue_work_on+0xb6/0xc0
>     led_classdev_unregister+0x26b/0x340
>     corsair_remove+0x1c2/0x2d0
>     hid_device_remove+0xba/0x1e0
>     usbhid_disconnect+0xa0/0xe0
>   Allocated by task 129:
>     corsair_probe+0x560/0xd50
>   Freed by task 11:
>     corsair_remove+0xec/0x2d0
> 
> Cancelling after the unregister avoids that, but reintroduces precisely
> the use-after-free that commit set out to fix: a worker that has
> already tested led->removed and found it false goes on to dereference
> led->cdev.dev, which led_classdev_unregister() has meanwhile freed via
> device_unregister().
> 
> Use disable_work_sync(), which provides both halves at once. It waits
> for a worker that is already executing, so nothing can be sitting
> between the led->removed test and the led->cdev.dev dereference when the
> device goes away, and it makes the subsequent schedule_work() from the
> LED_OFF callback fail rather than queue, so nothing is left on the
> worklist to be freed. The ordering then stops mattering. The removed
> flag is left alone; it is redundant for these paths now but harmless.
> 
> The fail_sysfs error path in k90_init_macro_functions() unregisters
> before cancelling, and so still carries the dereference-after-free that
> was fixed in the teardown paths, so convert it too.
> 
> Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
> Reported-by: syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=abcedffc9201f2bb66c2
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
> 
> Changes in v2:
> - v1 moved cancel_work_sync() after led_classdev_unregister(). That was
>   in effect a revert of the commit in the Fixes: tag and reintroduced
>   the use-after-free it fixed; thanks to the Sashiko review on the v1
>   thread for catching it.
> - Use disable_work_sync() instead, which closes both races without
>   depending on the ordering at all.
> - Also convert the fail_sysfs error path in k90_init_macro_functions(),
>   which v1 left alone and which still had the same use-after-free.
> 
> Tested with the reproducer below on a KASAN kernel with panic_on_warn=1,
> so any report would have been fatal: 15 probe/remove cycles, no reports.
> Unpatched it panics on the first unbind. That exercises the re-arm race
> only. The dereference-after-free race is a few instructions wide and I
> was not able to trigger it, so that half rests on the disable_work_sync()
> semantics and on the analysis in the Fixes: commit.
> 
> Reproducer. Needs CONFIG_HID_CORSAIR, CONFIG_USB_DUMMY_HCD,
> CONFIG_USB_CONFIGFS_F_HID and KASAN. It fakes a K90 with a configfs
> gadget on dummy_hcd and unbinds it. syzbot has no reproducer for this one.
> 
>   #!/bin/sh
>   # Reproducer for the hid-corsair teardown use-after-free.
>   #
>   # Emulates a Corsair K90 (1b1c:1b02) with a configfs USB gadget bound to
>   # dummy_hcd, so hid-corsair probes and registers its two LEDs. Unbinding the
>   # gadget drives corsair_remove(), which is the path under test:
>   #
>   #	removed = true;
>   #	cancel_work_sync(&work);        <- work cancelled
>   #	led_classdev_unregister(&cdev); <- led_set_brightness(LED_OFF) re-queues it
>   #	kfree(k90);                     <- freed while still on the worklist
>   #
>   # The splat surfaces on the *next* worklist insertion, as a KASAN
>   # slab-use-after-free in __list_add_valid_or_report() under __queue_work().
>   #
>   # Run inside a KASAN guest. Fires on the first unbind.
>   set -e
> 
>   G=/sys/kernel/config/usb_gadget/k90
> 
>   mountpoint -q /sys/kernel/config || mount -t configfs none /sys/kernel/config
> 
>   UDC=$(ls /sys/class/udc | head -1)
>   [ -n "$UDC" ] || { echo "no UDC found (need CONFIG_USB_DUMMY_HCD)"; exit 1; }
>   echo "using UDC: $UDC"
> 
>   cleanup() {
>   	[ -d "$G" ] || return 0
>   	echo "" > "$G/UDC" 2>/dev/null || true
>   	rm -f "$G"/configs/c.1/hid.usb0 2>/dev/null || true
>   	rmdir "$G"/configs/c.1/strings/0x409 "$G"/configs/c.1 2>/dev/null || true
>   	rmdir "$G"/functions/hid.usb0 "$G"/strings/0x409 "$G" 2>/dev/null || true
>   }
>   cleanup
> 
>   mkdir -p "$G"
>   cd "$G"
>   echo 0x1b1c > idVendor          # USB_VENDOR_ID_CORSAIR
>   echo 0x1b02 > idProduct         # USB_DEVICE_ID_CORSAIR_K90
> 
>   mkdir -p strings/0x409
>   echo "0001"    > strings/0x409/serialnumber
>   echo "Corsair" > strings/0x409/manufacturer
>   echo "K90"     > strings/0x409/product
> 
>   mkdir -p functions/hid.usb0
>   echo 1 > functions/hid.usb0/protocol      # keyboard
>   echo 1 > functions/hid.usb0/subclass
>   echo 8 > functions/hid.usb0/report_length
>   # Standard HID boot-keyboard report descriptor, 63 bytes.
>   # NOTE: octal escapes, not \xHH -- Debian's /bin/sh is dash, whose printf does
>   # not implement \xHH and would write the escapes out as literal ASCII text.
>   printf '\005\001\011\006\241\001\005\007\031\340\051\347\025\000\045\001\165\001\225\010\201\002\225\001\165\010\201\003\225\005\165\001\005\010\031\001\051\005\221\002\225\001\165\003\221\003\225\006\165\010\025\000\045\145\005\007\031\000\051\145\201\000\300' \
>   	> functions/hid.usb0/report_desc
> 
>   desc_sz=$(wc -c < functions/hid.usb0/report_desc)
>   [ "$desc_sz" -eq 63 ] || { echo "BAD DESCRIPTOR ($desc_sz bytes, want 63)"; exit 1; }
> 
>   mkdir -p configs/c.1/strings/0x409
>   echo "c1" > configs/c.1/strings/0x409/configuration
>   ln -s functions/hid.usb0 configs/c.1/
> 
>   echo "binding gadget..."
>   echo "$UDC" > UDC
>   sleep 2
> 
>   dev=$(ls /sys/bus/hid/drivers/corsair/ 2>/dev/null | grep ':' || true)
>   [ -n "$dev" ] || { echo "hid-corsair did not bind - check dmesg"; cleanup; exit 1; }
>   echo "bound: $dev"
>   echo "LEDs: $(ls /sys/class/leds 2>/dev/null | grep "$dev" | tr '\n' ' ')"
> 
>   echo "--- unbinding (triggers corsair_remove) ---"
>   echo "" > UDC
>   sleep 2
> 
>   cleanup
>   echo "done (no splat)"
>  drivers/hid/hid-corsair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 278c6efb565d..f966005d69dd 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -507,8 +507,8 @@ static int k90_init_macro_functions(struct hid_device *dev)
>  
>  fail_sysfs:
>  	k90->record_led.removed = true;
> +	disable_work_sync(&k90->record_led.work);
>  	led_classdev_unregister(&k90->record_led.cdev);
> -	cancel_work_sync(&k90->record_led.work);
>  fail_record_led:
>  	kfree(k90->record_led.cdev.name);
>  fail_record_led_alloc:
> @@ -524,7 +524,7 @@ static void k90_cleanup_backlight(struct hid_device *dev)
>  
>  	if (drvdata->backlight) {
>  		drvdata->backlight->removed = true;
> -		cancel_work_sync(&drvdata->backlight->work);
> +		disable_work_sync(&drvdata->backlight->work);
>  		led_classdev_unregister(&drvdata->backlight->cdev);
>  		kfree(drvdata->backlight->cdev.name);
>  		kfree(drvdata->backlight);
> @@ -540,7 +540,7 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
>  		sysfs_remove_group(&dev->dev.kobj, &k90_attr_group);
>  
>  		k90->record_led.removed = true;
> -		cancel_work_sync(&k90->record_led.work);
> +		disable_work_sync(&k90->record_led.work);
>  		led_classdev_unregister(&k90->record_led.cdev);
>  		kfree(k90->record_led.cdev.name);
>  
> -- 
> 2.55.0

Hi Jeffin,

Reviewed-by: Chen Changcheng <chenchangcheng@kylinos.cn>
