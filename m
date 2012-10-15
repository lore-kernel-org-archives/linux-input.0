From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] Input: twl*-vibra probe cleanups (devm_* conversion)
Date: Mon, 15 Oct 2012 14:08:57 +0200
Message-ID: <507BFCD9.6070302@ti.com>
References: <1339755732-23774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:46176 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab2JOMJE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Oct 2012 08:09:04 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so4842536oag.19
        for <linux-input@vger.kernel.org>; Mon, 15 Oct 2012 05:09:03 -0700 (PDT)
In-Reply-To: <1339755732-23774-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On 06/15/2012 12:22 PM, Peter Ujfalusi wrote:
> Hello,
>=20
> Convert the twl4030, twl6040 vibra drivers to use devm_ at probe time=
 to clean
> up the code a bit.
> The twl6040-vibra driver needed bigger change since the ordering of t=
he
> initialization was not correct.

Would it be possible to include this two patch for 3.7-rc2?
I can resend them if you no longer have them.

Thank you,
P=E9ter

>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   Input: twl4030-vibra: Convert to use devm_* in probe
>   Input: twl6040-vibra: Code cleanup in probe with devm_* conversion
>=20
>  drivers/input/misc/twl4030-vibra.c |    8 +--
>  drivers/input/misc/twl6040-vibra.c |   99 ++++++++++++++++----------=
---------
>  2 files changed, 47 insertions(+), 60 deletions(-)
>=20



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
