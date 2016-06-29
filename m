From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 3/8] Input: synaptics-rmi4: Add dribble and palm
 gesture parameters to device tree
Date: Tue, 28 Jun 2016 17:44:14 -0700
Message-ID: <577319DE.1070700@synaptics.com>
References: <1466813917-15841-1-git-send-email-aduggan@synaptics.com>
 <20160628205606.GL3737@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160628205606.GL3737@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

Hi Rob,

On 06/28/2016 01:56 PM, Rob Herring wrote:
> On Fri, Jun 24, 2016 at 05:18:37PM -0700, Andrew Duggan wrote:
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> ---
>>   .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt          |  4 ++++
>>   drivers/input/rmi4/rmi_2d_sensor.c                            | 11 +++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>> index f2c30c8..86cb8e3 100644
>> --- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
>> @@ -37,6 +37,10 @@ Optional Properties:
>>   				disable reporing absolute position data.
>>   - syna,rezero-wait-ms: Time in miliseconds to wait after issuing a rezero
>>   				command.
>> +- syna,dribble-enable: Enable reporting of dribble packets in the firmware.
>> +- syna,dribble-disable: Disable reporting of dribble packets in the firmware.
>> +- syna,palm-detect-enable: Enable reporting the palm detect gesture in the firmware.
>> +- syna,palm-detect-disable: Disable reporting the palm detect gesture in the firmware.
> No need for enable and disable. Make the common case be no property and
> the property is the opposite.

There are actually three states here. No property means to use the 
default value set in the firmware. The enable parameter means that the 
default should be overwritten and the feature should be explicitly 
enabled. Disable means the feature should be explicitly disabled. An 
earlier version of this patch had one parameter per feature which needed 
to be set to 0, 1, or 2 which correspond the the values of an enum in 
the driver. It was suggested that the current approach would be clearer 
then setting 0, 1, or 2.

Thanks for reviewing,
Andrew

> Rob
