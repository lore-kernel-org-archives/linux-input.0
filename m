From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: Transport layer renaming.
Date: Thu, 26 Dec 2013 15:43:55 -0800
Message-ID: <20131226234355.GH18562@core.coreip.homeip.net>
References: <1387315890-21681-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:33063 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab3LZXn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Dec 2013 18:43:58 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so8527944pbb.8
        for <linux-input@vger.kernel.org>; Thu, 26 Dec 2013 15:43:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387315890-21681-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, Dec 17, 2013 at 01:31:30PM -0800, Christopher Heiny wrote:
> The current RMI4 driver uses the term "physical" for two different logical
> entities: the communications transport layer (I2C, SPI, and so on), and the
> actual RMI4 device that is being communicated with.  Such usage makes the
> code harder to understand due to confusion as to just which elements are
> being referred to.
> 
> This patch renames the transport layer elements in order to eliminate this
> confusion.  Much of the renaming was accomplished by the following Bash script
> 
>   #!/bin/bash
>   #
>   # Update RMI4 driver transport layer naming.
>   #
> 
>   files="rmi_bus.c rmi_bus.h rmi_driver.c rmi_driver.h rmi_f01.c rmi_i2c.c"
>   cd drivers/input/rmi4
> 
>   for f in $files ; do
>     echo $f
>     sed -i.bak s/rmi_phys_device/rmi_transport_dev/g $f
>     sed -i.bak s/rmi_phys_info/rmi_transport_info/g $f
>     sed -i.bak "s/rmi_transport_dev \*phys/rmi_transport_dev \*xport/g" $f
>     sed -i.bak "s/rmi_transport_dev \*rmi_phys/rmi_transport_dev \*xport/g" $f
>     sed -i.bak "s/phys\([^i]\)/xport\1/g" $f
>     sed -i.bak "s/->phys/->xport/g" $f
>     sed -i.bak "s/register_physical_device/register_transport_device/g" $f
>     sed -i.bak "s/physical_device_count/transport_device_count/g" $f
>   done
> 
> although some changes proved easier to simply do by hand, particularly in the
> comments.  Changes are confined strictly to the renaming, to keep the patch
> relatively simple.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>


Applied, thank you.

-- 
Dmitry
