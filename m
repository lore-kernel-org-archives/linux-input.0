From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Hang in mousedev_init
Date: Wed, 28 May 2008 13:32:51 -0400
Message-ID: <20080528133017.ZZRA012@mailhub.coreip.homeip.net>
References: <1211989782.3079.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:52404 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbYE1Rc4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2008 13:32:56 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2365499wxd.4
        for <linux-input@vger.kernel.org>; Wed, 28 May 2008 10:32:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1211989782.3079.68.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
Cc: linux-input@vger.kernel.org, yoann.v@prelude-ids.com

On Wed, May 28, 2008 at 11:49:42AM -0400, Eric Paris wrote:
> I have a report of a person who is booting a 2.6.25 based fedora kernel
> and hanging in mounsedev_init().  Moving to our old 2.6.24 based fedora
> kernels he doesn't see any problems.
> 
> we know its mousedev_init since we added initcall_debug and
> mousedev_init() is called but never returns...
> 

Is it possible to get a SysRQ-P and SysRq-T traces and see where we
get stuck? Does the boot progress if you exclude mousedev from the
kernel?

> Doesn't look like many patches between then and now
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=3b04a61107dfe46dbfc1796298b59ca3c0a09cd9
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d182c10c842007984e12b3b816df2b10d997cc8e
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a7097ff89c3204737a07eecbc83f9ae6002cc534
> 
> About the only thing my clueless eye noticed was in
> d182c10c842007984e12b3b816df2b10d997cc8e
> 
> --- a/drivers/input/mousedev.c
> +++ b/drivers/input/mousedev.c
> @@ -1032,7 +1032,7 @@ static const struct input_device_id mousedev_ids[] = {
>                 .flags = INPUT_DEVICE_ID_MATCH_EVBIT |
>                         INPUT_DEVICE_ID_MATCH_KEYBIT |
>                         INPUT_DEVICE_ID_MATCH_ABSBIT,
> -               .evbit = { BIT(EV_KEY) | BIT(EV_ABS) | BIT(EV_SYN) },
> +               .evbit = { BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) },
>                 .keybit = { [BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) },
>                 .absbit = { BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) },
>         },      /* Mouse-like device with absolute X and Y but ordinary
> 
> You dropped the | BIT(EV_SYN)   does that matter?  What could have
> changed to cause a hang?  Any clues?
> 

Every device has EV_SYN so it makes no sense to try to match on it.

-- 
Dmitry
