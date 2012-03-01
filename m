From: Eric Paris <eparis@parisplace.org>
Subject: Re: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Thu, 1 Mar 2012 08:39:10 -0500
Message-ID: <CACLa4pvuSqorMzdNE8nPvHVyayufUoL95AXNh9-8_M5oLONhWg@mail.gmail.com>
References: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
	<CAKON4OymbCJL7takyEujPmjmNVE4hWEOVi9FX8sjg3sPd-2ybg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62217 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680Ab2CANjM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Mar 2012 08:39:12 -0500
Received: by vbbff1 with SMTP id ff1so434116vbb.19
        for <linux-input@vger.kernel.org>; Thu, 01 Mar 2012 05:39:11 -0800 (PST)
In-Reply-To: <CAKON4OymbCJL7takyEujPmjmNVE4hWEOVi9FX8sjg3sPd-2ybg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Feb 29, 2012 at 4:37 PM, jonsmirl@gmail.com <jonsmirl@gmail.com=
> wrote:
> On Wed, Feb 29, 2012 at 4:00 PM, Eric Paris <eparis@parisplace.org> w=
rote:

>> I just got a new Logitech MX5500 bluetooth keyboard mouse combo. =A0=
I
>> had no problem at all getting them recognized and connected using th=
e
>> built in bluetooth on my Lenovo X200 laptop. =A0My problem is with t=
he
>> middle mouse 'button.' =A0On all of my other mice clicking the scrol=
l
>> wheel acted as a middle button. =A0On this new mouse it makes a nois=
e
>> like a 'click' but it doesn't do anything. =A0I launched evtest and =
see
>> events for everything on the mouse (it has a thumb scroll whell, ext=
ra
>> buttons, all sorts of stuff) but it gives no event for 'click'ing th=
e
>> scroll wheel. (I do see events for scrolling the scroll wheel)
=2E..
> It has never worked as far as I know. The middle button on the mouse
> reports as device 0 which the input layer is not expecting. I gave up
> trying to get it to work.
>
> This makes the back button near your thumb work as the middle button:
> /usr/bin/xinput set-button-map "Logitech MX Revolution Mouse" 1 2 3 4=
 5 6 2 2
>
> I have it in .bashrc but it really should be in a udev script. The
> mouse occasionally disconnects/reconnect. In udev the command would
> get automatically reapplied.

If I run your command by hand it works.  I created a udev rule to try
to auto-run the command and it does not work.

ATTR{address}=3D=3D"00:1F:20:3A:C8:BD", ACTION=3D=3D"add",
RUN+=3D"/usr/bin/xinput set-button-map "Logitech MX Revolution Mouse" 1
2 3 4 5 6 2 2"

I know the udev rule is triggered, because when I replaced it with
/bin/touch /tmp/logitech the file was created in /tmp every time the
mouse turned on.  Now I'm trying to figure out why it doesn't work as
a udev rule.  Anyone thoughts?  If not, at least I have one way to get
it mostly working.  Thanks so much everyone!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
