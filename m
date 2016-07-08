From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Fri, 8 Jul 2016 14:37:54 -0700
Message-ID: <20160708213754.GF28589@dtor-ws>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
 <20160621003113.GE22426@dtor-ws>
 <20160621112730.GU29844@pali>
 <20160707114101.GS29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34695 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbcGHVh6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 17:37:58 -0400
Content-Disposition: inline
In-Reply-To: <20160707114101.GS29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 07, 2016 at 01:41:01PM +0200, Pali Roh=E1r wrote:
> On Tuesday 21 June 2016 13:27:30 Pali Roh=E1r wrote:
> > On Monday 20 June 2016 17:31:13 Dmitry Torokhov wrote:
> > > Hi Pali,
> > >=20
> > > On Mon, Jun 06, 2016 at 01:23:56PM +0200, Pali Roh=E1r wrote:
> > > > This patch series cleanup usage of alps_model_data table.
> > > >=20
> > > > Pali Roh=E1r (5):
> > > >   Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
> > > >   Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
> > > >   Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
> > > >   Input: alps - warn about unsupported ALPS V9 touchpad
> > > >   Input: alps - cleanup ALPS_PROTO_V2 detection
> > >=20
> > > Frankly, I do not quite like this series. The rule of thumb we ha=
d: if
> > > we can use e7 data to identify the device it should go into table=
,
> > > if we need to have more elaborate logic - then implement it in
> > > __alps_indentify(). I would understand if we got rid of the table
> > > completely, but we didn't.
> >=20
> > Hans and me agreed that alps_model_data array is for old touchpads
> > defined as quirks table. So in this patch series I'm trying to elim=
inate
> > using that array. And it is possible for V1, V4 and V6 touchpads be=
cause
> > each protocol has only one entry in table. And last user is just V2
> > protocol which is I think better...
> >=20
> > So this is my motivation for this patch series.
>=20
> Any suggestion how to rework it? And any agreement if we should remov=
e
> V1/V4/V6 from alps_model_date or let it stay here?

As I mentioned below I am happy with removing ALPS_PROTO_V4 and
subsequently command_mode_resp from alps_model_info, while leaving the
rest in the table.

Thanks.

>=20
> > > I think the patch removing ALPS_PROTO_V4 and subsequent patch rem=
oving
> > > command_mode_resp from alps_model_info are good, the rest are not=
 so
> > > much.
> > >=20
> > > Thanks.
> > >=20
> >=20
>=20
> --=20
> Pali Roh=E1r
> pali.rohar@gmail.com

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
