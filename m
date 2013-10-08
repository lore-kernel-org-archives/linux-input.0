From: simon@mungewell.org
Subject: Re: [PATCH] HID: logitech - lg2ff: Add IDs for Formula Vibration
 Feedback Wheel
Date: Tue, 8 Oct 2013 14:24:24 -0400
Message-ID: <54625f2d10e55f9ca1c5e56d61479fbc.squirrel@mungewell.org>
References: <1381164492-27145-1-git-send-email-anssi.hannula@iki.fi>
    <CADbOyBSry1eFsCycM-BaDEhaA7_+JUBpYZEqA4s5s-g2vq5whg@mail.gmail.com>
    <fa1af5a9ba814114ddf5ee8fe65b8b4b.squirrel@www.mungewell.org>
    <4607275.ItDsRbK9eM@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:46928 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3JHSYp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Oct 2013 14:24:45 -0400
In-Reply-To: <4607275.ItDsRbK9eM@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@prifuk.cz>
Cc: simon@mungewell.org, Elias Vanderstuyft <elias.vds@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

> We can hack the descriptor in hid-logitech just
> like we did it for DFP. If we come across more wheels that need a hacked
> descriptor, perhaps we should consider handling the raw data ourselves
> (check out the Wii remote driver for details)...

We currently 'hack HID desc.' for the DF, DFP and MOMO-Red. The DFGT, G25
and G27 are pushed into native mode and automatically split the brake and
accel axis.

I'll get the 'hack HID desc.' done for Elias' wheel and the MOMO-black I
picked last week. Should be done this week sometime.

I think we've got every wheel variant covered.... unless the release more
with different IDs (recently saw a new DFGT version).

In the longer term we may wish to add an option/control to split (or not)
the brake/accel as the user requests. I don't actually think that anyone
wants combined axis, but there's no telling with some people ;-)

Simon

