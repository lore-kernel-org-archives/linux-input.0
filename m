Received: from mta1.migadu.com (out-252.mta1.migadu.com [95.215.58.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884104D6C5E
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340840; cv=none; b=kURYy7p+LIXLHutKmvqdVDGg05NFD9tw8MsbO4hCmzxGnju1Af1zSmC6oYVZ0Mv9mzem2d1+7n21OFUHNFEGDw5qDusiXctgI5DscVPq6EfdAWal8OH9DbPR4GVYTD5EutOs8JM1vBl720NZFPdVCHUE2Tp0R8Yrk76jlB5f1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340840; c=relaxed/simple;
	bh=fSqrzaDICGEJ0LU/VHMQJYPwzZ2/9uo5D+VsIbLo8uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdOGAW5yH3R8c8wbJ16Z2AlLRJltZEv5jlMe5/NIRP+aWcxvBWBNDPGtrHsAiZQwbGw/n5nZapXhHJnezMwlCzMpJvVAo9mGWFoB085PdeaJlkQiOSf37vG0Jjaeo3el5J9YQzLAtE1XcQgOoO51iI/TmaiiEv8dvZmzeGoHkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLA5eNX2; arc=none smtp.client-ip=95.215.58.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uLA5eNX2"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fSqrzaDICGEJ0LU/VHMQJYPwzZ2/9uo5D+VsIbLo8uk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792340834; v=1; x=1792945634;
 b=uLA5eNX2PZY0qczyYm6Dw3AIwWnKtIsgcIQiVfCD4zeG6NHuacSMTy3RjQ1wC4CR9tAMoUJt
 GU0pVn/dVETdD7aNa8Hq/q/GufuH+aXWFhS/s28+CxPIzMtXz35S15rc48fp5AhRV8+A5VSONpa
 ZdB3kBfl9nGd1tjYWzTqBoGk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eec9daf701e69fdf;
	Sun, 18 Oct 2026 16:27:14 +0000
X-Mizu-Trace-ID: eec9daf701e69fdf
X-Migadu-Flow: FLOW_OUT
Message-ID: <cc579458-5817-47d3-bf80-781e2e68595f@linux.dev>
Date: Sun, 18 Oct 2026 18:27:08 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] HID: asus: Cycle the platform profile from the
 Zenbook Duo profile key
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Nathan Chancellor <nathan@kernel.org>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-5-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261013104033.36079-5-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/26 12:40, Paolo Pisati wrote:
> From: Joshua Leivenzon <hacker1024@users.sourceforge.net>
>
> The Zenbook Duo keyboard reports Fn+F, the performance mode key, as
> vendor usage 0x9d. On the built-in keyboards of other ASUS laptops the
> same key arrives through asus-wmi, which cycles the platform profile
> in response. Do the same here so the key works on the detachable
> keyboard too.
>
> asus_event() runs from the HID input path, which for USB is the URB
> completion handler, while platform_profile_cycle() takes a mutex, so run
> it from the driver's worker like the Fn-lock toggle, and consume the
> event. Queue at most one cycle at a time, so that a device repeating the
> key cannot grow the worker's list. Only call it when the platform
> profile class is reachable: it is not built on architectures without
> ACPI, where HID_ASUS still is, and it may be a module while HID_ASUS is
> built in.
>
> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> [pisati: defer platform_profile_cycle() to the worker and queue at
>  most one cycle, return 1 from asus_event() instead of propagating
>  its return value, and guard the call with
>  IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE)]
> Assisted-by: LLM
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Tested-by: Rebecca Mara Müller <rebecca.mara@posteo.de> # UX8407AA
> ---
>  drivers/hid/hid-asus.c | 67 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index d69431615c27..b127f5c38f60 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -29,6 +29,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
>  #include <linux/power_supply.h>
> +#include <linux/platform_profile.h>
>  #include <linux/leds.h>
>  
>  #include "hid-ids.h"
> @@ -115,6 +116,7 @@ enum asus_work_action_type {
>  	FN_LOCK_SYNC,
>  	BRIGHTNESS_SET,
>  	WMI_FAN,
> +	PLATFORM_PROFILE_CYCLE,
>  };
>  
>  struct hid_raw_event_data {
> @@ -423,6 +425,42 @@ static int asus_kbd_fn_lock_set(struct asus_drvdata *drvdata, bool enabled)
>  	return 0;
>  }
>  
> +static int asus_platform_profile_cycle(struct asus_drvdata *drvdata)
> +{
> +	struct asus_worker *worker = drvdata->worker;
> +	struct asus_work_action *action, *pending;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
> +		return 0;
> +
Isn't IS_REACHABLE a macro? Why not using #if and/or #else ?
> +	spin_lock_irqsave(&worker->lock, flags);
> +
> +	/*
> +	 * One pending cycle is enough: a key press cannot outrun the
> +	 * worker, and a device repeating the key must not grow the list.
> +	 */
> +	list_for_each_entry(pending, &worker->actions, node) {
> +		if (pending->type == PLATFORM_PROFILE_CYCLE)
> +			goto unlock;
> +	}
> +
> +	action = kzalloc_obj(struct asus_work_action, GFP_ATOMIC);
> +	if (!action) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	action->type = PLATFORM_PROFILE_CYCLE;
> +	INIT_LIST_HEAD(&action->node);
> +	asus_worker_schedule(worker, action);
> +
> +unlock:

asus_platform_profile_cycle_unlock please because label names
are unique, not per-function

> +	spin_unlock_irqrestore(&worker->lock, flags);
> +	return ret;
> +}
> +
>  static int asus_kbd_wmi_fan_send(struct asus_drvdata *drvdata, u8 *report_data,
>  				 size_t report_size)
>  {
> @@ -459,8 +497,25 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
>  	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR &&
>  	    (usage->hid & HID_USAGE) != 0x00 &&
>  	    (usage->hid & HID_USAGE) != 0xff && !usage->type) {
> -		hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
> -			 usage->hid & HID_USAGE);
> +		/*
> +		 * Some vendor usages do not map to a key and need special
> +		 * handling.
> +		 */
> +		switch (usage->hid & HID_USAGE) {
> +		case 0x9d: /* Zenbook Duo Fn+F: cycle the platform profile */
> +			if (value) {
> +				ret = asus_platform_profile_cycle(drvdata);
> +				if (ret) {
> +					hid_err(hdev, "Failed to cycle the platform profile: %d\n",
> +						ret);
> +					return ret;
> +				}
> +			}
> +			return 1;
> +		default:
> +			hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
> +				 usage->hid & HID_USAGE);
> +		}

If asus recycles 0x9d to make something else is nome other hardware it will end up
doing something else... It's acceptable I think but perhaps a guard may be better?
After all there is a warn about that already...

>  	}
>  
>  	if (usage->type == EV_KEY && value) {
> @@ -765,6 +820,7 @@ static void asus_work(struct work_struct *work)
>  	struct asus_worker *worker = container_of(work, struct asus_worker, work);
>  	struct asus_work_action *action = NULL;
>  	unsigned long flags;
> +	int ret;
>  
>  	/* Save the action to be performed and clear the flag */
>  	spin_lock_irqsave(&worker->lock, flags);
> @@ -788,6 +844,13 @@ static void asus_work(struct work_struct *work)
>  	case WMI_FAN:
>  		asus_kbd_wmi_fan(worker->hdev, &action->data.fan_hid_data);
>  		break;
> +	case PLATFORM_PROFILE_CYCLE:
> +		if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
> +			break;

As before: #if !IS_REACHABLE(...)

> +		ret = platform_profile_cycle();
> +		if (ret)
> +			hid_dbg(worker->hdev, "Failed to cycle the platform profile: %d\n", ret);
> +		break;
>  	default:
>  		hid_err(worker->hdev, "Invalid action type: %d\n", action->type);
>  		break;
