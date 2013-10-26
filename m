From: Niels de Vos <ndevos@redhat.com>
Subject: Re: [PATCH] Input: Adding support for touchpad on Dell XT2 model
Date: Sat, 26 Oct 2013 09:18:03 +0200
Message-ID: <20131026071803.GL32239@ndevos-laptop.usersys.redhat.com>
References: <1382715581-2584-1-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab3JZHST (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Oct 2013 03:18:19 -0400
Content-Disposition: inline
In-Reply-To: <1382715581-2584-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: dmitry.torokhov@gmail.com, cernekee@gmail.com, dturvene@dahetral.com, linux-input@vger.kernel.org, gaspard@oknaj.eu, jclift@redhat.com, yunkang.tang@cn.alps.com

On Fri, Oct 25, 2013 at 11:39:41PM +0800, Yunkang Tang wrote:
> Hi all,
> 
> This patch adding the support for touchpad on Dell XT2 model.
> It's a dual device with device ID: 73, 00, 14, that comply with "ALPS_PROTO_V2".
> 
> 
> Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>

Tested-by: Gaspard Jankowiak <gaspard@oknaj.eu>
Reviewed-by: Niels de Vos <ndevos@redhat.com>
    (well, for as far a one-line review goes)

Thanks!

> ---
>  drivers/input/mouse/alps.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index ca7a26f..24b3626 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -103,6 +103,7 @@ static const struct alps_model_info alps_model_data[] = {
>  	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
>  	{ { 0x62, 0x02, 0x14 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf,
>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
> +	{ { 0x73, 0x00, 0x14 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_DUALPOINT },		/* Dell XT2 */
>  	{ { 0x73, 0x02, 0x50 }, 0x00, ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },		/* Dell Vostro 1400 */
>  	{ { 0x52, 0x01, 0x14 }, 0x00, ALPS_PROTO_V2, 0xff, 0xff,
>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },				/* Toshiba Tecra A11-11L */
> -- 
> 1.8.1.2
> 
