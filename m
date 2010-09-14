From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/7] davinci: define tnetv107x keypad platform data
Date: Mon, 13 Sep 2010 18:26:48 -0700
Message-ID: <20100914012648.GC2491@core.coreip.homeip.net>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
 <1284395388-32687-2-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60549 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0INB0y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 21:26:54 -0400
Received: by gxk23 with SMTP id 23so2226790gxk.19
        for <linux-input@vger.kernel.org>; Mon, 13 Sep 2010 18:26:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1284395388-32687-2-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>
Cc: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com

Hi Cyril,

On Mon, Sep 13, 2010 at 12:29:42PM -0400, Cyril Chemparathy wrote:
> This patch adds a definition for the platform data structure needed to
> configure the keypad controller on tnetv107x socs.
> 
> Since this controller is (so far) present only on tnetv107x devices, the data
> structure definition has been kept local to tnetv107x.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---
>  arch/arm/mach-davinci/include/mach/tnetv107x.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
> index c720647..1ee3035 100644
> --- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
> +++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
> @@ -37,6 +37,16 @@
>  #include <mach/nand.h>
>  #include <mach/serial.h>
>  
> +struct tnetv107x_keypad_data {
> +	int		*keymap;
> +	const char	**keynames;
> +	int		keymap_size;
> +	int		rows;
> +	int		cols;
> +	u32		debounce;
> +	u32		stable;
> +};
> +

This should be folded into the next patch and probably split into a
separate header file. Also, please consider switching to interface in
linux/input/matrix_keymap.h

Thanks.

- 
Dmitry
