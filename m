From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Polled input device: add device open and close
	methods
Date: Wed, 14 Oct 2009 01:00:57 -0700
Message-ID: <20091014080057.GE5318@core.coreip.homeip.net>
References: <1255415088-31845-1-git-send-email-samu.p.onkalo@nokia.com> <1255415088-31845-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f186.google.com ([209.85.221.186]:46484 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbZJNIBj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 04:01:39 -0400
Received: by qyk16 with SMTP id 16so3925389qyk.15
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2009 01:01:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1255415088-31845-2-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-input@vger.kernel.org

On Tue, Oct 13, 2009 at 09:24:48AM +0300, Samu Onkalo wrote:
> Optional open and close methods for preparing and closing
> the device.
> 
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> ---
>  drivers/input/input-polldev.c |    6 ++++++
>  include/linux/input-polldev.h |    2 ++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
> index 0d3ce7a..0ad788b 100644
> --- a/drivers/input/input-polldev.c
> +++ b/drivers/input/input-polldev.c
> @@ -80,6 +80,9 @@ static int input_open_polled_device(struct input_dev *input)
>  	if (error)
>  		return error;
>  
> +	if (dev->open)
> +		dev->open(dev);
> +
>  	if (dev->flush)
>  		dev->flush(dev);

Hmm... I think having both open and flush is overkill. My fault for not
looking closer, I will kill the flush and convert existing users to
open.

-- 
Dmitry
