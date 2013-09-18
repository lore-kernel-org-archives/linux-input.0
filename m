From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH V2 1/1] Drivers: input: serio: New driver to support
 Hyper-V synthetic keyboard
Date: Wed, 18 Sep 2013 23:27:51 +0000
Message-ID: <304cbdeb0aa34f9a9ba6b44828fb5647@SN2PR03MB061.namprd03.prod.outlook.com>
References: <1379460418-1523-1-git-send-email-kys@microsoft.com>
 <20130918210107.GA32320@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:46260
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751511Ab3IRX2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 19:28:13 -0400
In-Reply-To: <20130918210107.GA32320@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "vojtech@suse.cz" <vojtech@suse.cz>



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, September 18, 2013 2:01 PM
> To: KY Srinivasan
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; dan.carpenter@oracle.com; linux-
> input@vger.kernel.org; vojtech@suse.cz
> Subject: Re: [PATCH V2 1/1] Drivers: input: serio: New driver to support Hyper-V
> synthetic keyboard
> 
> Hi K.Y.,
> 
> On Tue, Sep 17, 2013 at 04:26:58PM -0700, K. Y. Srinivasan wrote:
> > Add a new driver to support synthetic keyboard. On the next generation
> > Hyper-V guest firmware, many legacy devices will not be emulated and this
> > driver will be required.
> >
> > I would like to thank Vojtech Pavlik <vojtech@suse.cz> for helping me with the
> > details of the AT keyboard driver. I would also like to thank
> > Dan Carpenter <dan.carpenter@oracle.com> and
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> for their detailed review of
> this
> > driver.
> >
> > I have addressed all the comments of Dan and Dmitry in this version of
> > the patch
> 
> This looks much better. Could you tell me if the patch below (on top of
> yours) still works?
> 
> Thanks.

Thank you. The code looks much better now. You forgot to initialize the port_data and
after I fixed that everything seems to work as it did before: Here is the patch I used:

> -----Original Message-----
> From: K. Y. Srinivasan [mailto:kys@microsoft.com]
> Sent: Wednesday, September 18, 2013 4:50 PM
> To: KY Srinivasan
> Subject: [PATCH 1/1] Drivers: input: serio: hyper-V: Initialize the port data
> correctly
> 
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/input/serio/hyperv-keyboard.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-
> keyboard.c
> index 401fbdd..aff4152 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -351,6 +351,7 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
> 
>  	hv_serio->dev.parent  = &hv_dev->device;
>  	hv_serio->id.type = SERIO_8042_XL;
> +	hv_serio->port_data = kbd_dev;
>  	strlcpy(hv_serio->name, dev_name(&hv_dev->device),
>  		sizeof(hv_serio->name));
>  	strlcpy(hv_serio->phys, dev_name(&hv_dev->device),
> --
> 1.7.4.1


Once again; thank you for all your help.

Regards,

K. Y

