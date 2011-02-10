From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/1] Fix error path in wacom_probe
Date: Thu, 10 Feb 2011 14:18:16 +0100
Message-ID: <20110210131816.GB8935@polaris.bitmath.org>
References: <1297237048-32714-1-git-send-email-strakh@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:59420 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754058Ab1BJNTX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Feb 2011 08:19:23 -0500
Content-Disposition: inline
In-Reply-To: <1297237048-32714-1-git-send-email-strakh@ispras.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Strakh <cromlehg@gmail.com>
Cc: dmitry.torokhov@gmail.com, oneukum@suse.de, oblivian@users.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Strakh <strakh@ispras.ru>

Hi Alexander,

>   In file drivers/input/tablet/wacom_sys.c in
> wacom_probe after error we can goto label2. In
>  this case function usb_free was not called. 
>  It will be right goto for the label tail3.
> 
>         wacom->irq = usb_alloc_urb(0, GFP_KERNEL);
> 
> 	...
> 
>         /* Retrieve the physical and logical size for OEM devices */
>         error = wacom_retrieve_hid_descriptor(intf, features);
>         if (error)
>                 goto fail2;
> 	...
> 	 fail3: usb_free_urb(wacom->irq);
> 	 fail2: usb_free_coherent(dev, WACOM_PKGLEN_MAX, wacom_wac->data, wacom->data_dma);
> 
> Replaced wrong transition.

Yep, thanks for this.

Acked-by: Henrik Rydberg <rydberg@euromail.se>
