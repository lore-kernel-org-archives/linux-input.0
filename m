From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Add support for setting resolution
 based on dmi data
Date: Sun, 22 Jan 2017 12:03:07 +0100
Message-ID: <00a665ed-6930-f44f-a170-498193df2963@redhat.com>
References: <20170102105538.4009-1-hdegoede@redhat.com>
 <20170121190413.GB36944@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbdAVLDK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 06:03:10 -0500
In-Reply-To: <20170121190413.GB36944@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi,

On 21-01-17 20:04, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Mon, Jan 02, 2017 at 11:55:38AM +0100, Hans de Goede wrote:
>> On ACPI based tablets, the ACPI touchscreen node only contains info on
>> the gpio and the irq, and is missing any info on the axis. This info is
>> expected to be built into the tablet model specific version of the driver
>> shipped with the os-image for the device.
>>
>> Add support for getting the missing info from a table built into the
>> driver, using dmi data to identify which entry of the table to use and
>> add info for the CUBE iwork8 Air and Jumper EZpad mini3 tablets on which
>> this code was tested / developed.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=187531
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Put the dmi code in a separate silead_dmi.c file
>> -Use device_add_properties to add the info
>
> This leaks data (device_add_properties() does deep copy of properties)
> you unbind and rebind the driver.
>
> Also I would prefer this all be kept in the swamp that is platform
> drivers and I believe we have enough infrastructure to do just that.
> Could you please tell me if the following version of the patch works on
> your devices?

I had to drop the unregistering of the bus-notifier, as the i2c controller
driver may be a module (and in my case is as I'm testing with a Fedora
distro kernel based .config) so the device may not get registered
till after late_init.

With that + the ACPI names fixed it works. I still need to test on the
ezpad (only tested on the cube so far) then I'll submit this (as v3)
to the platform drivers maintainer with you in the Cc.

Regards,

Hans

