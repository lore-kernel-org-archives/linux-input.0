From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/2] HID: i2c-hid: Do not register i2c_hid_driver on
 devices with a CHPN0001 touchscreen
Date: Tue, 27 Jun 2017 15:13:57 +0200
Message-ID: <6f7c4390-085d-2b22-cbf7-733ee2404307@redhat.com>
References: <20170618101448.17734-1-hdegoede@redhat.com>
 <alpine.LSU.2.20.1706271426140.30709@cbobk.fhfr.pm>
 <20170627124845.GD26073@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdF0NOF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Jun 2017 09:14:05 -0400
In-Reply-To: <20170627124845.GD26073@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi,

On 06/27/2017 02:48 PM, Benjamin Tissoires wrote:
> On Jun 27 2017 or thereabouts, Jiri Kosina wrote:
>> On Sun, 18 Jun 2017, Hans de Goede wrote:
>>
>>> Hi Jiri, Benjamin,
>>>
>>> As discussed with myself in the linux-input thread about adding
>>> icn8505 (ACPI HID CHPN0001) devices to the icn8313 driver:
>>> https://www.spinics.net/lists/linux-input/msg51916.html
>>>
>>> Unfortunately the ACPI node for this non HID compatible device has an
>>> ACPI CID (compatility ID) of PNP0C50 causing the i2c-hid driver to bind,
>>> which leads to the touchscreen not working (see the second patch
>>> commit message for details).
>>>
>>> Although these 2 patches are not really pretty I believe they are the
>>> best way to fix this.
>>>
>>> Note that even if I do add firmware upload support to the icn8318 driver,
>>> we still have the issue left of i2c-hid doing a
>>> dev_err(dev, "hid_descr_cmd failed") which is also undesirable.
>>>
>>> A normal system bootup should have no output for "dmesg --level=err",
>>> this is esp. important for the flickerfree boot experience both Fedora
>>> and Ubuntu have been working towards. Any _err kernel messages will
>>> cause the splash screen to drop back to text-mode breaking the
>>> flickerfree experience. So to silence that error we would need to
>>> blacklist the CHPN0001 ACPI HID somewhere in the i2c-hid driver
>>> anyways.
>>
>> Benjamin, as i2c-hid is mainly your playground, would you mind (n)Acking
>> this? :)
>>
> 
> Sorry, I should have replied here too.
> 
> I still maintain: http://www.spinics.net/lists/linux-input/msg51961.html
> So unless we have some new elements, I am NAcking this patch.

I was planning on implementing the suggested match stuff right away so I
did not answer you, but I did not find the time. So let me at least reply
now :)

I agree that the match callback solution you propose in the mail you
linked is better then my initial fix for this, so I will implement that
and then we will so how that is received.

Regards,

Hans
