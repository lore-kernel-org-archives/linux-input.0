Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5485C3C2B8D
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781444065; cv=none; b=CYtfuhn2Y42y+VEB6W74RMy+Ib79eGxZhzNuWprgghuUmGswdh+ehT7JXaHFqp5snP7KkYmY6ZGipRhrTwQ3GXX5+1Uw7IsdbAIJHb5YK7SQv194IGWRJjQLK6MTLTCFHxMuz953TWQeZobI+SDlKg8DvEIUvow45/4veAf167o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781444065; c=relaxed/simple;
	bh=BOS0AkAbU/qpoXM2ZEj9+upVXEgxGhRkzwLx8/LuOKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXcG1z+1qPPZbvQCaE4pKRwAnVfJWkpmDCU9mMyyw+8phpbQj/uFhEwnZOeIZTu6FlkpwNxve2vc6F+A7C82jfCKhtTy0nW1YaA1R3lVQqULcu53UAKBlE+D4s89k1FnSC+4C9iVoEuCctxEALreJnap19EptZNqGB22smk3Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ulJpvvLp; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ulJpvvLp"
Message-ID: <66696080-3601-4d15-8f0f-6850a59cbe9f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781444052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yT4TlFhORyBN+ULuFLfUsjrihYCgkiIYZ5+d1Ua7oFo=;
	b=ulJpvvLpWY96D4uWXcDHa9FH84m5mmIi+za2tI4GLutSigifdBfQR+eE823QFCl8ocAFWc
	3PDMbxdmNBERa36p8boaqIhAyq3HTucIeaONRQvJfng12B+Ds0LO2dHys5fXYbJt+JHkRd
	8RFu2U2R/ABX3yodxGYvlGgr3H8UYhM=
Date: Sun, 14 Jun 2026 15:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/8] HID: asus: avoid sleeping calls in atomic context
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
 Connor Belli <connorbelli2003@gmail.com>, sahiko-bot@kernel.org
References: <20260613153029.2559774-1-denis.benato@linux.dev>
 <20260613153029.2559774-6-denis.benato@linux.dev>
 <CAGwozwHXKosBi23oS8uvVrjr+fKZ+O+yUpHb0oT=acFCgRDwng@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <CAGwozwHXKosBi23oS8uvVrjr+fKZ+O+yUpHb0oT=acFCgRDwng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/13/26 18:15, Antheas Kapenekakis wrote:
> On Sat, 13 Jun 2026 at 17:30, Denis Benato <denis.benato@linux.dev> wrote:
>> Avoid possibly calling asus_wmi_send_event(): a method that can sleep in
>> asus_raw_event() that is called in atomic context.
>>
>> This commit changes when methods are called, not method parameters:
>> the driver behaves as before.
> Observe the new AI guidelines and add assisted by tags if necessary.
> Or write the patches manually for mainline. This sentence is an AI
> euphemism
No AI was harmed during the production of these patches.

