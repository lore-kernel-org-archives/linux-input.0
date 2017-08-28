From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Mon, 28 Aug 2017 14:44:30 +0200
Message-ID: <e050f500-8a8e-65c2-ac0e-785928b3fb80@redhat.com>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <20170722185537.12696-2-hdegoede@redhat.com>
 <20170817193912.hccxyjwstrtr5oiv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbdH1Mof (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Aug 2017 08:44:35 -0400
In-Reply-To: <20170817193912.hccxyjwstrtr5oiv@ninjato>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

On 17-08-17 21:39, Wolfram Sang wrote:
> Hey guys,
> 
> Sorry, I don't understand some of the stuff here. But I'd like to
> understand it before I add something to the I2C core. Especially as it
> feels a bit a the edge of the driver model to me.
> 
> On Sat, Jul 22, 2017 at 08:55:37PM +0200, Hans de Goede wrote:
>> The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID compatible,
>> it uses its own protocol which is handled by the chipone_icn8318 driver.
>>
>> If the i2c_hid_driver's probe functon gets called it will fail with a
>> "hid_descr_cmd failed" error.
> 
> That sounds like it fails pretty late. I'd assume we could check the
> blacklist right at the beginning of probe and bail out immediately?

The problem is that calling probe (and then failing) leads to the device-core
powering up and then powering down (put in D0 / D3 state) the device, after
which the touchscreen controller has lost its firmware.

So the trick is to get the device-core to never call i2c_bus_type.probe
for i2c-hid at all, which means that i2c_bus_type.match must return false
in this case.

>> Worse, after the probe failure the i2c / ACPI core code will put the ACPI
>> device in D3 state
> 
> Where does that happen? Sorry, I can't find it. Would it be an idea to
> add a flag somewhere telling the device should not be put into D3? That
> would be way more generic in case this happens outside I2C world, or?
> Disclaimer: I am brainstorming here, don't know super much about ACPI.

i2c_device_probe() calls dev_pm_domain_attach(&client->dev, true)
which calls acpi_dev_pm_attach(dev, true) which then does a
acpi_dev_pm_full_power(adev) moving the device to D0 (if it was not
in D0 already).

When the probe fails i2c_device_probe() then does
dev_pm_domain_detach(&client->dev, true); which calls
acpi_dev_pm_detach(dev, true) which does acpi_dev_pm_low_power(...)
and now the device is in D3.

>> This commit adds a match callback and returns -ENODEV for i2c_client-s
>> with a CHPN0001 ACPI device id, so that the probe function never gets
>> called, fixing the controller losing its firmware.
> 
> Do you know if something like a match-callback exists somewhere else in
> the kernel?

No AFAIK there is no driver level match callback (only bus level) at
other places in the kernel.

Regards,

Hans
