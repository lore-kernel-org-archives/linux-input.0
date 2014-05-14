From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] input: dts: Add commonly used event types
Date: Wed, 14 May 2014 11:08:16 -0700
Message-ID: <20140514180816.GD30089@core.coreip.homeip.net>
References: <1398490639-18411-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:39701 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaENSIT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 14:08:19 -0400
Content-Disposition: inline
In-Reply-To: <1398490639-18411-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org

On Sat, Apr 26, 2014 at 09:37:19AM +0400, Alexander Shiyan wrote:
> Patch adds commonly used event types (EV_KEY and EV_SW) to
> devicetree bindings header for input subsystem.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Will DT folks pick it up please?

> ---
>  include/dt-bindings/input/input.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/input/input.h b/include/dt-bindings/input/input.h
> index 042e7b3..3a141d92 100644
> --- a/include/dt-bindings/input/input.h
> +++ b/include/dt-bindings/input/input.h
> @@ -9,6 +9,9 @@
>  #ifndef _DT_BINDINGS_INPUT_INPUT_H
>  #define _DT_BINDINGS_INPUT_INPUT_H
>  
> +#define EV_KEY			0x01
> +#define EV_SW			0x05
> +
>  #define KEY_RESERVED		0
>  #define KEY_ESC			1
>  #define KEY_1			2
> -- 
> 1.8.3.2
> 

-- 
Dmitry
