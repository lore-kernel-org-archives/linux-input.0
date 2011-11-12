From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Annoying touchpad behavior
Date: Fri, 11 Nov 2011 22:05:05 -0800
Message-ID: <20111112060505.GA20411@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.1111112303590.306-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53704 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab1KLGFM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 01:05:12 -0500
Received: by pzk36 with SMTP id 36so6310940pzk.1
        for <linux-input@vger.kernel.org>; Fri, 11 Nov 2011 22:05:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1111112303590.306-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-input@vger.kernel.org

Hi Alan,

On Fri, Nov 11, 2011 at 11:10:46PM -0500, Alan Stern wrote:
> Dmitry:
> 
> My laptop has a Synaptics touchpad:
> 
> [    2.528474] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04731/0xa40000/0xa0000
> [    2.566383] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio4/input/input4
> 
> Under circumstances which I can't pin down (they generally involve my
> thumb brushing over the trackpad, which happens fairly often as I
> type), the touchpad reports a right-click.  This causes gnome-terminal
> to pop up its menu, which is very annoying.
> 
> Why does the trackpad report a right-click instead of a normal 
> left-click?  How can I fix this?

You probably have corner taps or multi-finger taps enabled on your box.
What does "synclient' has to say about your setup?

Thanks.

-- 
Dmitry
