From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: change KEY_DATA from 0x275 to 0x277
Date: Mon, 28 Nov 2016 13:20:36 -0800
Message-ID: <20161128212036.GA37762@dtor-ws>
References: <1480366164-18706-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36655 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbcK1VUk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 16:20:40 -0500
Received: by mail-pg0-f68.google.com with SMTP id x23so14139846pgx.3
        for <linux-input@vger.kernel.org>; Mon, 28 Nov 2016 13:20:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1480366164-18706-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Kamil Debski <kamil@wypas.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Mon, Nov 28, 2016 at 12:49:24PM -0800, Ping Cheng wrote:
> 0x275 is used by KEY_FASTREVERSE. Or, was that on purpose to use
> the same value as KEY_FASTREVERSE for KEY_DATA?
> 
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

Ugh, that's not good. I guess we should indeed change this and make sure
it goes to stable.

Hans, Kamil, I do not suppose anyone actually been using KEY_DATA as it
would have been clashing with KEY_FASTREVERSE?

Thanks.

> ---
>  include/uapi/linux/input-event-codes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index d6d071f..3af60ee 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -640,7 +640,7 @@
>   * Control a data application associated with the currently viewed channel,
>   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
>   */
> -#define KEY_DATA			0x275
> +#define KEY_DATA			0x277
>  
>  #define BTN_TRIGGER_HAPPY		0x2c0
>  #define BTN_TRIGGER_HAPPY1		0x2c0
> -- 
> 2.7.4
> 

-- 
Dmitry
