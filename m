From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [ADD] 1.support new ic type for version 4.
Date: Thu, 8 Jan 2015 13:32:46 -0800
Message-ID: <20150108213246.GC23256@dtor-ws>
References: <013d01d02b25$cdb240e0$6916c2a0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:42033 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbbAHVcv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 16:32:51 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so4641998igi.1
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 13:32:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <013d01d02b25$cdb240e0$6916c2a0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5rSq5LiA56u5?= <sam.hung@emc.com.tw>
Cc: linux-input@vger.kernel.org, dusonlin@emc.com.tw

Hi Sam,

=46YI:

You sent this message as both plain/text and html, but vger.kernel.org
mailing lists are configured to discard all emails with html in them, s=
o
while I did get your reply others did not. Please try to find mail agen=
t
allowing you to use only plain text when interacting with Linux-related
mailing list.

In any case I received your updated patch and applied it. It should sho=
w
up in mainline with my next pull request (couple of days).

Thanks!

On Thu, Jan 08, 2015 at 05:30:54PM +0800, =E6=B4=AA=E4=B8=80=E7=AB=B9  =
wrote:
> Thank you for your prompt reply!
>=20
> Reply message below.
>=20
> =20
>=20
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
> Sent: Wednesday, January 07, 2015 3:26 PM
> To: Sam hung
> Cc: linux-input@vger.kernel.org; dusonlin@emc.com.tw
> Subject: Re: [PATCH] [ADD] 1.support new ic type for version 4.
>=20
> =20
>=20
> On Tue, Jan 06, 2015 at 11:21:36PM -0800, Dmitry Torokhov wrote:
>=20
> > Hi Sam,
>=20
> >=20
>=20
> > On Tue, Jan 06, 2015 at 04:10:16PM +0800, Sam hung wrote:
>=20
> > > ---
>=20
> > >  drivers/input/mouse/elantech.c | 23 +++++++++++++----------
>=20
> > >  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> > >=20
>=20
> > > diff --git a/drivers/input/mouse/elantech.c=20
>=20
> > > b/drivers/input/mouse/elantech.c index f2b9780..4891d07 100644
>=20
> > > --- a/drivers/input/mouse/elantech.c
>=20
> > > +++ b/drivers/input/mouse/elantech.c
>=20
> > > @@ -700,14 +700,14 @@ static int elantech_packet_check_v1(struct=20
>=20
> > > psmouse *psmouse)
>=20
> > > =20
>=20
> > >  static int elantech_debounce_check_v2(struct psmouse *psmouse)  =
{
>=20
> > > -        /*
>=20
> > > -         * When we encounter packet that matches this exactly, i=
t means
> the
>=20
> > > -         * hardware is in debounce status. Just ignore the whole
> packet.
>=20
> > > -         */
>=20
> > > -        const u8 debounce_packet[] =3D { 0x84, 0xff, 0xff, 0x02,=
 0xff,
> 0xff };
>=20
> > > -        unsigned char *packet =3D psmouse->packet;
>=20
> > > -
>=20
> > > -        return !memcmp(packet, debounce_packet,
> sizeof(debounce_packet));
>=20
> > > +        /*
>=20
> > > +        * When we encounter packet that matches this exactly, it=
 means
> the
>=20
> > > +        * hardware is in debounce status. Just ignore the whole =
packet.
>=20
> > > +        */
>=20
> > > +        const u8 debounce_packet[] =3D { 0x84, 0xff, 0xff, 0x02,=
 0xff,
> 0xff };
>=20
> > > +        unsigned char *packet =3D psmouse->packet;
>=20
> > > +
>=20
> > > +        return !memcmp(packet, debounce_packet,
> sizeof(debounce_packet));
>=20
> > >  }
>=20
> >=20
>=20
> > Hmm, this chunk seems to be replacing spaces with tabs... I'd rathe=
r=20
>=20
> > had it separate from the hardware version changes.
>=20
> >=20
>=20
> > I'll pick up the chunk below though.
>=20
> OK,In this Patch I will not change these lines (=E2=80=98space=E2=80=99=
to =E2=80=98tab=E2=80=99).
>=20
> =20
>=20
> Ah, I missed the fact that the patch does not have your "signed-off-b=
y"
>=20
> signature (see Documentation/SubmittingPatches). Please resend with i=
t.
>=20
> =20
>=20
> Thanks for your reminder.
>=20
> I will fix this problem.
>=20
> >=20
>=20
> > > =20
>=20
> > >  static int elantech_packet_check_v2(struct psmouse *psmouse) @@=20
>=20
> > > -1499,7 +1499,7 @@ static const struct dmi_system_id=20
>=20
> > > no_hw_res_dmi_table[] =3D {
>=20
> > >  /*
>=20
> > >   * determine hardware version and set some properties according =
to it.
>=20
> > >   */
>=20
> > > -static int elantech_set_properties(struct elantech_data *etd)
>=20
> > > +static int elantech_set_properties(struct psmouse *psmouse, stru=
ct=20
>=20
> > > +elantech_data *etd)
>=20
> > >  {
>=20
> > >         /* This represents the version of IC body. */
>=20
> > >         int ver =3D (etd->fw_version & 0x0f0000) >> 16; @@ -1520,=
9
> +1520,12=20
>=20
> > > @@ static int elantech_set_properties(struct elantech_data *etd)
>=20
> > >                 case 7:
>=20
> > >                 case 8:
>=20
> > >                 case 9:
>=20
> > > +                case 10:
>=20
> > > +                case 13:
>=20
> > >                         etd->hw_version =3D 4;
>=20
> > >                         break;
>=20
> > >                 default:
>=20
> > > +                        psmouse_err(psmouse, "failed to setting =
hw
> version.\n");
>=20
> =20
>=20
> The caller of elantech_set_properties() already issues message about =
unknown
> hardware version, why do we need to have it here as well?
>=20
> =20
>=20
> I think you're right.
>=20
> I will fix this line.
>=20
> =20
>=20
> > >                         return -1;
>=20
> > >                 }
>=20
> > >         }
>=20
> > > @@ -1593,7 +1596,7 @@ int elantech_init(struct psmouse *psmouse)
>=20
> > >         }
>=20
> > >         etd->fw_version =3D (param[0] << 16) | (param[1] << 8) | =
param[2];
>=20
> > > =20
>=20
> > > - if (elantech_set_properties(etd)) {
>=20
> > > +        if (elantech_set_properties(psmouse, etd)) {
>=20
> > >                 psmouse_err(psmouse, "unknown hardware version,
> aborting...\n");
>=20
> > >                 goto init_fail;
>=20
> > >         }
>=20
> > > --
>=20
> > > 1.8.3.2
>=20
> > >=20
>=20
> =20
>=20
> Thanks.
>=20
> =20
>=20
> --=20
>=20
> Dmitry
>=20
> =20
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
