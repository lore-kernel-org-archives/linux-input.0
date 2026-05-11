Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AE4D8DA2
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536510; cv=none; b=IbAvNBXwU51j7Sj5x1LS7HsdquAf7g8JI51PQXSx/9cmPkR2xXOgxlaUelTZ7wmiRvE/nOixpkmq9XLJfb6t5m8OQ5TjZM4WejwpsxyubbJOQiQeE4lcQkaZ+405M79uTvJE4UbwQzsYT4ehU81un4J2X2ocYXK/EfVUACRzW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536510; c=relaxed/simple;
	bh=NzRrgdqz4nEIoMnqLvi98xvutqhcVqw1QpBUiFoB1uc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=o+XRQkK/1+aMqH+aUAoPnMy7Yc1fc/bpLyzl9AknQLJBEnNZTI6KZOURaGONq48E2roj98+L8xCR9u5kWGDwTPSbZorElF5UYXsgOvGWokLMXt8TrVn91CK5Y8AUyN9FRsJ6UacfuRd2YzQfoBm8wYHViNG6oBf+WDzPi99lwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhfal5m0; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhfal5m0"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso5372414eec.0
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778536508; x=1779141308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BmUOZb/0iJu7cUFvnyBMuIAtVRaC6aw3BvJ4ZeLGelE=;
        b=Rhfal5m0lIwVZHNawg9HHbgWgKC6G14aPqzTZpMDyL5iuXBpJUcrg6GacwZ/6danh3
         zdIJjlLjWISFq3XSJFwDSoY9oj2m/AfICQm0YrAQMbNgIESujeslxemxolhtpblct3ft
         G8Kts113j55W8h4AM3gPatsDieMnp1rdCUFQhwaHZUkjU/2178TxzIQ6CkuJNIPtz0oQ
         p3fLz4TE9B1GmkRZZGFudpaaKR4GzUXEZ7aHSvLAo+XTlaaKVEMUkzRe2cOIYAiFPaSB
         noHT1JH7Wu79IP0rKUZjS/cU82u73QQYYJ1TJCGsuJcAX0920+NGAw+z60kUMTdBS6In
         GvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536508; x=1779141308;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmUOZb/0iJu7cUFvnyBMuIAtVRaC6aw3BvJ4ZeLGelE=;
        b=aVlUCpu8ADCl1WjhkSDBvNdNQ6oRDcH5rCIvWnlgfjiaoTXkrvF5ySrcbDt/YflxIm
         d+ZQU0hYQNXs2EBjxRPYaZRlC4CzEV08d1s4stnuoOmwKutTlgax5OJXR/w/U+TQeGMT
         4XoSdiZtCME7kvdPp2yxGMU8WoeKFm+kU8OB5ngjD9bpWsAEE6xa//gsTvpziQKpOx8Z
         MNPp1TXnafDCzKKCl9HHcvI/UFB/IPg5uuEqvniu8CteAuWsV/c+4MtT859FVYeS0GIw
         lAA2EIuvyM1xLiPPbs3KYag5zQ5oSOJFE1QyM2a5fcSR13kEsDogxv5NH+Xk6psv7hbg
         44rg==
X-Forwarded-Encrypted: i=1; AFNElJ91BHT4SzdTTkIvnDxMo1pf3ih0MdM9HhBujyHouNg7SarW/qCovCTnVNZd+rQ4vRtEfG7dwqfclYiwyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyifUrdhIJ67k6AC/bLmGZo6R3puOD4OL3akRv5gMmfkPo8BZKv
	EMaNnnw5SwT/cctHQMLFO+CygzVRMGJae/uJdqjMm4iUCPA1UOIpJ+Qe
