From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 1/3] HID: Add HID_CLAIMED_OTHER for non-generic drivers
Date: Mon, 16 Jul 2012 21:47:42 +0200
Message-ID: <CANq1E4QuFX1-KVTb1udzMP6QUuWe=zhmu4RS2cgQ2=CdfJf5gg@mail.gmail.com>
References: <20120716184530.GA407@polaris.bitmath.org>
	<CANq1E4Q2AoA7JP9rL39gEkyMCy+-a3vcysn_kWOdB8Z4okAf+A@mail.gmail.com>
	<20120716193502.GA617@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34189 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab2GPTrn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jul 2012 15:47:43 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so4190409wey.19
        for <linux-input@vger.kernel.org>; Mon, 16 Jul 2012 12:47:43 -0700 (PDT)
In-Reply-To: <20120716193502.GA617@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi Henrik

On Mon, Jul 16, 2012 at 9:35 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
> On Mon, Jul 16, 2012 at 09:08:47PM +0200, David Herrmann wrote:
>> Hi Henrik
>>
>> On Mon, Jul 16, 2012 at 8:45 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > Hi David,
>> >
>> > Perhaps one should make hid-core warn instead of bailing out instead?
>> > Something may need to be done to make sure everything works smoothly,
>> > but really, why would hid-core mind keeping a device on the bus with a
>> > non-standard io driver?
>>
>> No, I think bailing out is the correct thing to do. If we emit a
>> warning but leave the device on the bus, the device will have no
>> driver loaded and idling in background. Hence, dropping the device is
>> the best solution for 99% of the devices.
>
> If the driver that picks up the device (wiimote for instance) decides
> it does not want to use any of the io drivers (HID_CONNECT*) by
> calling hid_hw_start(hdev, 0), in what way is that different from
> calling it with, say, hid_hw_start(hdev, HID_CONNECT_TO_OTHER)?  (The
> latter would be an equivalent (but cleaner) way of setting your
> HID_CLAIMED_OTHER flag).

I am sorry, I misunderstood you. Yes, in fact, this is what wiimote
currently does. Well, it uses HID_CONNECT_HIDRAW but this has no
effect if CONFIG_HIDRAW is not set so this is equivalent to 0. My
first attempt was to make this work, however, this means refactoring
hid_connect() a lot as we need to differentiate between
hidraw_connect() failing and HID_CONNECT_HIDRAW being not set. Same
for hidinput_connect() and hiddev_connect(). That is, if
hid_hw_start() is called with HID_CONNECT_HIDDEV set, but
hiddev_connect() fails? Should the core bail out or let the device
through? In most cases bailing out is the best option. However, what
to do for the wiimote case? It requests hidraw but if hidraw_connect()
fails, then the wiimote driver can still work without it so in this
case we must not bail out.

Taking this into account I really have no idea how to implement this
in a cleaner and safer way than using HID_CONNECT_OTHER. Btw., what
should the wiimote driver pass to hid_hw_start() in your case? It
wants HID_CONNECT_HIDRAW but also wants to get through if
CONFIG_HIDRAW is not set. It cannot pass 0 as this would always
disable HIDRAW. But in the case that HIDRAW is not available, it
cannot tell the core that it wants to stay on the bus. Hence, I think
using HID_CONNECT_OTHER is the only way, isn't it?

> To catch possible mistakes, one could check for the presence of
> raw_event() instead, for instance.
>
> What I am getting at is that we really do not need to create any more
> backdoors into the hid core - on the contrary, we can most likely
> easily remove some of them instead.

I fully agree, but I have to admit that I didn't find an easier way
that actually works.

Thanks a lot for having a look at this. If you have any other ideas I
will gladly implement and test them, but I am currently out of ideas.
Regards
David
