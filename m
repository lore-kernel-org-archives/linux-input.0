From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] hid-input: Use a larger event buffer for MT devices
Date: Mon, 14 Jun 2010 09:17:49 -0700
Message-ID: <AANLkTinI8w5vCi-VOf_IybZmOBDe8gjlJymZNSmmpkpk@mail.gmail.com>
References: <1276516181-4519-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:44666 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab0FNQRv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 12:17:51 -0400
In-Reply-To: <1276516181-4519-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

On Mon, Jun 14, 2010 at 4:49 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> The MT devices produce a lot of data. Tell the underlying input devic=
e
> approximately how many events will be sent per synchronization, to al=
low
> for better buffering. The number is a template based on continuously
> reporting details for each finger on a single hand.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Jiri,
>
> This patch goes together with the evdev buffer patchset, which Dmitry
> is going to queue for 2.6.36.
>
> Cheers,
> Henrik
>
> =A0drivers/hid/hid-input.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7a0d2e4..69d152e 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -534,6 +534,9 @@ mapped:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(i=
nput, usage->code, a, b, (b - a) >> 8, (b - a) >> 4);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0 =A0input_set_abs_params(input=
, usage->code, a, b, 0, 0);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* use a larger default input buffer fo=
r MT devices */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usage->code =3D=3D ABS_MT_POSITION_=
X && input->hint_events_per_packet =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_events_per_pa=
cket(input, 60);

Do we really want to use a hardcoded number here? Considering you have
used the same value in your "input: bcm5974" patch, adding it as an
ifdef in linux/input.h should not be an overkill in design and offers
the other drivers a chance to use it.

Ping

> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (usage->type =3D=3D EV_ABS &&
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
