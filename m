Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA2A3515F8
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139529; cv=none; b=clLMzoavA3fvVXNr0Z8acTgs2Hh4ZAXFVWavLyVHhGvqKUK5tabMNw0JmU39zk/EvbBvKdgRJSlPJKzGb2F+Uv4gj2cqz1d8JNckomTWUbqc03zrGhweoVgHdeLgYOGLICuuqtSp/eY7veedLEZ6LKOdvCE0GgWBXiXjGiHsbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139529; c=relaxed/simple;
	bh=rOLit0W3VCFGTP5kXtsPzIPoTYVAhJ8ej1x5RJG9eCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Syywa5awDJToADyHbXh2QnW1RWTHGC8LEjNLeH8tfs0q6oEh8kn0id2Nu4NTEqEDyRRIiC7u8iC/S4uDeo7vHPyHcAFEC5HCUonmqgoXp5EFzE1jt7NkP7l0PvSWE5O80hEwqRKoTRBunMKZdbvjYINX/amiNAQVSBv3Af4lNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCJe9leo; arc=none smtp.client-ip=91.218.175.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCJe9leo"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rOLit0W3VCFGTP5kXtsPzIPoTYVAhJ8ej1x5RJG9eCI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789139523; v=1; x=1789744323;
 b=oCJe9leofDGa6JkKeh9Krd0+PQ2WfTq01gGyXBohCQFI4ksa3OtdLWDywpM6aKnlhCpFygiq
 R6ud4hKe01TjpJJVc0nLFy91dU1GDuH1ym6EjjQYDtrr+qy7vgxa442N63AEzKkA9T70fAdcn3f
 Gw16BnuVOnl4+fY9pGk4dY+8=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7e34b019e9c53bef;
	Fri, 11 Sep 2026 15:12:03 +0000
X-Mizu-Trace-ID: 7e34b019e9c53bef
X-Migadu-Flow: FLOW_OUT
Message-ID: <91447a15-eea8-4f21-abd6-2d79b5c647bb@linux.dev>
Date: Fri, 11 Sep 2026 17:12:02 +0200
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
Content-Transfer-Encoding: 8bit


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

Sure thing! While we wait I will get a v4 going that is reported working better
and having battery reporting too by Adolfo.

This new table will be used by Derek too for some trustmaster (I think) he's
working on that is in the same situation.

Best regards,
Denis Benato 
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
