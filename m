From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] input/nomadik-ske: add multi key press support
Date: Mon, 25 Jun 2012 00:31:40 -0700
Message-ID: <20120625073140.GF13876@core.coreip.homeip.net>
References: <1339942662-20085-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41666 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab2FYHbp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 03:31:45 -0400
Received: by dady13 with SMTP id y13so4954571dad.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 00:31:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339942662-20085-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Sun, Jun 17, 2012 at 04:17:42PM +0200, Linus Walleij wrote:
> From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> 
> Added the multi key press support for SKE keypad by modifying the irq
> function for handling the two different keys on the same column and also
> pressing the two different keys of different columns on the same ASR
> register.
> 
> Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/nomadik-ske-keypad.c |   65 ++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
> index 4ea4341..6857454 100644
> --- a/drivers/input/keyboard/nomadik-ske-keypad.c
> +++ b/drivers/input/keyboard/nomadik-ske-keypad.c
> @@ -135,12 +135,37 @@ static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
>  	return 0;
>  }
>  
> -static void ske_keypad_read_data(struct ske_keypad *keypad)
> +static void ske_keypad_report(struct ske_keypad *keypad, u8 status, int col)
>  {
> +	int row = 0, code, pos;
>  	struct input_dev *input = keypad->input;
> -	u16 status;
> -	int col = 0, row = 0, code;
> -	int ske_asr, ske_ris, key_pressed, i;
> +	u32 ske_ris;
> +	int key_pressed;
> +	int num_of_rows;
> +
> +	/* find out the row */
> +	num_of_rows = hweight8(status);
> +	do {
> +		pos = __ffs(status);
> +		row = pos;
> +		status &= ~(1 << pos);
> +
> +		code = MATRIX_SCAN_CODE(row, col, SKE_KEYPAD_ROW_SHIFT);
> +		ske_ris = readl(keypad->reg_base + SKE_RIS);
> +		key_pressed = ske_ris & SKE_KPRISA;
> +
> +		input_event(input, EV_MSC, MSC_SCAN, code);
> +		input_report_key(input, keypad->keymap[code], key_pressed);
> +		input_sync(input);
> +		num_of_rows--;
> +	} while (num_of_rows);
> +}
> +
> +static void ske_keypad_read_data(struct ske_keypad *keypad)
> +{
> +	u8 status;
> +	int col = 0;
> +	int ske_asr, i;
>  
>  	/*
>  	 * Read the auto scan registers
> @@ -154,25 +179,17 @@ static void ske_keypad_read_data(struct ske_keypad *keypad)
>  		if (!ske_asr)
>  			continue;
>  
> -		/* now that ASRx is zero, find out the column x and row y*/
> -		if (ske_asr & 0xff) {
> +		/* now that ASRx is zero, find out the coloumn x and row y */
> +		status = ske_asr & 0xff;
> +		if (status) {
>  			col = i * 2;
> -			status = ske_asr & 0xff;
> -		} else {
> +			ske_keypad_report(keypad, status, col);
> +		}
> +		status = (ske_asr & 0xff00) >> 8;
> +		if (status) {
>  			col = (i * 2) + 1;
> -			status = (ske_asr & 0xff00) >> 8;
> +			ske_keypad_report(keypad, status, col);
>  		}
> -
> -		/* find out the row */
> -		row = __ffs(status);
> -
> -		code = MATRIX_SCAN_CODE(row, col, SKE_KEYPAD_ROW_SHIFT);
> -		ske_ris = readl(keypad->reg_base + SKE_RIS);
> -		key_pressed = ske_ris & SKE_KPRISA;
> -
> -		input_event(input, EV_MSC, MSC_SCAN, code);
> -		input_report_key(input, keypad->keymap[code], key_pressed);
> -		input_sync(input);
>  	}
>  }
>  
> @@ -186,12 +203,10 @@ static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
>  	ske_keypad_set_bits(keypad, SKE_ICR, 0x0, SKE_KPICA);
>  
>  	while ((readl(keypad->reg_base + SKE_CR) & SKE_KPASON) && --retries)
> -		msleep(5);
> +		cpu_relax();
>  
> -	if (retries) {
> -		/* SKEx registers are stable and can be read */
> -		ske_keypad_read_data(keypad);
> -	}
> +	/* SKEx registers are stable and can be read */
> +	ske_keypad_read_data(keypad);
>  
>  	/* enable auto scan interrupts */
>  	ske_keypad_set_bits(keypad, SKE_IMSC, 0x0, SKE_KPIMA);
> -- 
> 1.7.9.2
> 

-- 
Dmitry
