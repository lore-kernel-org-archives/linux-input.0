From: =?UTF-8?B?RUxBTiDlionlmInpp78=?= <scott.liu@emc.com.tw>
Subject: RE: [PATCH v1] Input: elants_i2c: Add Elan touchscreen support
Date: Fri, 21 Nov 2014 09:16:37 +0800
Message-ID: <001101d00528$ce525f80$6af71e80$@emc.com.tw>
References: <1388146515-19481-1-git-send-email-scott.liu@emc.com.tw> <20141120081113.GA37534@dtor-ws> <1416479490.28599.13.camel@linux-0dmf.site> <000001d004bd$0ad90830$208b1890$@emc.com.tw> <20141120175158.GB14798@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:63113 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640AbaKUBQz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 20:16:55 -0500
In-Reply-To: <20141120175158.GB14798@dtor-glaptop>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Oliver Neukum' <oneukum@suse.de>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Vincent Wang' <vincent.wang@emc.com.tw>, 'Jeff Chuang' <jeff.chuang@emc.com.tw>, 'Benson Leung' <bleung@chromium.org>, 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>, 'Henrik Rydberg' <rydberg@euromail.se>, 'David Herrmann' <dh.herrmann@gmail.com>, james.chen@emc.com.tw, =?UTF-8?B?J+iUoeS7geixqic=?= <jh.tsai@emc.com.tw>

Hi Dmitry:


> -----Original Message-----
> From: 'Dmitry Torokhov' [mailto:dmitry.torokhov@gmail.com]
> Sent: Friday, November 21, 2014 1:52 AM
> To: ELAN =E5=8A=89=E5=98=89=E9=A7=BF
> Cc: 'Oliver Neukum'; linux-kernel@vger.kernel.org; linux-input@vger.k=
ernel.org;
> 'Vincent Wang'; 'Jeff Chuang'; 'Benson Leung'; 'Benjamin Tissoires'; =
'Henrik
> Rydberg'; 'David Herrmann'
> Subject: Re: [PATCH v1] Input: elants_i2c: Add Elan touchscreen suppo=
rt
>=20
> On Thu, Nov 20, 2014 at 08:25:15PM +0800, ELAN =E5=8A=89=E5=98=89=E9=A7=
=BF wrote:
> >
> > Hi Oliver:
> >
> > -----Original Message-----
> > From: Oliver Neukum [mailto:oneukum@suse.de]
> > Sent: Thursday, November 20, 2014 6:32 PM
> > To: Dmitry Torokhov
> > Cc: scott; linux-kernel@vger.kernel.org; linux-input@vger.kernel.or=
g;
> > Vincent Wang; Jeff Chuang; Benson Leung; Benjamin Tissoires; Henrik
> > Rydberg; David Herrmann
> > Subject: Re: [PATCH v1] Input: elants_i2c: Add Elan touchscreen
> > support
> >
> >
> >
> > > +static int elants_i2c_sw_reset(struct i2c_client *client) {
> > > +       const u8 soft_rst_cmd[] =3D { 0x77, 0x77, 0x77, 0x77 };
> > > +       int error;
> > > +
> > > +       error =3D elants_i2c_send(client, soft_rst_cmd,
> > > +                               sizeof(soft_rst_cmd));
> > > +       if (error) {
> > > +               dev_err(&client->dev, "software reset failed: %d\=
n",
> > > error);
> > > +               return error;
> > > +       }
> > > +
> > > +       /*
> > > +        * We should wait at least 10 msec (but no more than 40)
> > > before
> > > +        * sending fastboot or IAP command to the device.
> > > +        */
> > > +       msleep(30);
> >
> > If timing is critical in both ways, you should take our guarantee i=
f sufficient
> sleep. I suggest you sleep 11msecs.
> >
> > Sorry, this is our firmware tricky but it should be sleep longer th=
an 30ms.
> Actually 70ms.
> > (Dmitry, I need to modify this delay time to 70ms. Sorry for the ch=
anged over
> and over again;
> > 	because we consider big sensor solution which need to use more ICs
> > and need more longer delay)
> >
>=20
> Wait, before you said that upper bound is critical, otherwise the dev=
ice will
> ignore the next command and will not enter IAP mode. So what will hap=
pen if
> we increase the wait to 70 msecs and use the driver with smaller sens=
ors?
>=20

I think the timeout(40ms) was wrong information. (We do have that, but =
we will no longer use it on Chrome projects)
As we encountered some problem on Chrome project of big sensor solution=
, and we already have resolved by modify bootcode timeout value.

Precisely speaking, the 40ms bootcode is special solution for specific =
project, and general solution is the 100ms bootcode.
So we have replaced 40ms bootcode with 100ms bootcode. That=E2=80=99s w=
hat our firmware engineer told me.


Thanks.
--
Scott

> Thanks.
>=20
> --
> Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
