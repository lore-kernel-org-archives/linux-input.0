From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: A question about touchscreen absmax value
Date: Mon, 16 Nov 2009 21:48:23 -0800
Message-ID: <20091117054822.GA6451@core.coreip.homeip.net>
References: <4B00B08E.2030905@samsung.com> <20091116171202.GC24026@core.coreip.homeip.net> <4B0211B8.4020508@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:64831 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZKQFsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Nov 2009 00:48:21 -0500
Received: by mail-px0-f180.google.com with SMTP id 10so1690973pxi.33
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2009 21:48:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B0211B8.4020508@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

On Tue, Nov 17, 2009 at 12:00:08PM +0900, Joonyoung Shim wrote:
> On 11/17/2009 2:12 AM, Dmitry Torokhov wrote:
> > Hi Joonyoung,
> > 
> > On Mon, Nov 16, 2009 at 10:53:18AM +0900, Joonyoung Shim wrote:
> >> Hi, all.
> >>
> >> I have a question about touchscreen resolution. My touchscreen device
> >> can report the position from 0 to 1023 of x and y coordinates, so i
> >> setted the absmax of input device to 1023. BTW, i only can get from 0 to 
> >> 479 x position and to 799 y position because the LCD resolution of the
> >> target is 480 x 800. I wonder which value is setted to the absmax - 479
> >> and 799 or 1023.
> > 
> > I believe driver should, by default, set absmin and absmax to match the
> > limits of the hardware/protocol. In your case it would be 1023. The
> > driver may choose to accept additional infromation from platform data, if
> > present, you can also adjust absmin/absmax etc via ioctl durng the
> > bootup sequence.
> 
> Hmm, i get the resolution information from platform data, so i can 
> set absmax values from platform data. Is it ok?
> 

Sure, if there is only one possible configuration for the device on a
given platform - yes.

-- 
Dmitry
