From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH v6 7/8, needs improvement] hid: add suspend/resume hooks for hid drivers
Date: Sun, 11 Apr 2010 22:27:32 +0200
Message-ID: <201004112227.32045.oliver@neukum.org>
References: <20100324233707.7243b04d@neptune.home> <alpine.LNX.2.00.1004112029220.8345@pobox.suse.cz> <20100411204002.6ba32f43@neptune.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:39122 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab0DKU1c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 16:27:32 -0400
In-Reply-To: <20100411204002.6ba32f43@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>

Am Sonntag, 11. April 2010 20:40:02 schrieb Bruno Pr=E9mont:
> On Sun, 11 April 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> > > As far as I understand the code, in auto-suspend case if the driv=
er=20
> > > sends commands to the device it will have to call usbhid_wait_io(=
).=20
> > > Please correct me if I'm wrong!
> >=20
> > It's not needed. There is a queuing mechanism in place on=20
> > 'resumption_waker' workqueue.
>=20
> So the driver is not allowed to ask the device to do something
> at auto-suspend time (as that would abort the auto-suspension).

=46rom within suspend()?

Generally if the driver wants to talk to a device that's a good
reason to wake up a device.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
