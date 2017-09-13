From: Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH] HID: Remove Jabra speakerphone devices from ignore list
Date: Wed, 13 Sep 2017 15:33:36 +0200
Message-ID: <CAP_ceTzwOgA6e2gO2fc8vzps4mUJkxC=LzoGEACHcLKkoygXpA@mail.gmail.com>
References: <CAP_ceTxM-Rgz=i6Zy_iBOa1Cs5D=5Hi0BgWzQKmXoWmL_9TBWA@mail.gmail.com>
 <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com>
 <CAP_ceTz-9vYpo1xqUnEF=LtWcGhxx5FiTo7xJwLreL5vYx7xww@mail.gmail.com> <VI1PR0701MB299142D55AF9734A4BC5CADADA690@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:48644 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdIMNd6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 09:33:58 -0400
Received: by mail-it0-f44.google.com with SMTP id c195so2608090itb.1
        for <linux-input@vger.kernel.org>; Wed, 13 Sep 2017 06:33:58 -0700 (PDT)
In-Reply-To: <VI1PR0701MB299142D55AF9734A4BC5CADADA690@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "mnilsson@chromium.org" <mnilsson@chromium.org>

On Tue, Sep 12, 2017 at 4:22 PM, Niels Skou Olsen <nolsen@jabra.com> wrote:
>
> On Tue, 12 Sep 2017, vpalatin@google.com wrote:
>
> > On Mon, Sep 11, 2017 at 11:27 AM, Niels Skou Olsen <nolsen@jabra.com> w=
rote:
> > >
> > > On Fri, 8 Sep 2017, vpalatin@google.com wrote:
> > >
> > >> Re-sending (seems I forgot the HTML subpart that linux-input doesn't
> > >> like)
> > >>
> > >> On Fri, Sep 8, 2017 at 3:13 PM, Jiri Kosina <jikos@kernel.org> wrote=
:
> > >> >
> > >> > On Tue, 5 Sep 2017, nolsen@jabra.com wrote:
> > >> >
> > >> > > From: Niels Skou Olsen <nolsen@jabra.com>
> > >> > >
> > >> > > Two Jabra speakerphone devices were added to the ignore list in
> > >> > > 2013 because, at the time, the device HID interfaces didn't work
> > >> > > well with kernel usbhid driver, and could reportedly cause volum=
e
> > >> > > key event storm.
> > >> >
> > >> > Also apparently there was an userspace application that made use o=
f
> > >> > these keys, and required the usbhid driver to be unbound from them=
.
> > >> >
> > >> > How come this is not the case any more?
> > >
> > > I can't really tell why, but it could be that our firmware has "impro=
ved" since 2013,
> > > and maybe also the Linux drivers and user mode stuff like PulseAudio =
have improved
> > > the situation. Anyway, I don't see the volume event storm issue when =
I test on a
> > > Ubuntu desktop with patched 4.4 and 4.13 kernels, and our firmware
> > > SPEAK410/1.8.0 and SPEAK510/2.10.0.
> >
> > A related question: How does I read the firmware on Jabra speaker ?
> > (see below why)
> > Pick something which looks like a brand new Jabra SPEAK 410 (Model:
> > PHS001U P/N 7410 - 219  , Ver.: A120314) gives me :
> >   idVendor           0x0b0e GN Netcom
> >   idProduct          0x0412
> >   bcdDevice            1.09
> >   iManufacturer           0
> >   iProduct                2 Jabra SPEAK 410 USB
> >   iSerial                 3 50C971FEF72Dx010900
> >
> > is the bcdDevice related to hardware version or firmware version ?
>
> The bcdDevice is the firmware version. So you are running 1.9.0 (the last=
 level is always 0).
>
> > >> On our side, we are still using a custom userspace for the Jabra
> > >> speakers (ie the jabra_vold daemon:
> > >> https://chromium.googlesource.com/chromiumos/platform/jabra_vold/+/m=
a
> > >> ster plus some direct USB interfacing in a Chrome app).
> > >> while If somebody is using the device another way, we can blacklist
> > >> it or detach it on our side in the future,  I'm somewhat surprised
> > >> that it's working well through the HID interface with the Jabra
> > >> speakerphone 510. Even if there is no longer any basic breakage, in
> > >> my experience there are other challenges to overcome with the 510
> > >> firmware (at least the one I had on my devices) e.g. for the volume
> > >> key to work more than once, you need to do a precise sequence on the=
 USB
