From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Mon, 28 Aug 2017 14:50:49 +0200
Message-ID: <0c72f919-eab2-2f3f-a760-1aacc25d2550@redhat.com>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <20170722185537.12696-2-hdegoede@redhat.com>
 <20170817193912.hccxyjwstrtr5oiv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdH1Muy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Aug 2017 08:50:54 -0400
In-Reply-To: <20170817193912.hccxyjwstrtr5oiv@ninjato>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

Hi again,

I realized I did not answer 1 of your questions:

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
> 
>> Worse, after the probe failure the i2c / ACPI core code will put the ACPI
>> device in D3 state
> 
> Where does that happen? Sorry, I can't find it. Would it be an idea to
> add a flag somewhere telling the device should not be put into D3?

It is already possible to do this and my patches for the icn8318 driver
do this:

	struct acpi_device *adev;

	adev = ACPI_COMPANION(dev);

	/*
	 * Disable ACPI power management the _PS3 method is empty, so
	 * there is no powersaving when using ACPI power management.
	 * The _PS0 method resets the controller causing it to loose its
	 * firmware, which has been loaded by the BIOS and we do not
	 * know how to restore the firmware.
	 */
	adev->flags.power_manageable = 0;

The problem is that this happens in the probe() from the icn8318 driver
and if the i2c-hid drivers probe() executes first we end up in the
dev_pm_domain_detach() path of i2c_device_probe() and after that the
touchscreen-controller no longer works (*), iow after that it is too late
to disable acpi pm for the device.

*) Unless we find a way to reload the firmware, which technically is
doable, but then we get into the problem of now having to distribute the
firmware in linux-firmware

Regards,

Hans
