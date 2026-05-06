Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC54331A76
	for <linux-input@vger.kernel.org>; Wed,  6 May 2026 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105909; cv=none; b=qIWkIKWRrGvzGRacMk2rEhQ/S8Sr+p1zu9nCiBBUpjDcg+wTKmbEAz3mST6U9OIlfxnTYEOfagF6jWxEM1v+QjZU1Yl6BAfUT4zimb9MxCZp0lI4RvpyovLLRUvMjZGbPH+0I0OEHLkYlLL8UWeBXto/EIRV6n7OVRk+7zY7JeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105909; c=relaxed/simple;
	bh=0RLNI0AFB095KcYZ/F2tAtnonubPf4Fa80XKXUjPv9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PG55PKPsExVtwDgzBVLm9ru5m2XdR6H7nyXyDZbgRMtNZEwo+LPOhYifeIx8n29LuSeClgXmPG1DUmVE1cZtpUk708FIwFoXzlM9fvpf0KLvrxZLwKJgEwBwaZ7fhg+/GSPzUGRZpQ+69iCDV4TUkyn14q55qm/EcVvDP4lijkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VP1bskUc; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VP1bskUc"
Message-ID: <9b568ce0-93f7-4a7f-98e4-625e910f8a1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778105892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+jcphnwXXp3flt9xTy4KQpmtdfXWmyEhR7s7osQqBA=;
	b=VP1bskUcJd8YinLCM+OJNPY6M1MHLTYQ/3m5nv71wixIMiUBfq5Kw7nOZvYZUS0Izl204i
	SfKUOXjWnxwh34JDV3Wrnp1r/7jDwha/Ur8gXlzBT3bcTN+kPLDbRmSc49j/WHa1N8gMgf
	ThuCih4ouTweKod5+BGpzBoxWX0M8iM=
Date: Thu, 7 May 2026 00:17:59 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] HID: asus: export asus_hid_fnlock_notify() for
 direct fn-lock control
To: =?UTF-8?Q?Marcus_Gren=C3=A4ngen?= <marcus@grenangen.se>,
 platform-driver-x86@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 luke@ljones.dev, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 jikos@kernel.org, bentiss@kernel.org, corentin.chary@gmail.com
References: <458d9e6c-8702-4cbc-9c4f-33cbd1175e67@linux.dev>
 <20260506193326.5862-1-marcus@grenangen.se>
 <20260506193326.5862-2-marcus@grenangen.se>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260506193326.5862-2-marcus@grenangen.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/6/26 21:33, Marcus Grenängen wrote:
> Some ASUS platforms cannot control fn-lock via WMI DEVS and must send a
> HID feature report directly to the N-Key keyboard device instead.
>
> Add a module-level fnlock_hdev pointer (protected by a mutex) that is set
> at probe time for devices with QUIRK_HID_FN_LOCK and cleared at remove.
> Export asus_hid_fnlock_notify(bool) so that asus-armoury can call into
> hid-asus without a circular dependency.
>
> Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
> ---
>  drivers/hid/hid-asus.c                     | 43 +++++++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h |  5 +++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d34d74df3dc0..8a51dacf35eb 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -584,6 +584,38 @@ static void asus_sync_fn_lock(struct work_struct *work)
>  	asus_kbd_set_fn_lock(drvdata->hdev, drvdata->fn_lock);
>  }
>  
> +/*
> + * Module-level reference to the HID device that handles fn-lock via feature
> + * report. Set at probe and cleared at remove for QUIRK_HID_FN_LOCK devices.
> + * Protected by fnlock_hdev_lock.
> + */
> +static DEFINE_MUTEX(fnlock_hdev_lock);
> +static struct hid_device *fnlock_hdev;
> +
> +/**
> + * asus_hid_fnlock_notify() - Set fn-lock state directly via HID feature report.
> + * @enabled: true to lock fn (F1-F12 primary), false to unlock.
> + *
> + * Called by asus-armoury on platforms where the WMI DEVS path for fn-lock is
> + * non-functional (e.g. ASUS ProArt P16, N-Key keyboard product ID 0x19B6).
> + *
> + * Returns 0 on success, -ENODEV if no fn-lock capable HID device is present.
> + */
> +int asus_hid_fnlock_notify(bool enabled)
Generally I see _notify naming being used for internal kernel
messaging or to notify the sysfs of a change, can you change
the name of this to something like asus_hid_fnlock_enable()
or asys_hid_fnlock_set()?
> +{
> +	int ret = -ENODEV;
> +
> +	guard(mutex)(&fnlock_hdev_lock);
> +	if (fnlock_hdev) {
> +		ret = asus_kbd_set_fn_lock(fnlock_hdev, enabled);
> +		/* hid_hw_raw_request returns byte count on success; normalise to 0 */
The pattern I see most ofter used is

ret = operation()
if (ret < 0)
   return ret;

return 0;

IMHO much easier to read and doesn't need a comment to explain.
> +		if (ret > 0)
> +			ret = 0;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(asus_hid_fnlock_notify);
> +
>  static void asus_schedule_work(struct asus_kbd_leds *led)
>  {
>  	unsigned long flags;
> @@ -969,6 +1001,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  		drvdata->fn_lock = true;
>  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>  		asus_kbd_set_fn_lock(hdev, true);
> +		guard(mutex)(&fnlock_hdev_lock);
> +		fnlock_hdev = hdev;
>  	}
>  
>  	if (drvdata->tp) {
> @@ -1008,6 +1042,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  		drvdata->fn_lock = true;
>  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>  		asus_kbd_set_fn_lock(hdev, true);
> +		guard(mutex)(&fnlock_hdev_lock);
> +		fnlock_hdev = hdev;
>  	}
>  
>  	return 0;
> @@ -1362,8 +1398,13 @@ static void asus_remove(struct hid_device *hdev)
>  		cancel_work_sync(&drvdata->kbd_backlight->work);
>  	}
>  
> -	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
> +	if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> +		scoped_guard(mutex, &fnlock_hdev_lock) {
> +			if (fnlock_hdev == hdev)
> +				fnlock_hdev = NULL;
> +		}
>  		cancel_work_sync(&drvdata->fn_lock_sync_work);
> +	}
>  
>  	hid_hw_stop(hdev);
>  }
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 554f41b827e1..20facd5da74e 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -196,6 +196,7 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval);
>  int asus_hid_register_listener(struct asus_hid_listener *cdev);
>  void asus_hid_unregister_listener(struct asus_hid_listener *cdev);
>  int asus_hid_event(enum asus_hid_event event);
> +int asus_hid_fnlock_notify(bool enabled);
>  #else
>  static inline void set_ally_mcu_hack(enum asus_ally_mcu_hack status)
>  {
> @@ -227,6 +228,10 @@ static inline int asus_hid_event(enum asus_hid_event event)
>  {
>  	return -ENODEV;
>  }
> +static inline int asus_hid_fnlock_notify(bool enabled)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */
