From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/3] hid: thingm: improve locking
Date: Mon, 29 Feb 2016 23:38:06 +0100
Message-ID: <20160229223806.GD22340@mail.corp.redhat.com>
References: <56D4AC4C.3050707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D4AC4C.3050707@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Heiner,

On Feb 29 2016 or thereabouts, Heiner Kallweit wrote:
> When reading from the device the full operation including sending the
> read command and the actual read should be protected by the mutex.
> Facilitate this by changing the semantics of thingm_recv to include
> sending the read command.

I really like the cleanups of patches 1/3 and 2/3. However, this patch
does not make sense to me. thingm_send() and thingm_recv() are pretty
well defined to me. One reads data from the device, the other writes it.

With this change, whenever you read data from the device, you start by
overwriting its value and then read it back. Am I missing something?

I think you'd better add the proper mutexes around thingm_version()
or add the read command before thingm_send() in thingm_write_color()
(and please add a comment explaining why we need to read first).

Cheers,
Benjamin

> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/hid/hid-thingm.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> index 5e35ec1..0e4b50c 100644
> --- a/drivers/hid/hid-thingm.c
> +++ b/drivers/hid/hid-thingm.c
> @@ -77,9 +77,13 @@ static int thingm_send(struct thingm_device *tdev, u8 buf[REPORT_SIZE])
>  			buf[0], buf[1], buf[2], buf[3], buf[4],
>  			buf[5], buf[6], buf[7], buf[8]);
>  
> +	mutex_lock(&tdev->lock);
> +
>  	ret = hid_hw_raw_request(tdev->hdev, buf[0], buf, REPORT_SIZE,
>  			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>  
> +	mutex_unlock(&tdev->lock);
> +
>  	return ret < 0 ? ret : 0;
>  }
>  
> @@ -87,16 +91,26 @@ static int thingm_recv(struct thingm_device *tdev, u8 buf[REPORT_SIZE])
>  {
>  	int ret;
>  
> +	mutex_lock(&tdev->lock);
> +
> +	ret = hid_hw_raw_request(tdev->hdev, buf[0], buf, REPORT_SIZE,
> +			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +	if (ret < 0)
> +		goto err;
> +
>  	ret = hid_hw_raw_request(tdev->hdev, buf[0], buf, REPORT_SIZE,
>  			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>  	if (ret < 0)
> -		return ret;
> +		goto err;
> +
> +	ret = 0;
>  
>  	hid_dbg(tdev->hdev, "<- %d %c %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx\n",
>  			buf[0], buf[1], buf[2], buf[3], buf[4],
>  			buf[5], buf[6], buf[7], buf[8]);
> -
> -	return 0;
> +err:
> +	mutex_unlock(&tdev->lock);
> +	return ret;
>  }
>  
>  static int thingm_version(struct thingm_device *tdev)
> @@ -104,10 +118,6 @@ static int thingm_version(struct thingm_device *tdev)
>  	u8 buf[REPORT_SIZE] = { REPORT_ID, 'v', 0, 0, 0, 0, 0, 0, 0 };
>  	int err;
>  
> -	err = thingm_send(tdev, buf);
> -	if (err)
> -		return err;
> -
>  	err = thingm_recv(tdev, buf);
>  	if (err)
>  		return err;
> @@ -135,14 +145,10 @@ static int thingm_led_set(struct led_classdev *ldev,
>  	struct thingm_led *led = container_of(ldev, struct thingm_led, ldev);
>  	int ret;
>  
> -	mutex_lock(&led->rgb->tdev->lock);
> -
>  	ret = thingm_write_color(led->rgb);
>  	if (ret)
>  		hid_err(led->rgb->tdev->hdev, "failed to write color\n");
>  
> -	mutex_unlock(&led->rgb->tdev->lock);
> -
>  	return ret;
>  }
>  
> -- 
> 2.7.1
> 
