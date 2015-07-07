From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: hid-rmi: configuration automatically changed after suspend/resume
Date: Tue, 7 Jul 2015 10:45:21 -0400
Message-ID: <20150707144521.GH18484@mail.corp.redhat.com>
References: <1463383.73UKVcFjqX@xps13>
 <559B13AD.50103@synaptics.com>
 <2572052.srFcAdtYRh@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55353 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757042AbbGGOpY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2015 10:45:24 -0400
Content-Disposition: inline
In-Reply-To: <2572052.srFcAdtYRh@xps13>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, jkosina@suse.cz

On Jul 07 2015 or thereabouts, Gabriele Mazzotta wrote:
> On Monday 06 July 2015 16:47:57 Andrew Duggan wrote:
> > Hi Gabriele,
> > 
> > On 07/06/2015 03:20 AM, Gabriele Mazzotta wrote:
> > > Hi,
> > >
> > > I recently noticed that there's a minor issue with hid-rmi.c. After a
> > > suspend/resume cycle the f11 control register is set to the default
> > > configuration, thus undoing the changes performed on init.
> > 
> > This is because i2c_hid does a reset of the touchpad during resume. 
> > Power cycles or resets will clear the changes to the control registers. 
> > There isn't a way to make these changes persistent without changing the 
> > firmware.
> 
> OK, I suspected this was what was happening.
> 
> > > I made some changes to the driver to prevent this from happening: the
> > > configuration is saved on suspend and restored upon resume. This seemed
> > > the simplest thing to do, but I encountered a small problem.
> > 
> > I haven't been able to successfully complete reads which I perform in 
> > the suspend callback. They end up timing out waiting for the response. 
> > Maybe this is only an issue on certain platforms if this is working for you.
> 
> I have the same problem and I solved it with the following patch.
> Please see if it works for you as well:
> 
> From 654156ae5ed496daba792b4231858c788712df15 Mon Sep 17 00:00:00 2001
> From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Date: Sat, 27 Jun 2015 16:29:45 +0200
> Subject: [PATCH] hid: i2c-hid - call suspend callback before disabling irq
> 
> This will make possible to perform operations from the device suspend
> callback that needs the irq to be enabled.

FWIW, this makes perfect sense and is
reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Please submit it upstream with your signed-off-by line.

Cheers,
Benjamin

> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index f77469d..9ed69b5 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1092,13 +1092,13 @@ static int i2c_hid_suspend(struct device *dev)
>  	struct hid_device *hid = ihid->hid;
>  	int ret = 0;
>  
> +	if (hid->driver && hid->driver->suspend)
> +		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
> +
>  	disable_irq(ihid->irq);
>  	if (device_may_wakeup(&client->dev))
>  		enable_irq_wake(ihid->irq);
>  
> -	if (hid->driver && hid->driver->suspend)
> -		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
> -
>  	/* Save some power */
>  	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
>  
> -- 
> 
> > >
> > > I'm saving and writing the whole register since the kernel can't know
> > > what userspace tools might have done. According to a comment in the
> > > sources, some firmwares split the control register, so blindly copying
> > > and writing 20 sequential bytes as I'm doing could be a problem.
> > 
> > Since reading from the suspend callback doesn't seem to be reliable on 
> > all platforms, I think it would  be better to store the values of the 
> > control registers on init. The driver can update the stored values and 
> > write that back to the device on init and after coming out of resume. 
> > This will overwrite any changes done by userspace tools. But, if it is 
> > important enough to have a F11 control register change persist over 
> > suspend / resume then it should probably be implemented in the hid-rmi 
> > anyway.
> > 
> > > Is there a way to recognize those firmwares? Or even better, is there a
> > > way to prevent the firmware from restoring the default configuration?
> > 
> > This bug can be worked around by only reading a max of 16 bytes at a 
> > time. So to read all 20 you can just read 16, then add 16 to the address 
> > and read the remaining 4. Also, the size of the control registers 
> > depends on the configuration so it could be more or less then 20. Did 
> > you have a particular register that you want to change which isn't 
> > currently in hid-rmi?
> 
> No, only what's currently in hid-rmi.
> 
> > > PS: I didn't check if the same happens with other registers, but I
> > > suspenct it does.
> > >
> > > Thanks,
> > > Gabriele
> > 
> > In the meantime I have another patch to post related to suspend / 
> > resume. I'm going to go ahead and post that now to avoid conflicts.
> > 
> > Andrew
> 
