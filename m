Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6C49F13A;
	Fri, 11 Sep 2026 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143461; cv=none; b=pSyaY/Oc3oX+Aq1NTEPDSX67IGK5rrkr+H4SneeAXbkmc3j8lqUo9fbrIn5sfcisiGzjGJSABAKQzGJDgvAh6Q8V7gvHgG9RhhisHLQpKN1r1aNcOCYvJDWu7FdK3qWBkE7ycdo0jvqf1vdMq2xqA4YWTDdIa5JfmsZIhVSKoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143461; c=relaxed/simple;
	bh=fBkFibeyEnLM15yPHAigYaVAQi+CAgj22cnAydaV+8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q6Whcvpxy0gFMUiT7QU/kiyStYVvOvbmb4Oih0Gfe39NmBMXlndEilVlM7+B2ILoCqh5ZOZTnsi3PvyICiOR6BXtrMMDyu9G4FgNxCfvc61ej3UAvddES6sB2tUiVcvRPvLCygMCRfB3zq/jR8LEhBQ8iCttE95wcgCK2bRPm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAcYQlSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAcYQlSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD19F1F000FF;
	Fri, 11 Sep 2026 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789143459;
	bh=7QHKF5I564MBjh6E4TOc/G9dCTwriScQDN+3xalmo/U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=FAcYQlSBZiqkKsSzqFnu3wFeFOcdIF6sF9/FcZDKiVNHjAVIPF/Ur+84mzYmhlLa3
	 ZTQ6bQlMPtAftFHvdYPMROSo9sG0xWC2DCOtGT/uk2y/PHKZNz0moxsJNqiDA7hoNZ
	 RTofJ79J298yyS7vdIBn05h5xwIJcemypD6+Pp4aW0rfqfZvARIUmMTn2sr5dqeljZ
	 vipzATr9oRoWb5YQbqi10Vuz6n6v7XocCnI/wOrPt8ZHS636jlHH2TaYvrLKV3T1ND
	 e0ZtyyiaJ8lDciArDh1qWcgG46wTfsQCe6F4v73TZLJK+s0jYF8K0d6N+qQafLwbA0
	 f5XWFF7O11r9w==
Date: Fri, 11 Sep 2026 18:17:36 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Jeffin Philip <jeffinphilip14@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com, 
    syzbot+0b8bff5929865345b29e@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: corsair: do not re-schedule LED worker after it
 has been cancelled
In-Reply-To: <20260831074130.71683-1-chenchangcheng@kylinos.cn>
Message-ID: <8s5r192r-rqp0-nq7n-n317-r7r503239474@xreary.bet>
References: <20260831074130.71683-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 31 Aug 2026, Chen Changcheng wrote:

> Commit eb51c9f8cb4f0 ("HID: corsair: cancel worker before unregistering
> LED to fix use-after-free") moved cancel_work_sync() ahead of
> led_classdev_unregister() in k90_cleanup_backlight() and
> k90_cleanup_macro_functions().  led_classdev_unregister() internally
> calls led_set_brightness(LED_OFF), which reaches the driver's
> k90_brightness_set() callback.  Since that callback schedules the worker
> unconditionally, the worker was re-queued after cancel_work_sync() had
> drained it, and the subsequent kfree() freed a still-active work_struct:
> 
>     ODEBUG: free active (active state 0) object type: work_struct
>             hint: k90_record_led_work
> 
> The removed flag check inside the worker itself only stops it from
> dereferencing freed memory once it runs; it cannot prevent the re-queue.
> 
> Fix this by making k90_brightness_set() a no-op once removed is set, so
> the LED_OFF update issued from led_classdev_unregister() can no longer
> re-schedule the worker after it has been cancelled.  Also apply the
> cancel-before-unregister ordering to the probe error path
> (k90_init_macro_functions() fail_sysfs) for consistency.
> 
> Fixes: eb51c9f8cb4f0 ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
> Reported-by: syzbot+0a031a76585d1c7e737d@syzkaller.appspotmail.com
> Reported-by: syzbot+0b8bff5929865345b29e@syzkaller.appspotmail.com
> https://lore.kernel.org/all/6a937393.1d9ded08.62e62.0113.GAE@google.com/
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
> ---
>  drivers/hid/hid-corsair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 278c6efb565d..73b3c1ff78c6 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -194,6 +194,9 @@ static void k90_brightness_set(struct led_classdev *led_cdev,
>  {
>  	struct k90_led *led = container_of(led_cdev, struct k90_led, cdev);
>  
> +	if (led->removed)
> +		return;
> +

Sashiko is right here about the race. Can you please fix that and 
resubmit? Thanks,

-- 
Jiri Kosina
SUSE Labs

