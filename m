From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] drivers/input/touchscreen/edt-ft5x06.c: remove
 unnecessary null test before debugfs_remove_recursive
Date: Wed, 9 Jul 2014 09:46:47 -0700
Message-ID: <20140709164647.GA10364@core.coreip.homeip.net>
References: <1403901512-9710-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41129 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaGIQqz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jul 2014 12:46:55 -0400
Content-Disposition: inline
In-Reply-To: <1403901512-9710-1-git-send-email-fabf@skynet.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Jun 27, 2014 at 10:38:32PM +0200, Fabian Frederick wrote:
> Fix checkpatch warning:
> "WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required"
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied, thank you.

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index d4f3399..5a6d50c 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -733,8 +733,7 @@ edt_ft5x06_ts_prepare_debugfs(struct edt_ft5x06_ts_data *tsdata,
>  static void
>  edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
>  {
> -	if (tsdata->debug_dir)
> -		debugfs_remove_recursive(tsdata->debug_dir);
> +	debugfs_remove_recursive(tsdata->debug_dir);
>  	kfree(tsdata->raw_buffer);
>  }
>  
> -- 
> 1.8.4.5
> 

-- 
Dmitry
