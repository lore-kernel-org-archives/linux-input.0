From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: PROBLEM: [HP Stream Notebook - 11-d010nr] clickpad malfunctions
 after performing a hardware click
Date: Wed, 17 Dec 2014 11:09:36 +1000
Message-ID: <20141217010936.GA6906@jelly.redhat.com>
References: <CAN+gG=E+8277zg3LLW-eFWZb8bNyU_Umf9M2w6+t7Y3sSkkSFg@mail.gmail.com>
 <CALmnu0bPLi4skqUxvjd9DWrZJysvqX-+nxNHdx5APGsoNZsnKA@mail.gmail.com>
 <CAN+gG=Emz8r=17OpUETpVQyjCMDMX=aNEFFHZo3ivGS=xTZHXA@mail.gmail.com>
 <CALmnu0agW-mN9RON1FT9DCxE9POiwS2Jhj7hXZaW+6escc7OGw@mail.gmail.com>
 <CALmnu0aMX8RuDJFozCwP6GmP11Uep=R6bc0EqPYzBknwpHBmpA@mail.gmail.com>
 <CAN+gG=E=3kG9t9XTNe0X1kFumdkQ3CfM-ViXnOBGThmyJDNJ4g@mail.gmail.com>
 <CALmnu0Yg1vd4FOD5vtW39cbbcsRYiPuiiMD0A+obLyrkvKO+jA@mail.gmail.com>
 <CALmnu0Y0kvU-yqrKvNAQmjUgFJQ-v0NESyV6o_=CuVzc2dx=YQ@mail.gmail.com>
 <CAN+gG=GucHKyGB0Z=qP+G2KSej0yoVe3vpa3AzRbBDeP2jw9Qg@mail.gmail.com>
 <CALmnu0a_HmgJXa9aYbCpyRhAb5h_FrLyhVUeeojMJa0tPUTHTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:33476 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaLQBJp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2014 20:09:45 -0500
Content-Disposition: inline
In-Reply-To: <CALmnu0a_HmgJXa9aYbCpyRhAb5h_FrLyhVUeeojMJa0tPUTHTg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amordea Whiteoak <amordea@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>

On Mon, Dec 15, 2014 at 03:05:04PM -0500, Amordea Whiteoak wrote:
> > Strictly speaking, there is no right click button on clickpads. We
> > emulate one with the software buttons in Xorg.
> > IIRC, there were some "workarounds" in your original bugs which
> > consist in disabling the software buttons area. Can you make sure that
> > there is no left over from this?
> 
> I learn new things about clickpads every day. :)
> 
> To my knowledge, those configurations changes should reset upon reboot
> and I never committed any of those lines to any of my startup files.
> So we should be good there, I think. Just in case, I am enclosing the
> output of my synclient -l, which should be the default configuration.

there are at least two options in there that are non-default, so maybe other
options are different too. an xorg.log would be more useful here, or make
sure that you don't have any custom configs in /etc/X11/xorg.conf.d/
or an xorg.conf

> > If this still doesn't work, we wil need to check that the X and Y
> > ranges reported by your clickpad are accurate and that the software
> > buttons are properly activated.
> 
> I don't know the testing methodology to use to provide positioning
> data for my trackpad, but let me know if you need that and how you
> want me to get it and I will be happy to provide.

Two options:
* use evtest or evemu-record to record the data and look at the output, or
  simpler
* use libevdev's touchpad-edge-detector tool to scope out the min/max ranges
  of your touchpad

Cheers,
   Peter

