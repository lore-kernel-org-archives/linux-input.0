From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Sat, 16 Jan 2016 10:30:08 -0800
Message-ID: <20160116183008.GB9203@dtor-ws>
References: <20160115123928.d06e1fed.cand@gmx.com>
 <5698D343.3000606@vmware.com>
 <20160115132312.654ad5aa.cand@gmx.com>
 <56991418.1070701@vmware.com>
 <20160115175040.GA5664@dtor-ws>
 <20160116105735.5c659e05.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33782 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbcAPSaM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 13:30:12 -0500
Received: by mail-pf0-f180.google.com with SMTP id e65so135115299pfe.0
        for <linux-input@vger.kernel.org>; Sat, 16 Jan 2016 10:30:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160116105735.5c659e05.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Sat, Jan 16, 2016 at 10:57:35AM +0200, Lauri Kasanen wrote:
> On Fri, 15 Jan 2016 09:50:40 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Although we will make vmmouse work with /dev/input/mice, could you
> > please tell TinyCore that 90s are calling and they want their mouse
> > technology back? And tell them to switch to switch to evdev X driver.
> 
> TinyCore sends their regards, and tells they will consider evdev when
> Xorg + evdev + paraphelia can total less than 650kb.

I do not think you are doing your users any favors by limiting them to
PS/2 emulation. For desktops, unless they only use basic mice mousedev
emulation does not work well for neither touchpads, nor tablets, nor
touchscreens.  And for appliances you do not need mouse at all. Maybe if
you targeting kiosks with limited UI it will work for a bit. I wonder
how long Xorg will be keeping lights on for mouse_drv.

I am tempted to deprecate mousedev and maybe joydev as well. They were
supposed to fill the gap between then current applications and kernel,
but that was 10+ years ago.

Thanks.

-- 
Dmitry
