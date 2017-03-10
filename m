From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: rmi4 - prevent null pointer dereference in f30
Date: Fri, 10 Mar 2017 10:23:36 -0800
Message-ID: <20170310182336.GF21811@dtor-ws>
References: <20170310180552.8375-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36032 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932485AbdCJSXk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 13:23:40 -0500
Content-Disposition: inline
In-Reply-To: <20170310180552.8375-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 10, 2017 at 07:05:52PM +0100, Benjamin Tissoires wrote:
> If the platform data has f30_data.disable set, f30 in rmi_f30_config()
> might be null. Prevent a kernel oops by checking for non-null f30.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_f30.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
> index d8ff285..a0e4030 100644
> --- a/drivers/input/rmi4/rmi_f30.c
> +++ b/drivers/input/rmi4/rmi_f30.c
> @@ -170,6 +170,10 @@ static int rmi_f30_config(struct rmi_function *fn)
>  				rmi_get_platform_data(fn->rmi_dev);
>  	int error;
>  
> +	/* can happen if f30_data.disable is set */
> +	if (!f30)
> +		return 0;
> +
>  	if (pdata->f30_data.trackstick_buttons) {
>  		/* Try [re-]establish link to F03. */
>  		f30->f03 = rmi_find_function(fn->rmi_dev, 0x03);
> -- 
> 2.9.3
> 

-- 
Dmitry
