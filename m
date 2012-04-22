From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Sun, 22 Apr 2012 08:50:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204220848020.15283-100000@netrider.rowland.org>
References: <CACVXFVNz8uuiXWVfg3rqhE_bazCSsH1mGANc5rJCJbbejTc1dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:49452 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751475Ab2DVMuJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Apr 2012 08:50:09 -0400
In-Reply-To: <CACVXFVNz8uuiXWVfg3rqhE_bazCSsH1mGANc5rJCJbbejTc1dQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Oliver Neukum <oliver@neukum.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sun, 22 Apr 2012, Ming Lei wrote:

> > Although the kerneldoc doesn't actually say so, it should be safe t=
o
> > assume that usb_unlink_urb calls the completion routine directly _o=
nly_
> > in cases where the unlink succeeded. =A0(We could add this to the
> > kerneldoc.)
> >
> > Therefore: If the URB completes with status other than -ECONNRESET =
then
> > you can safely take the lock for resubmission. =A0If the URB comple=
tes
> > with status =3D=3D -ECONNRESET then you know it was unlinked, so yo=
u don't
> > need to take the lock -- the race has already been lost.
> >
> > Does that solve your problem?
>=20
> Not sure if that does work.
>=20
> If the URB completes asynchronously after unlinking, its status is st=
ill
>  -ECONNRESET, so extra race may be caused without holding the lock
> because complete handler will access some global data.

That would be a completely separate race, right?  So maybe it can use a=
=20
different lock for protection -- and this other lock could be dropped=20
before usb_unlink_urb is called.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
