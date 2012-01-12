From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Key mapping question
Date: Thu, 12 Jan 2012 10:20:36 -0800
Message-ID: <1981809.NxLeYEmSmg@dtor-d630.eng.vmware.com>
References: <20120111223550.202a9604@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64916 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab2ALSUu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jan 2012 13:20:50 -0500
Received: by iabz25 with SMTP id z25so3067964iab.19
        for <linux-input@vger.kernel.org>; Thu, 12 Jan 2012 10:20:50 -0800 (PST)
In-Reply-To: <20120111223550.202a9604@pyramind.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, khnz@users.sourceforge.net, Matthew Garrett <mjg59@srcf.ucam.org>

Hi Alan,

On Wednesday, January 11, 2012 10:35:50 PM Alan Cox wrote:
> I'm currently adding the Fujitsu Q550 to the fujitsu-tablet driver
> (http://sourceforge.net/projects/fjbtndrv/files/fjbtndrv/)
> 
> The Q550 has 3 buttons - a direction flipping button, a keyboard button
> and a ctrl-alt-delete button.
> 
> It's labelled as such, it acts as such and I'm tempted to map it as such
> including modifiers but that does rather violate the usual behaviour we
> expect.

Reading manual it looks like it is a dedicated SAK button. While we do
not currently have a dedicated key code for it we could easily add one.

> 
> So how should it be mapped ?
> 
> I'll send Robert Gerlach a patch once I have a good answer on that one.
> It would also be nice to get the kernel bits for this driver upstream.
> Barring some trivial printk/pr_debug things it looks to me to be in
> perfectly good shape to go upstream, and it's kind of handy when the
> buttons work on your tablet !

Yes, the driver indeed looks nice, changing a few printk and making sure
we do not leak ACPI statuses into the other layers (like what happens in
fujitsu_module_init() - should convert acpi status to linux errno upon
failure - if acpi_bus_register_driver() really returns acpi status) should
make it ready for mainline. I think tt should go to Matthew's
drivers/platform subtree though.

Thanks.

-- 
Dmitry
