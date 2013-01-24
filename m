From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/2] Input: twl6040-vibra cleanups (devm_* conversion,
 system wq)
Date: Thu, 24 Jan 2013 12:44:29 +0100
Message-ID: <51011E9D.7050409@ti.com>
References: <1358177678-16509-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54035 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab3AXLoc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jan 2013 06:44:32 -0500
In-Reply-To: <1358177678-16509-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On 01/14/2013 04:34 PM, Peter Ujfalusi wrote:
> Hi Dmitry,
>=20
> Changes since v2:
> - twl4030-vibra patches are left out (they have been applied)
> - Do not use devm_input_allocate_device() in twl6040-vibra

Do you want me to resend this two patch for 3.9?

Regards,
P=E9ter

>=20
> Changes since v1:
> - Use devm_input_allocate_device()
> - swtich drivers to use system workqueue
>=20
> Cover letter from v1 (resend set):
>=20
> This series seams to got lost:
> https://lkml.org/lkml/2012/6/15/128
>=20
> Can you take it for 3.9?
>=20
> Convert the twl4030, twl6040 vibra drivers to use devm_ at probe time=
 to clean
> up the code a bit.
> The twl6040-vibra driver needed bigger change since the ordering of t=
he
> initialization was not correct.
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   Input: twl6040-vibra: Code cleanup in probe with devm_* conversion
>   input: twl6040-vibra: Use system workqueue
>=20
>  drivers/input/misc/twl6040-vibra.c | 100 +++++++++++++++------------=
----------
>  1 file changed, 41 insertions(+), 59 deletions(-)
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
