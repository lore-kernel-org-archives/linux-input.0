From: Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH] HID: Remove Jabra speakerphone devices from ignore list
Date: Tue, 12 Sep 2017 12:04:04 +0200
Message-ID: <CAP_ceTz-9vYpo1xqUnEF=LtWcGhxx5FiTo7xJwLreL5vYx7xww@mail.gmail.com>
References: <CAP_ceTxM-Rgz=i6Zy_iBOa1Cs5D=5Hi0BgWzQKmXoWmL_9TBWA@mail.gmail.com>
 <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:38897 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdILKE1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Sep 2017 06:04:27 -0400
Received: by mail-io0-f182.google.com with SMTP id n69so42491236ioi.5
        for <linux-input@vger.kernel.org>; Tue, 12 Sep 2017 03:04:27 -0700 (PDT)
In-Reply-To: <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "mnilsson@chromium.org" <mnilsson@chromium.org>

On Mon, Sep 11, 2017 at 11:27 AM, Niels Skou Olsen <nolsen@jabra.com> wrote=
:
>
> On Fri, 8 Sep 2017, vpalatin@google.com wrote:
>
>> Re-sending (seems I forgot the HTML subpart that linux-input doesn't lik=
e)
>>
>> On Fri, Sep 8, 2017 at 3:13 PM, Jiri Kosina <jikos@kernel.org> wrote:
>> >
>> > On Tue, 5 Sep 2017, nolsen@jabra.com wrote:
>> >
>> > > From: Niels Skou Olsen <nolsen@jabra.com>
>> > >
>> > > Two Jabra speakerphone devices were added to the ignore list in 2013
>> > > because, at the time, the device HID interfaces didn't work well
>> > > with
>> > > kernel usbhid driver, and could reportedly cause volume key event
>> > > storm.
>> >
>> > Also apparently there was an userspace application that made use of
>> > these keys, and required the usbhid driver to be unbound from them.
>> >
>> > How come this is not the case any more?
>
> I can't really tell why, but it could be that our firmware has "improved"=
 since 2013, and maybe also the Linux drivers and user mode stuff like Puls=
eAudio have improved the situation. Anyway, I don't see the volume event st=
orm issue when I test on a Ubuntu desktop with patched 4.4 and 4.13 kernels=
, and our firmware SPEAK410/1.8.0 and SPEAK510/2.10.0.

A related question: How does I read the firmware on Jabra speaker ?
(see below why)
Pick something which looks like a brand new Jabra SPEAK 410 (Model:
PHS001U P/N 7410 - 219  , Ver.: A120314) gives me :
  idVendor           0x0b0e GN Netcom
  idProduct          0x0412
  bcdDevice            1.09
  iManufacturer           0
  iProduct                2 Jabra SPEAK 410 USB
  iSerial                 3 50C971FEF72Dx010900

is the bcdDevice related to hardware version or firmware version ?


>
>> On our side, we are still using a custom userspace for the Jabra speaker=
s (ie the
>> jabra_vold daemon:
>> https://chromium.googlesource.com/chromiumos/platform/jabra_vold/+/maste=
r
>> plus some direct USB interfacing in a Chrome app).
>> while If somebody is using the device another way, we can blacklist it o=
r detach it on
>> our side in the future,  I'm somewhat surprised that it's working well t=
hrough the HID
>> interface with the Jabra speakerphone 510. Even if there is no longer an=
y basic
>> breakage, in my experience there are other challenges to overcome with t=
he 510
>> firmware (at least the one I had on my devices) e.g. for the volume key =
to work more
>> than once, you need to do a precise sequence on the USB audio interface =
every time
>> one of the volume key is released.
>> Do you have another kernel driver for this ? a userspace software ?
>
> Thank you for your input, Vincent. As mentioned above I can't reproduce t=
he volume event storm. I can, however, reproduce the issue you mention, tha=
t our device only emits an event for the first volume key press. We have a =
new firmware fixing that, so that volume keys now behave sanely on Linux. I=
 would be happy to send you the new firmware, if you could find the time to=
 try it out with ChromiumOS. Just let me know.

Sure I can test it, if you have a firmware updater for Linux
(ie downloaded firmware from Jabra website gives me a .dfu file I
don't know what I'm supposed to do with)

>
> Could we remove the blacklisting even if the current firmware behaves a b=
it "weird" with regard to volume button handling?
>  I don't think this quirk is severe enough to warrant the complete blackl=
isting.

wrt 'the complete blacklisting', not really it's just disabling
instantiating a HID device by default,
the USB device is still there, adventurous people who knows what to do
with it can still ask for the HID device (e.g by passing
'quirks=3D0x0b0e:0x0412:0x40000000' as usbhid module parameter to avoid
ignoring it)

wrt 'current firmware behaves a bit "weird" with regard to volume
button', that was an example but over the 5 buttons (vol_up, vol_down,
mic_mute, call, hang_up), none of them is behaving properly with just
the regular HID driver:
vol_up/down works only once as mentioned earlier, mute/call/hang never
sends events (due to the state the device is in by default). If I
remember properly getting them to work requires to send HID reports
(SET_REPORT) to the device first, ie basically writing a program to do
so.
So with no working buttons by default, it's not really interesting to
instantiate the driver ...

> As mentioned we have a new firmware coming out now that fixes it.
> And if ChromiumOS intends to continue with jabra_vold and blacklisting in=
 the future, I guess there is no conflict?

Are you planning to provide the new firmware and the updater to the
Linux users ?
If so, we might be able to make the quirk conditional on the firmware
version ? (hence my firmware version reading question above)

ChromiumOS devs will do whatever is necessary to keep the current
devices working and avoiding the current userspace daemon would be one
less maintenance burden, but for other Linux users, there is very
little value in getting an always broken HID device unless they can
update their devices.

--=20
Vincent
