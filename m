From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Sat, 24 Oct 2015 15:53:41 -0700
Message-ID: <20151024225341.GA17120@dtor-pixel>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35350 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbbJYDIW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Oct 2015 23:08:22 -0400
Content-Disposition: inline
In-Reply-To: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

On Tue, Aug 25, 2015 at 11:12:59AM -0400, Benjamin Tissoires wrote:
> +static int uinput_abs_setup(struct uinput_device *udev,
> +			    struct uinput_setup __user *arg, size_t size)
> +{
> +	struct uinput_abs_setup setup = {};
> +	struct input_dev *dev;
> +
> +	if (size > sizeof(setup))
> +		return -E2BIG;
> +	if (udev->state == UIST_CREATED)
> +		return -EINVAL;
> +	if (copy_from_user(&setup, arg, size))
> +		return -EFAULT;
> +	if (setup.code > ABS_MAX)
> +		return -ERANGE;
> +
> +	dev = udev->dev;
> +
> +	input_alloc_absinfo(dev);
> +	if (!dev->absinfo)
> +		return -ENOMEM;
> +
> +	set_bit(setup.code, dev->absbit);
> +	dev->absinfo[setup.code] = setup.absinfo;
> +
> +	/*
> +	 * We restore the state to UIST_NEW_DEVICE because the user has to call
> +	 * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
> +	 * validity of the absbits.
> +	 */

Do we have to be this strict? It seems to me that with the new IOCTLs
you naturally want to use the new ioctl to setup the device, then adjust
various axes and bits and then validate everything.

Thanks.

-- 
Dmitry
