From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Wed, 29 Feb 2012 16:37:15 -0500
Message-ID: <CAKON4OymbCJL7takyEujPmjmNVE4hWEOVi9FX8sjg3sPd-2ybg@mail.gmail.com>
References: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55303 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab2B2VhR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Feb 2012 16:37:17 -0500
Received: by wgbdr13 with SMTP id dr13so4140070wgb.1
        for <linux-input@vger.kernel.org>; Wed, 29 Feb 2012 13:37:15 -0800 (PST)
In-Reply-To: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Paris <eparis@parisplace.org>
Cc: linux-input@vger.kernel.org

On Wed, Feb 29, 2012 at 4:00 PM, Eric Paris <eparis@parisplace.org> wro=
te:
> I'm running an up2date version of Fedora 16 (I am completely input
> clueless so have no idea what might be relevant, please tell me what =
I
> can supply).
>
> kernel-3.2.7-1.fc16.x86_64
> xorg-x11-server-common-1.11.4-1.fc16.x86_64
>
> I just got a new Logitech MX5500 bluetooth keyboard mouse combo. =A0I
> had no problem at all getting them recognized and connected using the
> built in bluetooth on my Lenovo X200 laptop. =A0My problem is with th=
e
> middle mouse 'button.' =A0On all of my other mice clicking the scroll
> wheel acted as a middle button. =A0On this new mouse it makes a noise
> like a 'click' but it doesn't do anything. =A0I launched evtest and s=
ee
> events for everything on the mouse (it has a thumb scroll whell, extr=
a
> buttons, all sorts of stuff) but it gives no event for 'click'ing the
> scroll wheel. (I do see events for scrolling the scroll wheel)
>
> So, what can I do, try, collect, give, test, code, whatever to figure
> out if my mouse just wasn't supposed to have have a middle mouse clic=
k
> (aka return this PoS because I need fast cut and paste). =A0Figure ou=
t
> if just this one particular mouse has a broken button (aka replace
> this mouse) or if really it's a driver problem. =A0Any help would be
> greatly appreciated!

It has never worked as far as I know. The middle button on the mouse
reports as device 0 which the input layer is not expecting. I gave up
trying to get it to work.

This makes the back button near your thumb work as the middle button:
/usr/bin/xinput set-button-map "Logitech MX Revolution Mouse" 1 2 3 4 5=
 6 2 2

I have it in .bashrc but it really should be in a udev script. The
mouse occasionally disconnects/reconnect. In udev the command would
get automatically reapplied.

BTW, it you plug the mouse in under Windows and program the middle
button to behave like a middle button, it will work until you forget
to charge the mouse. Then you have to put it back on Windows and
reprogram the button.



>
> -Eric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
