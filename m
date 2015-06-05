From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/9] input: goodix: fix variable length array warning
Date: Fri, 5 Jun 2015 09:40:53 -0700
Message-ID: <20150605164053.GA26708@dtor-ws>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-3-git-send-email-irina.tirdea@intel.com>
 <20150528175753.1f85723b5b880ecf02fd4a79@ao2.it>
 <1F3AC3675D538145B1661F571FE1805F19A78DD0@irsmsx105.ger.corp.intel.com>
 <20150603224953.6613b674931390f187b81e7a@ao2.it>
 <1F3AC3675D538145B1661F571FE1805F19A79D7B@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36341 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422920AbbFEQk6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 12:40:58 -0400
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A79D7B@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: 'Antonio Ospite' <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 05, 2015 at 04:34:38PM +0000, Tirdea, Irina wrote:
>=20
>=20
> > -----Original Message-----
> > From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@v=
ger.kernel.org] On Behalf Of Antonio Ospite
> > Sent: 03 June, 2015 23:50
> > To: Tirdea, Irina
> > Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.org; d=
evicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/9] input: goodix: fix variable length array w=
arning
> >=20
> > On Wed, 3 Jun 2015 10:26:47 +0000
> > "Tirdea, Irina" <irina.tirdea@intel.com> wrote:
> >=20
> > > > -----Original Message-----
> > > > From: Antonio Ospite [mailto:ao2@ao2.it]
> > > > Sent: 28 May, 2015 18:58
> > > > To: Tirdea, Irina
> > > > Cc: Dmitry Torokhov; Bastien Nocera; linux-input@vger.kernel.or=
g; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 2/9] input: goodix: fix variable length arr=
ay warning
> > > >
> > > > On Thu, 28 May 2015 15:47:38 +0300
> > > > Irina Tirdea <irina.tirdea@intel.com> wrote:
> > > >
> > > > > Fix sparse warning:
> > > > > drivers/input/touchscreen/goodix.c:182:26: warning:
> > > > > Variable length array is used.
> > > > >
> > > > > Replace the variable length array with fixed length.
> > > > >
> > > > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > > > ---
> > > > >  drivers/input/touchscreen/goodix.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/inp=
ut/touchscreen/goodix.c
> > > > > index c2e785c..dac1b3c 100644
> > > > > --- a/drivers/input/touchscreen/goodix.c
> > > > > +++ b/drivers/input/touchscreen/goodix.c
> > > > > @@ -147,7 +147,7 @@ static void goodix_ts_report_touch(struct=
 goodix_ts_data *ts, u8 *coor_data)
> > > > >   */
> > > > >  static void goodix_process_events(struct goodix_ts_data *ts)
> > > > >  {
> > > > > -	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num]=
;
> > > > > +	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACT=
S];
> > > >
> > > > Hi,
> > > >
> > >
> > > Hi Antonio,
> > >
> > > > this fixes the warning from sparse, but also changes the semant=
ics of
> > > > the code: ts->max_touch_num is less that GOODIX_MAX_CONTACTS fo=
r 5
> > > > touches devices and in this case we'll end up using more memory=
 than is
> > > > necessary.
> > > >
> > >
> > > I wasn't sure if it is better to save the 5 bytes or fix the warn=
ing,
> > > so I sent this to get some more input.
> > > Thanks for the feedback, I will  drop this patch.
> > >
> >=20
> > Use kmalloc() or, alternatively, add at least a comment telling why=
 you
> > think that sacrificing a few bytes =E2=80=94only for some devices=E2=
=80=94 has
> > advantages over dynamic allocation.
> >=20
>=20
> You are right, kmalloc will solve both problems - the sparse warning =
and allocating
> more bytes than necessary. Don't know why I did not think of that.
> Will use that in v2.

Please leave the patch as is. We can spare 80 bytes on the stack given
that we are running in threaded IRQ. kmallocing will use more code and
runtime resources and won't give any benefits.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
