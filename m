From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Documented input device properties.
Date: Mon, 9 Jan 2012 09:55:51 -0800
Message-ID: <20120109175551.GC15083@core.coreip.homeip.net>
References: <1326127454-11695-1-git-send-email-jussi.pakkanen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63559 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab2AIRz5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 12:55:57 -0500
Received: by iaeh11 with SMTP id h11so6913268iae.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2012 09:55:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326127454-11695-1-git-send-email-jussi.pakkanen@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Pakkanen <jussi.pakkanen@canonical.com>
Cc: linux-input@vger.kernel.org

Hi Jussi,

On Mon, Jan 09, 2012 at 06:44:14PM +0200, Jussi Pakkanen wrote:
> ---
>  Documentation/input/event-codes.txt |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
> index 23fcb05..7c515a5 100644
> --- a/Documentation/input/event-codes.txt
> +++ b/Documentation/input/event-codes.txt
> @@ -220,6 +220,33 @@ EV_PWR:
>  EV_PWR events are a special type of event used specifically for power
>  mangement. Its usage is not well defined. To be addressed later.
>  
> +Device properties:
> +=================
> +
> +INPUT_PROP_POINTER:
> +------------------
> +There is a one to one mapping between the device coordinates and
> +screen coordinates.

This is not correct as touchpads fall firmly into INPUT_PROP_POINTER
land and certainly do not have 1:1 relationship between on-screen and
device coordinates.

> This property only has meaning for non-touch based
> +input such as a pen or an eraser. A drawing tablet would have this property
> +set.

Wacom Bamboo touch can be said is touch based but still is a pointer
device. Basically pointer device is one that requires use of an
on-screen pointer to reflect user's movement while with direct devices
touching object itself serves as a pointer to the user.

Thanks.

-- 
Dmitry
