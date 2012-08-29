From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Remap micmute to F20
Date: Wed, 29 Aug 2012 16:56:19 +0100
Message-ID: <1346255779.26684.22.camel@novo.hadess.net>
References: <1346196739-3619-1-git-send-email-james.leddy@canonical.com>
	 <1346197001.1928.16.camel@sirocco.hadess.net>
	 <503E3890.3050605@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53368 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999Ab2H2P4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Aug 2012 11:56:23 -0400
In-Reply-To: <503E3890.3050605@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: James M Leddy <james.leddy@canonical.com>
Cc: linux-input@vger.kernel.org

On Wed, 2012-08-29 at 11:43 -0400, James M Leddy wrote:
> On 08/28/2012 07:36 PM, Bastien Nocera wrote:
> > Em Tue, 2012-08-28 =E0s 19:32 -0400, James M Leddy escreveu:
> >> Because of a limitation of the X11 protocol, we can't use micmute =
in
> >> it's current mapping. I've chosen to map this to F20, since we do
> >> similar things with the touchpad buttons for the same reason. What=
ever
> >> we use, we will have to agree with xkeyboard-config.
> >>
> >> http://lists.freedesktop.org/archives/xorg-devel/2012-August/03344=
2.html
> >=20
> > Feel free to implement this once you're done :)
> > https://bugzilla.gnome.org/show_bug.cgi?id=3D651051
>=20
> Already ahead of you :) Just have to make sure the patch applies clea=
nly
> upstream. Thanks for the bug number.

I can tell you it won't, as your copy of gnome-settings-daemon has been
atrociously mutilated by notify-osd patches.

I'll add a reference to the patch in the upstream bug, if somebody want=
s
to use it as an example.

> https://bazaar.launchpad.net/~jm-leddy/ubuntu/quantal/gnome-settings-=
daemon/micmute/view/head:/debian/patches/micmute.patch



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
