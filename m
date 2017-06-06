From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Tue, 6 Jun 2017 16:32:46 +0200
Message-ID: <0232a641-c741-1f95-9086-840b31f5d055@free-electrons.com>
References: <20170529144538.29187-1-mylene.josserand@free-electrons.com>
 <20170529144538.29187-2-mylene.josserand@free-electrons.com>
 <20170530080225.rgvy5too2cy5m2zp@flea.lan>
 <c732ffe4-e0fb-16d7-c27a-d18a1995c360@free-electrons.com>
 <20170606120400.ekfbbaai7myscitu@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40448 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFFOcs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 10:32:48 -0400
In-Reply-To: <20170606120400.ekfbbaai7myscitu@flea.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, fery@cypress.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com

Maxime,

On 06/06/2017 14:04, Maxime Ripard wrote:
> On Tue, Jun 06, 2017 at 10:03:48AM +0200, Mylene Josserand wrote:
>>>> +static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
>>>> +{
>>>> +	int rc, t;
>>>> +	u8 cmd[HID_OUTPUT_BL_LAUNCH_APP];
>>>> +	u16 crc;
>>>> +
>>>> +	mutex_lock(&ts->system_lock);
>>>> +	ts->hid_cmd_state = HID_OUTPUT_BL_LAUNCH_APP + 1;
>>>> +	mutex_unlock(&ts->system_lock);
>>>> +
>>>> +	cmd[0] = LOW_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
>>>> +	cmd[1] = HI_BYTE(HID_OUTPUT_BL_LAUNCH_APP_SIZE);
>>>> +	cmd[2] = HID_BL_OUTPUT_REPORT_ID;
>>>> +	cmd[3] = 0x0; /* Reserved */
>>>> +	cmd[4] = HID_OUTPUT_BL_SOP;
>>>> +	cmd[5] = HID_OUTPUT_BL_LAUNCH_APP;
>>>> +	cmd[6] = 0x0; /* Low bytes of data */
>>>> +	cmd[7] = 0x0; /* Hi bytes of data */
>>>> +	crc = cyttsp5_compute_crc(&cmd[4], 4);
>>>> +	cmd[8] = LOW_BYTE(crc);
>>>> +	cmd[9] = HI_BYTE(crc);
>>>> +	cmd[10] = HID_OUTPUT_BL_EOP;
>>>> +
>>>> +	rc = cyttsp5_write(ts, HID_OUTPUT_REG, cmd,
>>>> +			   HID_OUTPUT_BL_LAUNCH_APP_SIZE);
>>>
>>> It seems like you'll send HID_OUTPUT_BL_LAUNCH_APP_SIZE twice here,
>>> once as setup in cyttsp5_write, and once in the buffer you want to
>>> send. Is that on purpose?
>>
>> I am not sure to see the second time it is sent. What do you mean by "as
>> setup in cyttsp5_write"? Anyway, the size is needed in the buffer of the
>> frame.
>
> Nevermind, I confused the HID_OUTPUT_BL_LAUNCH_APP_SIZE with the
> register, my bad.
>

No problem.

>>>> +	/* Call platform init function */
>>>> +	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>>> +	if (IS_ERR(ts->reset_gpio)) {
>>>> +		rc = PTR_ERR(ts->reset_gpio);
>>>> +		dev_err(dev, "Failed to request reset gpio, error %d\n", rc);
>>>> +		return rc;
>>>> +	}
>>>> +
>>>> +	/* Need a delay to have device up */
>>>> +	msleep(20);
>>>
>>> In the case where the device has already been out of reset, this means
>>> that this alone is not sufficient to reset it and bring it out of
>>> reset, which also means that you do not have any guarantee on the
>>> current state of the device. I'm not sure how it would impact the
>>> proper operations though.
>>
>> Okay. A reset frame can be sent to perform a "software
>> reset". Should I add it on startup to be in a "known behavior"?
>
> I guess you'd be safer just getting the GPIO with the low level by
> default, and then changing to high. That way you know that you went
> through a reset state, before bringing up the device.

Okay, I will update the driver, thanks!

>>>> +	ts->input = input_allocate_device();
>>>> +	if (!ts->input) {
>>>> +		dev_err(dev, "%s: Error, failed to allocate input device\n",
>>>> +			__func__);
>>>> +		rc = -ENODEV;
>>>> +		goto error_startup;
>>>> +	}
>>>
>>> In error_startup, you never uninitialize the device. Given your
>>> comment in cyttsp5_startup, this means that you might end up in a
>>> situation where your driver probes again with the device initialized
>>> and no longer in a bootloader mode, which is likely to cause some
>>> error.
>>>
>>> Putting the call to cyttsp5_startup later will make you less likely to
>>> fail (especially because of the DT parsing), and putting the device
>>> back into reset will probably address the issue once and for all.
>>
>> Hm, I am not sure to understand what you want to say, here.
>> Could you explain me more what you have in mind?
>
> I meant to say that there was still an issue with the reset here, and
> moving the DT parsing code further would ease the reset operation.

Okay

>
>> Notice that the DT parsing uses a sysinfo's variable (si->num_btns)
>> which is retrieved in the startup function (thanks to
>> get_sysinfo). So, currently, it is not possible to move the startup
>> function after the DT parsing.
>
> Can't that be made the other way around? You parse the number of
> buttons in the DT, and check the consistency with the hardware?

It could be possible but currently, it was designed to enable every 
button from hardware's configuration and DT binding was just a way to 
customize button's keycode (default is KEY_RESERVED).
If I base it on the DT, it means that some buttons could never be 
reported (such as deactivated) because they will not be present in the 
DT. I am not sure if it is the behavior we want. What do you think?


Best regards,

-- 
Mylène Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
