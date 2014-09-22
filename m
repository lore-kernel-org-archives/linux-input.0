From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 2/3] cap1106: support for active-high interrupt option
Date: Mon, 22 Sep 2014 09:44:02 +0200
Message-ID: <541FD342.6080508@zonque.org>
References: <1411268469-21283-1-git-send-email-mranostay@gmail.com> <1411268469-21283-3-git-send-email-mranostay@gmail.com> <541EA326.1070404@zonque.org> <20140922055656.GA4147@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:40086 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbaIVHoF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Sep 2014 03:44:05 -0400
In-Reply-To: <20140922055656.GA4147@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>, galak@codeaurora.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org

On 09/22/2014 07:56 AM, Dmitry Torokhov wrote:
> On Sun, Sep 21, 2014 at 12:06:30PM +0200, Daniel Mack wrote:
>> On 09/21/2014 05:01 AM, Matt Ranostay wrote:
>>> Some applications need to use the active-high push-pull interrupt
>>> option. This allows it be enabled in the device tree child node.
>>>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>>> ---
>>>  drivers/input/keyboard/cap1106.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/input/keyboard/cap1106.c b/drivers/input/keyboard/cap1106.c
>>> index b9c43b5..33e2590 100644
>>> --- a/drivers/input/keyboard/cap1106.c
>>> +++ b/drivers/input/keyboard/cap1106.c
>>> @@ -234,6 +234,12 @@ static int cap1106_i2c_probe(struct i2c_client *i2c_client,
>>>  			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
>>>  	}
>>>  
>>> +	if (of_property_read_bool(node, "microchip,active-high")) {
>>
>> I think the name of that property should make clear it's only changing
>> the interrupt output driver configuration. What about
>> "microchip,irq-active-high"?
> 
> Can we infer the setting from IRQ flags by chance?

Hmm, I thought of that as well, but there could be electrical wiring
setups that want the CPU's hardware pin in push/pull mode but the one on
the sensor chip in open-drain. I'd rather not make the assuption the
pins are directly connected and have both sides individually configurable.


Thanks,
Daniel

