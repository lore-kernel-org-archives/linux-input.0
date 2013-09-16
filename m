From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: input: serio: New driver to support
 Hyper-V synthetic keyboard
Date: Mon, 16 Sep 2013 18:42:25 +0000
Message-ID: <117fbf407a554684b4d72ab06b033eeb@SN2PR03MB061.namprd03.prod.outlook.com>
References: <1379309334-25042-1-git-send-email-kys@microsoft.com>
 <20130916082110.GN25896@mwanda>
 <3b5096d0190b4440a8e25afbd22ab72d@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916150548.GO25896@mwanda>
 <baabf219b12b40de8e17b029e621e079@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916170951.GB20734@core.coreip.homeip.net>
 <3e45f054c6e243eabf2896ab1dcf38d4@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916183319.GM19256@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20130916183319.GM19256@mwanda>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vojtech@suse.cz" <vojtech@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Monday, September 16, 2013 11:33 AM
> To: KY Srinivasan
> Cc: Dmitry Torokhov; olaf@aepfle.de; gregkh@linuxfoundation.org;
> jasowang@redhat.com; linux-kernel@vger.kernel.org; vojtech@suse.cz; linux-
> input@vger.kernel.org; apw@canonical.com; devel@linuxdriverproject.org
> Subject: Re: [PATCH 1/1] Drivers: input: serio: New driver to support Hyper-V
> synthetic keyboard
> 
> Just roll something like the following into your patch.
> 
> regards,
> dan carpenter
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-
> keyboard.c
> index 0d4625f..262721b 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -151,15 +151,18 @@ static void hv_kbd_free_device(struct hv_kbd_dev
> *device)
>  }
> 
>  static void hv_kbd_on_receive(struct hv_device *device,
> -				struct vmpacket_descriptor *packet)
> +			      struct vmpacket_descriptor *packet, size_t size)
>  {
>  	struct synth_kbd_msg *msg;
>  	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(device);
>  	struct synth_kbd_keystroke *ks_msg;
> +	int offset;
>  	u16 scan_code;
> 
> -	msg = (struct synth_kbd_msg *)((unsigned long)packet +
> -					(packet->offset8 << 3));
> +	offset = packet->offset8 << 3;
> +	if (offset + sizeof(struct synth_kbd_protocol_response) > size)
> +		return;
> +	msg = (void *)packet + offset;
> 
>  	switch (msg->header.type) {
>  	case SYNTH_KBD_PROTOCOL_RESPONSE:
> @@ -220,7 +223,7 @@ static void hv_kbd_on_channel_callback(void *context)
>  				break;
> 
>  			case VM_PKT_DATA_INBAND:
> -				hv_kbd_on_receive(device, desc);
> +				hv_kbd_on_receive(device, desc, bytes_recvd);
>  				break;
> 
>  			default:

Dan,

Rolling the changes you have indicated is not the issue; this can trivially be done.
My contention is that it is not needed given that the underlying function is already
doing that. Look at the function  vmbus_recvpacket_raw() in drivers/hv/channel.c.

Regards,

K. Y
