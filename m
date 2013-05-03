From: Ignaz Forster <ignaz.forster@gmx.de>
Subject: Re: Game Controllers
Date: Sat, 04 May 2013 00:03:22 +0200
Message-ID: <5184342A.10706@gmx.de>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com> <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com> <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:52935 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034Ab3ECWFM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 May 2013 18:05:12 -0400
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MYIQh-1V3TmR3G1B-00V9y4 for
 <linux-input@vger.kernel.org>; Sat, 04 May 2013 00:05:10 +0200
In-Reply-To: <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: todd@electronjump.com
Cc: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Todd Showalter schrieb am 30.04.2013 02:46 Uhr:
>     What I'd like to request at the evdev level is that things which
> are gamepads export these values in standard offsets, so that:
> 
> EV_ABS 0 == left stick x
> EV_ABS 1 == left stick y
> EV_ABS 2 == right stick x
> EV_ABS 3 == right stick y
> EV_ABS 4 == dpad x
> EV_ABS 5 == dpad y
> EV_ABS 6 == left trigger
> EV_ABS 7 == right trigger
> 
>     Or some similar defined order.  I'd like buttons to be similarly mapped:
> 
> BTN_START == start button
> BTN_WEST == xbox x, ps square
> BTN_NORTH == xbox y, ps triangle
> BTN_EAST == xbox b, ps circle
> BTN_SOUTH == xbox a, ps x

I don't think this will work as you expect it.

Let's take my own gamepad adapter for example: You can connect PlayStation, Dreamcast and GameCube controllers to it. The Dreamcast controller has the A button on the bottom and the B button on the right side, the GameCube controller has the A button in the middle and the B button on the lower left side:

          | A      | B          | X     | Y
- ----------+--------+------------+-------+-----
Dreamcast | bottom | right      | left  | top
- ----------+--------+------------+-------+-----
GameCube  | middle | lower left | right | top

In any case the A button is reported as the first button, the B button as the second one etc.
Now the question is: Which button is BTN_WEST? You cannot tell, as it depends on what controller is connected.

This may be a special case, but there are probably other controllers with "weird" button layouts out there (e.g. 6 button pads, the SNES pad, ...); moreover you don't have the guaranty that every gamepad has all the buttons you expect.
To make it usable "out of the box" you would have to limit the interface to gamepads with a certain layout, but this will probably break if any of the major manufacturers decides to develop a new gamepad layout. Those "features specific to a gamepad" you are mentioning in another mail are probably everything that a gamepad has, as you can never be sure about it's layout ;-)


While I totally agree that the situation is not ideal there is probably nothing to do about it. Using a default layout which fits for most controllers (these days probably the Xbox 360 controller layout) and offering some kind of ingame mapping to adjust it for non-standard controllers should be the way to go. You will have to offer an ingame remapping option anyway if you don't want to force your users to use your button mapping even if they may prefer another one.


Ignaz
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with SeaMonkey - http://www.enigmail.net/

iEYEARECAAYFAlGENCoACgkQ/2+SjQTlQJnbVwCfVVGZcuESUNv9V+UDcLikGJtC
RUYAmwcYvb7Ngjo0fSNkrhXoeA4hXKWj
=dH7P
-----END PGP SIGNATURE-----