X-Gm-Gg: Acq92OFhEMbvdCRpXHWB4ttAlzilgSeYdQII+RLY7yHB7XtgXM0x8Pz8uSUNIhcKTmn
	xLP3AysC1i4UgynnQfpthtRR7VzALhwP1MHSZVYTYDATtAXjrLfBHJPtNQpxBejXPmkb9kI1udM
	zNA6teRThI+P28hwoJQyAPBH9wFKfLE1+iaHYkC0eRbxEw6ZMLZx91kWs5AbGJGsJqDaMKwgrts
	gIpr6bkVAt8+Zqqs8kJ16dqD2/L44r4mypxaCngZ3xhvrZoJBoRvLgrwEfDAWxNxbOeBDTxRBJE
	JnBPReZCpuDfoKcXV4gFmLXgaY9xpfj6BWbksbXDSVLj4B20N7ehquHWcptBE8ZqwvOOEgJNJEv
	5r5JSRitgnjwXjdcKPtTWuXXNl4udHG4DaWgegGdkoN3ngBGLwE7VdHo/oEtQr1wGC6+aj6Y+KH
	X7hbeE0Oaeuhz4T6+JwOArgBazk6wfHpRP8bbVyUpoaGo57KXjH3h2mGfXK2bIA+4s20JlEfAcI
	6+i00IkglAWLnGZPMABog==
X-Received: by 2002:a05:7300:e404:b0:2dd:c066:c02 with SMTP id 5a478bee46e88-2ffd77e6eb6mr240084eec.22.1778536508388;
        Mon, 11 May 2026 14:55:08 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb034sm15357293eec.5.2026.05.11.14.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 14:55:08 -0700 (PDT)
Date: Mon, 11 May 2026 14:55:09 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: sashiko@lists.linux.dev, sashiko-bot@kernel.org
CC: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH 3/4] HID: hid-msi-claw: Add RGB control interface
User-Agent: Thunderbird for Android
In-Reply-To: <20260511212230.21800C2BCB0@smtp.kernel.org>
References: <20260510043510.442807-4-derekjohn.clark@gmail.com> <20260511212230.21800C2BCB0@smtp.kernel.org>
Message-ID: <EAA30E51-66FB-4772-AEBB-4A94402FA9F5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 11, 2026 2:22:29 PM PDT, sashiko-bot@kernel=2Eorg wrote:
>Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
>- [High] `speed_show()` incorrectly casts the LED class device pointer to=
 a `hid_device`, leading to an out-of-bounds memory read and kernel crash=
