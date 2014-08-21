From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] doc: dt/bindings: input: introduce TI DRV2667 haptic
 driver description
Date: Thu, 21 Aug 2014 23:32:47 +0400
Message-ID: <53F6495F.9050204@cogentembedded.com>
References: <1408645143-25690-1-git-send-email-dmurphy@ti.com> <1408645143-25690-2-git-send-email-dmurphy@ti.com> <53F642AF.3070200@cogentembedded.com> <00FC9A978A94B7418C33AFAE8A35ED49DF0ABE@DFLE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:37841 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717AbaHUTcv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 15:32:51 -0400
Received: by mail-lb0-f171.google.com with SMTP id l4so8662439lbv.16
        for <linux-input@vger.kernel.org>; Thu, 21 Aug 2014 12:32:49 -0700 (PDT)
In-Reply-To: <00FC9A978A94B7418C33AFAE8A35ED49DF0ABE@DFLE09.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Murphy, Dan" <dmurphy@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/21/2014 11:14 PM, Murphy, Dan wrote:

[...]

>>> DRV2667 is a haptic/vibrator driver for Linear Resonant Actuators.
>>> Adding dt binding for this part

>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>    .../devicetree/bindings/input/ti,drv2667.txt       |   18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/input/ti,drv2667.txt

>>> diff --git a/Documentation/devicetree/bindings/input/ti,drv2667.txt b/Documentation/devicetree/bindings/input/ti,drv2667.txt
>>> new file mode 100644
>>> index 0000000..525216d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/input/ti,drv2667.txt
>>> @@ -0,0 +1,18 @@
>>> +Texas Instruments - drv2667 Haptics driver
>>> +
>>> +The drv2667 uses serial control bus communicates through I2C protocols
>>> +
>>> +Required properties:
>>> +	- compatible - "ti,drv2667" - DRV2667
>>> +	- reg -  I2C slave address
>>> +	- vbat-supply - Required supply regulator
>>> +
>>> +Example:
>>> +
>>> +drv2667: drv2667@59 {

>>      The ePAPR standard [1] has something to say on this matter:

> What is this reference?  Did not know this existed so wanted to read up on it.

    Sorry, forgot to paste the link. :-<

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei

