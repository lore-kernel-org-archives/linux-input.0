From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - clear device info before filling in
Date: Mon, 29 May 2017 20:16:54 -0700
Message-ID: <20170530031654.GE32841@dtor-ws>
References: <20170529052707.2144-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36273 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdE3DQ6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 23:16:58 -0400
Content-Disposition: inline
In-Reply-To: <20170529052707.2144-1-ebiggers3@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>

On Sun, May 28, 2017 at 10:27:07PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> synaptics_query_hardware() was being passed a
> 'struct synaptics_device_info' in uninitialized stack memory, then not
> always initializing all fields.  This caused garbage to show up in
> certain fields, making the touchpad unusable.
> 
> Fix by zeroing the device info, so all fields default to 0.
> 
> Fixes: 6c53694fb222 ("Input: synaptics - split device info into a separate structure")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 131df9d3660f..4f97970abc94 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -397,6 +397,8 @@ static int synaptics_query_hardware(struct psmouse *psmouse,
>  {
>  	int error;
>  
> +	memset(info, 0, sizeof(*info));
> +
>  	error = synaptics_identify(psmouse, info);
>  	if (error)
>  		return error;
> -- 
> 2.13.0
> 

-- 
Dmitry
