From: Eric Paris <eparis@parisplace.org>
Subject: Re: Logitech MX5500 Bluetooth mouse middle 'button' does not work
Date: Thu, 1 Mar 2012 08:45:44 -0500
Message-ID: <CACLa4psSCDyCqGfyqqYfua=1wdstQzMzFWrtFaKf=p3tgBUg4w@mail.gmail.com>
References: <CACLa4pukyDgXeqJ=e7-b+FKw88O32g02zob0R1T9JR1VvR+2mQ@mail.gmail.com>
	<CAKON4OymbCJL7takyEujPmjmNVE4hWEOVi9FX8sjg3sPd-2ybg@mail.gmail.com>
	<CACLa4pvuSqorMzdNE8nPvHVyayufUoL95AXNh9-8_M5oLONhWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55201 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759282Ab2CANpp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Mar 2012 08:45:45 -0500
Received: by vcqp1 with SMTP id p1so436031vcq.19
        for <linux-input@vger.kernel.org>; Thu, 01 Mar 2012 05:45:44 -0800 (PST)
In-Reply-To: <CACLa4pvuSqorMzdNE8nPvHVyayufUoL95AXNh9-8_M5oLONhWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Mar 1, 2012 at 8:39 AM, Eric Paris <eparis@parisplace.org> wrot=
e:
> On Wed, Feb 29, 2012 at 4:37 PM, jonsmirl@gmail.com <jonsmirl@gmail.c=
om> wrote:
>> On Wed, Feb 29, 2012 at 4:00 PM, Eric Paris <eparis@parisplace.org> =
wrote:
>
>>> I just got a new Logitech MX5500 bluetooth keyboard mouse combo. =A0=
I
>>> had no problem at all getting them recognized and connected using t=
he
>>> built in bluetooth on my Lenovo X200 laptop. =A0My problem is with =
the
>>> middle mouse 'button.' =A0On all of my other mice clicking the scro=
ll
>>> wheel acted as a middle button. =A0On this new mouse it makes a noi=
se
>>> like a 'click' but it doesn't do anything. =A0I launched evtest and=
 see
>>> events for everything on the mouse (it has a thumb scroll whell, ex=
tra
>>> buttons, all sorts of stuff) but it gives no event for 'click'ing t=
he
>>> scroll wheel. (I do see events for scrolling the scroll wheel)
> ...
>> It has never worked as far as I know. The middle button on the mouse
>> reports as device 0 which the input layer is not expecting. I gave u=
p
>> trying to get it to work.
>>
>> This makes the back button near your thumb work as the middle button=
:
>> /usr/bin/xinput set-button-map "Logitech MX Revolution Mouse" 1 2 3 =
4 5 6 2 2
>>
>> I have it in .bashrc but it really should be in a udev script. The
>> mouse occasionally disconnects/reconnect. In udev the command would
>> get automatically reapplied.
>
> If I run your command by hand it works. =A0I created a udev rule to t=
ry
> to auto-run the command and it does not work.
>
> ATTR{address}=3D=3D"00:1F:20:3A:C8:BD", ACTION=3D=3D"add",
> RUN+=3D"/usr/bin/xinput set-button-map "Logitech MX Revolution Mouse"=
 1
> 2 3 4 5 6 2 2"
>
> I know the udev rule is triggered, because when I replaced it with
> /bin/touch /tmp/logitech the file was created in /tmp every time the
> mouse turned on. =A0Now I'm trying to figure out why it doesn't work =
as
> a udev rule. =A0Anyone thoughts? =A0If not, at least I have one way t=
o get
> it mostly working. =A0Thanks so much everyone!

I probably have 2 problems.

1) I used "" around the "Logitech MX Revolution Mouse" which likely
screwed up the udev rule
2) after moving that to a script and piping the output to a file I see
the xinput fails with:

Unable to connect to X server

Any thoughts from anyone?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
