From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: alps - fix v4 button press recognition
Date: Wed, 15 Oct 2014 10:45:21 -0700
Message-ID: <20141015174521.GB1968@dtor-ws>
References: <CAA0OBZzqB28ZpfSt-ruOTOwdMxMC7SEdR+MsM03_ZVa16ybjug@mail.gmail.com>
 <1413313685-24405-1-git-send-email-linux@progandy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:57608 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaJORp0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 13:45:26 -0400
Received: by mail-pa0-f44.google.com with SMTP id et14so1742581pad.3
        for <linux-input@vger.kernel.org>; Wed, 15 Oct 2014 10:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413313685-24405-1-git-send-email-linux@progandy.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Bosch <linux@progandy.de>
Cc: linux-input@vger.kernel.org

On Tue, Oct 14, 2014 at 09:08:05PM +0200, Andreas Bosch wrote:
> Since the change to struct input_mt_pos some variables are now bitfields
> instead of integers. Automatic conversion from integer to bitfield entry
> destroys information, therefore enforce boolean interpretation instead.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1114768
> Fixes: 02d04254a5df ("Input: alps - use struct input_mt_pos to track coordinates")
> Signed-off-by: Andreas Bosch <linux@progandy.de>

Applied, thank you.

> ---
> 
> This is the second version of the patch. The first try got mangled 
> during the transmission.
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 35a49bf..2b0ae8c 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -835,8 +835,8 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
>  		f->fingers = alps_process_bitmap(priv, f);
>  	}
>  
> -	f->left = packet[4] & 0x01;
> -	f->right = packet[4] & 0x02;
> +	f->left = !!(packet[4] & 0x01);
> +	f->right = !!(packet[4] & 0x02);
>  
>  	f->st.x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
>  		  ((packet[0] & 0x30) >> 4);
> -- 
> 2.1.2
> 

-- 
Dmitry
