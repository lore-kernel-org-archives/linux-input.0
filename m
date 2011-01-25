From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid kernel module for wireless remote LC Power model
 RC1000MCE
Date: Tue, 25 Jan 2011 14:01:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101251359150.5725@pobox.suse.cz>
References: <4D3DAE2F.3080009@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39610 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908Ab1AYNBh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 08:01:37 -0500
In-Reply-To: <4D3DAE2F.3080009@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris schlund <chrisschlund@gmx.de>
Cc: linux-input@vger.kernel.org

On Mon, 24 Jan 2011, chris schlund wrote:

> I bought a remote control LC Power RC1000MCE (usb rf keyboard). Some keys were
> not working. Therefore I took the hid-topseed kernel module copied it and
> prepared it as a new kernel module hid-lcpower which provides the correct
> keymapping for this remote control.
> I tested it on the 2.6.32 kernel.
> I modified it to compile with the kernel version 2.6.37 (untested).

Hi Chris,

thanks a lot for the driver.

First, I am missing your Signed-off-by: line, without which I can't apply 
your driver. Please see Documentation/SubmittingPatches for details.

Second, your mailer has damaged (line-wrapped) the patch.

[ ... snip ... ]
> +config HID_LCPOWER
> +       tristate "LC-Power" if EMBEDDED
> +       depends on USB_HID
> +       default !EMBEDDED

Also, we are not going the EMBEDDED path any more (see commit 
73d5e8f77e88a4 for explanation).

Could you please fix that up and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
