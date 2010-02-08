From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] input: mark {corgi,spitz,tosa}kbd driver deprecated
Date: Mon, 8 Feb 2010 19:05:08 +0100
Message-ID: <20100208180507.GA1469@ucw.cz>
References: <f17812d71002041631o25e63574t4cf13d21dc759dff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46852 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0BHSFT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 13:05:19 -0500
Content-Disposition: inline
In-Reply-To: <f17812d71002041631o25e63574t4cf13d21dc759dff@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>

Hi!

>     input: mark {corgi,spitz,tosa}kbd driver deprecated
> 
>     Provided that now keyboards on these devices are now fully supported
>     by generic GPIO based matrix keypad driver, mark these hardcoded, and
>     difficult to maintain drivers deprecated in favour of this.
> 
>     Cc: Richard Purdie <rpurdie@rpsys.net>
>     Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

ACK, but..

> @@ -329,13 +332,16 @@ config KEYBOARD_PXA930_ROTARY
>  	  module will be called pxa930_rotary.
> 
>  config KEYBOARD_SPITZ
> -	tristate "Spitz keyboard"
> +	tristate "Spitz keyboard (deprecated)"
>  	depends on PXA_SHARPSL
>  	default y

Default should be N, and config option probably should be removed
altogether -- with recent mach_spitz, keyboard_spitz will not be bound
to the hw, anyway... right?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
