From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no longer works
Date: Fri, 09 Jun 2017 12:41:31 +0200
Message-ID: <87y3t1h290.fsf@miraculix.mork.no>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
        <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
        <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
        <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
        <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
        <20170609082703.GA29271@kroah.com> <8760g5ilut.fsf@miraculix.mork.no>
        <20170609090028.GA30604@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:52529 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbdFIKl6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Jun 2017 06:41:58 -0400
In-Reply-To: <20170609090028.GA30604@kroah.com> (Greg KH's message of "Fri, 9
        Jun 2017 11:00:28 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Greg KH <greg@kroah.com> writes:
> On Fri, Jun 09, 2017 at 10:52:42AM +0200, Bj=C3=B8rn Mork wrote:
>> Greg KH <greg@kroah.com> writes:
>>=20
>> > On Fri, Jun 09, 2017 at 10:21:47AM +0200, Jiri Kosina wrote:
>> >> Longer-term, we'd ideally make 'generic' driver special and let it at=
tach=20
>> >> as a 'last resort driver' if none of the specific driver picked the d=
evice=20
>> >> up during probe. But I don't think our current driver model allows th=
is=20
>> >> easily ... or is there way I am not seeing?
>> >
>> > Nope, the driver model does not provide a way for this, sorry, it's be=
en
>> > a complaint from the very beginning that we don't really know how to
>> > handle, except to make sure the order of the drivers loaded are the
>> > priority list, and that's not really a solution at all.
>>=20
>> Add a 'priority' field to struct device_driver and sort the list by this
>> field instead of load order?
>
> We've been over this before :)

OK, I have to google that.

> What happens when a new module is loaded, are you supposed to then
> disconnect a device from an existing driver, recan all of the existing
> drivers, and then bind the "correct" one then?


You don't have to touch any bound device unless it matches the new
driver, which hopefully only will be the rare cases where that driver
actually *is* a better alternative.

But yes, there are many issues which needs to be resolved.  What if you
unbind from an existing driver and the new driver fails probing?  What
if the user manually bound the device to the existing driver?  What if
different devices want different driver priorities? Can we make module
loading follow the priority to avoid bind/unbind bouncing for the common
case?  Etc.

Lots of work, but I still think it's the way to go.  Just look at what
we have today: Inflexible build time priorities implemented as paired
blacklists and whitelists.  Even if you get all the IS_ENABLED ifdefs
right, you will fail if the user blacklists or removes one of the
modules at runtime.  And when you have two alternative drivers for a
device, possibly with different feature sets [1], there is no way to
switch between drivers without rebuilding.  And you have a number of
class drivers with long lists of apparently redundant device IDs.  Until
you look at the source and discover that these devices are actually
blacklisted. Ugly and confusing.

I was a bit unsure if I should dare mention this since it is one of the
uglier constructs I know about, and I am responsible, but what the h...:
The cdc_ncm vs cdc_mbim is particularily bad.  It has its own "priority"
flag implemented as a module parameter in the cdc_ncm driver. This was
done because both drivers had to match NCM interfaces, since these are
allowed to transform into MBIM interfaces depending on altsetting. I
still don't see any way to support that without priorities.  I only wish
I had tried to push generic driver priorities instead of making it
specific to cdc_ncm/cdc_mbim.

But I should probably go google now, before I repeat too mcuh of the
previous discussions ;-)


[1] there are real examples of this.  r8152 vs cdc_ether is one.



Bj=C3=B8rn
