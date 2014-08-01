From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard: register as a wakeup source
Date: Fri, 1 Aug 2014 17:29:09 +0000
Message-ID: <0c4b13461c5c44c5a7ebaa3d215e1875@BY2PR0301MB0711.namprd03.prod.outlook.com>
References: <1406903304-7256-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dns-bn1lp0143.outbound.protection.outlook.com ([207.46.163.143]:27169
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751694AbaHAR3N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Aug 2014 13:29:13 -0400
In-Reply-To: <1406903304-7256-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>



> -----Original Message-----
> From: Dexuan Cui [mailto:decui@microsoft.com]
> Sent: Friday, August 1, 2014 7:28 AM
> To: gregkh@linuxfoundation.org; dmitry.torokhov@gmail.com; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org; driverdev-
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com
> Cc: KY Srinivasan; Haiyang Zhang
> Subject: [PATCH] Input: hyperv-keyboard: register as a wakeup source
> 
> With this patch, we can press a key to wake up the VM after the VM
> executes "echo freeze > /sys/power/state".
> 
> This addresses part of https://bugzilla.redhat.com/show_bug.cgi?id=1086100
> 
> Cc: K. Y. Srinivasan <kys@microsoft.com>
Thanks Dexuan.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/input/serio/hyperv-keyboard.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c
> b/drivers/input/serio/hyperv-keyboard.c
> index 6132619..e74e5d6 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -170,6 +170,15 @@ static void hv_kbd_on_receive(struct hv_device
> *hv_dev,
>  			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
>  		}
>  		spin_unlock_irqrestore(&kbd_dev->lock, flags);
> +
> +		/*
> +		 * Only trigger a wakeup on key down, otherwise
> +		 * "echo freeze > /sys/power/state" can't really enter the
> +		 * state because the Enter-UP can trigger a wakeup at once.
> +		 */
> +		if (!(info & IS_BREAK))
> +			pm_wakeup_event(&hv_dev->device, 0);
> +
>  		break;
> 
>  	default:
> @@ -376,6 +385,9 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
>  		goto err_close_vmbus;
> 
>  	serio_register_port(kbd_dev->hv_serio);
> +
> +	device_init_wakeup(&hv_dev->device, true);
> +
>  	return 0;
> 
>  err_close_vmbus:
> @@ -390,6 +402,7 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
> {
>  	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(hv_dev);
> 
> +	device_init_wakeup(&hv_dev->device, false);
>  	serio_unregister_port(kbd_dev->hv_serio);
>  	vmbus_close(hv_dev->channel);
>  	kfree(kbd_dev);
> --
> 1.9.1

