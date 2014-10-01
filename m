From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH] HID: cp2112: remove use of gpiochip_remove() retval
Date: Wed, 01 Oct 2014 13:49:16 +0530
Message-ID: <542BB904.1010705@smartplayin.com>
References: <1412087049-4368-1-git-send-email-pramod.gurav@smartplayin.com> <alpine.LNX.2.00.1410010917000.26311@pobox.suse.cz> <542BACB3.3010203@smartplayin.com> <alpine.LNX.2.00.1410011000450.26311@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1410011000450.26311@pobox.suse.cz>
Sender: linux-gpio-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday 01 October 2014 01:31 PM, Jiri Kosina wrote:
> On Wed, 1 Oct 2014, Pramod Gurav wrote:
> 
>>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>>> Cc: Alexandre Courbot <gnurou@gmail.com>
>>>>> Cc: Jiri Kosina <jkosina@suse.cz>
>>>>> Cc: linux-input@vger.kernel.org 
>>>>> Cc: linux-gpio@vger.kernel.org
>>>>>
>>>>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>>> I guess this depends on some other patch that hasn't gone to Linus yet, 
>>> right? As Linus' tree currently has this prototype:
>>>
>>> 	int gpiochip_remove(struct gpio_chip *chip)
>>
>> Yes. It is yet to make it to linus's tree. But the change is there in
>> linux-next master branch.
> 
> Alright. It probably makes most sense to take this patch together with the 
> prototype change in one pile (i.e. not through my tree).
> 
> For that purpose
> 
> 	Acked-by: Jiri Kosina <jkosina@suse.cz>

Jiri,

Just realized when Linus told me these changes are already in his tree
as well as in mast of linux-tree. Sorry for spaming and late realizing this.

> 
