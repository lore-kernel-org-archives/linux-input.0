From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Only read the F54 query
 registers which are used
Date: Thu, 22 Jun 2017 21:14:53 +0100
Message-ID: <20170622201453.GA18432@lava.h.shmanahar.org>
References: <1498000128-31037-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:41784 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdFVUWi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Jun 2017 16:22:38 -0400
Content-Disposition: inline
In-Reply-To: <1498000128-31037-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>

On Tue, Jun 20, 2017 at 04:08:48PM -0700, Andrew Duggan wrote:
> The F54 driver is currently only using the first 6 bytes of F54 so there
> is no need to read all 27 bytes. Some Dell systems
> (Dell XP13 9333 and similar) have an issue with the touchpad or I2C bus
> when readiing reports larger then 16 bytes. Reads larger then 16 bytes
> are reported in two HID reports. Something about the back to back
> reports seems to cause the next read to report incorrect data. This
> results in F30 failing to load and the click button failing to work.
> 
> Previous issues with the I2C controller or touchpad were addressed in:
> commit 5b65c2a02966 ("HID: rmi: check sanity of the incoming report")
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=195949
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Looks fine to me.

Reviewed-by: Nick Dyer <nick@shmanahar.org>

> ---
> Also, in addition to changing the size of the read I moved the query
> buffer. I figured that since the query buffer is only acceessed in the
> rmi_f54_detect function it was not necessary keep it in f54_data. The
> parsed values are already being stored in f54_data.
> 
> Thanks,
> Andrew
> 
> 
>  drivers/input/rmi4/rmi_f54.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index dea63e2..f5206e2 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -31,9 +31,6 @@
>  #define F54_GET_REPORT          1
>  #define F54_FORCE_CAL           2
>  
> -/* Fixed sizes of reports */
> -#define F54_QUERY_LEN			27
> -
>  /* F54 capabilities */
>  #define F54_CAP_BASELINE	(1 << 2)
>  #define F54_CAP_IMAGE8		(1 << 3)
> @@ -95,7 +92,6 @@ struct rmi_f54_reports {
>  struct f54_data {
>  	struct rmi_function *fn;
>  
> -	u8 qry[F54_QUERY_LEN];
>  	u8 num_rx_electrodes;
>  	u8 num_tx_electrodes;
>  	u8 capabilities;
> @@ -632,22 +628,23 @@ static int rmi_f54_detect(struct rmi_function *fn)
>  {
>  	int error;
>  	struct f54_data *f54;
> +	u8 buf[6];
>  
>  	f54 = dev_get_drvdata(&fn->dev);
>  
>  	error = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
> -			       &f54->qry, sizeof(f54->qry));
> +			       buf, sizeof(buf));
>  	if (error) {
>  		dev_err(&fn->dev, "%s: Failed to query F54 properties\n",
>  			__func__);
>  		return error;
>  	}
>  
> -	f54->num_rx_electrodes = f54->qry[0];
> -	f54->num_tx_electrodes = f54->qry[1];
> -	f54->capabilities = f54->qry[2];
> -	f54->clock_rate = f54->qry[3] | (f54->qry[4] << 8);
> -	f54->family = f54->qry[5];
> +	f54->num_rx_electrodes = buf[0];
> +	f54->num_tx_electrodes = buf[1];
> +	f54->capabilities = buf[2];
> +	f54->clock_rate = buf[3] | (buf[4] << 8);
> +	f54->family = buf[5];
>  
>  	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "F54 num_rx_electrodes: %d\n",
>  		f54->num_rx_electrodes);
> -- 
> 2.7.4
> 
