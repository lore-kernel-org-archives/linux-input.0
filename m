From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 02/06] input/rmi4: Core files
Date: Mon, 22 Oct 2012 14:58:47 -0700
Message-ID: <5085C197.7020906@synaptics.com>
References: <1349496603-20775-1-git-send-email-cheiny@synaptics.com>  <1349496603-20775-3-git-send-email-cheiny@synaptics.com>  ,<1349525982.2008.86.camel@joe-AO722>  <BFABBC009FBA1C43B207B15FD485ABD922C22B7B@USW-MAIL1.synaptics-inc.local> <1349924771.2243.16.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:27164 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219Ab2JVV6u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Oct 2012 17:58:50 -0400
In-Reply-To: <1349924771.2243.16.camel@joe-AO722>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>

On 10/10/2012 08:06 PM, Joe Perches wrote:
> On Thu, 2012-10-11 at 02:49 +0000, Christopher Heiny wrote:
>> Joe Perches wrote:
> []
>>>> +     list_for_each_entry(entry, &data->rmi_functions.list, list)
>>>> +             if (entry->irq_mask)
>>>> +                     process_one_interrupt(entry, irq_status,
>>>> +                                           data);
>>>
>>> style nit, it'd be nicer with braces.
>>
>> I agree with you, but checkpatch.pl doesn't. :-(
>
> Sure it does.
>
> $ cat t.c
> {
> 	list_for_each_entry(entry, &data->rmi_functions.list, list) {
> 		if (entry->irq_mask)
> 			process_one_interrupt(entry, irq_status, data);
> 	}
> }
> $ ./scripts/checkpatch.pl --strict -f t.c
> total: 0 errors, 0 warnings, 0 checks, 7 lines checked
>
> t.c has no obvious style problems and is ready for submission.

I stand corrected.  Thanks!
