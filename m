From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Driver for TC35894XBG keypad controller
Date: Tue, 5 Oct 2010 10:47:49 -0700
Message-ID: <20101005174630.GB21399@core.coreip.homeip.net>
References: <20101005161838.16209.16231.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101005161838.16209.16231.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 05, 2010 at 05:19:18PM +0100, Alan Cox wrote:
> +
> +/*
> + * Largest keycode that the chip can send, plus one,
> + * so keys can be mapped directly at the index of the
> + * TC35894XBG keycode instead of subtracting one.
> + */
> +#define TC35894XBG_KEYMAP_SIZE      (0x7f + 1)
> +
> +#define SHIFT_NEEDED    (0x1000)
> +
> +#define KEY_EXCLAM      (KEY_1 + SHIFT_NEEDED)  /* '!' -> shift+1 */
> +#define KEY_AT          (KEY_2 + SHIFT_NEEDED)  /* '@' -> shift+2 */
> +#define KEY_NUMBER_SIGN (KEY_3 + SHIFT_NEEDED)  /* '#' -> shift+3 */
> +#define KEY_DOLLAR_SIGN (KEY_4 + SHIFT_NEEDED)  /* '$' -> shift+4 */
> +#define KEY_NOR         (KEY_6 + SHIFT_NEEDED)  /* '^' -> shift+6 */
> +#define KEY_PERCENT     (KEY_5 + SHIFT_NEEDED)  /* '%' -> shift+5 */
> +#define KEY_AMPERSAND   (KEY_7 + SHIFT_NEEDED)  /* '&' -> shift+7 */
> +#define KEY_PLUS        (KEY_EQUAL + SHIFT_NEEDED) /* '+' -> shift+= */
> +
> +#define KEY_BAR         (KEY_BACKSLASH + SHIFT_NEEDED)  /* '|' -> shift+\ */
> +#define KEY_COLON       (KEY_SEMICOLON + SHIFT_NEEDED)  /* ':' -> shift+; */
> +#define KEY_UNDERSCORE  (KEY_MINUS + SHIFT_NEEDED) /* '_' -> shift+- */
> +#define KEY_QUOTE_DBL   (KEY_APOSTROPHE + SHIFT_NEEDED) /* '"' -> shift+' */

No, this will not fly. It assumes presence of certain keymap which is not
necessarily the case.

-- 
Dmitry
