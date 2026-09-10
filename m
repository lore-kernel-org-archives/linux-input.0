Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B65496D4D
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071301; cv=none; b=FV9JKrJqV+MU7isSfkzQbJUg4OSIkwnTLf5olueOn56japOKBsmQlmBP6UslVaMVRtaxEmk7OEYRNRHFxqpvdmx8JId9m7erttaGDNw2KKP3c9Bk/RF2TQg4RNIa91AjHsVF023gr/lUHDb7Fen1H18ls+5MiE5KBchuIKxeyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071301; c=relaxed/simple;
	bh=3JfMjcL3TjwifMoTOhz947nuR1JuljzjS3B7u8xLlM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkHsvPuXHRzaPf/zpVQVAJLxtlJj4Z+othpVa30cQtAWmK9rJDaTu1+aNNJhbXk+muYq8e4Ya41P9l5Rd/0qxRzQOZlsKljCFE0aVflYasG14vaPZXQXk7CVrO0lAqsBDnhSeIbz792NQHaXsXm8Fw7rpCPsl+NyzOLQk1aH3U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9eLUuSn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9eLUuSn"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d6efd73032so13841735ad.0
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789071296; x=1789676096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7uKprB+h3ngZbp+GZpW+cGpHu1N3q8AXMZNCBK5sCMs=;
        b=O9eLUuSn13f7ykDaDWoIsXJMCAmPg0ER0aRI3aoNbjbT9nXMOJuVTHulRmfeL50Ibx
         u9gxbLdQWCDGWwUZ1/14vmsETJia+kD9qgr4zFQT6FZhs3oJH5A30tdrWQFj6m+4IPA3
         gvQcrHTECPiItHTcYFqS+/dnaTp8Onh+JieV3EZam79n5gO1m8hK4CZ4QCo6WE8D0YoK
         ApPXo6+p29AUtm00oal+x0V9JO7cnwLEQp2V0K+/UqeKCAgqKexSYkZ8p80Z7SwaARnQ
         Lw9ZIbiwlzJk3hdC9drMW6CE4urwNzu4k247/1bxl5byuKei2AThX6qPRvk0yEWypLay
         nDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071296; x=1789676096;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7uKprB+h3ngZbp+GZpW+cGpHu1N3q8AXMZNCBK5sCMs=;
        b=UQ1Iwb6oq7kUmjWSNO4n0K4eLk6QMNUftssr3ba+GJAJjP5a7mtnCdifIk3Q7JPjkF
         vLFasWJIOaYawALQwUa/sSXMM/YWjusCLh8oQRLj7khWODAiJH1EI5GZU78beSX7JLHi
         gynEpx78xWAQnHe703/dXAbx2WemRHbblYy1ruOmbstAu1txfRE50O1A3oWV7ULjXrsP
         0ga31N/aXAyUcN2kKcUf9r6kA0G8Rs0TcIXenvq2RwCvntsZRQzSwRDsYkfevB/FRzhD
         d4L7XZ6rqJ6bOEn+zqYjsPfowI7aWUsCUNLXusMxNnNPPfSRFbFI6Wls61OvsHh0h7Q/
         AqXA==
X-Gm-Message-State: AFuF++nlcgXi0lkLO3wqFI2q9aZqLk8Sk4j0wAD+o7Xq1yhwqKWtpgVa
	ua5IERLJoDcrDtYhRakUyOwhn7CUI7thcizmmD7CaojCWn8xhryhJ3/Z
X-Gm-Gg: AYBFou2a8Rh8/n5HgaWQ1BprfycoH+pzx3ItbituZ0pFFqRfZO0JfwNGiVkNKHLyqo7
	zP+r/OIgc9BSbMpGja7jw5fAbY7/yOegttfxyc6ZpiIO4CRNjd7AVgKkinSFR136VlSUQEFriQW
	On8PBR1EIUF69/3b3uMGWeX1Q67D3AXwLjltabEbbCSIfhx+8JPpy+TWGuyDM+8cpmyqRrdu4ix
	UJuzSSHR3hVipFKFQqaWpur9C8r8MHhXzsszzHwW1VFd0RjTMHNbNWDavcaiEgrgROQo5Z23VVf
	Ogj9lkOvBLwp9ysAQjSrimCPpnf21jmy/+nCU61/rRa5pDXagvAIxCbIMaZKSBn7SeF2nbIFx43
	pWxFLLnm8BozUXvA0LtizKVMXqgKMi3dTbwsAXsgVHt+Aa3G8k2ej89oj2nclLzjbcNeXlzlvLK
	56QqI5cVtMzBC2dyvmnTryVwml9EL7DZnhNxJ+ZxhSObjmqDX96P6MZbH/BV+AIQHjJZCGPNZHe
	o15N1AuxiRAvnozSFSLkU+whrhkWohXXK1t4rdJeMleHz9Yg0AXt73Fo6kc0aJOdxd6bJnRfH1h
