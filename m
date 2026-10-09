Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA54DD6DB
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546424; cv=none; b=UYDmYY1L5+g+WRBr9HJOuCQv0+9trnOZMHaAGW+yJCj74xvYcBop5q7pAyFMOJUDxgKC41XDqml+pSMeKa2VqMovZ0f9kUgfldgoqqkpmklKwAbF5N0bo/Bi/Ds6hDFHIPK12KHbojsBex3QJbZw1Cb2E30+3EC++kymD1+hVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546424; c=relaxed/simple;
	bh=eNzg+bfeFy0bMPZ3YN8tWVXL0Hv6lyLk8riO4DNvSqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+z5ntrOHjcheVsTEYphWg73UvbmulX+au7krdTQ6DWeHH+f6gdGxJsHQgvmwut4rXdYlXGAQIwPxSvPHccuxWRbdGUPXM1FoLqwC8U80Sz6g9rwWkrUzQILMofh/0+UGmx19P6mdKF8rVjV5S7sgUwiCwPb9s58dyBRP0Mc2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UiFKGTxV; arc=none smtp.client-ip=91.218.175.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UiFKGTxV"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eNzg+bfeFy0bMPZ3YN8tWVXL0Hv6lyLk8riO4DNvSqU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791546413; v=1; x=1792151213;
 b=UiFKGTxVEZgL6U/5GHQDWyPPTHucCPoWoWJlsG2jZjNycpAPk6RoGqxop9cfnwAD5cM6+GZt
 e4h/Twmq6wQqYUN6NoU2bDJ9kgQLX4g7uQSo984jTkyZ6WgAwReQtNHJx70vPXwnC/1xofbHhPm
 R8OPW8FUs6MHdlnioOkQnOJI=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c9cd8961b0ec5f7b;
	Fri, 09 Oct 2026 11:46:53 +0000
X-Mizu-Trace-ID: c9cd8961b0ec5f7b
X-Migadu-Flow: FLOW_OUT
Message-ID: <ecba8e43-c2c6-4d29-a4bb-09e905f319d4@linux.dev>
Date: Fri, 9 Oct 2026 13:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Input: xpad - introduce a static table to ignore
 devices
To: Jiri Kosina <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J. Clark" <derekjohn.clark@gmail.com>
References: <20260811125856.1692045-1-denis.benato@linux.dev>
 <20260811125856.1692045-3-denis.benato@linux.dev>
 <6598sn1p-p330-1r7o-q43p-r1rnr7nn0022@xreary.bet>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <6598sn1p-p330-1r7o-q43p-r1rnr7nn0022@xreary.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/11/26 16:11, Jiri Kosina wrote:
> On Tue, 11 Aug 2026, Denis Benato wrote:
>
>> Certain devices can work both as HID and as an xpad device: binding both
>> would duplicate inputs causing userspace to receive double inputs; at the
>> same time if a HID device is available it is to be preferred as it can
>> support additional features such as integrated IMU and additional buttons
>> and more, depending on the specific driver, therefore allow only the
>> best driver available to bind the device.
>>
>> Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> I'd like to have Dmitry's Ack on this one before taking the Flydigi 
> support through the HID tree.

Hi Jiri,


Any news on this front yet?

> Thanks.
>
>> ---
>>  drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>> index feb8f368f834..545119a4fb36 100644
>> --- a/drivers/input/joystick/xpad.c
>> +++ b/drivers/input/joystick/xpad.c
>> @@ -406,6 +406,18 @@ static const struct xpad_device {
>>  	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
>>  };
>>  
>> +#define XPAD_SUBSTITUTE(_vid, _pid, _enabled) \
>> +	{ .vid = (_vid), .pid = (_pid), .enabled = (_enabled) }
>> +
>> +static const struct xpad_excluded_device {
>> +	u16 vid;
>> +	u16 pid;
>> +	bool enabled;
>> +} xpad_excluded_devices[] = {
>> +	XPAD_SUBSTITUTE(0x37d7, 0x2401, IS_ENABLED(CONFIG_HID_FLYDIGI)),
>> +	{ }
>> +};
>> +
>>  /* buttons shared with xbox and xbox360 */
>>  static const signed short xpad_common_btn[] = {
>>  	BTN_A, BTN_B, BTN_X, BTN_Y,			/* "analog" buttons */
>> @@ -2044,11 +2056,23 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>>  	struct usb_device *udev = interface_to_usbdev(intf);
>>  	struct usb_xpad *xpad;
>>  	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
>> +	const struct xpad_excluded_device *excluded;
>>  	int i, error;
>>  
>>  	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
>>  		return -ENODEV;
>>  
>> +	for (excluded = xpad_excluded_devices;
>> +	     excluded->vid || excluded->pid;
>> +	     excluded++) {
>> +		if (!excluded->enabled)
>> +			continue;
>> +
>> +		if (le16_to_cpu(udev->descriptor.idVendor) == excluded->vid &&
>> +		    le16_to_cpu(udev->descriptor.idProduct) == excluded->pid)
>> +			return -ENODEV;
>> +	}
>> +
>>  	for (i = 0; xpad_device[i].idVendor; i++) {
>>  		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
>>  		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
>> -- 
>> 2.47.3
>>
