Received: from mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0332931EE
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174566; cv=none; b=gG+tNMgyMxbBAoEs0hXisx95QX2pMY4jmI1Yb8CYYep+cMo5AFIEYnEXJpW/p07MXVTlI/V6T/Uu0XlBzI/l1qJxRnyh8ie0nSBHTdrY+AJj2HDseR/Zb+ig4vnBUgLc/OEq50DOf3K7+jy1CM1gHiZo0DSsr+WKBTh8FwTwSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174566; c=relaxed/simple;
	bh=ORe5ihNzKp5uDsNyFoir3oP0+RDs+ueQ3G07msDULwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIreVW+1rjo43zS1J0F5diyI93FxjUOHjHdMntnkIyl+SBM1Eh7iDfNPnXQdHMYfGueQbGAfgqwyUQm0UBjciNARaDD9YahtVdVjiDzY7h8t4k/f2sAlGUDmUVX3P0bAyeZTDrFhBiQ+4pPVUO2OVDy3xXT7qE81EFRJEQGgfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cm9Pzg+Y; arc=none smtp.client-ip=91.218.175.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cm9Pzg+Y"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ORe5ihNzKp5uDsNyFoir3oP0+RDs+ueQ3G07msDULwQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789174561; v=1; x=1789779361;
 b=Cm9Pzg+Y9dxN80MBgCa1Wl5lEkyz2WpoSTbH73rdjzUH+ClCQLdrGv9kPxQpQxE/WmnPnks/
 jhuMc+/qkFOwOHgS3Y6W9E3yo1aCMrQRDm5sCa8arrKnSGgYzfXipr6QNV9X962sZvUXNiqWbP6
 ksL6Bc78f8/vsUr438puytJ8=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 55d87a568804cd70;
	Sat, 12 Sep 2026 00:56:01 +0000
X-Mizu-Trace-ID: 55d87a568804cd70
X-Migadu-Flow: FLOW_OUT
Message-ID: <7c3370ca-d03c-4b99-b653-fd91592ca672@linux.dev>
Date: Sat, 12 Sep 2026 02:56:00 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Input: xpad - introduce a static table to ignore
 devices
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Jiri Kosina <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811125856.1692045-1-denis.benato@linux.dev>
 <20260811125856.1692045-3-denis.benato@linux.dev>
 <6598sn1p-p330-1r7o-q43p-r1rnr7nn0022@xreary.bet>
 <91447a15-eea8-4f21-abd6-2d79b5c647bb@linux.dev>
 <F4BC32F9-792B-48C3-A1EF-65BC4E2534C5@gmail.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <F4BC32F9-792B-48C3-A1EF-65BC4E2534C5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/11/26 17:39, Derek J. Clark wrote:
> On September 11, 2026 8:12:02 AM PDT, Denis Benato <denis.benato@linux.dev> wrote:
>> On 9/11/26 16:11, Jiri Kosina wrote:
>>> On Tue, 11 Aug 2026, Denis Benato wrote:
>>>
>>>> Certain devices can work both as HID and as an xpad device: binding both
>>>> would duplicate inputs causing userspace to receive double inputs; at the
>>>> same time if a HID device is available it is to be preferred as it can
>>>> support additional features such as integrated IMU and additional buttons
>>>> and more, depending on the specific driver, therefore allow only the
>>>> best driver available to bind the device.
>>>>
>>>> Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>>> I'd like to have Dmitry's Ack on this one before taking the Flydigi 
>>> support through the HID tree.
>> Hi Jiri,
>>
>> Sure thing! While we wait I will get a v4 going that is reported working better
>> and having battery reporting too by Adolfo.
>>
>> This new table will be used by Derek too for some trustmaster (I think) he's
>> working on that is in the same situation.
>>
> Hi Denis,
>
> I'm waiting for Vicky's GIP driver to land before I do that because I'll need to add a similar table to that driver and I want to avoid getting in their way.
Well that means I am trying to set up something better than some code: a pattern on how to handle these cases :D
> Cheers,
> Derek
>
>> Best regards,
>> Denis Benato 
>>> Thanks.
>>>
>>>> ---
>>>>  drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
>>>>  1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>>>> index feb8f368f834..545119a4fb36 100644
>>>> --- a/drivers/input/joystick/xpad.c
>>>> +++ b/drivers/input/joystick/xpad.c
>>>> @@ -406,6 +406,18 @@ static const struct xpad_device {
>>>>  	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
>>>>  };
>>>>  
>>>> +#define XPAD_SUBSTITUTE(_vid, _pid, _enabled) \
>>>> +	{ .vid = (_vid), .pid = (_pid), .enabled = (_enabled) }
>>>> +
>>>> +static const struct xpad_excluded_device {
>>>> +	u16 vid;
>>>> +	u16 pid;
>>>> +	bool enabled;
>>>> +} xpad_excluded_devices[] = {
>>>> +	XPAD_SUBSTITUTE(0x37d7, 0x2401, IS_ENABLED(CONFIG_HID_FLYDIGI)),
>>>> +	{ }
>>>> +};
>>>> +
>>>>  /* buttons shared with xbox and xbox360 */
>>>>  static const signed short xpad_common_btn[] = {
>>>>  	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
>>>> @@ -2044,11 +2056,23 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>>>>  	struct usb_device *udev = interface_to_usbdev(intf);
>>>>  	struct usb_xpad *xpad;
>>>>  	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
>>>> +	const struct xpad_excluded_device *excluded;
>>>>  	int i, error;
>>>>  
>>>>  	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
>>>>  		return -ENODEV;
>>>>  
>>>> +	for (excluded = xpad_excluded_devices;
>>>> +	     excluded->vid || excluded->pid;
>>>> +	     excluded++) {
>>>> +		if (!excluded->enabled)
>>>> +			continue;
>>>> +
>>>> +		if (le16_to_cpu(udev->descriptor.idVendor) == excluded->vid &&
>>>> +		    le16_to_cpu(udev->descriptor.idProduct) == excluded->pid)
>>>> +			return -ENODEV;
>>>> +	}
>>>> +
>>>>  	for (i = 0; xpad_device[i].idVendor; i++) {
>>>>  		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
>>>>  		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
>>>> -- 
>>>> 2.47.3
>>>>
