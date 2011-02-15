From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380 accelerometers
Date: Tue, 15 Feb 2011 10:37:52 +0530
Message-ID: <4D5A0A28.6090700@ti.com>
References: <20110214100622.2282.1584.stgit@bob.linux.org.uk>	<4D5916F5.1090301@ti.com> <20110214122727.0cb550a5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:44074 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751066Ab1BOFII (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 00:08:08 -0500
Received: by mail-gw0-f43.google.com with SMTP id 17so2412395gwb.30
        for <linux-input@vger.kernel.org>; Mon, 14 Feb 2011 21:07:57 -0800 (PST)
In-Reply-To: <20110214122727.0cb550a5@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On Monday 14 February 2011 05:57 PM, Alan Cox wrote:
> On Mon, 14 Feb 2011 17:20:13 +0530
> Shubhrajyoti<shubhrajyoti@ti.com>  wrote:
>
>> Hello,
>> Some comments inlined.
> Please trim stuff when you add comments inline like that. Firstly it
> saves bandwidth but more importantly it makes them easier to find !
Yes, will take care henceforth.
>
>>>    obj-$(CONFIG_INPUT_SGI_BTNS)		+=3D sgi_btns.o
>>> +obj-$(CONFIG_INPUT_BMA023)			+=3D bma023.o
>> May consider alphabetical order
> oops - yes good point. I didn't check that when merging.
>
>
>>> + *	bma023_xyz_read_reg	-	read the axes values
>>> + *	@reg: register being updated
>>> + *	@val: value to write
>> Didn=E2=80=99t understand this
> That would be because the comments need updating. Will fix that now.
>
>
>>> +	struct bma023_sensor *sensor =3D dev_get_drvdata(dev);
>>> +
>>> +	pm_runtime_get_sync(dev);
>> Not a comment really , what does  pm_runtime_get_sync(dev); do ?
> We need to be sure it's powered up when we read it via sysfs.
>
OK , so it powers up the device.thanks
>>> +	pm_runtime_put(dev);
>> Also did you  pm_runtime_put(dev); here? Didnt understand this did y=
ou
>> mean sync?
> No - as we don't care if it powers off immediately just that it gets
> around to it.
>
>>> +
>>> +	return sprintf(buf, "(%d,%d,%d)\n",
>>> +		sensor->data.x, sensor->data.y, sensor->data.z);
>>> +}
>>> +static DEVICE_ATTR(accel_data, S_IRUGO, bma023_show_xyz, NULL);
>> Since it is reported as an input device do you need the sysfs entry?
> Yes - the device is usable both as an input device (think about tilt
> based games) and for other purposes like orientation or drop detectio=
n.
> The sysfs interface covers the latter.
>
>
>>> + *	Add an input device to the sensor. This will be used to report
>>> + *	events from the sensor itself.
>>> + */
>>> +static int bma023_register_input_device(struct bma023_sensor *sens=
or)
>> this could be devinit as well as called only from probe.
> Looks like it could will check
>
>
>>> +	if (idev)
>>> +		input_free_device(idev);
>> This check is there in the function
> Yep
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