> > audio interface every time one of the volume key is released.
> > >> Do you have another kernel driver for this ? a userspace software ?
> > >
> > > Thank you for your input, Vincent. As mentioned above I can't reprodu=
ce the
> > > volume event storm. I can, however, reproduce the issue you mention, =
that our
> > > device only emits an event for the first volume key press. We have a =
new firmware
> > > fixing that, so that volume keys now behave sanely on Linux. I would =
be happy to
> > > send you the new firmware, if you could find the time to try it out w=
ith ChromiumOS.
> > > Just let me know.
> >
> > Sure I can test it, if you have a firmware updater for Linux (ie downlo=
aded firmware
> > from Jabra website gives me a .dfu file I don't know what I'm supposed =
to do with)
>
> The .dfu file can be programmed into the device using dfu-util (http://df=
u-util.sourceforge.net/). The device needs to be put into DFU mode before r=
unning dfu-util.

Along with the firmware version in bcdDevice, this is great news !
So everybody should have a path to update.

> Unfortunately, the only way to enter DFU mode is by sending a command ove=
r HID -- there is no way to do it on the device.
> So, to update, the HID blacklisting needs to be removed.
> I will send you a shell script that puts the device into DFU mode and inv=
okes dfu-util.

maybe ... or to send a single command, you can also send it directly
to the USB device rather than through the HID layer.
It's a bit challenging to write in a shell script (but not
impossible), my own lame Python one-liner makes my Jabra 410 ring :
python -c "from ctypes import * ; so =3D CDLL('libusb-1.0.so') ;
so.libusb_init(c_void_p()) ;
so.libusb_control_transfer(so.libusb_open_device_with_vid_pid(None,
0x0b0e, 0x0412), 0x21, 0x09, 0x0203, 0x0003, '\x03\x08\0', 3, 5000)"
it would probably put it in DFU mode if I knew the secret command.

>
> > > Could we remove the blacklisting even if the current firmware behaves=
 a bit "weird"
> > > with regard to volume button handling?
> > >  I don't think this quirk is severe enough to warrant the complete bl=
acklisting.
> >
> > wrt 'the complete blacklisting', not really it's just disabling instant=
iating a HID device
> > by default, the USB device is still there, adventurous people who knows=
 what to do
> > with it can still ask for the HID device (e.g by passing
> > 'quirks=3D0x0b0e:0x0412:0x40000000' as usbhid module parameter to avoid=
 ignoring
> > it)
>
> That's a nice trick, but most end users can't do that.

most end users cannot use the current firmware either ...
Actually plugging the Jabra SPEAK 410 (firmware 1.9) on my workstation
(running Ubuntu LTS 14.04 with kernel 4.4) has just randomly made my
mouse misbehave to my great dismay. With the old firmware, not all
issues are gone.


> > wrt 'current firmware behaves a bit "weird" with regard to volume butto=
n', that was an
> > example but over the 5 buttons (vol_up, vol_down, mic_mute, call, hang_=
up), none of
> > them is behaving properly with just the regular HID driver:
> > vol_up/down works only once as mentioned earlier, mute/call/hang never =
sends
> > events (due to the state the device is in by default). If I remember pr=
operly getting
> > them to work requires to send HID reports
> > (SET_REPORT) to the device first, ie basically writing a program to do =
so.
> > So with no working buttons by default, it's not really interesting to i=
nstantiate the
> > driver ...
>
> Yes, the volume buttons have issues. We are fixing it. The other telephon=
y related buttons need a softphone application to help drive the state mach=
ine in the device. For example, when you hit the call button a report is is=
sued. Now a softphone must acknowledge that a call is open. If this does no=
t happen, the device will time out and emit a hangup report. If you press h=
angup with an active call, a hangup report is emiited. If you press hangup =
without an active call, no report is emitted. So I don't think it's fair to=
 say 'no buttons working'. And it definitely is interesting for us that the=
 HID driver is instantiated. Without it you can't write applications that d=
oes call control, firmware update etc.

You cannot or you can ... actually with the current firmware issues,
we wrote 2 years chrome.usb application which works well so far.


>
> > > As mentioned we have a new firmware coming out now that fixes it.
> > > And if ChromiumOS intends to continue with jabra_vold and blacklistin=
g in the
> > > future, I guess there is no conflict?
> >
> > Are you planning to provide the new firmware and the updater to the Lin=
ux users ?
> > If so, we might be able to make the quirk conditional on the firmware v=
ersion ? (hence
> > my firmware version reading question above)
>
> Yes. As mentioned dfu-util can do the update given a tiny shell script wr=
apper, and the firmware will be available on jabra.com. Also we have a mass=
 deployment tool for corporate Linux based thin client environments.
>
> > ChromiumOS devs will do whatever is necessary to keep the current devic=
es
> > working and avoiding the current userspace daemon would be one less mai=
ntenance
> > burden, but for other Linux users, there is very little value in gettin=
g an always broken
> > HID device unless they can update their devices.
>
> Agreed. But it is catch-22 here -  the HID blacklisting needs to be lifte=
d in order for firmware update on a Linux system to be possible.

I don't think so, as mentioned above.
It would have been nice to ignore it in HID based on the firmware
version/bcdUSB but not my call.

--=20
Vincent
