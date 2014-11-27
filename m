From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] Input: amikbd - Allocate temporary keymap buffer dynamically
Date: Thu, 27 Nov 2014 12:17:12 +0100
Message-ID: <87wq6gvqo7.fsf@igel.home>
References: <1417081340-2989-1-git-send-email-geert@linux-m68k.org>
	<1417081340-2989-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1417081340-2989-2-git-send-email-geert@linux-m68k.org> (Geert
	Uytterhoeven's message of "Thu, 27 Nov 2014 10:42:20 +0100")
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-m68k@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> @@ -147,13 +148,18 @@ static unsigned char amikbd_keycode[0x78] __initdata = {
>  
>  static void __init amikbd_init_console_keymaps(void)
>  {
> +	unsigned short *temp_map;
> +	size_t temp_map_size = NR_KEYS * sizeof(*temp_map);
>  	int i, j;
>  
> +	temp_map = kmalloc(temp_map_size, GFP_KERNEL);
> +	if (!temp_map)
> +		return;
> +
>  	for (i = 0; i < MAX_NR_KEYMAPS; i++) {
> -		static u_short temp_map[NR_KEYS] __initdata;
>  		if (!key_maps[i])
>  			continue;
> -		memset(temp_map, 0, sizeof(temp_map));
> +		memset(temp_map, 0, temp_map_size);
>  		for (j = 0; j < 0x78; j++) {
>  			if (!amikbd_keycode[j])
>  				continue;

How about allocating it on the stack?  With NR_KEYS == 256 that means
512 bytes, which should be ok, doesn't it?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
