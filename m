From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Mon, 14 Mar 2011 23:02:03 -0700
Message-ID: <20110315060203.GF1046@core.coreip.homeip.net>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51500 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060Ab1COGCJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 02:02:09 -0400
Received: by iwn34 with SMTP id 34so283226iwn.19
        for <linux-input@vger.kernel.org>; Mon, 14 Mar 2011 23:02:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

Hi Alan,

On Wed, Mar 09, 2011 at 01:47:51PM +0000, Alan Cox wrote:
> From: Joseph Lai <joseph_lai@wistron.com>
> 
> This driver is registered as an input device with sysfs control
> interface, but it still can output 3 axes data in non-interrupt mode.
> 
> This is primarily an input device but can also be used as for other things.
> It thus exposes the power control (so you can keep power on when you want) and
> x/y/z co-ordinates directly.

I'd be more happy if it was just an input device. If non-wired interrupt
is a common case then we should probably add polled input device mode,
but we certainly should not register completely non-functional input
device as the driver does now.

We also have a way of retrieving current (or rather most recent)
coordinates via EVIOCGABS so I am not sure why we want the sysfs way of
retrieving coordinates as well.

Regarding power mode - I really believe that this should be done on the
driver core level instead of implementing "manual off" in every single
driver out there.

Thanks.

-- 
Dmitry
