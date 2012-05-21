From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: Elantech touchpad detected as Logitech PS2 Wheel Mouse
Date: Mon, 21 May 2012 15:56:53 +0800
Message-ID: <877gw655mi.fsf@emc.com.tw>
References: <4FB939B5.4000309@gmx.com> <20120520192052.GA3959@burratino> <4FB951A0.6020102@gmx.com> <20120521051825.GB3840@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:20714 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2EUHxo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 03:53:44 -0400
In-Reply-To: <20120521051825.GB3840@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>, Nicola Alessi <nialessi@gmx.com>
Cc: linux-input@vger.kernel.org

Hi Jonathan and Nicola,

On Mon, 21 May 2012 00:23:11 -0500, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Nicola Alessi wrote:
> 
> > [    6.734445] psmouse serio4: elantech: unexpected magic knock
> > result 0x3c, 0x03, 0x3c.
           ^^^^^^^^^^^^^^^^^
Yes, from this, the touchpad is probably Elan.

But it is meant to be used as such, a basic pointing device. Some NB
vendors may not require the multi-finger functions, for cost reason or
others. Elan touchpad reports this magic knock when it only supports
the basic mouse functions. With these touchpads, the multi-finger functons
are NOT TESTED and thus NOT SUPPORTED.

We used to have a "force_elantech" module param to force the TP to be
detected as Elan, but I removed it when I was updating elantech.c to
support newer models. Maybe you can convince Dmitry to add it back, but
still, this kind of Elan touchpads is not supported as multi-touch
pointing device, so I wouldn't recommand it.

I hope this helps.

Best regards,
-JJ

> >
> > I hope this can help.
> 
> Yes, thanks much.
> 
> One more question: how do you know this touchpad is an Elantech pad?
> E.g., is there another OS with a driver that detects it as Elantech?
> 
> Based on [1] it seems the Amilo Pi 2515 ships with a variety of
> different touchpad models.
> 
> Jonathan
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=10942
