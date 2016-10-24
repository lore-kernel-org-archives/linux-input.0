From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tca8418_keypad: hide gcc-4.9
 -Wmaybe-uninitialized warning
Date: Mon, 24 Oct 2016 16:45:13 -0700
Message-ID: <20161024234513.GA15034@dtor-ws>
References: <20161024153222.2738294-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024153222.2738294-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Arnd,
On Mon, Oct 24, 2016 at 05:32:08PM +0200, Arnd Bergmann wrote:
> Older versions of gcc warn about the tca8418_irq_handler function
> as they can't keep track of the variable assignment inside of the
> loop when using the -Wmaybe-unintialized flag:
> 
> drivers/input/keyboard/tca8418_keypad.c: In function ‘tca8418_irq_handler’:
> drivers/input/keyboard/tca8418_keypad.c:172:9: error: ‘reg’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/input/keyboard/tca8418_keypad.c:165:5: note: ‘reg’ was declared here
> 
> This is fixed in gcc-6, but it's possible to rearrange the code
> in a way that avoids the warning on older compilers as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/input/keyboard/tca8418_keypad.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 9002298698fc..3048ef3e3e16 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -164,11 +164,18 @@ static void tca8418_read_keypad(struct tca8418_keypad *keypad_data)
>  	int error, col, row;
>  	u8 reg, state, code;
>  
> -	/* Initial read of the key event FIFO */
> -	error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
> +	do {
> +		error = tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
> +		if (error < 0) {
> +			dev_err(&keypad_data->client->dev,
> +				"unable to read REG_KEY_EVENT_A\n");
> +			break;
> +		}
> +
> +		/* Assume that key code 0 signifies empty FIFO */
> +		if (reg <= 0)
> +			break;

I am unconvinced that this rearrangement fixes the issue for all older
GCCs. Can we simply do:

	u8 uninitialized_var(reg);

and be done with it?

Thanks.

-- 
Dmitry
