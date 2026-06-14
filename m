Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47803A3815
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781441729; cv=none; b=AEMinbFDLZPPBOrHRNfgqN5t49P8Uf7s8mQfAoRd0e/IWGxrcuELDI9QCYsA4KV+1RTbYVhSNFuu6GURAJQvm77VR9+7EkdatfF932Il5zP2nHraFTRkXUL4z3iKcgB/vdEJOO9YZ+ztMHYVFFpBlwLsacG5ONtDJ9HQ6BJ35lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781441729; c=relaxed/simple;
	bh=cj9JZm6uCwEVXP1jBJgO97mYwAX/pE/bnryPlNat7F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMEV7fDMz54kwcbNCTR5g+sRDg1EtYHdhGab49ZClrhMWhML8WtaPr81yhujAWmW9pxgl5hEg/qeLdGdRGg1fqxGgQ/KYmm3M5JQ9fuyKGVcVn460w1IpFdOJTc4cLEbRh+RV6oVK4VaENbyBeSHnKqdgF0r2b3BWi7lve1/geA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xw9z+XZz; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xw9z+XZz"
Message-ID: <f3b1f501-39c7-406b-9d07-a9b89052aa79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781441713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWKvqXe0Ca8okXZrAH8Q2DIZvwSEDeon1DDi9CbLSQE=;
	b=xw9z+XZzrFNncVduoAGWojo7XlhHcqVyARRzuYlXgfIeH2ihfZaPjj6QZ645hZLq8t2B3A
	fXw5DaAUcSQlo6l8aliU2T2Gewn+jxEp4lxLsDqWORV6ibpGR8ptlwMY9jq73Pla+1b6Yq
	SqSpTNn9E0BIiC1VVuO9KZTnwV/fiak=
Date: Sun, 14 Jun 2026 14:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/8] HID: asus: cleanup keyboard listener on failure:
 avoid use-after-free
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
 Connor Belli <connorbelli2003@gmail.com>, sahiko-bot@kernel.org
References: <20260613153029.2559774-1-denis.benato@linux.dev>
 <20260613153029.2559774-5-denis.benato@linux.dev>
 <CAGwozwGsDUh_pGjf-NcX6JiYfg8GhbADUcFTFs_E5BsuktdKaA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <CAGwozwGsDUh_pGjf-NcX6JiYfg8GhbADUcFTFs_E5BsuktdKaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/13/26 17:57, Antheas Kapenekakis wrote:
> On Sat, 13 Jun 2026 at 17:30, Denis Benato <denis.benato@linux.dev> wrote:
>> asus_kbd_register_leds(), I noticed it registers a listener to a global list
>> and uses devm_kzalloc(). If a subsequent initialization step in asus_probe()
>> fails the driver returns without unregistering the listener, and the devres
>> subsystem will automatically free the memory, leaving a dangling pointer
>> in the global list.
>>
>> Fixes: b34b5945a769 ("HID: asus: listen to the asus-wmi brightness device instead of creating one")
>> Reported-by: sahiko-bot@kernel.org
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>> ---
>>  drivers/hid/hid-asus.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 0a6c97155549..f38b18ad65c6 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -1426,11 +1426,17 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>                 if (drvdata->tp) {
>>                         ret = asus_start_multitouch(hdev);
>>                         if (ret)
>> -                               goto err_stop_hw;
>> +                               goto err_unregister_backlight;
>>                 }
> This block currently does two things, rename and init the touchpad.
> Instead,  you may pull the touchpad init to be below the hid_hw_start
> block and keep the same bail.
I'm not particularly keen on changing the sequence of packets in these
kinds of patches: I was trying to solve the reported issue in a way that
only solves the issue: nothing less and nothing more.
>>         }
>>
>>         return 0;
>> +err_unregister_backlight:
>> +       if (drvdata->kbd_backlight) {
>> +               asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);
>> +               devm_kfree(&hdev->dev, drvdata->kbd_backlight);
>> +               drvdata->kbd_backlight = NULL;
>> +       }
>>  err_stop_hw:
> OR add asus_hid_unregister_listener(&drvdata->kbd_backlight->listener) here.
>
> Here, you'd also drop err_unregister_backlight, devm_kfree, and
> nulling. The driver is closing. It is not necessary.
>
> err_stop_hw is only used once, you do not need a secondary tag.
I will do this instead, thanks.
>>         hid_hw_stop(hdev);
>>         return ret;
>> --
>> 2.47.3
>>
>>
