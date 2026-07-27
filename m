Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F5217F27
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186123; cv=none; b=i4Rc8wNccSvVVMkDAZIAuKLBEfkDgK1vz1UGgC+DFb2sq5wz1GgAfNAL7o+/VZzWtWtRBDScAG0juY18ifmOnpcghInMkb56s5CTBWX4JpjT8bOeWvojjFrBnvTCCNZw+QliIE539mbhd1izhpahwvLlwuL0xj/r/TBtOVb052I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186123; c=relaxed/simple;
	bh=zmKlsXzHHQvXRtPNHD4rdYc95qGUg0SprQfiY1tcqOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YS3iB+NrdeafQ0tS5lW1Boutvs/jxO8maOABsCz6QBY+7EKlXCasVJTfYfxirZrw1pAS0RwEijwFczMUWyXQ3yh+V4II3scOfXhYyg4zAbntuMGvVN3ySuL87tdTGFTRvhBz0mPZDKfs28hjXh6aBI32W3uq8CMeWkCG2LTXdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RjVKT2YQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RjVKT2YQ"
Message-ID: <583d411e-07c8-45f7-9919-c01247cad718@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785186118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFH0Uadlc10pZ/VQm8kqDe/uQo18rRyQM/o0zQy554Q=;
	b=RjVKT2YQQLtyj4XdFbCzNUMNoCCVvja/QsqDfBm8GNuLP/4sF2v2roI7GxNeZXT/VOqe6r
	NfmdDLRnZ039y0u2fnmB/4+xtkR6ZTtAEIXjA1CAOhotnByhEWmr6G1xtgcKSHd+e+q7lt
	E3IQF5ehoBTyyypFiKMtvjKPXBZhSNs=
Date: Mon, 27 Jul 2026 23:01:55 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] HID: asus: export asus_hid_fnlock_set() for direct
 fn-lock control
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Marcus_Gren=C3=A4ngen?= <marcus@grenangen.se>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, luke@ljones.dev,
 Hans de Goede <hansg@kernel.org>, jikos@kernel.org, bentiss@kernel.org,
 corentin.chary@gmail.com
References: <9b568ce0-93f7-4a7f-98e4-625e910f8a1d@linux.dev>
 <20260507092911.8855-1-marcus@grenangen.se>
 <20260507092911.8855-2-marcus@grenangen.se>
 <ad587675-cef3-f5b5-eb39-0f76dea8d617@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <ad587675-cef3-f5b5-eb39-0f76dea8d617@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/27/26 13:09, Ilpo Järvinen wrote:
> On Thu, 7 May 2026, Marcus Grenängen wrote:
>
>> Some ASUS platforms cannot control fn-lock via WMI DEVS and must send a
>> HID feature report directly to the N-Key keyboard device instead.
>>
>> Add a module-level fnlock_hdev pointer (protected by a mutex) that is set
>> at probe time for devices with QUIRK_HID_FN_LOCK and cleared at remove.
>> Export asus_hid_fnlock_set(bool) so that asus-armoury can call into
>> hid-asus without a circular dependency.
>>
>> Signed-off-by: Marcus Grenängen <marcus@grenangen.se>
>> ---
>>  drivers/hid/hid-asus.c                     | 44 +++++++++++++++++++++-
>>  include/linux/platform_data/x86/asus-wmi.h | 15 ++++++++
>>  2 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index d34d74df3dc0..402ba9d5e982 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -584,6 +584,39 @@ static void asus_sync_fn_lock(struct work_struct *work)
>>  	asus_kbd_set_fn_lock(drvdata->hdev, drvdata->fn_lock);
>>  }
>>  
>> +/*
>> + * Module-level reference to the HID device that handles fn-lock via feature
>> + * report. Set at probe and cleared at remove for QUIRK_HID_FN_LOCK devices.
>> + * Protected by fnlock_hdev_lock.
>> + */
>> +static DEFINE_MUTEX(fnlock_hdev_lock);
>> +static struct hid_device *fnlock_hdev;
>> +
>> +/**
>> + * asus_hid_fnlock_set() - Set fn-lock state directly via HID feature report.
>> + * @enabled: true to lock fn (F1-F12 primary), false to unlock.
>> + *
>> + * Called by asus-armoury on platforms where the WMI DEVS path for fn-lock is
>> + * non-functional (e.g. ASUS ProArt P16, N-Key keyboard product ID 0x19B6).
>> + *
>> + * Returns: 0 on success, -ENODEV if no fn-lock capable HID device is present.
>> + */
>> +int asus_hid_fnlock_set(bool enabled)
>> +{
>> +	int ret;
>> +
>> +	guard(mutex)(&fnlock_hdev_lock);
>> +	if (!fnlock_hdev)
>> +		return -ENODEV;
>> +
>> +	ret = asus_kbd_set_fn_lock(fnlock_hdev, enabled);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(asus_hid_fnlock_set);
>> +
>>  static void asus_schedule_work(struct asus_kbd_leds *led)
>>  {
>>  	unsigned long flags;
>> @@ -969,6 +1002,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>  		drvdata->fn_lock = true;
>>  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>>  		asus_kbd_set_fn_lock(hdev, true);
>> +		guard(mutex)(&fnlock_hdev_lock);
>> +		fnlock_hdev = hdev;
>>  	}
>>  
>>  	if (drvdata->tp) {
>> @@ -1008,6 +1043,8 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>  		drvdata->fn_lock = true;
>>  		INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
>>  		asus_kbd_set_fn_lock(hdev, true);
>> +		guard(mutex)(&fnlock_hdev_lock);
>> +		fnlock_hdev = hdev;
> What's going on with this patch? Why this context appears more than once 
> on different lines???
Hi Ilpo,

I think this patch has been taken by HID already as I had to resolve another issue with it:
mutex usage in atomic context; you can read out more here:
https://lore.kernel.org/all/20260619001103.1189200-2-denis.benato@linux.dev/

The main idea as I understood it is that to activate the fn key, do things, and then
deactivate it: the problem in this logic comes from the fact that using true both time
is very likely an oversight and it should have been true -> false.

I requested clarification too but still haven't got any response yet.

Let me know if I can do something.

Thanks,
Denis
> I even wasted my time on checking what hid tree has queued, and came up 
> zero explanation (as expected).
>
> --
>  i.
