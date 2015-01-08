From: "Gavin Lambert" <gavinl@compacsort.com>
Subject: RE: [eGalax] no click events with touchscreen
Date: Fri, 9 Jan 2015 12:19:22 +1300
Message-ID: <000f01d02b99$89843d00$9c8cb700$@compacsort.com>
References: <000701d02af4$cab68350$602389f0$@compacsort.com>	<CAN+gG=Hw98OCcJZj-jUk6H64D+C_eyyXo52uvOdyomFFwELXQw@mail.gmail.com>	<000b01d02b91$4303a8f0$c90afad0$@compacsort.com> <CAN+gG=GKpPhXm8HkxC6WAOQ5RY24WpSXUrOyY6xiPzJ6hGL=yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.compacsort.com ([202.180.125.98]:41341 "EHLO
	mail.compacsort.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbAHXTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 18:19:24 -0500
In-Reply-To: <CAN+gG=GKpPhXm8HkxC6WAOQ5RY24WpSXUrOyY6xiPzJ6hGL=yw@mail.gmail.com>
Content-Language: en-nz
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 9 January 2015 11:55, quoth Benjamin Tissoires:
> On Thu, Jan 8, 2015 at 5:20 PM, Gavin Lambert <gavinl@compacsort.com> wrote:
> > On 9 January 2015 04:17, you quoth:
> >> So here, everything seems fine except for the tracking ID and the
> BTN_TOUCH.
> >> The kernel does not sends the touch begin and touch end information,
> >> thus the device is not working :(
> >>
> >> Can you compile and install hid-recorder from
> >> http://bentiss.github.io/hid- replay-docs/ ?
> >> I would need a hid-record of your touchscreen so I can figure out why
> >> the kernel does not handle it properly.
> >
> > Attached.  (Sent off-list to avoid spamming uninterested parties with
> > the file; please feel free to reply on-list if you prefer.)
> >
> > During the recording, I made one touch and release to the centre of the
> screen, waited about three seconds, then did a staggered two-point multitouch
> (touch left, touch right, release left, release right).  Just in case both
> scenarios are useful to you.
> >
> 
> Well, unfortunately, when I first read your bug report, I missed that you are
> using one of the most buggy touchscreen available.
> Egalax still tries to reuse the product id 0001 for *many* different
> touchscreens. Some are multitouch, some are not.
> With all this mess, it is impossible to figure out which way to go and write
> something upstream about it :(

Buggy or not, it seems to be the most common kind of small panel commercially available for the Pi.  Two out of three touchscreens I've tried getting seem to be eGalax ones.

> Anyway, given your hid outputs, if you run the following command before
> plugging your touchscreen (at boot is a good idea), you should be fine:
> # echo 3 0eef 0001 16 > /sys/bus/hid/drivers/hid-multitouch/new_id

I could probably add this to an init script somewhere, but I don't think there's any way I can do this before the touchscreen is physically connected.  Would it be sufficient to put it after mounting sys but before starting udev?

> *BUT* the outputs show only _one_ touch when you said you made 2.

This doesn't really surprise me.  It's a resistive panel, so I was very surprised when it loaded the multitouch driver.  Maybe that's the real problem?


