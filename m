From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: adding xpad support for PS-PC Smart Joypad
Date: Sat, 16 Jan 2016 10:34:53 -0800
Message-ID: <20160116183453.GC9203@dtor-ws>
References: <CAPMSj_FGPyTVtS-F-U6C-Jji8V7_yv9-nqu4=9+1_7wCNP2UnQ@mail.gmail.com>
 <CAKdAkRTjs6r4fE5F3g9qw1kszRkrLQ6L3AVAxLtkRiv16OU9JQ@mail.gmail.com>
 <CAPMSj_HSv_cYc+fk8-j-7DDrkcE8OtV=962_ytOhJPrEgyToGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33065 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbcAPSe4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 13:34:56 -0500
Received: by mail-pf0-f177.google.com with SMTP id e65so135151818pfe.0
        for <linux-input@vger.kernel.org>; Sat, 16 Jan 2016 10:34:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPMSj_HSv_cYc+fk8-j-7DDrkcE8OtV=962_ytOhJPrEgyToGw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Allen M." <ase1592@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Jan 15, 2016 at 08:18:03PM -0600, Allen M. wrote:
> On Fri, Jan 15, 2016 at 6:43 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Allen,
> >
> > On Fri, Jan 15, 2016 at 9:42 AM, Allen M. <ase1592@gmail.com> wrote:
> >> Hello, I have a Playstation 1 to USB device I'd like to request to be added
> >> as an xpad supported device. verbose lsusb output for the device can be
> >> found here: http://ix.io/nq3
> >>
> >> The device currently works fine as a generic joystick. However, it needs
> >> the MAP_DPAD_AS_BUTTONS option in order for it to be used with a dance pad.
> >> Let me know if I need to do anything further or if I need to provide more
> >> info for the device.
> >
> > This looks like a generic HID device, not Xbox device, so xpad driver
> > would be wrong one to add it to. Can you have UDEV rule to remap
> > buttons form userspace when the device is discovered, similarly to
> > what we do for keyboards?
> >
> > Thanks.
> >
> > --
> > Dmitry
> 
> Can UDEV remap a joystick axis to buttons? I wasn't aware it had that
> ability. Currently I cannot simultaneously hit the left and right buttons
> on the dance pad, as that simply does not work for an axis-mapped device.

Hmm, you are right, we can only remap keys or not-yep mapped usages, not
usages that are represented as relative or absolute axis. So it really
depends how your device presents itself to HID.

If udev keymap load does not work you will need to create a tiny HID
driver that overrides mapping in kernel.

Thanks.

-- 
Dmitry
