From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/7] Input: xpad: Set the correct LED number
Date: Mon, 3 Feb 2014 09:22:11 +0100
Message-ID: <20140203082211.GB21279@kroah.com>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
 <1391173414-6199-5-git-send-email-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41289 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaBCIUo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 03:20:44 -0500
Content-Disposition: inline
In-Reply-To: <1391173414-6199-5-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

On Fri, Jan 31, 2014 at 02:03:31PM +0100, Greg Kroah-Hartman wrote:
> From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> 
> The LED number should not just be incremented every time, that doesn't
> work, set the number based on the number it actually is.
> 
> Note, the joydev subsystem doesn't allow us to easily find out the minor
> number, so we have to walk all devices in order to find a joystick
> device by looking at the name of the device.  Odds are, this isn't the
> best way to do it, but I don't know of any other way at the moment.
> 
> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/input/joystick/xpad.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

I'll preempt David's NAK of this patch before he gets a chance to catch
up on his email from being at FOSDEM :)

I spent some time talking with David about this, and I think I know a
better way to handle this instead of the "walk the joystick devices"
mess that should work for systems that don't even use joydev (which
"modern" systems shouldn't be using anyway.)

So I'll do a respin of this patch series in a week or so when I catch up
with my other stuff and send it out again...

But, if someone wants to review the other 6 in this series, that would
be great.

thanks,

greg k-h
