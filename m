From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Wed, 16 Nov 2011 11:27:49 -0800
Message-ID: <20111116192749.GA26909@core.coreip.homeip.net>
References: <4EC10878.20109@edigma.com>
 <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
 <4EC13B0F.2080509@edigma.com>
 <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com>
 <4EC3F2AD.5080505@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49646 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab1KPT2B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 14:28:01 -0500
Received: by iage36 with SMTP id e36so1036030iag.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 11:28:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC3F2AD.5080505@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

Hi Nuno,

On Wed, Nov 16, 2011 at 05:28:13PM +0000, Nuno Santos wrote:
>     Why? I thought this thing is an input device? Why does an
> application have to modify a running device? Is this modification
> local to the application<->device interface or does it also affect
> all other running applications that use this device? If it is a
> configuration value to put the device into a different state or
> similar, then you can use a sysfs attribute. The user can change
> this with "echo <value> >/sys/class/input/inputX/<attribute>"

Any chance you could use some sane quoting style? It is almost
impossible to dechipher where someone else's mail stops and your reply
starts.

> 
> I'm already with working examples of ATTRIB in my driver project.
> The thing is that I have random kernel panics when I try to read
> from the attribute. This is my attribute code:
> 
> static ssize_t usbtouchscreen_get_state(struct device *dev, struct
> device_attribute *attr, char *buf)
> {
>     int count=0;
>     struct usbtouch_usb *usbtouch = dev_get_drvdata(dev);
>     struct dpx_priv *priv = usbtouch->priv;
> 
>     printk(KERN_INFO "state length: %d",sizeof(DPX_DEVICE_STATE));
> // size = 43196 bytes

So it is probably 39K more than sysfs attribute can handle.

> 
>     memcpy(buf,(void*)&priv->context->State,sizeof(DPX_DEVICE_STATE));

and you are smashing kernel stack here.

-- 
Dmitry
