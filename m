From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2 03/10] Input: synaptics-rmi4: Add device tree support
 for RMI4 I2C devices
Date: Fri, 15 Jan 2016 11:16:04 -0800
Message-ID: <56994574.3010002@synaptics.com>
References: <1452815059-22980-1-git-send-email-aduggan@synaptics.com>
 <CAFmnZc3Ce40CT9V8X223aPxfbRXUcRX5RvK=0GitQ5yrPVXhOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:1127 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755069AbcAOTQG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 14:16:06 -0500
In-Reply-To: <CAFmnZc3Ce40CT9V8X223aPxfbRXUcRX5RvK=0GitQ5yrPVXhOg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org

Hi Audrey,

On 01/15/2016 03:24 AM, Andrey Gusakov wrote:
> On Fri, Jan 15, 2016 at 2:44 AM, Andrew Duggan <aduggan@synaptics.com> wrote:
>> Add devicetree binding for I2C devices and add bindings for optional
>> parameters in the function drivers. Parameters for function drivers are
>> defined in child nodes for each of the functions.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ...
>> +#ifdef CONFIG_OF
>> +static void rmi_function_of_probe(struct rmi_function *fn)
>> +{
>> +       char of_name[8];
>> +
>> +       snprintf(of_name, sizeof(of_name), "rmi4-f%02x",
>> +               fn->fd.function_number);
>> +       fn->dev.of_node = of_find_node_by_name(
>> +                               fn->rmi_dev->xport->dev->of_node, of_name);
>> +}
>>
> Name like "rmi4-f11" including 0 terminator does not fit in 8 chars.
> This leads to the inability to find the correct OF node and get settings.

Oh, I missed that! I'll fix it in the next patch series.

Thanks,
Andrew

> Sorry for previous HTML noise.

