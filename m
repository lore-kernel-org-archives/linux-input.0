From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Patch for oops in a grabbed evdev after disconnect
Date: Tue, 18 Mar 2008 09:31:25 -0400
Message-ID: <20080318092733.ZZRA012@mailhub.coreip.homeip.net>
References: <20080317234807.42c72a76.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:7699 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYCRNbf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2008 09:31:35 -0400
Received: by mu-out-0910.google.com with SMTP id i10so12003415mue.5
        for <linux-input@vger.kernel.org>; Tue, 18 Mar 2008 06:31:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080317234807.42c72a76.zaitcev@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org

Hi Pete,

On Mon, Mar 17, 2008 at 11:48:07PM -0700, Pete Zaitcev wrote:
> If a device was grabbed through evdev and then became disconnected,
> we oops on close. This happens because input_release_device uses memory
> which was freed.
> 
> Fedora enabled evdev in X11 by default recently, and now anyone who
> flips a KVM oopses when they log out (Fedora bug 436659).
> 

Could you tell me what memory is freed? As far as I understand the
the input_dev structure shold be pinned in memory by the driver
core since we have this link:

	evdev->dev.parent = &input_dev->dev;

This should guarantee that input_device is not gone until we
call evdev_free which should be done way after the ungrab.

What am I missing here?

> Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 0727b0a..c0874a3 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -155,7 +155,8 @@ static int evdev_ungrab(struct evdev *evdev, struct evdev_client *client)
>  
>  	rcu_assign_pointer(evdev->grab, NULL);
>  	synchronize_rcu();
> -	input_release_device(&evdev->handle);
> +	if (evdev->exist)
> +		input_release_device(&evdev->handle);
>  
>  	return 0;
>  }

-- 
Dmitry
