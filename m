From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: i8042 - change dbg to pr_warn when returning
 errors
Date: Fri, 16 Dec 2016 16:54:45 -0800
Message-ID: <20161217005445.GB22632@dtor-ws>
References: <20161206234531.4320-1-marcos.souza.org@gmail.com>
 <20161206234531.4320-2-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34461 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934201AbcLQAys (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Dec 2016 19:54:48 -0500
Content-Disposition: inline
In-Reply-To: <20161206234531.4320-2-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Marcos,

On Tue, Dec 06, 2016 at 09:44:55PM -0200, Marcos Paulo de Souza wrote:
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/input/serio/i8042.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 1c70747..bc54ce5 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -323,13 +323,13 @@ static int __i8042_command(unsigned char *param, int command)
>  	for (i = 0; i < ((command >> 8) & 0xf); i++) {
>  		error = i8042_wait_read();
>  		if (error) {
> -			dbg("     -- i8042 (timeout)\n");
> +			pr_warn("     -- i8042 (timeout)\n");
>  			return error;
>  		}
>  
>  		if (command == I8042_CMD_AUX_LOOP &&
>  		    !(i8042_read_status() & I8042_STR_AUXDATA)) {
> -			dbg("     -- i8042 (auxerr)\n");
> +			pr_warn("     -- i8042 (auxerr)\n");
>  			return -1;

No, we expect this to fail on some systems (that is the whole point of
testing using the LOOP command to verify that AUX port is there and is
wired properly), so we should not be issuing warnings - the system way
very well be functioning properly.

dbg() is always there, so just rerun the boot with i8042.debug and get
all the trace needed.

Thanks.

-- 
Dmitry
