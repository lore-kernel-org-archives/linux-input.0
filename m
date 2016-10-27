From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: Re: [PATCH 4/4] Input: goodix - Support interchanging x and y
 coordinates in hardware
Date: Thu, 27 Oct 2016 12:54:53 -0500
Message-ID: <e2ca2719-538c-5110-2dde-6a18cd202be6@ti.com>
References: <20161020195917.20051-1-fcooper@ti.com>
 <20161020195917.20051-5-fcooper@ti.com>
 <20161026231816.a35orxe3mpsvcx3m@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34843 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935125AbcJ0RzI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 13:55:08 -0400
In-Reply-To: <20161026231816.a35orxe3mpsvcx3m@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: dmitry.torokhov@gmail.com, hadess@hadess.net, octavian.purdila@intel.com, irina.tirdea@intel.com, merker@debian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, nm@ti.com



On 10/26/2016 06:18 PM, Rob Herring wrote:
> On Thu, Oct 20, 2016 at 02:59:17PM -0500, Franklin S Cooper Jr wrote:
>> On systems with a fixed display/touchscreen orientation it is important to
>> pass in the "correct" x and y coordinates based on the orientation.
>> Currently, to support landscape and portrait touchscreen-swapped-x-y
>> simply does the following:
>>
>> Assuming touchscreen is as follows:
>> X: 1280 Y:800 programmed in touchscreen controller and also interchange
>> bit cleared. Assuming ts mounted in portrait mode.
>>
>> 1280 (X)
>> ------
>> |    |
>> |    | 800 (Y)
>> |    |
>> |    |
>> ------
>>
>> 800 (Y)
>> ------
>> |    |
>> |    | 1280 (X)
>> |    |
>> |    |
>> ------
>>
>> However, the above isn't really what we want especially in distros that
>> assumes a fixed orientation. In this case what we really want is to
>> interchange the x and y coordinates so the Y coordinate can return a max
>> value of 1280 and X can return a max value of 800.
>>
>> 800 (X)
>> ------
>> |    |
>> |    | 1280 (Y)
>> |    |
>> |    |
>> ------
>>
>> Since the driver is limited to the value reported by the touchscreen
>> controller this issue can't be fixed purely in the driver. Therefore,
>> add a new DT property that supports interchanging X and Y coordinates
>> internally within the hardware.
> 
> I'm not sure I follow why existing properties don't cover this.
> 
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>>  .../devicetree/bindings/input/touchscreen/goodix.txt        |  2 ++
>>  drivers/input/touchscreen/goodix.c                          | 13 +++++++++++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> index ebc7cb7..b8be2ab 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>> @@ -25,6 +25,8 @@ Optional properties:
>>   - touchscreen-inverted-y  : Y axis is inverted (boolean)
>>   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
>>                               (swapping is done after inverting the axis)
>> + - touchscreen-inter-x-y   : X and Y maximum values programmed in the device
>> +                             are interchanged internally in hardware. (boolean)
> 
> Minimally this should be vendor specific and have a vendor prefix I 
> think.

Would "goodix,inter-x-y" work?
> 
> Rob
> 
