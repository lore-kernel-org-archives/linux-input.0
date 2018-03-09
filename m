From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: stmpe-keypad - remove VLA usage
Date: Fri, 9 Mar 2018 15:32:35 -0800
Message-ID: <20180309233235.GC60941@dtor-ws>
References: <20180309224208.GA7080@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309224208.GA7080@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 09, 2018 at 04:42:08PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead.
> 
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/input/keyboard/stmpe-keypad.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
> index 8c6c0b9..cfa1dbe 100644
> --- a/drivers/input/keyboard/stmpe-keypad.c
> +++ b/drivers/input/keyboard/stmpe-keypad.c
> @@ -48,6 +48,8 @@
>  #define STMPE_KEYPAD_KEYMAP_MAX_SIZE \
>  	(STMPE_KEYPAD_MAX_ROWS * STMPE_KEYPAD_MAX_COLS)
>  
> +#define MAX_NUM_DATA			5
> +
>  /**
>   * struct stmpe_keypad_variant - model-specific attributes
>   * @auto_increment: whether the KPC_DATA_BYTE register address
> @@ -74,7 +76,7 @@ struct stmpe_keypad_variant {
>  static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>  	[STMPE1601] = {
>  		.auto_increment		= true,
> -		.num_data		= 5,
> +		.num_data		= MAX_NUM_DATA,
>  		.num_normal_data	= 3,
>  		.max_cols		= 8,
>  		.max_rows		= 8,
> @@ -84,7 +86,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>  	[STMPE2401] = {
>  		.auto_increment		= false,
>  		.set_pullup		= true,
> -		.num_data		= 3,
> +		.num_data		= MAX_NUM_DATA - 2,

Logically MAX_NUM_DATA - 2 does not mean anything, it is simply a way
for you to get to 3, so I'd rather we did not do that.

Can we do

#define STMPE1601_NUM_DATA	5
#define STMPE2401_NUM_DATA	3
#define STMPE2403_NUM_DATA	5
#define MAX_NUM_DATA		max3(STMPE1601_NUM_DATA, \
				     STMPE2401_NUM_DATA, \
				     STMPE2403_NUM_DATA)


or simply

/* Make sure it covers all cases above */
#define MAX_NUM_DATA		5

>  		.num_normal_data	= 2,
>  		.max_cols		= 8,
>  		.max_rows		= 12,
> @@ -94,7 +96,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>  	[STMPE2403] = {
>  		.auto_increment		= true,
>  		.set_pullup		= true,
> -		.num_data		= 5,
> +		.num_data		= MAX_NUM_DATA,
>  		.num_normal_data	= 3,
>  		.max_cols		= 8,
>  		.max_rows		= 12,
> @@ -156,7 +158,7 @@ static irqreturn_t stmpe_keypad_irq(int irq, void *dev)
>  	struct stmpe_keypad *keypad = dev;
>  	struct input_dev *input = keypad->input;
>  	const struct stmpe_keypad_variant *variant = keypad->variant;
> -	u8 fifo[variant->num_data];
> +	u8 fifo[MAX_NUM_DATA];
>  	int ret;
>  	int i;
>  
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