TBF I tried, but it changed too much things I didn't want to
change and then I ran out of credits, so.... I decided good old
manual bricolage was better for this.
> Who let 1489a34e97ef through? I implemented the plumbing for WMI
> callbacks with asus_hid_event last year because WMI cannot be called
> through HID. Brightness events had the exact same problem.
> kbd_led_work/kbd_led_update_all could be renamed and used for this. I
> would rather avoid introducing a new work queue. The one I added is
> enough if not too much
Alright, I'll try to use that queue for everything.
> Antheas
>
>> Fixes: 1489a34e97ef ("HID: asus: Implement Fn+F5 fan control key handler")
>> Reported-by: sahiko-bot@kernel.org
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>> ---
>>  drivers/hid/hid-asus.c | 67 +++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 56 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index f38b18ad65c6..a6467172c455 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -150,6 +150,13 @@ struct asus_drvdata {
>>         unsigned long battery_next_query;
>>         struct work_struct fn_lock_sync_work;
>>         bool fn_lock;
>> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
>> +       struct work_struct wmi_work;
>> +       bool wmi_work_disabled;
>> +       u8 wmi_data[FEATURE_KBD_REPORT_SIZE];
>> +       int wmi_size;
>> +       spinlock_t wmi_lock;
>> +#endif
>>         struct asus_xgm_led *xgm_led;
>>  };
>>
>> @@ -338,6 +345,7 @@ static int asus_e1239t_event(struct asus_drvdata *drvdat, u8 *data, int size)
>>         return 0;
>>  }
>>
>> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
>>  /*
>>   * Send events to asus-wmi driver for handling special keys
>>   */
>> @@ -361,6 +369,32 @@ static int asus_wmi_send_event(struct asus_drvdata *drvdata, u8 code)
>>         return 0;
>>  }
>>
>> +static void asus_wmi_work(struct work_struct *work)
>> +{
>> +       struct asus_drvdata *drvdata = container_of(work, struct asus_drvdata, wmi_work);
>> +       u8 report_data[FEATURE_KBD_REPORT_SIZE];
>> +       int report_size;
>> +       unsigned long flags;
>> +       int ret;
>> +
>> +       spin_lock_irqsave(&drvdata->wmi_lock, flags);
>> +       memcpy(report_data, drvdata->wmi_data, drvdata->wmi_size);
>> +       report_size = drvdata->wmi_size;
>> +       spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
>> +
>> +       ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
>> +       if (ret) {
>> +               if (ret != -ENODEV)
>> +                       hid_warn(drvdata->hdev, "Failed to notify asus-wmi: %d\n", ret);
>> +
>> +               /* Fallback: pass the raw event to the HID core */
>> +               hid_report_raw_event(drvdata->hdev, HID_INPUT_REPORT,
>> +                                    report_data, report_size,
>> +                                    report_size, 1);
>> +       }
>> +}
>> +#endif
>> +
>>  static int asus_event(struct hid_device *hdev, struct hid_field *field,
>>                       struct hid_usage *usage, __s32 value)
>>  {
>> @@ -397,6 +431,9 @@ static int asus_raw_event(struct hid_device *hdev,
>>                 struct hid_report *report, u8 *data, int size)
>>  {
>>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
>> +       unsigned long flags;
>> +#endif
>>
>>         if (drvdata->battery && data[0] == BATTERY_REPORT_ID)
>>                 return asus_report_battery(drvdata, data, size);
>> @@ -422,19 +459,18 @@ static int asus_raw_event(struct hid_device *hdev,
>>                          * pass to userspace so it can implement its own fan control.
>>                          */
>>                         if (data[1] == ASUS_FAN_CTRL_KEY_CODE) {
>> -                               int ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
>> -
>> -                               if (ret == 0) {
>> -                                       /* Successfully handled by asus-wmi, block event */
>> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
>> +                               spin_lock_irqsave(&drvdata->wmi_lock, flags);
>> +                               memcpy(drvdata->wmi_data, data, min_t(int, size, sizeof(drvdata->wmi_data)));
>> +                               drvdata->wmi_size = size;
>> +                               spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
>> +
>> +                               if (!drvdata->wmi_work_disabled) {
>> +                                       schedule_work(&drvdata->wmi_work);
>> +                                       /* Successfully handled asynchronously, block event */
>>                                         return -1;
>>                                 }
>> -
>> -                               /*
>> -                                * Warn if asus-wmi failed (but not if it's unavailable).
>> -                                * Let the event reach userspace in all failure cases.
>> -                                */
>> -                               if (ret != -ENODEV)
>> -                                       hid_warn(hdev, "Failed to notify asus-wmi: %d\n", ret);
>> +#endif
>>                         }
>>
>>                         /*
>> @@ -1350,6 +1386,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>                 hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
>>
>>         drvdata->hdev = hdev;
>> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
>> +       INIT_WORK(&drvdata->wmi_work, asus_wmi_work);
>> +       spin_lock_init(&drvdata->wmi_lock);
>> +#endif
>>
>>         if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
>>                 ret = asus_battery_probe(hdev);
>> @@ -1460,6 +1500,11 @@ static void asus_remove(struct hid_device *hdev)
>>         if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
>>
>> +#if IS_REACHABLE(CONFIG_ASUS_WMI)
>> +       drvdata->wmi_work_disabled = true;
>> +       cancel_work_sync(&drvdata->wmi_work);
>> +#endif
>> +
>>         if (drvdata->xgm_led)
>>                 led_classdev_unregister(&drvdata->xgm_led->cdev);
>>
>> --
>> 2.47.3
>>
>>
