From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Wed, 29 Feb 2012 15:28:22 -0600
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FE96BAD@AUSP01VMBX24.collaborationhost.net>
References: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail132.messagelabs.com ([216.82.242.115]:13527 "EHLO
	mail132.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331Ab2B2Vam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Feb 2012 16:30:42 -0500
In-Reply-To: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Paris <eparis@parisplace.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wednesday, February 29, 2012 2:01 PM, Eric Paris wrote:
> I'm running an up2date version of Fedora 16 (I am completely input
> clueless so have no idea what might be relevant, please tell me what I
> can supply).
>
> kernel-3.2.7-1.fc16.x86_64
> xorg-x11-server-common-1.11.4-1.fc16.x86_64
>
> I just got a new Logitech MX5500 bluetooth keyboard mouse combo.  I
> had no problem at all getting them recognized and connected using the
> built in bluetooth on my Lenovo X200 laptop.  My problem is with the
> middle mouse 'button.'  On all of my other mice clicking the scroll
> wheel acted as a middle button.  On this new mouse it makes a noise
> like a 'click' but it doesn't do anything.  I launched evtest and see
> events for everything on the mouse (it has a thumb scroll whell, extra
> buttons, all sorts of stuff) but it gives no event for 'click'ing the
> scroll wheel. (I do see events for scrolling the scroll wheel)
>
> So, what can I do, try, collect, give, test, code, whatever to figure
> out if my mouse just wasn't supposed to have have a middle mouse click
> (aka return this PoS because I need fast cut and paste).  Figure out
> if just this one particular mouse has a broken button (aka replace
> this mouse) or if really it's a driver problem.  Any help would be
> greatly appreciated!

I actually had my MX5500 mouse torn apart the other day to clean it.

The scroll wheel does have a push button switch underneath it. There are also
two push button switches on the sides to detect a left/right tilt of the scroll
wheel.

Unfortunately, I only have Linux running under VMware so my mouse is virtualized.
I don't think I can do anything to help you figure out how to get the button to work.

This doesn't help you get the button working.. But at least you know there is
one physically in the mouse.

Regards,
Hartley
