From: Terry Lambert <tlambert@chromium.org>
Subject: Re: Busted keyboard, fix, and Question about default HID device plumbing
Date: Fri, 7 Oct 2011 19:56:54 -0700
Message-ID: <CAA_E9NEi_gxb4px1344ChsAMmTEkUGSP8Vj=X31fBnQgwJ4c0g@mail.gmail.com>
References: <CAA_E9NGQC1Jy-MqRbMEj1cetuFktknBmtU91N7gPv1_rApzX6Q@mail.gmail.com>
	<20111007220745.GA30273@core.coreip.homeip.net>
	<CAA_E9NEDVynFfVBfkXPW6viAsGT3_ffBVfD309eSAeqq6QGj3w@mail.gmail.com>
	<20111008002524.GB30273@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:2192 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab1JHC46 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 22:56:58 -0400
Received: from hpaq7.eem.corp.google.com (hpaq7.eem.corp.google.com [172.25.149.7])
	by smtp-out.google.com with ESMTP id p982uu2f018186
	for <linux-input@vger.kernel.org>; Fri, 7 Oct 2011 19:56:56 -0700
Received: from gyg4 (gyg4.prod.google.com [10.243.50.132])
	by hpaq7.eem.corp.google.com with ESMTP id p982uNhQ016943
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 7 Oct 2011 19:56:55 -0700
Received: by gyg4 with SMTP id 4so5811645gyg.5
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2011 19:56:55 -0700 (PDT)
In-Reply-To: <20111008002524.GB30273@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-usb@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

You make a very good point on the key remapping.

=2E..

Are we sure that there isn't a field in the keyboard information in
the USB that reports the keyboard does this?

The only other alternative seems to be to quirk the keyboard as
reporting keys down when they are down, up when they are up, and
generating pseudo events for "keycode not present in report".

I guess I'm willing to write a "hosed keyboard driver" driver if
necessary.  This apparently effects about 5-10% of keyboards,
predominantly laptops with internal USB (some dell inspiron, some
samsung), and the folding keyboards people like to use with android
tablets.

I'm willing to take any advice about where I can get a handle on all
the keys in a given report to implement a general quirk on this
hardware.

If necessary, we can always write a driver, I suppose, if you can
point me at an example?

Thanks,
-- Terry



On Fri, Oct 7, 2011 at 5:25 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Oct 07, 2011 at 04:01:19PM -0700, Terry Lambert wrote:
> > Thanks for replying, Dmitry...
> >
> > I guess I need to clarify a point or two.
> >
> > On Fri, Oct 7, 2011 at 3:07 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Hi Terry,
> > >
> > > On Fri, Oct 07, 2011 at 01:44:29PM -0700, Terry Lambert wrote:
> > > > I have a USB keyboard that needs a workaround. =A0I know what t=
he
> > > > workaround is, but not where to plumb it in.
> > > >
> > > > This is apparently an issue with a number of keyboards from a n=
umber
> > > > of vendors, and Mac OS X and Windows both work around it. =A0It=
 impacts
> > > > all Linux desktops, Android, and Chrome OS for a number of popu=
lar
> > > > folding keyboards, as well as other keyboards.
> > > >
> > > > I'm perfectly able to write the workaround, and have done so us=
ing the
> > > > boot protocol, but now I want to fix the issue in the default s=
tack
> > > > used for the console.
> > > >
> > > > I don't care about the UHCI/EHCI plumbing, or anything up to hi=
ddev;
> > > > but from there it gets murky as to how an event in the raw driv=
er ends
> > > > up getting turned into a keyboard key. =A0It appears to be lost=
 in
> > > > callbacks I'm having a hard time tracing through.
> > > >
> > > > I've read three books on the Linux USB system, two of them very=
 out of
> > > > date, and they're all written from the perspective of "So, you =
want to
> > > > write a device driver", rather than the perspective of "This bo=
ok
> > > > documents the plumbing between the driver and userspace and how=
 to
> > > > figure it out".
> > > >
> > > > So the question is: how are things plumbed between hiddev and t=
he
> > > > console driver,
> > >
> > >
> > > They aren't. Or maybe we are talking about different "hiddev"s. T=
he
> > > generic HID driver binds devices to hid-input which registers the=
m with
> > > input core as separate input devices. The legacy console register=
s a
> > > separate input handler (see drivers/tty/vt/keyboard.c) that binds=
 to all
> > > keyboard-like devices, listens to input events and converts them =
to
> > > keystrokes and sends them to tty.
> >
> > My question is "who processes USB report packets from a USB keyboar=
d
> > into EV_KEY events?"
>
> drivers/hid/hid-input.c
>
> >
> > I understand that there's a separate evdev handler that publishes r=
aw
> > events as /dev/input/eventX. =A0It's handling the events from somew=
here,
> > but it's not clear to me how a hidraw1 event turns into a console
> > input event.
> >
> > Somewhere someone is translating a USB 1.11 section 8.3 report into=
 an
> > EV_KEY, and I need to do the modifier magic to alter the contents o=
f
> > the reports before it gets to whoever that is.
> > You seem to be saying hid-input.c ... but I'm not seeing the modifi=
er
> > bits being processed out of the report?
>
> I do not believe we pay attention to these modifier bits as we keep
> track of keys pressed ourselves (and keys could be remapped anyway).
>
> Anyway, it looks like the devicde should not be reportign LeftShift
> together with 1 in the 2nd report as it makes hhid-input think that
> (accounding to the rules of 8.3) it is being released.
>
> I wonder if the fix is to not replrt released when we get newly press=
ed
> keys in the report.
>
> Thanks.
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
