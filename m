From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 09/10] Input: atmel_mxt_ts - tool type is ignored when
 slot is closed
Date: Mon, 23 Jul 2018 15:33:47 -0700
Message-ID: <20180723223347.GJ100814@dtor-ws>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-9-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180720215122.23558-9-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 20, 2018 at 10:51:21PM +0100, Nick Dyer wrote:
> From: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> input_mt_report_slot_state() ignores the tool when the slot is closed.
> Remove the tool type from these function calls, which has caused a bit of
> confusion.

Hmm, maybe we could introduce MT_TOOL_NONE or MT_TOOL_INACTIVE and get
rid of the 3rd parameter? It will require a bit of macro trickery for a
release or 2...

> 
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index d7023d261458..c31af790ef84 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -838,8 +838,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
>  		 * have happened.
>  		 */
>  		if (status & MXT_T9_RELEASE) {
> -			input_mt_report_slot_state(input_dev,
> -						   MT_TOOL_FINGER, 0);
> +			input_mt_report_slot_state(input_dev, 0, 0);
>  			mxt_input_sync(data);
>  		}
>  
> @@ -855,7 +854,7 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
>  		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, area);
>  	} else {
>  		/* Touch no longer active, close out slot */
> -		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, 0);
> +		input_mt_report_slot_state(input_dev, 0, 0);
>  	}
>  
>  	data->update_input = true;
> -- 
> 2.17.1
> 

-- 
Dmitry
