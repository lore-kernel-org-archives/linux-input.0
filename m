From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Fix documentation. Event type is EV_KEY, not
	REL_KEY.
Date: Fri, 17 Apr 2009 08:36:45 -0700
Message-ID: <20090417153645.GA20999@dtor-d630.eng.vmware.com>
References: <1239960623-28133-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:52636 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbZDQPhA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 11:37:00 -0400
Received: by rv-out-0506.google.com with SMTP id f9so962273rvb.1
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2009 08:36:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1239960623-28133-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-input@vger.kernel.org

On Fri, Apr 17, 2009 at 06:30:23AM -0300, Thadeu Lima de Souza Cascardo wrote:
> ---
>  Documentation/input/input.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/input/input.txt b/Documentation/input/input.txt
> index 686ee99..b93c084 100644
> --- a/Documentation/input/input.txt
> +++ b/Documentation/input/input.txt
> @@ -278,7 +278,7 @@ struct input_event {
>  };
>  
>    'time' is the timestamp, it returns the time at which the event happened.
> -Type is for example EV_REL for relative moment, REL_KEY for a keypress or
> +Type is for example EV_REL for relative moment, EV_KEY for a keypress or
>  release. More types are defined in include/linux/input.h.
>  
>    'code' is event code, for example REL_X or KEY_BACKSPACE, again a complete

Will apply, thank you.

-- 
Dmitry
