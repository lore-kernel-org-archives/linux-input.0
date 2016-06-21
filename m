From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Tue, 21 Jun 2016 13:27:30 +0200
Message-ID: <20160621112730.GU29844@pali>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
 <20160621003113.GE22426@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36495 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbcFUL1e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 07:27:34 -0400
Content-Disposition: inline
In-Reply-To: <20160621003113.GE22426@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 20 June 2016 17:31:13 Dmitry Torokhov wrote:
> Hi Pali,
>=20
> On Mon, Jun 06, 2016 at 01:23:56PM +0200, Pali Roh=C3=A1r wrote:
> > This patch series cleanup usage of alps_model_data table.
> >=20
> > Pali Roh=C3=A1r (5):
> >   Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
> >   Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
> >   Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
> >   Input: alps - warn about unsupported ALPS V9 touchpad
> >   Input: alps - cleanup ALPS_PROTO_V2 detection
>=20
> Frankly, I do not quite like this series. The rule of thumb we had: i=
f
> we can use e7 data to identify the device it should go into table,
> if we need to have more elaborate logic - then implement it in
> __alps_indentify(). I would understand if we got rid of the table
> completely, but we didn't.

Hans and me agreed that alps_model_data array is for old touchpads
defined as quirks table. So in this patch series I'm trying to eliminat=
e
using that array. And it is possible for V1, V4 and V6 touchpads becaus=
e
each protocol has only one entry in table. And last user is just V2
protocol which is I think better...

So this is my motivation for this patch series.

> I think the patch removing ALPS_PROTO_V4 and subsequent patch removin=
g
> command_mode_resp from alps_model_info are good, the rest are not so
> much.
>=20
> Thanks.
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
