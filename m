From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] input: make i2c device id constant
Date: Sat, 9 Jan 2010 23:49:29 -0800
Message-ID: <20100110074928.GB16057@core.coreip.homeip.net>
References: <4B487CD3.3080908@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43720 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab0AJHte (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2010 02:49:34 -0500
Content-Disposition: inline
In-Reply-To: <4B487CD3.3080908@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Raphael Derosso Pereira <raphaelpereira@gmail.com>, Kwangwoo Lee <kwlee@mtekvision.com>, Stephen Hemminger <shemminger@linux-foundation.org>, Jochen Eisinger <jochen@penguin-breeder.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sat, Jan 09, 2010 at 01:55:47PM +0100, N=E9meth M=E1rton wrote:
> From: M=E1rton N=E9meth <nm127@freemail.hu>
>=20
> The id_table field of the struct i2c_driver is constant in <linux/i2c=
=2Eh>
> so it is worth to make the initialization data also constant.
>=20

Applied all 5 to the next branch, thank you M=E1rton.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
