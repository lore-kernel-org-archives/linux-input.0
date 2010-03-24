From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Two questions regarding evdev
Date: Wed, 24 Mar 2010 14:41:48 -0700
Message-ID: <201003241441.48437.dmitry.torokhov@gmail.com>
References: <20100324205332.GA7303@hardeman.nu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:24094 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab0CXVmB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Mar 2010 17:42:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1755057fgg.1
        for <linux-input@vger.kernel.org>; Wed, 24 Mar 2010 14:42:00 -0700 (PDT)
In-Reply-To: <20100324205332.GA7303@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?iso-8859-1?q?H=E4rdeman?= <david@hardeman.nu>
Cc: linux-input@vger.kernel.org

Hi David,

On Wednesday 24 March 2010 01:53:32 pm David H=E4rdeman wrote:
> I've been going over the evdev (drivers/input/evdev.c) code since I'm
> using it as inspiration for a small project I'm hacking on. So far I
> have two questions with regard to the code:
>=20
> First, evdev_event passes a new event to all connected clients (writi=
ng
> it to each client's event fifo) and then calls wake_up_interruptible.
> However, given that all clients will have at least one new event to r=
ead
> after evdev_event is done, shouldn't wake_up_interruptible_all be cal=
led
> instead?

wake_up() vs. wake_up_all() only matters if there is exclusive waiters
which evdev does not use. PLease see comment/explanation for wake up
here:

	http://lxr.linux.no/linux+v2.6.33/kernel/sched.c#L5685

>=20
> Second, evdev_poll never sets the POLLOUT flag, but evdev can accept
> writes (which will be passed to input_inject_event), so shouldn't the
> POLLOUT flag always be set?

We could but I guess nobody tries to pull evdev for writing, everyone
is interested in reading.=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
