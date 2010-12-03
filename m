From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] USB: USBHID: Fix race between disconnect and hiddev_ioctl
Date: Fri, 3 Dec 2010 15:16:12 -0800
Message-ID: <20101203231611.GB22969@core.coreip.homeip.net>
References: <20101203172746.GA31045@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:59948 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0LCXQW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 18:16:22 -0500
Content-Disposition: inline
In-Reply-To: <20101203172746.GA31045@mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Valentine Barshak <vbarshak@mvista.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 03, 2010 at 08:27:46PM +0300, Valentine Barshak wrote:
> A USB HID device can be disconnected at any time.
> If this happens right before or while hiddev_ioctl is in progress,
> the hiddev_ioctl tries to access invalid hiddev->hid pointer.
> When the hid device is disconnected, the hiddev_disconnect()
> ends up with a call to hid_device_release() which frees
> hid_device, but doesn't set the hiddev->hid pointer to NULL.
> If the deallocated memory region has been re-used by the kernel,
> this can cause a crash or memory corruption.
> 
> Since disconnect can happen at any time, we can't initialize
> struct hid_device *hid = hiddev->hid at the beginning of ioctl
> and then use it.
> 
> This change checks hiddev->exist flag while holding
> the existancelock and uses hid_device only if it exists.

Why didn't you take the lock and check hiddev->exist at the beginning of
ioctl handler instead of pushing it down into individual command
handlers? I guess it would slow down HIDIOCGVERSION but I think we could
pay this price for code that is more clear ;)

-- 
Dmitry
