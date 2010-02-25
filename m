From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Date: Thu, 25 Feb 2010 16:29:32 +0100
Message-ID: <20100225162932.43ee42a8@neptune.home>
References: <20100221002001.0a7e05a7@neptune.home>
	<20100224170049.0d04af3c@neptune.home>
	<alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz>
	<20100225123214.0523a310@neptune.home>
	<alpine.LNX.2.00.1002251615570.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1002251615570.30967@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>
List-Id: linux-input@vger.kernel.org

On Thu, 25 February 2010 Jiri Kosina <jkosina@suse.cz> wrote:
>
> On Thu, 25 Feb 2010, Bruno Pr=C3=A9mont wrote:
>=20
> > For the two sysfs attributes I currently use, the 'reset' one shall=
=20
> > probably be moved to debugfs (I would like to place it under=20
> > /sys/kernel/debug/hid/$device/ next to rdesc and event).
>=20
> Yes, that would make sense.

So I will move it.

> ( ... which reminds me to finally to the Documentation/ABI part in
> sync with respect to current HID code again ... )
>=20
> > By the way, I'm wondering why event does not list any of the
> > reports coming from my device though as I understand the code it
> > should be doing that before my raw_event function gets called...
>=20
> Sorry, what 'event' do you mean in 'event does not list any of the=20
> reports'?

Sorry, one 's' that got eaten between my brain and mail client. I
mean events file in debugfs.
=46or USB HID keyboard each key press generates "report dump" under
/sys/kernel/debug/hid/$device/events but for my PicoLCD I don't get
any entry in there. I'm wondering why.

Thanks,
Bruno