X-Received: by 2002:a17:903:2d2:b0:2d8:d4d2:d136 with SMTP id d9443c01a7336-2dd0ee981d3mr74221065ad.18.1789071296498;
        Thu, 10 Sep 2026 13:14:56 -0700 (PDT)
Received: from [192.168.0.158] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fbd424sm440196eec.31.2026.09.10.13.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:14:56 -0700 (PDT)
Message-ID: <5063b29c-e686-472c-8b80-c6c68def0d0e@gmail.com>
Date: Thu, 10 Sep 2026 13:14:54 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] HID: hid-oxp: handle controller reinitialization
 across suspend
To: Andrei Aldea <andrei1998@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-leds@vger.kernel.org
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-11-andrei1998@gmail.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260910032115.28669-11-andrei1998@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:21, Andrei Aldea wrote:
> A Gen2 monocolor reply uses the same command value as the asynchronous MCU
> reset notification. Treating every such report as a reset can schedule a
> spurious controller reinitialization.
>
> Track an outstanding monocolor write by command and zone under a per-HID
> spinlock, and consume its matching acknowledgment before considering the
> report a reset notification. Clear pending reply state during suspend and
> teardown. A missing reply does not change legacy transport success
> semantics.
>
> For system suspend, disable and drain initialized configuration work and
> reject new output while the device is suspended. Re-enable work on resume
> and queue a fallback reinitialization after the documented MCU reset
> interval. A qualifying reset notification can still bring that work
> forward. Leave runtime autosuspend unchanged.
>
> Fixes: 2f424f28fb39 ("HID: hid-oxp: Add Second Generation Gamepad Mode Switch")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
> ---
>   drivers/hid/hid-oxp.c | 116 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 107 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 7b36687..e26e6a9 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -16,6 +16,7 @@
>   #include <linux/kstrtox.h>
>   #include <linux/led-class-multicolor.h>
>   #include <linux/mutex.h>
> +#include <linux/spinlock.h>
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
> @@ -24,6 +25,7 @@
>   
>   #define OXP_PACKET_SIZE 64
>   #define OXP_STATUS_HEADER_SIZE 6
> +#define OXP_STATUS_ACK 0x20
>   
>   #define GEN1_MESSAGE_ID	0xff
>   #define GEN2_MESSAGE_ID	0x3f
> @@ -185,6 +187,10 @@ struct oxp_hid_cfg {
>   	struct hid_device *hdev;
>   	struct mutex cfg_mutex; /*ensure single synchronous output report*/
>   	struct mutex rgb_mutex; /*serialize complete RGB transactions*/
> +	spinlock_t rgb_reply_lock;
> +	u8 rgb_reply_command;
> +	u8 rgb_reply_zone;
> +	bool rgb_reply_pending;
>   	u8 rgb_brightness;
>   	u8 gamepad_mode;
>   	u8 rumble_intensity;
> @@ -193,6 +199,7 @@ struct oxp_hid_cfg {
>   	u8 rgb_en;
>   	bool rgb_work_initialized;
>   	bool gen2_work_initialized;
> +	bool suspended;
>   	bool removing;
>   };
>   
> @@ -371,7 +378,7 @@ static void oxp_mcu_init_fn(struct work_struct *work)
>   	u8 gp_mode_data[3] = { OXP_GP_MODE_DEBUG, 0x01, 0x02 };
>   	int ret;
>   
> -	if (READ_ONCE(cfg->removing))
> +	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
>   		return;
>   
>   	/* Re-apply the button mapping */
> @@ -410,6 +417,7 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
>   	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
>   	struct led_classdev_mc *led_mc = cfg->led_mc;
>   	struct oxp_gen_2_rgb_report *rgb_rep;
> +	bool solicited = false;
>   
>   	if (size < OXP_STATUS_HEADER_SIZE)
>   		return 0;
> @@ -417,11 +425,26 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
>   	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
>   		return 0;
>   
> +	/* A monocolor acknowledgment is not an MCU reset notification. */
> +	if (data[5] == OXP_STATUS_ACK) {
> +		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
> +			if (cfg->rgb_reply_pending &&
> +			    data[3] == cfg->rgb_reply_command &&
> +			    data[4] == cfg->rgb_reply_zone) {
> +				cfg->rgb_reply_pending = false;
> +				solicited = true;
> +			}
> +		}
> +		if (solicited)
> +			return 0;
> +	}
> +
>   	/* Sent ~6s after resume event, indicating the MCU has fully reset.
>   	 * Re-apply our settings after this has been received.
>   	 */
>   	if (data[3] == OXP_EFFECT_MONO_TRUE) {
>   		if (READ_ONCE(cfg->gen2_work_initialized) &&
> +		    !READ_ONCE(cfg->suspended) &&
>   		    !READ_ONCE(cfg->removing))
>   			mod_delayed_work(system_dfl_wq, &cfg->oxp_mcu_init,
>   					 msecs_to_jiffies(50));
> @@ -489,6 +512,7 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_s
>   			    size_t data_size, u8 *footer, size_t footer_size)
>   {
>   	unsigned char *dmabuf __free(kfree) = kzalloc(OXP_PACKET_SIZE, GFP_KERNEL);
> +	bool rgb_write;
>   	int ret;
>   
>   	if (!dmabuf)
> @@ -500,6 +524,19 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_s
>   	guard(mutex)(&cfg->cfg_mutex);
>   	if (READ_ONCE(cfg->removing))
>   		return -ENODEV;
> +	if (READ_ONCE(cfg->suspended))
> +		return -EHOSTDOWN;
> +
> +	rgb_write = header_size && data_size > 1 &&
> +		    header[0] == OXP_FID_GEN2_STATUS_EVENT &&
> +		    data[0] == OXP_EFFECT_MONO_TRUE;
> +	if (rgb_write) {
> +		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
> +			cfg->rgb_reply_command = data[0];
> +			cfg->rgb_reply_zone = data[1];
> +			cfg->rgb_reply_pending = true;
> +		}
> +	}
>   
>   	memcpy(dmabuf, header, header_size);
>   	memcpy(dmabuf + header_size, data, data_size);
> @@ -509,12 +546,18 @@ static int mcu_property_out(struct oxp_hid_cfg *cfg, u8 *header, size_t header_s
>   	dev_dbg(&cfg->hdev->dev, "raw data: [%*ph]\n", OXP_PACKET_SIZE, dmabuf);
>   
>   	ret = hid_hw_output_report(cfg->hdev, dmabuf, OXP_PACKET_SIZE);
> -	if (ret < 0)
> -		return ret;
> -
>   	/* MCU takes 200ms to be ready for another command. */
>   	msleep(200);
> -	return ret == OXP_PACKET_SIZE ? 0 : -EIO;
> +	if (ret >= 0)
> +		ret = ret == OXP_PACKET_SIZE ? 0 : -EIO;
> +
> +	if (rgb_write) {
> +		scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
> +			cfg->rgb_reply_pending = false;
> +		}
> +	}
> +
> +	return ret;
>   }
>   
>   static int oxp_gen_1_property_out(struct oxp_hid_cfg *cfg, enum oxp_function_index fid, u8 *data,
> @@ -748,7 +791,7 @@ static void oxp_btn_queue_fn(struct work_struct *work)
>   					      struct oxp_hid_cfg, oxp_btn_queue);
>   	int ret;
>   
> -	if (READ_ONCE(cfg->removing))
> +	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
>   		return;
>   
>   	ret = oxp_set_buttons(cfg);
> @@ -837,7 +880,7 @@ static ssize_t map_button_store(struct device *dev,
>   	default:
>   		return -EINVAL;
>   	}
> -	if (!READ_ONCE(cfg->removing))
> +	if (!READ_ONCE(cfg->suspended) && !READ_ONCE(cfg->removing))
>   		mod_delayed_work(system_dfl_wq, &cfg->oxp_btn_queue,
>   				 msecs_to_jiffies(50));
>   	return count;
> @@ -1413,7 +1456,7 @@ static void oxp_rgb_queue_fn(struct work_struct *work)
>   	u8 val = 4 * brightness / max_brightness;
>   	int ret;
>   
> -	if (READ_ONCE(cfg->removing))
> +	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
>   		return;
>   
>   	guard(mutex)(&cfg->rgb_mutex);
> @@ -1442,7 +1485,7 @@ static void oxp_rgb_brightness_set(struct led_classdev *led_cdev,
>   	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(led_cdev);
>   	struct oxp_hid_cfg *cfg = container_of(mc_cdev, struct oxp_hid_cfg, cdev);
>   
> -	if (READ_ONCE(cfg->removing))
> +	if (READ_ONCE(cfg->suspended) || READ_ONCE(cfg->removing))
>   		return;
>   
>   	led_cdev->brightness = brightness;
> @@ -1554,6 +1597,9 @@ static void oxp_drain_output(struct oxp_hid_cfg *cfg)
>   static void oxp_quiesce_work(struct oxp_hid_cfg *cfg)
>   {
>   	WRITE_ONCE(cfg->removing, true);
> +	scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
> +		cfg->rgb_reply_pending = false;
> +	}
>   	if (cfg->rgb_work_initialized)
>   		disable_delayed_work_sync(&cfg->oxp_rgb_queue);
>   	if (cfg->gen2_work_initialized) {
> @@ -1584,6 +1630,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
>   	cfg->hdev = hdev;
>   	mutex_init(&cfg->cfg_mutex);
>   	mutex_init(&cfg->rgb_mutex);
> +	spin_lock_init(&cfg->rgb_reply_lock);
>   
>   	/* Clear drvdata after registered callback objects have been released. */
>   	hid_set_drvdata(hdev, cfg);
> @@ -1714,6 +1761,54 @@ static void oxp_hid_remove(struct hid_device *hdev)
>   	hid_hw_stop(hdev);
>   }
>   
> +static int __maybe_unused oxp_hid_suspend(struct hid_device *hdev,
> +					  pm_message_t message)
> +{
> +	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
> +
> +	if (!cfg || PMSG_IS_AUTO(message))
> +		return 0;
> +
> +	WRITE_ONCE(cfg->suspended, true);
> +	scoped_guard(spinlock_irqsave, &cfg->rgb_reply_lock) {
> +		cfg->rgb_reply_pending = false;
> +	}
> +	if (cfg->rgb_work_initialized)
> +		disable_delayed_work_sync(&cfg->oxp_rgb_queue);
> +	if (cfg->gen2_work_initialized) {
> +		disable_delayed_work_sync(&cfg->oxp_btn_queue);
> +		disable_delayed_work_sync(&cfg->oxp_mcu_init);
> +	}
> +	oxp_drain_output(cfg);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused oxp_hid_resume(struct hid_device *hdev)
> +{
> +	struct oxp_hid_cfg *cfg = hid_get_drvdata(hdev);
> +
> +	if (!cfg || !READ_ONCE(cfg->suspended) ||
> +	    READ_ONCE(cfg->removing))
> +		return 0;
> +
> +	if (cfg->rgb_work_initialized)
> +		enable_delayed_work(&cfg->oxp_rgb_queue);
> +	if (cfg->gen2_work_initialized) {
> +		enable_delayed_work(&cfg->oxp_btn_queue);
> +		enable_delayed_work(&cfg->oxp_mcu_init);
> +	}
> +	WRITE_ONCE(cfg->suspended, false);
> +	if (!cfg->gen2_work_initialized)
> +		return 0;
> +
> +	/* Allow the controller MCU to finish rebooting before restoring state. */
> +	queue_delayed_work(system_dfl_wq, &cfg->oxp_mcu_init,
> +			   msecs_to_jiffies(6500));
> +
> +	return 0;
> +}
> +
>   static const struct hid_device_id oxp_devices[] = {
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CRSC, USB_DEVICE_ID_ONEXPLAYER_GEN1) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_WCH, USB_DEVICE_ID_ONEXPLAYER_GEN2) },
> @@ -1727,6 +1822,9 @@ static struct hid_driver hid_oxp = {
>   	.probe = oxp_hid_probe,
>   	.remove = oxp_hid_remove,
>   	.raw_event = oxp_hid_raw_event,
> +	.suspend = pm_ptr(oxp_hid_suspend),
> +	.resume = pm_ptr(oxp_hid_resume),
> +	.reset_resume = pm_ptr(oxp_hid_resume),
>   };
>   module_hid_driver(hid_oxp);
>   

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
