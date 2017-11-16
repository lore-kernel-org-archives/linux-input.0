From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/2] Input: silead - Add support for capactive home
 button found on some x86 tablets
Date: Thu, 16 Nov 2017 14:45:55 +0100
Message-ID: <7ce77147-1f03-5621-a69b-6d03c42006ab@redhat.com>
References: <20171019071728.6635-1-hdegoede@redhat.com>
 <CAL_Jsq+28caybU9xA+xVSWSFobEuJWgNhoq+YjPHoqpzjxhMng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935076AbdKPNp5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Nov 2017 08:45:57 -0500
In-Reply-To: <CAL_Jsq+28caybU9xA+xVSWSFobEuJWgNhoq+YjPHoqpzjxhMng@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On 16-11-17 14:34, Rob Herring wrote:
> On Thu, Oct 19, 2017 at 2:17 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On some x86 tablets with a silead touchscreen the windows logo on the
>> front is a capacitive home button. Touching this button results in a touch
>> with bits 12-15 of the Y coordinates set, while normally only the lower 12
>> are used.
>>
>> Detect this and report a KEY_LEFTMETA press when this happens. Note for
>> now we only respond to the Y coordinate bits 12-15 containing 0x01, on some
>> tablets *without* a capacative button I've noticed these bits containing
> 
> capacitive
> 
>> 0x04 when crossing the edges of the screen.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Only enable support for the home-button if a "silead,home-button"
>>   boolean device-property is set on the device
>>
>> Changes in v3:
>> -Document the new silead,home-button property in:
>>   Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> ---
>>   .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +
> 
> Acked-by: Rob Herring <robh@kernel.org>

I believe this means this is ready to be merged now. It would be nice
if we could still get this into 4.15 for rc2 (it is a fix in a way).

Regards,

Hans
