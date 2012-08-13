From: Oliver Neukum <oneukum@suse.de>
Subject: Re: 3.5.1 hid_generic causes mouse locking until a button is clicked
Date: Mon, 13 Aug 2012 08:30:35 +0200
Message-ID: <2204600.iAkYKzSYsi@linux-lqwf.site>
References: <k06dcc$u9q$1@dough.gmane.org> <20120812195329.2cb454c3@neptune.home> <50281d29.516eec0a.683e.1052@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38268 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab2HMICM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Aug 2012 04:02:12 -0400
In-Reply-To: <50281d29.516eec0a.683e.1052@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Cc: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

On Sunday 12 August 2012 18:16:22 D=E2niel Fraga wrote:

> 	I mean, it seems that with kernel 3.4 simply moving the mouse
> would wake up the usb port and now with kernel 3.5 it only works if I
> press a button.
>=20
> 	So, kernel 3.5 is supposed to wake up the usb port when we move
> the mouse or not?

The kernel doesn't do this. Mice are told to wake up when they have inp=
ut
data. They decide themselves what data should be collected while they
sleep. The USB HID spec offers no way to learn what will wake up a devi=
ce.
In fact, it does'nt mention power management.

> 	Is there a way to restore the old behaviour from kernel 3.4?

Probably the device didn't autosuspend. Disable autosuspension.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
