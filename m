From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ALPS - Add signature for HP Pavilion dm3 laptops
Date: Sat, 27 Mar 2010 12:11:02 -0700
Message-ID: <20100327191102.GA14548@core.coreip.homeip.net>
References: <1269712311-8041-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51376 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab0C0TLJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Mar 2010 15:11:09 -0400
Received: by gwaa18 with SMTP id a18so3268943gwa.19
        for <linux-input@vger.kernel.org>; Sat, 27 Mar 2010 12:11:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1269712311-8041-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

On Sat, Mar 27, 2010 at 01:51:51PM -0400, Chase Douglas wrote:
> Tested by a user running Ubuntu 9.10 in the following bug report.
> 
> BugLink: http://bugs.launchpad.net/bugs/545307
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> Cc: stable@kernel.org

Will apply, thank you Chase.

> ---
>  drivers/input/mouse/alps.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index f93c2c0..432e3ef 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -63,6 +63,7 @@ static const struct alps_model_info alps_model_data[] = {
>  	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
>  	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
> +	{ { 0x73, 0x02, 0x64 }, 0xf8, 0xf8, 0 },			  /* HP Pavilion dm3 */
>  };
>  
>  /*
> -- 
> 1.7.0
> 

-- 
Dmitry
