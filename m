From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V2 1/2] input: gpio-keys: add support for disable button
 from DT
Date: Wed, 13 Jan 2016 12:37:02 +0530
Message-ID: <5695F796.3030503@nvidia.com>
References: <1452665657-9412-1-git-send-email-ldewangan@nvidia.com> <20160113070609.GB8906@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15886 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbcAMHRV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 02:17:21 -0500
In-Reply-To: <20160113070609.GB8906@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com


On Wednesday 13 January 2016 12:36 PM, Dmitry Torokhov wrote:
> On Wed, Jan 13, 2016 at 11:44:16AM +0530, Laxman Dewangan wrote:
>> Add support to disable the button from DT via status property
>> if given button is not supporting on given platforms.
>>
>> This will help to re-use the existing dtsi file with status
>> enable/disable across platforms.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>> Changes from V1:
>> - Converted print to dev_dbg.
>>
>>   drivers/input/keyboard/gpio_keys.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>> index bef317f..08bada8 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -632,6 +632,14 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>>   	for_each_child_of_node(node, pp) {
>>   		enum of_gpio_flags flags;
>>   
>> +		/* Ignore the button if status of node is disabled */
>> +		error = of_device_is_available(pp);
>> +		if (!error) {
>> +			dev_dbg(dev, "Button %s is ignored\n", pp->name);
>> +			pdata->nbuttons--;
> Looking at this some more, maybe we should be using
> of_get_available_child_count() when calculating pdata->nbuttons (and do
> not decrement it here) and maybe even use
> for_each_available_child_of_node() in this loop and forego manual check.
>


yes, that is better option here. I was not knowing these APIs. Thanks 
for information. I will make another patch for this.

Thanks,
Laxman

