Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518042;
	b=pjTcrQgHi8zMgR99wURU6cakFNgqyNKw0iuhChVH6EXr2MlctGVIJ7GuN35YiqBxnhK+
	 tn9mwqBQReGUDGiNGJ+LRB8MzqfjI0FeICxPkWVZM7/iPrUCqQpsx3rfDttKwUSBDZd2y
	 Q4gMHdqijACKvWvlp6yrWtSGBA+6DeUt7yq5eV5M0SJBE+mXT1wzPGVJioVi061xZCqT5
	 zrp6qCpr+5RiGC413bq8CYbdPCxywG7pTnPuQ2qlg5B23DOYuIJiYt6NAjiVdJmUxKJfg
	 llFjt3oHoheHiZYJVgFR+NBu68KPzEZibWSR9aNAm2y/F7LTtC8gH3qWh8KF8chOBSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518042;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5IYWlKU/+GIYUf9F6hGp4MUFuJ1Vt60C6AuwwvbF+oE=;
	b=Lr039qAbaqyJtdijfKNwGoYW7HdyyDcg0h6L3HxVjvkmDc1DDbvarlnQ1cYoKVu+9aNU
	 vXXMaSZrXfgQGbrJ/h4MOUr0KVELQj23T5S32bVVCdjtqooVKXtz9e6w/GJSXYxqBbTu7
	 l9vDu07PCQEONODYAVU+hc0v40w8E1YqQwBS584XJrSg9FoC1zNiyRGmG1vmuzyGQaCQn
	 EYfne9KXvoFbst0mn8HhfCXYV4GdKAGSJKt8r1z8QWxi8lja8LIzV0+20Ev52imSiJsG9
	 Kmje9x7RUit2OfalwbcQ650mdmrBY1dVTV6W+S7WeS+PKOLV5gNiOAqFgGUkJ7M8PTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H2gI7OoJ;
	arc=none smtp.remote-ip=91.218.175.69
Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC8606A31D
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 17:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23DC8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H2gI7OoJ
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Rh/cC8ZvY1Vao3rvQEGNOIl3J6ScWWAHxRYKzyJgniQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792518040; v=1; x=1793122840;
 b=H2gI7OoJcw8ByckXEa+nm8nZH3mmGQqA4ETS2Ib3gyOgXtB0gqUVgpv/2OHK13kQDr/jqGdw
 W2/vyVVM6Dxnkd09ur5BoAr+JsjxVER/d05mw7PKyLodkVYvn8GVQD2VnjA6/H/DscojwchaP3j
 9E0Ze/HXEYhfe7qzmS4eapoE=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 961cfeb885f0235b;
	Tue, 20 Oct 2026 17:40:33 +0000
X-Mizu-Trace-ID: 961cfeb885f0235b
X-Migadu-Flow: FLOW_OUT
Message-ID: <bf782ca7-f248-4048-bd55-5aa355932b3b@linux.dev>
Date: Tue, 20 Oct 2026 19:40:32 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] HID: asus: Cycle the platform profile from the
 Zenbook Duo profile key
To: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
 Nathan Chancellor <nathan@kernel.org>
References: <20261020092423.36380-1-p.pisati@gmail.com>
 <20261020092423.36380-5-p.pisati@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261020092423.36380-5-p.pisati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/20/26 11:24, Paolo Pisati wrote:
> From: Joshua Leivenzon <hacker1024@users.sourceforge.net>
>
> The Zenbook Duo keyboard reports Fn+F, the performance mode key, as
> vendor usage 0x9d. On the built-in keyboards of other ASUS laptops the
> same key arrives through asus-wmi, which cycles the platform profile
> in response. Do the same here so the key works on the detachable
> keyboard too. Other ASUS devices may use the same usage for something
> else, so only handle it on the Zenbook Duo keyboards.
>
> asus_event() runs from the HID input path, which for USB is the URB
> completion handler, while platform_profile_cycle() takes a mutex, so run
> it from the driver's worker like the Fn-lock toggle, and consume the
> event. Queue at most one cycle at a time, so that a device repeating the
> key cannot grow the worker's list. Only call it when the platform
> profile class is reachable: it is not built on architectures without
> ACPI, where HID_ASUS still is, and it may be a module while HID_ASUS is
> built in.

