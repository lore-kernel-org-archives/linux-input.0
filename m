From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] input: dts: Add commonly used event types
Date: Fri, 28 Mar 2014 09:43:00 -0700
Message-ID: <20140328164300.GB7582@core.coreip.homeip.net>
References: <1395165888-17434-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:38683 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbaC1QnE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2014 12:43:04 -0400
Content-Disposition: inline
In-Reply-To: <1395165888-17434-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>

On Tue, Mar 18, 2014 at 10:04:47PM +0400, Alexander Shiyan wrote:
> Patch adds commonly used event types (EV_KEY and EV_SW) to
> devicetree bindings header for input subsystem.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
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

This I believe should go through device tree.

-- 
Dmitry
