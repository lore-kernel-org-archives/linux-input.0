From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] bcm5974-0.62: Compatibility mode reverted, BTN_TOUCH
	event added
Date: Tue, 2 Sep 2008 16:15:29 -0400
Message-ID: <20080902161432.ZZRA012@mailhub.coreip.homeip.net>
References: <48BD9CA4.7080805@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.241]:29766 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYIBUPh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Sep 2008 16:15:37 -0400
Received: by hs-out-0708.google.com with SMTP id 4so262350hsl.5
        for <linux-input@vger.kernel.org>; Tue, 02 Sep 2008 13:15:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48BD9CA4.7080805@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: akpm@osdl.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 02, 2008 at 10:05:56PM +0200, Henrik Rydberg wrote:
> @@ -296,6 +297,7 @@ static int report_tp_state(struct bcm5974 *dev, int size)
> 
>  	input_report_abs(input, ABS_PRESSURE, int2bound(&c->p, p));
> 
> +	input_report_key(input, BTN_TOUCH, p > 0);

Just relying on p will probably make it too sensitive, have you tried
adding hysteresis, like synaptics driver does?

-- 
Dmitry