=2E
>- [High] Deadlock and missing return in `cfg_setup_fn` when handling init=
ialization errors=2E
>- [High] Sysfs attributes re-arm the cancelled delayed work after device =
teardown, leading to a Use-After-Free=2E
>- [High] Racy nullification of `brightness_set` causes a TOCTOU NULL poin=
ter dereference=2E
>- [Medium] Communication failure in `claw_read_rgb_config` leaves the pro=
file parser in a corrupted state=2E
>--
>
>commit 9663adbabcba6be0b443e7073133d650a790c871
>Author: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>
>
>HID: hid-msi-claw: Add RGB control interface
>   =20
>Adds RGB control interface for MSI Claw devices with 9 total zones and
>supports up to 8 sequential frames of RGB zone data=2E
>
>> diff --git a/drivers/hid/hid-msi-claw=2Ec b/drivers/hid/hid-msi-claw=2E=
c
>> index 60694d075d56f=2E=2Ef4fe74a784c29 100644
>> --- a/drivers/hid/hid-msi-claw=2Ec
>> +++ b/drivers/hid/hid-msi-claw=2Ec
>
>[ =2E=2E=2E ]
>
>> @@ -743,6 +836,389 @@ static const struct attribute_group claw_gamepad_=
attr_group =3D {
>>  	=2Eis_visible =3D claw_gamepad_attr_is_visible,
>>  };
>> =20
>> +/* Read RGB config from device */
>> +static int claw_read_rgb_config(struct hid_device *hdev)
>> +{
>> +	u8 data[4] =3D { 0x01, 0x00, 0x00, CLAW_RGB_FRAME_OFFSET };
>> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
>> +	u16 read_addr =3D drvdata->rgb_addr;
>> +	size_t len =3D ARRAY_SIZE(data);
>> +	int ret, i;
>> +
>> +	if (!drvdata->rgb_addr)
>> +		return -ENODEV;
>> +
>> +	/* Loop through all 8 pages of RGB data */
>> +	for (i =3D 0; i < 8; i++) {
>> +		drvdata->profile_pending =3D CLAW_RGB_PENDING;
>> +		data[1] =3D (read_addr >> 8) & 0xff;
>> +		data[2] =3D read_addr & 0x00ff;
>> +		ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data,=
 len, 8);
>> +		if (ret)
>> +			return ret;
>
>If mcu_property_out() fails here, does drvdata->profile_pending remain se=
t
>to CLAW_RGB_PENDING? If a subsequent unrelated profile event or stray ACK
>arrives, could claw_profile_event() incorrectly parse its payload as an R=
GB
>frame?
>
Hi AI bot,

I am responding for the humans that will be reading this=2E

Valid=2E Pending should be reset after errors=2E TBS, I need to find a way=
 to push pending assignment into the mutex, or there will be issues as foun=
d in the other message=2E

>[ =2E=2E=2E ]
>
>> +static ssize_t speed_show(struct device *dev, struct device_attribute =
*attr,
>> +			  char *buf)
>> +{
>> +	struct hid_device *hdev =3D to_hid_device(dev);
>> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
>
>Since the rgb_attr_group attributes are attached to the LED class device
>rather than the HID device, does to_hid_device(dev) result in an invalid
>pointer dereference here? Other sysfs functions in this patch seem to
>correctly use dev_get_drvdata(dev) to retrieve the led_classdev=2E
>

Also valid, though it doesn't crash when run it would be more proper to tr=
eat the led cdev as the parent=2E

>
>> @@ -758,6 +1234,13 @@ static void cfg_setup_fn(struct work_struct *work=
)
>>  		claw_remove(drvdata->hdev);
>>  	}
>> =20
>> +	ret =3D claw_read_rgb_config(drvdata->hdev);
>> +	if (ret) {
>> +		dev_err(drvdata->led_mc=2Eled_cdev=2Edev,
>> +			"Failed to setup device, can't read RGB config: %d\n", ret);
>> +		claw_remove(drvdata->hdev);
>> +	}
>
>If claw_remove() is called from within the cfg_setup worker thread, and
>claw_remove() calls cancel_delayed_work_sync(&drvdata->cfg_setup), won't
>this deadlock waiting for itself to complete?

Since it's a void function I can't return an error=2E I suppose it can jus=
t dev_err and return without initializing any sysfs attributes=2E

>Also, since there is no return statement after claw_remove() is called in
>these error blocks, will this proceed to execute the rest of the function=
 on
>a stopped device?
>
>[ =2E=2E=2E ]
>
>> @@ -881,6 +1405,9 @@ static void claw_remove(struct hid_device *hdev)
>> =20
>>  	if (drvdata->endpoint =3D=3D CLAW_XINPUT_CFG_INTF_IN ||
>>  	    drvdata->endpoint =3D=3D CLAW_DINPUT_CFG_INTF_IN) {
>> +		/* Block writes to brightness/multi_intensity during teardown */
>> +		drvdata->led_mc=2Eled_cdev=2Ebrightness_set =3D NULL;
>
>Is it safe to dynamically nullify the brightness_set callback here? If a
>concurrent brightness update in the LED core checks the pointer, sees it =
as
>valid, and then this nullification happens before the actual function cal=
l,
>could it result in a NULL pointer dereference?

This was done specifically to address a timing issue with the LED core and=
 userspace writing to brightness during teardown=2E Without this we will ge=
t a null pointer dereference when the brightness function calls mcu_propert=
y_out=2E

>> +		cancel_delayed_work_sync(&drvdata->rgb_queue);
>
>Since the LED class device is registered with devres
>(devm_led_classdev_multicolor_register), the sysfs attributes like effect=
,
>speed, and enabled remain accessible until after claw_remove() completes=
=2E
>
>If userspace writes to any of those attributes in this window, could
>mod_delayed_work() re-arm rgb_queue, leading to a use-after-free when
>drvdata is subsequently freed?
>

Swapping this and the sysfs remove after should solve it=2E

-=20
>>  		sysfs_remove_group(&hdev->dev=2Ekobj, &claw_gamepad_attr_group);
>>  		cancel_delayed_work_sync(&drvdata->cfg_setup);
>>  		cancel_delayed_work_sync(&drvdata->cfg_resume);
>

