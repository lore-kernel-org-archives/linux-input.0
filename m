From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] uinput: Fix module crash on driver exit with force
 feedback effects still loaded
Date: Sat, 25 Jun 2016 08:44:04 -0700
Message-ID: <20160625154404.GC17812@dtor-ws>
References: <e9e2b6b9-83d6-fab7-88db-9e0e6a2b0185@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36449 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcFYPoJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jun 2016 11:44:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id i123so11866413pfg.3
        for <linux-input@vger.kernel.org>; Sat, 25 Jun 2016 08:44:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e9e2b6b9-83d6-fab7-88db-9e0e6a2b0185@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

On Sun, May 22, 2016 at 08:22:23PM +0200, Manuel Reimer wrote:
> Hello,
> 
> I had a deeper look into the uinput kernel module crash problem,
> which happens when a game loads effects and the driver exits while
> the game is still running.
> 
> The actual problem is, that "input_unregister_device", which is
> called in "uinput_destroy_device", seems to include some "cleanup
> routine" which includes erasing loaded force feedback effects. This
> cleanup routine causes the "uinput_dev_erase_effect" routine to be
> called, which will wait for the, already exited, daemon to answer
> this request.

There are 2 cases when we destroy the device:

- when daemon is exiting. In this case you are absolutely right, we have
  no hope of talking to the device and should not be trying to send
  requests to it;

- when userspace explicitly requested the device to be destroyed via
  UI_DEV_DESTROY ioctl. In this case I believe the kernel should attempt
  orderly device shutdown which includes stopping all FF effects.

I guess we'll need to introduce another bit of state and adjust behavior
accordingly.

> 
> The existing code contains a device state test, but this test is
> placed wrong. My patch moves the device state test, which was in
> "uinput_request_send", to the "uinput_request_submit" function. This

The device state is supposed to be protected by udev->mutex, your change
violates this constraint.

>
> way the erase requests, triggered by "input_unregister_device", are
> rejected immediately, so they no longer cause any trouble.
> 
> Should I have added a one-line comment above the device state test,
> mentioning the cleanup routine in "input_unregister_device"?
> 
> Signed-off-by: Manuel Reimer <mail@m-reimer.de>
> 
> --- a/drivers/input/misc/uinput.c	2016-05-13 16:06:31.919351656 +0200
> +++ b/drivers/input/misc/uinput.c	2016-05-22 19:33:30.814403482 +0200
> @@ -117,11 +117,6 @@ static int uinput_request_send(struct ui
>  	if (retval)
>  		return retval;
> 
> -	if (udev->state != UIST_CREATED) {
> -		retval = -ENODEV;
> -		goto out;
> -	}
> -
>  	init_completion(&request->done);
> 
>  	/*
> @@ -130,7 +125,6 @@ static int uinput_request_send(struct ui
>  	 */
>  	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
> 
> - out:
>  	mutex_unlock(&udev->mutex);
>  	return retval;
>  }
> @@ -140,6 +134,9 @@ static int uinput_request_submit(struct
>  {
>  	int error;
> 
> +	if (udev->state != UIST_CREATED)
> +		return -ENODEV;
> +
>  	error = uinput_request_reserve_slot(udev, request);
>  	if (error)
>  		return error;

Thanks.

-- 
Dmitry
