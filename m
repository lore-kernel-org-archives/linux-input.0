From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Documented input device properties.
Date: Wed, 11 Jan 2012 09:43:14 -0800
Message-ID: <20120111174313.GD21047@core.coreip.homeip.net>
References: <1326282991-4715-1-git-send-email-jussi.pakkanen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45490 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757907Ab2AKRnT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 12:43:19 -0500
Received: by iabz25 with SMTP id z25so1394660iab.19
        for <linux-input@vger.kernel.org>; Wed, 11 Jan 2012 09:43:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326282991-4715-1-git-send-email-jussi.pakkanen@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: linux-input@vger.kernel.org

On Wed, Jan 11, 2012 at 01:56:31PM +0200, Jussi Pakkanen wrote:
> Signed-off-by: Jussi Pakkanen <jussi.pakkanen@canonical.com>
> ---
>  Documentation/input/event-codes.txt |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
> index 23fcb05..2c4add3 100644
> --- a/Documentation/input/event-codes.txt
> +++ b/Documentation/input/event-codes.txt
> @@ -220,6 +220,40 @@ EV_PWR:
>  EV_PWR events are a special type of event used specifically for power
>  mangement. Its usage is not well defined. To be addressed later.
>  
> +Device properties:
> +=================
> +
> +INPUT_PROP_POINTER:
> +------------------
> +
> +There does not exist a one to one mapping between the device
> +coordinates and screen coordinates. This property only has meaning for
> +non-touch based input such as a pen or an eraser.

What exactly do you mean by "touch-based input"? Is a touchpad
touch-based or not? Going by this paragraph it should not have
INPUT_PROP_POINTER property, but in fact we do set it at least on
Synaptics touchpads.

Thanks.

-- 
Dmitry
