From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Problems with remote-wakeup settings
Date: Fri, 5 Mar 2010 23:16:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003052314130.10381-100000@netrider.rowland.org>
References: <201003052304.49261.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <201003052304.49261.rjw@sisk.pl>
Sender: linux-hotplug-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 5 Mar 2010, Rafael J. Wysocki wrote:

> On Friday 05 March 2010, Oliver Neukum wrote:
> > Am Freitag, 5. M=E4rz 2010 21:59:31 schrieben Sie:
> > > > I guess it's better if drivers don't set should_wakeup if unsur=
e, but of course
> > > > that's impossible to enforce.
> > >=20
> > > That's the real question.  Ideally, drivers won't touch should_wa=
keup. =20
> > > How do we get there from here?
> >=20
> > Enable it only for devices specifically designed for wakeup, that i=
s
> > keyboards, power buttons and WoL, perhaps also mice and modems.
> > Are we far away from that?
>=20
> I don't think we're very far from that.
>=20
> Mice are known dangerous, especially the USB ones, though.

I agree, especially for desktop systems.  You don't want the system to=20
wake up merely because you happened to jostle the mouse.  That happened=
=20
to me just a few days ago (and it was a PS/2 mouse, not USB).

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-hotplug=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
