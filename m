From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: Replace semaphore driver_lock with mutex
Date: Wed, 14 Jun 2017 08:56:37 +0200
Message-ID: <20170614065637.GA3302@mail.corp.redhat.com>
References: <1497420740-5133-1-git-send-email-binoy.jayan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdFNG4w (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Jun 2017 02:56:52 -0400
Content-Disposition: inline
In-Reply-To: <1497420740-5133-1-git-send-email-binoy.jayan@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Binoy Jayan <binoy.jayan@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

Hi Binoy,

Looks good to me. However (and maybe Jiri can amend this while applying
the patch), the title still says "HID: Replace semaphore driver_lock
with mutex" while you killed it altogether...

Cheers,
Benjamin

On Jun 14 2017 or thereabouts, Binoy Jayan wrote:
> The semaphore 'driver_lock' is used as a simple mutex, and
> also unnecessary as suggested by Arnd. Hence removing it, as
> the concurrency between the probe and remove is already
> handled in the driver core.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Binoy Jayan <binoy.jayan@linaro.org>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> 
> v2 --> v3:
> Removed reference to driver_lock in comments
> 
> v1 --> v2:
> Removed driver_lock
> 
>  drivers/hid/hid-core.c | 15 ++++-----------
>  include/linux/hid.h    |  3 +--
>  2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 04cee65..559533b 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2225,11 +2225,9 @@ static int hid_device_probe(struct device *dev)
>  	const struct hid_device_id *id;
>  	int ret = 0;
>  
> -	if (down_interruptible(&hdev->driver_lock))
> -		return -EINTR;
>  	if (down_interruptible(&hdev->driver_input_lock)) {
>  		ret = -EINTR;
> -		goto unlock_driver_lock;
> +		goto end;
>  	}
>  	hdev->io_started = false;
>  
> @@ -2256,8 +2254,7 @@ static int hid_device_probe(struct device *dev)
>  unlock:
>  	if (!hdev->io_started)
>  		up(&hdev->driver_input_lock);
> -unlock_driver_lock:
> -	up(&hdev->driver_lock);
> +end:
>  	return ret;
>  }
>  
> @@ -2267,11 +2264,9 @@ static int hid_device_remove(struct device *dev)
>  	struct hid_driver *hdrv;
>  	int ret = 0;
>  
> -	if (down_interruptible(&hdev->driver_lock))
> -		return -EINTR;
>  	if (down_interruptible(&hdev->driver_input_lock)) {
>  		ret = -EINTR;
> -		goto unlock_driver_lock;
> +		goto end;
>  	}
>  	hdev->io_started = false;
>  
> @@ -2287,8 +2282,7 @@ static int hid_device_remove(struct device *dev)
>  
>  	if (!hdev->io_started)
>  		up(&hdev->driver_input_lock);
> -unlock_driver_lock:
> -	up(&hdev->driver_lock);
> +end:
>  	return ret;
>  }
>  
> @@ -2745,7 +2739,6 @@ struct hid_device *hid_allocate_device(void)
>  	init_waitqueue_head(&hdev->debug_wait);
>  	INIT_LIST_HEAD(&hdev->debug_list);
>  	spin_lock_init(&hdev->debug_list_lock);
> -	sema_init(&hdev->driver_lock, 1);
>  	sema_init(&hdev->driver_input_lock, 1);
>  
>  	return hdev;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 5be325d..a49203f 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -516,7 +516,6 @@ struct hid_device {							/* device report descriptor */
>  	struct hid_report_enum report_enum[HID_REPORT_TYPES];
>  	struct work_struct led_work;					/* delayed LED worker */
>  
> -	struct semaphore driver_lock;					/* protects the current driver, except during input */
>  	struct semaphore driver_input_lock;				/* protects the current driver */
>  	struct device dev;						/* device */
>  	struct hid_driver *driver;
> @@ -538,7 +537,7 @@ struct hid_device {							/* device report descriptor */
>  	unsigned int status;						/* see STAT flags above */
>  	unsigned claimed;						/* Claimed by hidinput, hiddev? */
>  	unsigned quirks;						/* Various quirks the device can pull on us */
> -	bool io_started;						/* Protected by driver_lock. If IO has started */
> +	bool io_started;						/* If IO has started */
>  
>  	struct list_head inputs;					/* The list of inputs */
>  	void *hiddev;							/* The hiddev structure */
> -- 
> Binoy Jayan
> 
