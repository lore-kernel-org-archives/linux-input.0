From: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work
 in xorg or gpm
Date: Sun, 06 May 2012 03:11:59 -0300
Message-ID: <4FA6162F.1020408@osvaldobarrera.com.ar>
References: <20120503052000.GC15205@burratino> <20120503052420.GD15205@burratino> <4FA217B7.7070908@osvaldobarrera.com.ar> <20120503055051.GA15960@burratino> <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com> <20120506031428.GA20044@hugoo.com.ar> <20120506055508.GA21209@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from customer-static-210-108-249.iplannetworks.net ([190.210.108.249]:41095
	"EHLO hyperion.ubertech.com.ar" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751274Ab2EFGKF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 6 May 2012 02:10:05 -0400
In-Reply-To: <20120506055508.GA21209@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

Hi Jonathan,

On 2012-05-06 02:55, Jonathan Nieder wrote:
> Hugo Osvaldo Barrera wrote:
> 
>> Here's the dmesg I got:
> 
> Thanks.
> 
> [...]
>> [69358.971692] usbhid: USB HID core driver
>> <Mouse receiver was plugged in at this point.  Mouse was off.>
>> [69358.973309] [...]/drivers/hid/hid-logitech-dj.c: Logitech-DJ:logi_dj_init
> [...]
>> [69381.911438] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0001:10:1b.1-1/input2
>> [69381.918070] [...]/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
>> [69381.918124] [...]/drivers/hid/hid-logitech-dj.c: delayedwork_callback
>> [69381.918135] [...]/drivers/hid/hid-logitech-dj.c: logi_dj_recv_add_djhid_device: device list is empty
>> [69381.920069] [...]/drivers/hid/hid-logitech-dj.c: logi_dj_raw_event, size:15
>> [69381.920119] [...]/drivers/hid/hid-logitech-dj.c: delayedwork_callback
>> [69381.920297] [...]/drivers/hid/hid-logitech-dj.c: logi_dj_ll_parse
>> [69381.920308] [...]/drivers/hid/hid-logitech-dj.c: logi_dj_ll_start
>> <Mouse was turned on at this point.>
>> [69381.920430] logitech-djdevice 0003:046D:C52B.0004: hidraw1: USB HID v1.11 Device [Logitech Unifying Device. Wireless PID:101a] on usb-0001:10:1b.1-1:1
> 
> Still no "logi_dj_ll_parse: sending a mouse descriptor, reports_supported: 4"
> so it looks like the patch didn't have the intended effect.  Alas.
> 
> The pairing (...add_djhid_device) happens during initialization,
> before the mouse is turned on...

I don't think I quite follow there.  By "pairing" I though you meant
when the receiver connects to the mouse.  How can the pairing be done
while the device is off?  Or what am I missing here?

> 
>> Here's the capture of the pairing event.
> [...]
>> Reading from 0003:046D:C52B.0003 resulted in the following
>>
>> <Mouse turned on at this point>
>> report (size 15) (numbered) =  20 01 42 00 00 00 00 00 00 00 00 00 00 00 00
>> <Mouse turned off at this point>
>> report (size 15) (numbered) =  20 01 42 01 00 00 00 00 00 00 00 00 00 00 00
>> <EOF>
> 
> ... so the events captured do not include pairing events (0x41).  What
> we see here are connection status events (0x42).  Sorry about that.
> 
> Here's a new patch that prints more information to dmesg.  After
> applying the patch, you can use the patched driver by running
> 
> 	make drivers/hid/hid-logitech-dj.ko
> 	modprobe -r hid-logitech-dj
> 	insmod drivers/hid/hid-logitech-dj.ko

Great, that'll save me plenty of time!

> ---
> Thanks again,
> Jonathan
> 
>  drivers/hid/hid-logitech-dj.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index e1c38bba4375..33a70cfbec77 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -23,6 +23,7 @@
>  
>  
>  #include <linux/device.h>
> +#include <asm/unaligned.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  #include <linux/usb.h>
> @@ -273,8 +274,8 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
>  		goto dj_device_allocate_fail;
>  	}
>  
> -	dj_dev->reports_supported = le32_to_cpu(
> -		dj_report->report_params[DEVICE_PAIRED_RF_REPORT_TYPE]);
> +	dj_dev->reports_supported = get_unaligned_le32(
> +		dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
>  	dj_dev->hdev = dj_hiddev;
>  	dj_dev->dj_receiver_dev = djrcv_dev;
>  	dj_dev->device_index = dj_report->device_index;
> @@ -618,9 +619,18 @@ static int logi_dj_raw_event(struct hid_device *hdev,
>  	struct dj_report *dj_report = (struct dj_report *) data;
>  	unsigned long flags;
>  	bool report_processed = false;
> +	char buf[32 * 3 + 1];
> +	int i;
>  
>  	dbg_hid("%s, size:%d\n", __func__, size);
>  
> +	if (0 < size && size <= 32) {
> +		for (i = 0; i < size; i++)
> +			snprintf(buf + 3*i, sizeof(buf) - 3*i,
> +					" %02x", data[i]);
> +		dbg_hid("%s: report = %s\n", __func__, buf);
> +	}
> +
>  	/* Here we receive all data coming from iface 2, there are 4 cases:
>  	 *
>  	 * 1) Data should continue its normal processing i.e. data does not

Do I need to apply only this patch, or both the previous one and this one?


-- 
Hugo Osvaldo Barrera