Reviewed-by: Denis Benato <denis.benato@linux.dev>

> Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
> [pisati: defer platform_profile_cycle() to the worker and queue at
>  most one cycle, only handle the usage on Zenbook Duo keyboards, return
>  1 from asus_event() instead of propagating its return value, and
>  guard the call with IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE)]
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 68211ebe1290..739637f1964a 100644
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
> @@ -117,6 +118,7 @@ enum asus_work_action_type {
>  	FN_LOCK_SYNC,
>  	BRIGHTNESS_SET,
>  	WMI_FAN,
> +	PLATFORM_PROFILE_CYCLE,
>  };
>  
>  struct hid_raw_event_data {
> @@ -431,6 +433,36 @@ static int asus_kbd_fn_lock_set(struct asus_drvdata *drvdata, bool enabled)
>  	return 0;
>  }
>  
> +static int asus_platform_profile_cycle(struct asus_drvdata *drvdata)
> +{
> +	struct asus_worker *worker = drvdata->worker;
> +	struct asus_work_action *action, *pending;
> +
> +	if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&worker->lock);
> +
> +	/*
> +	 * One pending cycle is enough: a key press cannot outrun the
> +	 * worker, and a device repeating the key must not grow the list.
> +	 */
> +	list_for_each_entry(pending, &worker->actions, node) {
> +		if (pending->type == PLATFORM_PROFILE_CYCLE)
> +			return 0;
> +	}
> +
> +	action = kzalloc_obj(struct asus_work_action, GFP_ATOMIC);
> +	if (!action)
> +		return -ENOMEM;
> +
> +	action->type = PLATFORM_PROFILE_CYCLE;
> +	INIT_LIST_HEAD(&action->node);
> +	asus_worker_schedule(worker, action);
> +
> +	return 0;
> +}
> +
>  static int asus_kbd_wmi_fan_send(struct asus_drvdata *drvdata, u8 *report_data,
>  				 size_t report_size)
>  {
> @@ -467,6 +499,20 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
>  	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR &&
>  	    (usage->hid & HID_USAGE) != 0x00 &&
>  	    (usage->hid & HID_USAGE) != 0xff && !usage->type) {
> +		/* Zenbook Duo Fn+F: cycle the platform profile */
> +		if ((drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) &&
> +		    (usage->hid & HID_USAGE) == 0x9d) {
> +			if (value) {
> +				ret = asus_platform_profile_cycle(drvdata);
> +				if (ret) {
> +					hid_err(hdev, "Failed to cycle the platform profile: %d\n",
> +						ret);
> +					return ret;
> +				}
> +			}
> +			return 1;
> +		}
> +
>  		hid_warn(hdev, "Unmapped Asus vendor usagepage code 0x%02x\n",
>  			 usage->hid & HID_USAGE);
>  	}
> @@ -773,6 +819,7 @@ static void asus_work(struct work_struct *work)
>  	struct asus_worker *worker = container_of(work, struct asus_worker, work);
>  	struct asus_work_action *action = NULL;
>  	unsigned long flags;
> +	int ret;
>  
>  	/*
>  	 * Dequeue the next action, if any. Once teardown has begun .removed
> @@ -801,6 +848,13 @@ static void asus_work(struct work_struct *work)
>  	case WMI_FAN:
>  		asus_kbd_wmi_fan(worker->hdev, &action->data.fan_hid_data);
>  		break;
> +	case PLATFORM_PROFILE_CYCLE:
> +		if (!IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE))
> +			break;
> +		ret = platform_profile_cycle();
> +		if (ret)
> +			hid_dbg(worker->hdev, "Failed to cycle the platform profile: %d\n", ret);
> +		break;
>  	default:
>  		hid_err(worker->hdev, "Invalid action type: %d\n", action->type);
>  		break;
