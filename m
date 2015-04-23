From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input - elantech: fix semi-mt protocol for v3 HW
Date: Thu, 23 Apr 2015 09:09:55 -0700
Message-ID: <20150423160955.GB34808@dtor-ws>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
 <1429717509-27396-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35159 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965896AbbDWQKA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 12:10:00 -0400
Content-Disposition: inline
In-Reply-To: <1429717509-27396-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 22, 2015 at 11:45:08AM -0400, Benjamin Tissoires wrote:
> When the v3 hardware sees more than one finger, it uses
> the semi-mt protocol to report the touches. However, it
> currently works when num_fingers is 0, 1 or 2, but when
> it is 3 and above, it sends only 1 finger as if num_fingers
> was 1.
> 
> This confuses userspace which knows how to deal with extra
> fingers when all the slots are used, but not when some are
> missing.
> 
> Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=90101
> 
> CC: stable@vger.kernel.org
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 991dc6b..79363b6 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -315,7 +315,7 @@ static void elantech_report_semi_mt_data(struct input_dev *dev,
>  					 unsigned int x2, unsigned int y2)
>  {
>  	elantech_set_slot(dev, 0, num_fingers != 0, x1, y1);
> -	elantech_set_slot(dev, 1, num_fingers == 2, x2, y2);
> +	elantech_set_slot(dev, 1, num_fingers >= 2, x2, y2);
>  }
>  
>  /*
> -- 
> 2.1.0
> 

-- 
Dmitry
