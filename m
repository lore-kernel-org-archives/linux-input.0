From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Wed, 9 Dec 2009 15:15:17 -0800
Message-ID: <20091209231516.GF10138@core.coreip.homeip.net>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54357 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758517AbZLIXPQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 18:15:16 -0500
Received: by pwj9 with SMTP id 9so2695136pwj.21
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2009 15:15:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091209214928.1E24D9520C@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: linux-input@vger.kernel.org

Hi Stephane,

On Wed, Dec 09, 2009 at 10:49:28PM +0100, Stephane Chatty wrote:
> +
> +	if (emulate_touchscreen) {
> +		if (sd->first) {
> +			if (!sd->activity) {
> +				input_event(input, EV_KEY, BTN_TOUCH, 1);
> +				sd->activity = 1;
> +			}
> +			input_event(input, EV_ABS, ABS_X, sd->x);
> +			input_event(input, EV_ABS, ABS_Y, sd->y);
> +		}
> +	}

Why are you doing the above conditionally? Just report it always - less
setup required for the user.

-- 
Dmitry
