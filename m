From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1] Input: elants_i2c: Add Elan touchscreen support
Date: Thu, 20 Nov 2014 09:51:58 -0800
Message-ID: <20141120175158.GB14798@dtor-glaptop>
References: <1388146515-19481-1-git-send-email-scott.liu@emc.com.tw>
 <20141120081113.GA37534@dtor-ws>
 <1416479490.28599.13.camel@linux-0dmf.site>
 <000001d004bd$0ad90830$208b1890$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:42052 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313AbaKTRwD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 12:52:03 -0500
Content-Disposition: inline
In-Reply-To: <000001d004bd$0ad90830$208b1890$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ELAN =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: 'Oliver Neukum' <oneukum@suse.de>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Vincent Wang' <vincent.wang@emc.com.tw>, 'Jeff Chuang' <jeff.chuang@emc.com.tw>, 'Benson Leung' <bleung@chromium.org>, 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>, 'Henrik Rydberg' <rydberg@euromail.se>, 'David Herrmann' <dh.herrmann@gmail.com>

On Thu, Nov 20, 2014 at 08:25:15PM +0800, ELAN =E5=8A=89=E5=98=89=E9=A7=
=BF wrote:
>=20
> Hi Oliver:
>=20
> -----Original Message-----
> From: Oliver Neukum [mailto:oneukum@suse.de]=20
> Sent: Thursday, November 20, 2014 6:32 PM
> To: Dmitry Torokhov
> Cc: scott; linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;=
 Vincent Wang; Jeff Chuang; Benson Leung; Benjamin Tissoires; Henrik Ry=
dberg; David Herrmann
> Subject: Re: [PATCH v1] Input: elants_i2c: Add Elan touchscreen suppo=
rt
>=20
>=20
>=20
> > +static int elants_i2c_sw_reset(struct i2c_client *client) {
> > +       const u8 soft_rst_cmd[] =3D { 0x77, 0x77, 0x77, 0x77 };
> > +       int error;
> > +
> > +       error =3D elants_i2c_send(client, soft_rst_cmd,
> > +                               sizeof(soft_rst_cmd));
> > +       if (error) {
> > +               dev_err(&client->dev, "software reset failed: %d\n"=
,
> > error);
> > +               return error;
> > +       }
> > +
> > +       /*
> > +        * We should wait at least 10 msec (but no more than 40)
> > before
> > +        * sending fastboot or IAP command to the device.
> > +        */
> > +       msleep(30);
>=20
> If timing is critical in both ways, you should take our guarantee if =
sufficient sleep. I suggest you sleep 11msecs.
>=20
> Sorry, this is our firmware tricky but it should be sleep longer than=
 30ms. Actually 70ms.
> (Dmitry, I need to modify this delay time to 70ms. Sorry for the chan=
ged over and over again;=20
> 	because we consider big sensor solution which need to use more ICs a=
nd need more longer delay)
>=20

Wait, before you said that upper bound is critical, otherwise the devic=
e will
ignore the next command and will not enter IAP mode. So what will happe=
n if we
increase the wait to 70 msecs and use the driver with smaller sensors?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
