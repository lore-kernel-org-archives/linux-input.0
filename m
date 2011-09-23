From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: potential info leak in input_event_to_user()
Date: Fri, 23 Sep 2011 00:29:57 -0700
Message-ID: <20110923072957.GA613@core.coreip.homeip.net>
References: <20110923062207.GF4387@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45141 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1IWHaE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Sep 2011 03:30:04 -0400
Content-Disposition: inline
In-Reply-To: <20110923062207.GF4387@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, Sep 23, 2011 at 09:22:07AM +0300, Dan Carpenter wrote:
> Smatch has a new check for Rosenberg type information leaks where
> structs are copied to the user with uninitialized stack data in them.
> 
> The issue here is that struct input_event_compat has a hole in it.
> 
> struct input_event_compat {
>         struct compat_timeval {
>         } time;                             /*     0     0 */
> 
>         /* XXX 8 bytes hole, try to pack */
> 
>         short unsigned int         type;    /*     8     2 */

Hm, are you sure? 8-bytes is way too much. I'd expect type to be aligned
on 2-byte boundary, at least on x86_64...

> 
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
> index e46a867..007850a 100644
> --- a/drivers/input/input-compat.c
> +++ b/drivers/input/input-compat.c
> @@ -44,6 +44,8 @@ int input_event_to_user(char __user *buffer,
>  	if (INPUT_COMPAT_TEST) {
>  		struct input_event_compat compat_event;
>  
> +		memset(&compat_event, 0, sizeof(compat_event));
> +
>  		compat_event.time.tv_sec = event->time.tv_sec;
>  		compat_event.time.tv_usec = event->time.tv_usec;
>  		compat_event.type = event->type;

-- 
Dmitry
