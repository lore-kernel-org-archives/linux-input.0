From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 09 Jun 2015 00:58:11 +0200
Message-ID: <1433804291.12204.15.camel@hadess.net>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46397 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbbFHW6P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 18:58:15 -0400
In-Reply-To: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Mon, 2015-06-08 at 14:43 -0700, Dmitry Torokhov wrote:
> Hi,
> 
> I finally was able to spend some time looking over Samuel's patch set
> switching input LEDs from custom implementation over to standard LED 
> class
> devices and I think this is the shape I am reasonably happy with. The
> changes:
> 
<snip>
> 2. There are no per-input device triggers. Input devices only carry 
> LEDs
> and those LEDs use one of the system-wide triggers. Which ones is to 
> user
> to decide. The default triggers are the one defines by keyboard 
> handler for
> it's standard LED states.
> 
<snip>
> Please take a look and see if you see any holes.

What would the quirk for a keyboard not having LEDs look like?

In GNOME, we want to pop up a on-screen display when pressing, say, the
Caps Lock key on a keyboard that doesn't have any such keys (such as my
Lenovo X1 Carbon and the Logitech K750 that's plugged into it in my
case).

Cheers
