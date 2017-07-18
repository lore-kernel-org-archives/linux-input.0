From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 2/2] mfd: axp20x: use correct platform device id for many
 PEK
Date: Tue, 18 Jul 2017 09:43:54 +0200
Message-ID: <2ea34792-3775-7534-3c06-5bf7ca8211c6@free-electrons.com>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-3-quentin.schulz@free-electrons.com>
 <20170718071936.llnpgwqmgzt2axea@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46462 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdGRHoX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Jul 2017 03:44:23 -0400
In-Reply-To: <20170718071936.llnpgwqmgzt2axea@dell>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

Hi Lee,

On 18/07/2017 09:19, Lee Jones wrote:
> On Mon, 17 Jul 2017, Quentin Schulz wrote:
> 
>> According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
>> AXP809 and AXP813 PEK have different values for startup time bits from
>> the AXP20X, let's use the platform device id with the correct values.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/mfd/axp20x.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Patch is find, but are these names reference from platform data
> anywhere i.e. are we going to break anything by applying it?
> 

I don't really understand what you're asking.

We need the first patch of this patch series to be applied before the
second patch or axp20x-pek driver wouldn't be probed anymore.

There is no Device Tree declaring axp20x-pek and there is no support for
Device Tree probing in the driver.

I don't see how I could break anything with these patches. Could you
explain with an abstract example, please? I might not break anything
here but it's better to know now what I could have broken in another
situation/with another patch series so I won't make that mistake in the
future.

Oh, but this patch series would change the name of the directory exposed
in sysfs (/sys/bus/platform/devices/axp221-pek/*). Is that what you were
afraid of?

Thanks,
Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
