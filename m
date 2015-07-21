From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Tue, 21 Jul 2015 10:12:28 -0700
Message-ID: <20150721171228.GB39076@dtor-ws>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
 <20150720065446.GA13879@dtor-ws>
 <20150720072548.GA25910@pali>
 <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33556 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbbGURMd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 13:12:33 -0400
Received: by padck2 with SMTP id ck2so122891060pad.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2015 10:12:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Mon, Jul 20, 2015 at 11:00:27PM -0400, Douglas Christman wrote:
> On Mon, Jul 20, 2015 at 3:25 AM, Pali Roh=E1r <pali.rohar@gmail.com> =
wrote:
> > Hi! Please recompile psmouse.ko with dev_dbg() debug information an=
d
> > send new dmesg output. We need to know type of ALPS device. Thanks!
>=20
> I recompiled with CONFIG_DYNAMIC_DEBUG and echoed 'module psmouse' to
> /sys/kernel/debug/dynamic_debug/control as described in
> Documentation/dynamic-debug-howto.txt, but I don't see any additional
> output in dmesg after reloading the module.  I haven't done this
> before, so I'm probably overlooking something...

Have you tried doing this as:

rmmod psmouse
modprobe psmouse dyndbg=3Dp

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
