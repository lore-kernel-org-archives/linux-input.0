From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Problems with remote-wakeup settings
Date: Fri, 5 Mar 2010 23:04:49 +0100
Message-ID: <201003052304.49261.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1003051546370.1384-100000@iolanthe.rowland.org> <201003052208.09486.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <201003052208.09486.oliver@neukum.org>
Sender: linux-hotplug-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Friday 05 March 2010, Oliver Neukum wrote:
> Am Freitag, 5. M=E4rz 2010 21:59:31 schrieben Sie:
> > > I guess it's better if drivers don't set should_wakeup if unsure,=
 but of course
> > > that's impossible to enforce.
> >=20
> > That's the real question.  Ideally, drivers won't touch should_wake=
up. =20
> > How do we get there from here?
>=20
> Enable it only for devices specifically designed for wakeup, that is
> keyboards, power buttons and WoL, perhaps also mice and modems.
> Are we far away from that?

I don't think we're very far from that.

Mice are known dangerous, especially the USB ones, though.

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-hotplug=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
