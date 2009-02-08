From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/5] input: Update omap_keypad to use MATRIX_KEY macro
Date: Sun, 8 Feb 2009 08:44:45 -0800
Message-ID: <200902080844.45955.david-b@pacbell.net>
References: <BD79186B4FD85F4B8E60E381CAEE1909011A5469@mi8nycmail19.Mi8.com> <BD79186B4FD85F4B8E60E381CAEE19090120BD3E@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:34289 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751623AbZBHQor (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 8 Feb 2009 11:44:47 -0500
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090120BD3E@mi8nycmail19.Mi8.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Friday 06 February 2009, hartleys wrote:
> Update the omap_keypad driver to use common MATRIX_KEY macro.
> 
> As suggested by David Brownell, use two driver-internal defines:
>      * MATRIX_ROWCOL_MASK to strip R/C from MATRIX_KEY()
>      * MATRIX_KEYCODE_MASK to stip the keycode from a MATRIX_KEY()
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: David Brownell <david-b@pacbell.net>

Looks OK to me, but you might be better off cc'ing folk who
actually have something to do with this driver... check the
GIT history for and copyrights for suggestions.  :)

- Dave


> ---
> 
> diff --git a/arch/arm/plat-omap/include/mach/keypad.h
> b/arch/arm/plat-omap/include/mach/keypad.h
> index 232923a..c8269c3 100644
> --- a/arch/arm/plat-omap/include/mach/keypad.h
> +++ b/arch/arm/plat-omap/include/mach/keypad.h
> @@ -13,7 +13,7 @@
>  struct omap_kp_platform_data {
>  	int rows;
>  	int cols;
> -	int *keymap;
> +	unsigned int *keymap;
>  	unsigned int keymapsize;
>  	unsigned int rep:1;
>  	unsigned long delay;
> @@ -33,7 +33,5 @@ struct omap_kp_platform_data {
>  #define GROUP_3		(3 << 16)
>  #define GROUP_MASK	GROUP_3
>  
> -#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
> -
>  #endif
>  
> diff --git a/drivers/input/keyboard/omap-keypad.c
> b/drivers/input/keyboard/omap-keypad.c
> index 3f3d119..550b360 100644
> --- a/drivers/input/keyboard/omap-keypad.c
> +++ b/drivers/input/keyboard/omap-keypad.c
> @@ -64,7 +64,7 @@ struct omap_kp {
>  
>  static DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
>  
> -static int *keymap;
> +static unsigned int *keymap;
>  static unsigned int *row_gpios;
>  static unsigned int *col_gpios;
>  
> @@ -151,12 +151,13 @@ static void omap_kp_scan_keypad(struct omap_kp
> *omap_kp, unsigned char *state)
>  
>  static inline int omap_kp_find_key(int col, int row)
>  {
> -	int i, key;
> +	unsigned int key;
> +	int i;
>  
> -	key = KEY(col, row, 0);
> +	key = MATRIX_KEY(col, row, 0);
>  	for (i = 0; keymap[i] != 0; i++)
> -		if ((keymap[i] & 0xff000000) == key)
> -			return keymap[i] & 0x00ffffff;
> +		if ((keymap[i] & MATRIX_ROWCOL_MASK) == key)
> +			return keymap[i] & MATRIX_KEYCODE_MASK;
>  	return -1;
>  }
>   
> 
> 


