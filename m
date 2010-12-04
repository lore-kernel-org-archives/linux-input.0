From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] USB: USBHID: Fix race between disconnect and hiddev_ioctl
Date: Sat, 4 Dec 2010 21:22:23 +0100
Message-ID: <201012042122.23852.oliver@neukum.org>
References: <20101203172746.GA31045@mvista.com> <20101203231611.GB22969@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:50516 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab0LDUV0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Dec 2010 15:21:26 -0500
In-Reply-To: <20101203231611.GB22969@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Valentine Barshak <vbarshak@mvista.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Am Samstag, 4. Dezember 2010, 00:16:12 schrieb Dmitry Torokhov:
> > Since disconnect can happen at any time, we can't initialize
> > struct hid_device *hid = hiddev->hid at the beginning of ioctl
> > and then use it.
> > 
> > This change checks hiddev->exist flag while holding
> > the existancelock and uses hid_device only if it exists.
> 
> Why didn't you take the lock and check hiddev->exist at the beginning of
> ioctl handler instead of pushing it down into individual command
> handlers? I guess it would slow down HIDIOCGVERSION but I think we could
> pay this price for code that is more clear ;)

Strictly speaking you'd change the semantics. Right now you can execute
the ioctl even if you know you are holding an fd to a disconnected device
open.

	Regards
		Oliver
