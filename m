From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] alps: Document that Protocol V2 uses standard PS/2 mouse
 packets for the stick
Date: Sun, 5 Apr 2015 13:17:48 -0700
Message-ID: <20150405201748.GB31564@dtor-ws>
References: <1427962134-4871-1-git-send-email-hdegoede@redhat.com>
 <1427962134-4871-2-git-send-email-hdegoede@redhat.com>
 <201504030821.29619@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38133 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbbDEURx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Apr 2015 16:17:53 -0400
Received: by igbqf9 with SMTP id qf9so8740103igb.1
        for <linux-input@vger.kernel.org>; Sun, 05 Apr 2015 13:17:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201504030821.29619@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

On Fri, Apr 03, 2015 at 08:21:29AM +0200, Pali Roh=E1r wrote:
> On Thursday 02 April 2015 10:08:54 Hans de Goede wrote:
> > Document that Protocol V2 uses standard (bare) PS/2 mouse
> > packets for the DualPoint stick.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  Documentation/input/alps.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/input/alps.txt
> > b/Documentation/input/alps.txt index a63e5e0..92ae734 100644
> > --- a/Documentation/input/alps.txt
> > +++ b/Documentation/input/alps.txt
> > @@ -114,6 +114,9 @@ ALPS Absolute Mode - Protocol Version 2
> >   byte 4:  0   y6   y5   y4   y3   y2   y1   y0
> >   byte 5:  0   z6   z5   z4   z3   z2   z1   z0
> >=20
> > +Protocol Version 2 DualPoint devices send standard PS/2 mouse
> > packets for +the DualPoint Stick.
> > +
> >  Dualpoint device -- interleaved packet format
> >  ---------------------------------------------
> >=20
> > @@ -127,6 +130,11 @@ Dualpoint device -- interleaved packet
> > format byte 7:    0   y6   y5   y4   y3   y2   y1   y0
> >   byte 8:    0   z6   z5   z4   z3   z2   z1   z0
> >=20
> > +Devices which use the interleaving format normally send
> > standard PS/2 mouse +packets for the DualPoint Stick + ALPS
> > Absolute Mode packets for the +touchpad, switching to the
> > interleaved packet format when both the stick and +the
> > touchpad are used at the same time.
> > +
> >  ALPS Absolute Mode - Protocol Version 3
> >  ---------------------------------------
>=20
> Acked-By: Pali Roh=E1r <pali.rohar@gmail.com>

Applied this and the other 2 patches and will try to squeeze them into
4.0.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
