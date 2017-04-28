From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] HID: Support i2c-hid multitouch compatible Wacom
 touchscreens
Date: Fri, 28 Apr 2017 09:59:42 +0300
Message-ID: <2a8fe649-7178-647f-346b-0c7f0420be15@linux.intel.com>
References: <20170427135757.29947-1-jarkko.nikula@linux.intel.com>
 <20170427150928.GA28152@mail.corp.redhat.com>
 <CANRwn3QrURkBgB4gjWfwz4WknpOefLAP9Pj7v=Ax9Z+VGKKPMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19166 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939363AbdD1G7u (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 02:59:50 -0400
In-Reply-To: <CANRwn3QrURkBgB4gjWfwz4WknpOefLAP9Pj7v=Ax9Z+VGKKPMA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi

On 04/28/2017 01:48 AM, Jason Gerecke wrote:
> On Thu, Apr 27, 2017 at 8:09 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> On Apr 27 2017 or thereabouts, Jarkko Nikula wrote:
>>> Vendor specific handling in hid_scan_report() overrides the hid->group
>>> to HID_GROUP_WACOM for all devices with vendor ID equal to
>>> USB_VENDOR_ID_WACOM.
>>>
>>> However there is an i2c-hid multitouch compatible Wacom touschreen which
>>> is parsed as generic HID_GROUP_MULTITOUCH_WIN_8 device but
>>> hid-multitouch doesn't probe because of this overriding.
>>>
>>> Support this touschreen by overring the group only when the bus is
>>> different than I2C.
>>>
>>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>> ---
>>> I'm not an HID expert and I don't know is there any existing Wacom
>>> tablets using the I2C bus. There are USB and Bluetooth tablets so that's
>>
>> I'd say there are other I2C Wacom tablets. Jason and Ping can confirm.
>>
>
> Absolutely. There are a number of I2C tablets out there. The device
> table for wacom.ko includes "{ I2C_DEVICE_WACOM(HID_ANY_ID) }" so that
> we can attempt to handle them.
>
>>> the reason I'm checking id->bus != BUS_I2C when overring the group.
>>> I've done only basic testing that device is registered as an
>>> hid-multitouch device and "hexdump /dev/input/eventX" produces a bunch
>>> of hexadecimals when touschscreen is touched.
>>
>> What's the issue of having wacom.ko loaded for this particular
>> touchscreen? wacom.ko should handle it properly.
>>
Cool, it appears to handle it. I just didn't have CONFIG_HID_WACOM 
enabled. I thought the hid-multitouch should handle it as the HID and 
report descriptors looked similar than other I2C HID touchspanels I have 
here.

So please discard this patch.

-- 
Jarkko
