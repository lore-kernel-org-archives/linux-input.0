From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fixed bug in single-touch emulation on the Stantum panel
Date: Tue, 9 Feb 2010 11:49:04 -0800
Message-ID: <20100209194904.GA24002@core.coreip.homeip.net>
References: <20100206141912.71BA89520A@smtp.lii-enac.fr>
 <alpine.LNX.2.00.1002091125490.30967@pobox.suse.cz>
 <878D4FFC-9FA8-4A20-90D9-06BFBAE63658@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:54955 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab0BITtM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2010 14:49:12 -0500
Received: by pzk17 with SMTP id 17so264943pzk.4
        for <linux-input@vger.kernel.org>; Tue, 09 Feb 2010 11:49:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <878D4FFC-9FA8-4A20-90D9-06BFBAE63658@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Tue, Feb 09, 2010 at 03:59:34PM +0100, St=E9phane Chatty wrote:
>=20
> Le 9 f=E9vr. 10 =E0 11:27, Jiri Kosina a =E9crit :
>=20
> >On Sat, 6 Feb 2010, Stephane Chatty wrote:
> >
> >>Fixed bug in touchscreen emulation for the Stantum multitouch panel
> >
> >Hi Stephane,
> >
> >could you please perhaps provide a little bit more detailed
> >information
> >about the nature of the bug this is fixing? It might be useful for
> >people
> >looking through changelog.
>=20
> Fixed stupid copy-paste bug in touchscreen emulation for the Stantum
> multitouch panel: a flag was reset just before being tested.
>=20
> >>
> >
> >Are you planning to maintain this numbering, btw? Usually people
> >forget to
> >update it :)
>=20
> As a user I find it useful. As a coder I usually maintain them. But
> I was wondering what was going to happen if other people were to
> submit patches on the code; in that case, and if they don't update
> the number I guess having a version number is a bad idea.

Once a driver is in mainline its internal version number becomes pretty
meaningless, the only thing that can help identify the code is kernel
version or, better, commit ID of the branch it was built off.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
