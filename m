From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v5 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Fri, 12 Feb 2016 10:10:23 -0800
Message-ID: <56BE200F.5040602@synaptics.com>
References: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
 <CACRpkdaE91ncWccG9_dsOiC40j9mFpm7A=S_mpeHmP-vjSVjMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:14869 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750886AbcBLSKY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2016 13:10:24 -0500
In-Reply-To: <CACRpkdaE91ncWccG9_dsOiC40j9mFpm7A=S_mpeHmP-vjSVjMQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

On 02/12/2016 04:54 AM, Linus Walleij wrote:
> On Wed, Feb 10, 2016 at 11:23 PM, Andrew Duggan <aduggan@synaptics.com> wrote:
>
>> This is the v5 patch series which fixes the issues identified by kbuild
>> and coccinelle in the previous patch series. These include:
>>
>> - Using ARRAY_SIZE instead of a custom macro to calculate the size of the
>>    function handler array.
>> - Remove setting the .owner field for the driver in rmi_i2c and rmi_spi
>>    since the i2c-core and spi set that field.
>> - Fix if statment in rmi_f30 which was testing has_led twice instead of
>>    testing has_gpio.
> Works like a charm.
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for testing. At this point except for the touchscreen binding 
rename fix needed in patch 5, all of the outstanding issues have been 
addressed. If the rest of the patch series is acceptable, then I can do 
a final v6 respin which fixes the binding and also removes the HID 
patch. But, if more work needs to be done on the patch series I can wait 
to do the respin. Dmitry, what do you think of the patch series at this 
point?

Thanks,
Andrew

> Yours,
> Linus Walleij

