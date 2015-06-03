From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 2/9] input: goodix: fix variable length array warning
Date: Wed, 3 Jun 2015 22:49:53 +0200
Message-ID: <20150603224953.6613b674931390f187b81e7a@ao2.it>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
	<1432817265-23891-3-git-send-email-irina.tirdea@intel.com>
	<20150528175753.1f85723b5b880ecf02fd4a79@ao2.it>
	<1F3AC3675D538145B1661F571FE1805F19A78DD0@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:1720 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbbFCUuD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jun 2015 16:50:03 -0400
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A78DD0@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 3 Jun 2015 10:26:47 +0000
"Tirdea, Irina" <irina.tirdea@intel.com> wrote:

> > -----Original Message-----
> > From: Antonio Ospite [mailto:ao2@ao2.it]
> > Sent: 28 May, 2015 18:58
> > To: Tirdea, Irina
> > Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org; d=
evicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/9] input: goodix: fix variable length array w=
arning
> >=20
> > On Thu, 28 May 2015 15:47:38 +0300
> > Irina Tirdea <irina.tirdea@intel.com> wrote:
> >=20
> > > Fix sparse warning:
> > > drivers/input/touchscreen/goodix.c:182:26: warning:
> > > Variable length array is used.
> > >
> > > Replace the variable length array with fixed length.
> > >
> > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > ---
> > >  drivers/input/touchscreen/goodix.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/t=
ouchscreen/goodix.c
> > > index c2e785c..dac1b3c 100644
> > > --- a/drivers/input/touchscreen/goodix.c
> > > +++ b/drivers/input/touchscreen/goodix.c
> > > @@ -147,7 +147,7 @@ static void goodix_ts_report_touch(struct goo=
dix_ts_data *ts, u8 *coor_data)
> > >   */
> > >  static void goodix_process_events(struct goodix_ts_data *ts)
> > >  {
> > > -	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
> > > +	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> >=20
> > Hi,
> >=20
>=20
> Hi Antonio,
>=20
> > this fixes the warning from sparse, but also changes the semantics =
of
> > the code: ts->max_touch_num is less that GOODIX_MAX_CONTACTS for 5
> > touches devices and in this case we'll end up using more memory tha=
n is
> > necessary.
> >=20
>=20
> I wasn't sure if it is better to save the 5 bytes or fix the warning,
> so I sent this to get some more input.
> Thanks for the feedback, I will  drop this patch.
>

Use kmalloc() or, alternatively, add at least a comment telling why you
think that sacrificing a few bytes =E2=80=94only for some devices=E2=80=
=94 has
advantages over dynamic allocation.

I am not necessarily against the static allocation change, I was just
pointing out the issue.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
