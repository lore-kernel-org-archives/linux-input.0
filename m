From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: stmpe: check fifo_empty flag before
 reading x/y values
Date: Mon, 10 Apr 2017 20:33:47 -0700
Message-ID: <20170411033347.GA4346@dtor-ws>
References: <1491817946-13926-1-git-send-email-pfink@christ-es.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34506 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbdDKDdv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 23:33:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so28060661pga.1
        for <linux-input@vger.kernel.org>; Mon, 10 Apr 2017 20:33:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1491817946-13926-1-git-send-email-pfink@christ-es.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Fink <pfink@christ-es.de>
Cc: linux-input@vger.kernel.org, stefan.agner@toradex.com

Hi Peter,

On Mon, Apr 10, 2017 at 11:52:26AM +0200, Peter Fink wrote:
> STMPE driver with STMPE811 reported x=0/y=0 when clicking in succession at
> higher speeds. In some configurations the consuming X11 input stack is able
> to ignore this input, but e.g. with inverted axes this is prone to fail.
> 
> In these cases it might happen that even applications are closed when the
> close-X is located in the same corner as touch 0/0 is mapped to. This
> happens when touch coordinates are read from an empty fifo although the
> threshold interrupt indicates that new data is available.
> 
> To avoid wrong touch data read and evaluate the fifo_empty bit before
> accessing the fifo.
> 
> Signed-off-by: Peter Fink <pfink@christ-es.de>
> ---
>  drivers/input/touchscreen/stmpe-ts.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index 2a78e27..dcc9d48 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -44,6 +44,7 @@
>  #define OP_MOD_XYZ			0
>  
>  #define STMPE_TSC_CTRL_TSC_EN		(1<<0)
> +#define STMPE_FIFO_EMPTY		(1<<5)

This belongs with other FIFO STA register definitions, please move
there.  Also, all these could be converted to BIT().

>  
>  #define STMPE_FIFO_STA_RESET		(1<<0)
>  
> @@ -175,17 +176,22 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
>  	stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
>  				STMPE_TSC_CTRL_TSC_EN, 0);
>  
> -	stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA_XYZ, 4, data_set);
> +	if (!(stmpe_reg_read(ts->stmpe, STMPE_REG_FIFO_STA)
> +					& STMPE_FIFO_EMPTY)) {

We probably want to check for errors. So:

	fifo_sta = stmpe_reg_read(ts->stmpe, STMPE_REG_FIFO_STA);
	if (fifo_sta >= 0 && !(fifo_sta & STMPE_FIFO_EMPTY)) {
		...
	}

I am also looking at stmpe_work() and wonder if we should not check FIFO
status when we see touch detect and if we see it there we probably want
to bail?

Thanks.

-- 
Dmitry
