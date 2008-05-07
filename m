From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]full autosuspend for USB HID
Date: Wed, 7 May 2008 19:13:35 +0200
Message-ID: <200805071913.36445.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0805071145130.3701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:50943 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYEGRNj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 13:13:39 -0400
In-Reply-To: <Pine.LNX.4.44L0.0805071145130.3701-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Am Mittwoch 07 Mai 2008 17:46:38 schrieb Alan Stern:
> > The basic strategy for input is to keep the device marked busy. The=
 bulk of the
> > patch is for output, the work around for the release stuff and sync=
hronization.
>=20
> One big problem we always faced with autosuspend for keyboards is tha=
t
> most of them were not able to autoresume quickly enough to avoid losi=
ng
> keystrokes. =A0Isn't that still a problem?

=46or some keyboards that seems to be a limitation of the hardware noth=
ing
can be done about. Others do work, for example 046d:c312. Generally
as autosuspend is now disabled by default this is user space's problem.
IMHO the main use case for autosuspend of keyboards will be synchronize=
d
with the screen saver.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
