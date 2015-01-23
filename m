From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 5/6] Input: synaptics - Add PnP id for X1 Carbon 1nd
Date: Fri, 23 Jan 2015 09:42:02 +0100
Message-ID: <CADscph1o4tzwkEJ+3gsYTYanGYJhPq+-sfx6qyg-yFRVcWbNBA@mail.gmail.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
	<1421945201-1528-6-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64950 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbbAWImE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jan 2015 03:42:04 -0500
Received: by mail-qc0-f174.google.com with SMTP id s11so5320907qcv.5
        for <linux-input@vger.kernel.org>; Fri, 23 Jan 2015 00:42:02 -0800 (PST)
In-Reply-To: <1421945201-1528-6-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <consume.noise@gmail.com>
Cc: linux-input@vger.kernel.org

On 22 January 2015 at 17:46, Daniel Martin <daniel.martin@secunet.com> wrote:
> From: Daniel Martin <consume.noise@gmail.com>
>
> This adds the PnP id (LEN0030) for the X1 Carbon 1nd (2013/07) to the
> list of known PnP ids.
>
> The firmware exposes the correct dimensions:
>     x [1264..5678], y [1124..4732].
>
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---

Ups, forgotten to mention that I _think_ that this is the 1nd generation.

>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 7f6e004..70480c0 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -161,6 +161,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
>         "LEN002C",
>         "LEN002D",
>         "LEN002E",
> +       "LEN0030", /* X1 Carbon 1nd */
>         "LEN0033", /* Helix */
>         "LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
>         "LEN0035", /* X240 */
> --
> 2.2.2
>
