From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [PATCH] doc: dt/bindings: input: Fix drv260x binding document
Date: Fri, 22 Aug 2014 14:25:13 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49DF1F66@DFLE09.ent.ti.com>
References: <1408716741-1163-1-git-send-email-dmurphy@ti.com>
 <20140822141532.GC22707@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Felipe

On 08/22/2014 09:15 AM, Balbi, Felipe wrote:
> On Fri, Aug 22, 2014 at 09:12:21AM -0500, Dan Murphy wrote:
>> Update the drv260x dt binding document:
>> - Change the node name to the devices function not the
>> device name.
>> - Add vbat-supply to the example.
>> - Fix indentation of the example.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  .../devicetree/bindings/input/ti,drv260x.txt       |   19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/ti,drv260x.txt b/Documentation/devicetree/bindings/input/ti,drv260x.txt
>> index a9c8519..214e25d 100644
>> --- a/Documentation/devicetree/bindings/input/ti,drv260x.txt
>> +++ b/Documentation/devicetree/bindings/input/ti,drv260x.txt
>> @@ -37,15 +37,16 @@ Optional properties:
>>  			  3.2 v.
>>  Example:
>>  
>> -drv2605l: drv2605l@5a {
>> -		compatible = "ti,drv2605l";
>> -		reg = <0x5a>;
>> -		enable-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> -		mode = <DRV260X_LRA_MODE>;
>> -		library-sel = <DRV260X_LIB_LRA>;
>> -		vib-rated-mv = <3200>;
>> -		vib-overdriver-mv = <3200>;
>> -};
>> +haptics:@5a {
> 
> haptics: haptics@5a ??
> 

I found both types of entries in the bindings docs.

There is no consistency within the input bindings documentation.

I have no issue doing it either way.

Dan

-- 
------------------
Dan Murphy
