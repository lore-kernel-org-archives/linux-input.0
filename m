From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Thinkpad Edge E220S trackpoint detection [was: Re: Lenovo X220
 Touchpad + Trackpoint BIOS issue workaround ?]
Date: Tue, 4 Oct 2011 23:56:28 -0700
Message-ID: <20111005065627.GB11260@core.coreip.homeip.net>
References: <4E8ADD98.5000402@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62613 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab1JEG4d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 02:56:33 -0400
Received: by iakk32 with SMTP id k32so1470562iak.19
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 23:56:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E8ADD98.5000402@ubuntu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chow Loong Jin <hyperair@ubuntu.com>
Cc: linux-input@vger.kernel.org

Hi Loong Jin,

On Tue, Oct 04, 2011 at 06:19:04PM +0800, Chow Loong Jin wrote:
> Hi Dmitry,
> 
> I was reading through the linux-input thread (as mentioned in the subject)
> regarding trackpoint detection, and noticed that it bore an uncanny resemblence
> to the issue I'm currently having with my Thinkpad Edge E220S. I'll summarize
> the situation on my E220S here, which I believe to be more or less the same as
> the situation on the X220:
>  - Main device is a Synaptics touchpad/
>  - Trackpoint exists as a passthrough device/
>  - Trackpoint not detected until first resynchronization happens.
>  - Loss of sync can be triggered by moving the (undetected) trackpoint/
> 
> There seems to be a slight difference here though, in that I can't disable the
> trackpoint or touchpad in my BIOS.
> 
> I noticed that you requested for the full i8042.debug output, so I looked into
> doing just that, using the following steps:
> 1. rmmod psmouse
> 2. echo 1 > /sys/module/i8042/parameters/debug
> 3. modprobe psmouse
> 4. wait for i8042 to settle and stop spewing messages
> 5. move the trackpoint a bit.
> 6. wait for i8042 to settle and stop spewing messages again.
> 
> I have attached two snippets of /var/log/kern.log files to this email:
>  - modprobe-psmouse-until-settle.log: The log output between steps #3 and #4.
>  - touch-trackpoint-until-settle2.log: The log output between steps #5 and #6.
> 

It looks like you forgot to actually attached the files...

-- 
Dmitry
