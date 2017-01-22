From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] Input: soc_button_array - Set input device name
Date: Sun, 22 Jan 2017 09:49:24 +0100
Message-ID: <f6eeaeee-6343-a849-2dcd-0136b8882498@redhat.com>
References: <20170109175707.12854-1-hdegoede@redhat.com>
 <20170121191328.GC36944@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751160AbdAVIt2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 03:49:28 -0500
In-Reply-To: <20170121191328.GC36944@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

Hi,

On 21-01-17 20:13, Dmitry Torokhov wrote:
> On Mon, Jan 09, 2017 at 06:57:06PM +0100, Hans de Goede wrote:
>> On some tablets using the soc_button_array driver the buttons do not
>> follow the standard home, power, volume_up, volume_down, rotation_lock
>> button order as published by Microsoft.
>>
>> We can use the existing udev hwdb mechanism to fix this up, but then
>> the created devices must have a unique name, therefor this commit adds
>> a unique name for the 2 created gpio-keys input devices.
>
> Why does it have to have unique name? You should be able to match on
> other input device properties, for example ATTR{capabilities/ev} or
> ATTR{capabilities/keys} to identify the device you want to adjust.

hwdb entries do not have access to full udev data, basically there
are 2 match formats:

# Supported hardware matches are:
#  - Generic input devices match:
#      evdev:input:bZZZZvYYYYpXXXXeWWWW-VVVV
#    This matches on the kernel modalias of the input-device, mainly:
#    ZZZZ is the bus-id (see /usr/include/linux/input.h BUS_*), YYYY, XXXX and
#    WWW are the 4-digit hex uppercase vendor, product and version ID and VVVV
#    is an arbitrary length input-modalias describing the device capabilities.
#    The vendor, product and version ID for a device node "eventX" is listed
#    in /sys/class/input/eventX/device/id.
#
#  - Input driver device name and DMI data match:
#      evdev:name:<input device name>:dmi:bvn*:bvr*:bd*:svn<vendor>:pn*
#    <input device name> is the name device specified by the
#    driver, <vendor> is the firmware-provided string exported
#    by the kernel DMI modalias, see /sys/class/dmi/id/modalias


Since we want to match on DMI info we need to use the second, and
the info you are referring to is not available here.

Regards,

Hans


>
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/input/misc/soc_button_array.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
>> index 9bc1b20..d2e5186 100644
>> --- a/drivers/input/misc/soc_button_array.c
>> +++ b/drivers/input/misc/soc_button_array.c
>> @@ -113,6 +113,11 @@ soc_button_device_create(struct platform_device *pdev,
>>  	gpio_keys_pdata->nbuttons = n_buttons;
>>  	gpio_keys_pdata->rep = autorepeat;
>>
>> +	if (autorepeat)
>> +		gpio_keys_pdata->name = "SoC Button Array (autorepeat buttons)";
>> +	else
>> +		gpio_keys_pdata->name = "SoC Button Array";
>> +
>>  	pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
>>  	if (!pd) {
>>  		error = -ENOMEM;
>> --
>> 2.9.3
>>
>
> Thanks.
>
