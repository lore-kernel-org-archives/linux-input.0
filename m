From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH 3/3] drivers/input/tablet/aiptek: removed double define
Date: Mon, 11 Jul 2011 00:31:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107110031220.2818@swampdragon.chaosbits.net>
References: <1310336441-26893-1-git-send-email-edwin@cheatah.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from swampdragon.chaosbits.net ([90.184.90.115]:19884 "EHLO
	swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab1GJWbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jul 2011 18:31:51 -0400
In-Reply-To: <1310336441-26893-1-git-send-email-edwin@cheatah.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Edwin van Vliet <edwin@cheatah.nl>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 11 Jul 2011, Edwin van Vliet wrote:

> Constant AIPTEK_TOOL_BUTTON_PEN_MODE was diefined twice
> 
> Signed-off-by: Edwin van Vliet <edwin@cheatah.nl>
> ---
>  drivers/input/tablet/aiptek.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 0a619c5..6d89fd1 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -225,7 +225,6 @@
>  	/* toolMode codes
>  	 */
>  #define AIPTEK_TOOL_BUTTON_PEN_MODE			BTN_TOOL_PEN
> -#define AIPTEK_TOOL_BUTTON_PEN_MODE			BTN_TOOL_PEN
>  #define AIPTEK_TOOL_BUTTON_PENCIL_MODE			BTN_TOOL_PENCIL
>  #define AIPTEK_TOOL_BUTTON_BRUSH_MODE			BTN_TOOL_BRUSH
>  #define AIPTEK_TOOL_BUTTON_AIRBRUSH_MODE		BTN_TOOL_AIRBRUSH
> 
Reviewed-by: Jesper Juhl <jj@chaosbits.net>

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

