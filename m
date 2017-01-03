From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - fix TrackStick Y axis handling for SS5
 hardware
Date: Tue, 3 Jan 2017 10:41:56 -0800
Message-ID: <20170103184156.GB16032@dtor-ws>
References: <1483447529-13565-1-git-send-email-linux-kernel@PaulSD.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34178 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757434AbdACTOa (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 14:14:30 -0500
Received: by mail-pg0-f65.google.com with SMTP id b1so34374857pgc.1
        for <linux-input@vger.kernel.org>; Tue, 03 Jan 2017 11:14:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1483447529-13565-1-git-send-email-linux-kernel@PaulSD.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@PaulSD.com>
Cc: linux-input@vger.kernel.org

On Tue, Jan 03, 2017 at 07:45:29AM -0500, Paul Donohue wrote:
> A minus character was lost in commit 23fce365, causing the Y axis to be
> inverted for SS5 TrackStick events.  (Pushing the TrackStick up caused
> the pointer to move down, and vice versa.)  Restore the lost minus.
> 
> Signed-off-by: Paul Donohue <linux-kernel@PaulSD.com>

Applied, thank you.

> ---
>  drivers/input/mouse/alps.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> index cde6f4b..6d279aa 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -114,7 +114,7 @@ enum SS4_PACKET_ID {
>  				 (_b[1] & 0x7F)		\
>  				)
>  
> -#define SS4_TS_Y_V2(_b)		(s8)(				\
> +#define SS4_TS_Y_V2(_b)		-(s8)(				\
>  				 ((_b[3] & 0x01) << 7) |	\
>  				 (_b[2] & 0x7F)		\
>  				)
> -- 
> 2.9.3
> 

-- 
Dmitry
