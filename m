From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: register as a wakeup source
Date: Fri, 1 Aug 2014 17:29:38 +0000
Message-ID: <2e66fa7690584834b26b0069063e85e0@BY2PR0301MB0711.namprd03.prod.outlook.com>
References: <1406903201-7210-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:18925
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750851AbaHAR3l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Aug 2014 13:29:41 -0400
In-Reply-To: <1406903201-7210-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>



> -----Original Message-----
> From: Dexuan Cui [mailto:decui@microsoft.com]
> Sent: Friday, August 1, 2014 7:27 AM
> To: gregkh@linuxfoundation.org; jkosina@suse.cz; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; driverdev-
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com
> Cc: KY Srinivasan; Haiyang Zhang
> Subject: [PATCH] HID: hyperv: register as a wakeup source
> 
> With this patch, we can move the mouse to wake up the VM after the VM
> executes "echo freeze > /sys/power/state".
> 
> This addresses part of https://bugzilla.redhat.com/show_bug.cgi?id=1086100
> 
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

> ---
>  drivers/hid/hid-hyperv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c index
> f52dbcb..31fad64 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -308,6 +308,9 @@ static void mousevsc_on_receive(struct hv_device
> *device,
>  		memcpy(input_dev->input_buf, input_report->buffer, len);
>  		hid_input_report(input_dev->hid_device,
> HID_INPUT_REPORT,
>  				 input_dev->input_buf, len, 1);
> +
> +		pm_wakeup_event(&input_dev->device->device, 0);
> +
>  		break;
>  	default:
>  		pr_err("unsupported hid msg type - type %d len %d", @@ -
> 549,6 +552,8 @@ static int mousevsc_probe(struct hv_device *device,
>  		goto probe_err2;
>  	}
> 
> +	device_init_wakeup(&device->device, true);
> +
>  	input_dev->connected = true;
>  	input_dev->init_complete = true;
> 
> @@ -571,6 +576,7 @@ static int mousevsc_remove(struct hv_device *dev)  {
>  	struct mousevsc_dev *input_dev = hv_get_drvdata(dev);
> 
> +	device_init_wakeup(&dev->device, false);
>  	vmbus_close(dev->channel);
>  	hid_hw_stop(input_dev->hid_device);
>  	hid_destroy_device(input_dev->hid_device);
> --
> 1.9.1

