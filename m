From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Problems with remote-wakeup settings
Date: Fri, 5 Mar 2010 22:08:09 +0100
Message-ID: <201003052208.09486.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1003051546370.1384-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:38048 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab0CEVIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Mar 2010 16:08:34 -0500
In-Reply-To: <Pine.LNX.4.44L0.1003051546370.1384-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>

Am Freitag, 5. M=E4rz 2010 21:59:31 schrieben Sie:
> > I guess it's better if drivers don't set should_wakeup if unsure, b=
ut of course
> > that's impossible to enforce.
>=20
> That's the real question.  Ideally, drivers won't touch should_wakeup=
=2E =20
> How do we get there from here?

Enable it only for devices specifically designed for wakeup, that is
keyboards, power buttons and WoL, perhaps also mice and modems.
Are we far away from that?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
