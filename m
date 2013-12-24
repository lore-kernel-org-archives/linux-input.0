From: Joe Perches <joe@perches.com>
Subject: Re: [RFC  v3] Add ff-memless-next
Date: Mon, 23 Dec 2013 16:21:48 -0800
Message-ID: <1387844508.22671.73.camel@joe-AO722>
References: <1494187.y8mYFDm1lA@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:43615 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754099Ab3LXAVw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Dec 2013 19:21:52 -0500
In-Reply-To: <1494187.y8mYFDm1lA@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com

On Mon, 2013-12-23 at 23:46 +0100, Michal Mal=FD wrote:
> One case where uncombinable effects were mishandled was corrected. Re=
st of
> the changes are just coding style fixes.

trivia:

> diff --git a/drivers/input/ff-memless-next.c b/drivers/input/ff-memle=
ss-next.c
[]
> +static __always_inline s32 mlnx_calculate_x_force(const s32 level,
> +						  const u16 direction)

__always_inline is almost never warranted.
gcc generally does the right thing.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
