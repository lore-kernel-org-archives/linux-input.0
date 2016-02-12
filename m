From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v5 05/10] Input: synaptics-rmi4: Add device tree support
 for 2d sensors and F11
Date: Fri, 12 Feb 2016 09:20:46 -0800
Message-ID: <56BE146E.7050107@synaptics.com>
References: <1455143074-10259-1-git-send-email-aduggan@synaptics.com>
 <20160212154427.GA8795@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:32496 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750865AbcBLRUr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 12:20:47 -0500
In-Reply-To: <20160212154427.GA8795@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org

On 02/12/2016 07:47 AM, Rob Herring wrote:
> On Wed, Feb 10, 2016 at 02:24:34PM -0800, Andrew Duggan wrote:
>> 2D sensors have several parameter which can be set in the platform data.
>> This patch adds support for getting those values from devicetree.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> ---
>>   .../bindings/input/rmi4/rmi_2d_sensor.txt          |  56 +++++++++++
>>   .../bindings/input/touchscreen/touchscreen.txt     |   2 +
>>   drivers/input/rmi4/rmi_2d_sensor.c                 | 108 +++++++++++++++++++++
>>   drivers/input/rmi4/rmi_2d_sensor.h                 |   3 +
>>   drivers/input/rmi4/rmi_f11.c                       |   7 +-
>>   5 files changed, 175 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> [...]
>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>> index ac23caf..d6674de 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>> @@ -18,6 +18,8 @@ Optional properties for Touchscreens:
>>    - touchscreen-inverted-y	: Y axis is inverted (boolean)
>>    - touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
>>   				  Swapping is done after inverting the axis
>> + - touchscreen-mm-x		: horizontal length in mm of the touchscreen
>> + - touchscreen-mm-y		: vertical length in mm of the touchscreen
> As I mentioned on v3, put the units on the end.

Oh sorry! I see you did mention that in v3 and I must have missed it.

Thanks,
Andrew

> Rob

