From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe fail before	retrying
Date: Sat, 17 Apr 2010 11:31:16 -0400
Message-ID: <4BC9D444.3090802@canonical.com>
References: <4BC8EA42.6030507@canonical.com> <1271502098.4155.27.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:42140 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0DQPbV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Apr 2010 11:31:21 -0400
In-Reply-To: <1271502098.4155.27.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-input@vger.kernel.org, rubini@cvml.unipv.it

Hi,

i8042.reset=1 was one the first things we tried and it didn't
improve the situation. Now looking at the code for
i8042_controller_reset, I don't recall seeing these printks
though I could double check. Any other suggestions for
resets or instrumentation? Thanks.

Peter

On 04/17/2010 07:01 AM, Christoph Fritz wrote:
> Am Freitag, den 16.04.2010, 18:52 -0400 schrieb Peter M. Petrakis:
>> I filed a bug on this too:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=15780
>>
>> This particular laptop will lose it's synaptics touch
>> pad on return from suspend state.
>
>> I came up with the attached work around which simply calls
>> psmouse_reset on the port should the initial probe fail.
>
> In i8042.c i8042_controller_selftest() gets also called after
> suspending: So give it a try and add "i8042.reset=1" to your
> kernel-parameters. If that works for you, add your device to the
> i8042_dmi_reset_table in i8042-x86ia64io.h or tell us the output
> of:
>   cat /sys/class/dmi/id/product_name
>   cat /sys/class/dmi/id/sys_vendor
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
