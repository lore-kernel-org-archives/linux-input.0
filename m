From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 3/5] Input: add KEY_ROTATE_LOCK_TOGGLE
Date: Thu, 9 Nov 2017 17:41:22 -0800
Message-ID: <20171110014122.GC9783@fury>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <8ebdb255-b0b5-4de2-a680-e7f6713256d0@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42283 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755520AbdKJBlX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 20:41:23 -0500
Content-Disposition: inline
In-Reply-To: <8ebdb255-b0b5-4de2-a680-e7f6713256d0@rwthex-w2-a.rwth-ad.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org

On Thu, Nov 09, 2017 at 11:44:34PM +0100, Stefan Brüns wrote:
> The key has the same use as the SW_ROTATE_LOCK, but is used on devices
> where the state is not tracked by the hardware but has to be handled
> in software.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> 

Dmitry, this lands in the middle of series that otherwise applies to
drivers/platform/x86. OK with you if we carry this one?

> ---
> 
> Changes in v2:
> - New patch, add support for KEY_ROTATE_LOCK_TOGGLE
> 
>  include/uapi/linux/input-event-codes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index f4058bd4c373..ba5d709a8923 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -593,6 +593,7 @@
>  #define BTN_DPAD_RIGHT		0x223
>  
>  #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
> +#define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
>  
>  #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
>  #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
> -- 
> 2.15.0
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
