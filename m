From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics, CAP_FORCEPAD, bad behavior
Date: Thu, 9 Oct 2014 09:52:46 -0700
Message-ID: <20141009165246.GA18213@dtor-ws>
References: <543656A2.4080009@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48354 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaJIQwv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Oct 2014 12:52:51 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so86838pad.41
        for <linux-input@vger.kernel.org>; Thu, 09 Oct 2014 09:52:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <543656A2.4080009@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicole Faerber <nicole.faerber@kernelconcepts.de>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, Oct 09, 2014 at 11:34:26AM +0200, Nicole Faerber wrote:
> Hi!
> Just installed the just released 3.17 kernel and found a bad behavior of
> the new Synaptics driver on my Thinkpad Yoga which has the new Synaptics
> clickpad enabled touchpad:
> 
> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
> caps: 0xd002a3/0x940300/0x12f800, board id: 2911, fw id: 2560
> 
> The issue is that now a button release is only issued after the finger
> has completely left the touchpad and not when releasing the physical
> button. Is this physical button now called FORCEPAD? Anyway, this is
> pretty annoying. Double clicking become a real pain.
> I did comment out the new
> 
> 	if (SYN_CAP_FORCEPAD(priv->ext_cap_0c)) {
> 	...
> 
> and everything is back to normal again, i.e. when I do release the pad
> physical button but keep the finger on the pad, the button release event
> is issued properly.

Hmm, the forcepad code should only activate if the devoice do4es not
have physical buttons at all. Let me see what's the diffference in
capabilities between your and mine touchpads...

Thanks.

-- 
Dmitry
