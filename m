From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sat, 21 Apr 2012 13:31:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204211327090.475-100000@netrider.rowland.org>
References: <CACVXFVPR76O+zFtL3pBc-KyhN85xN6AkgTT_Md1kG2wWwjosiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:45825 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751217Ab2DURbV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Apr 2012 13:31:21 -0400
In-Reply-To: <CACVXFVPR76O+zFtL3pBc-KyhN85xN6AkgTT_Md1kG2wWwjosiw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sat, 21 Apr 2012, Ming Lei wrote:

> >> Think about what happens if the URB being unlinked hasn't been
> >> presented to the hardware yet. =A0Once it has been removed from th=
e HCD's
> >> internal lists, there's no reason not to give it back right away. =
=A0And
> >> there's no natural time to give it back later.
> >
> > Now. The question is not when, but from which context.
> > The context should be uniform, so that the requirements
> > for locking should also be uniform.
>=20
> How about always scheduling a tasklet to run what usb_unlink_urb does=
?
> just implement usb_unlink_urb as something like
> tasklet_schedule(unlink_tasklet).
>=20
> Then we can have a uniform lock requirement and no changes are involv=
ed
> on host controller drivers.

The return values would not be correct.

On the other hand, usbnet could call usb_unlink_urb from within a=20
tasklet.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
