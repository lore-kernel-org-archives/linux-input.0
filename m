From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/5] Input: alps - cleanup
Date: Mon, 20 Jun 2016 17:31:13 -0700
Message-ID: <20160621003113.GE22426@dtor-ws>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33292 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbcFUAi3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 20:38:29 -0400
Content-Disposition: inline
In-Reply-To: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Pali,

On Mon, Jun 06, 2016 at 01:23:56PM +0200, Pali Roh=E1r wrote:
> This patch series cleanup usage of alps_model_data table.
>=20
> Pali Roh=E1r (5):
>   Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
>   Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
>   Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
>   Input: alps - warn about unsupported ALPS V9 touchpad
>   Input: alps - cleanup ALPS_PROTO_V2 detection

=46rankly, I do not quite like this series. The rule of thumb we had: i=
f
we can use e7 data to identify the device it should go into table,
if we need to have more elaborate logic - then implement it in
__alps_indentify(). I would understand if we got rid of the table
completely, but we didn't.

I think the patch removing ALPS_PROTO_V4 and subsequent patch removing
command_mode_resp from alps_model_info are good, the rest are not so
much.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
