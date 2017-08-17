From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Thu, 17 Aug 2017 15:15:24 -0700
Message-ID: <CAKdAkRQjhE3WRkcWrZtYzxtMs+dy718JTYWjzELBEDRoVY_qWw@mail.gmail.com>
References: <20170722185537.12696-1-hdegoede@redhat.com> <20170722185537.12696-2-hdegoede@redhat.com>
 <20170817193912.hccxyjwstrtr5oiv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37176 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbdHQWP0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 18:15:26 -0400
In-Reply-To: <20170817193912.hccxyjwstrtr5oiv@ninjato>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>

On Thu, Aug 17, 2017 at 12:39 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
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

So I guess this will also happen if I unbind/rebind chipone_icn8318 driver?

>
> Where does that happen? Sorry, I can't find it. Would it be an idea to
> add a flag somewhere telling the device should not be put into D3? That
> would be way more generic in case this happens outside I2C world, or?
> Disclaimer: I am brainstorming here, don't know super much about ACPI.
>
>> This commit adds a match callback and returns -ENODEV for i2c_client-s
>> with a CHPN0001 ACPI device id, so that the probe function never gets
>> called, fixing the controller losing its firmware.
>
> Do you know if something like a match-callback exists somewhere else in
> the kernel?

Having blacklist means that we are failing at design somewhere...

In this case what we have is wrong ACPI table. Instead of adding hooks
to i2c core can we fix it (DSDT) up? I know people do not like it, but
I'd say this is task for yet another platform driver to adjust ACPI
properties (kill the wrong _CID, disable PS0) before instantiating the
device.

Thanks.

-- 
Dmitry
