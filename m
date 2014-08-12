From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND: PATCH 1/2] mfd: tc3589x: Add device tree bindings
Date: Tue, 12 Aug 2014 20:02:02 +0200
Message-ID: <CACRpkdY2xjp9=muE5WFoN3smzgC+cqR0ijgD306nXi7owEGyyw@mail.gmail.com>
References: <1397028480-15413-1-git-send-email-linus.walleij@linaro.org>
	<20140617202340.GW29841@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:45833 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbaHLSCD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 14:02:03 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so7572943obc.12
        for <linux-input@vger.kernel.org>; Tue, 12 Aug 2014 11:02:02 -0700 (PDT)
In-Reply-To: <20140617202340.GW29841@lee--X1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Jun 17, 2014 at 10:23 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 09 Apr 2014, Linus Walleij wrote:
>
>> This defines the device tree bindings for the Toshiba TC3589x
>> series of multi-purpose expanders. Only the stuff I can test
>> is defined: GPIO and keypad. Others may implement more
>> subdevices further down the road.
>>
>> This is to complement
>> commit a435ae1d51e2f18414f2a87219fdbe068231e692
>> "mfd: Enable the tc3589x for Device Tree" which left off
>> the definition of the device tree bindings.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v2->v3:
>> - Fix the keys/rows bindings to be u32 rather than
>>   /bits/ 8, inconsistency noted by Mark Rutland.
>> ChangeLog v1->v2:
>> - Include a verbose example in the DT bindings.
>> - Explain why this is a stand-alone bindings patch.
>> ---
>>  Documentation/devicetree/bindings/mfd/tc3589x.txt | 107 ++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/tc3589x.txt
>
> Looks about right, been on the list for ages and doesn't add any new
> properties.  Applied, thanks.

This wasn't in the v3.17 pull request AFAICT :-(

Did it get dropped to the floor accidentally?

Yours,
Linus Walleij
