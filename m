From: agust@denx.de
Subject: Re: [PATCH v2] Touchscreen driver for FT5x06 based EDT displays
Date: Thu, 15 Dec 2011 13:17:27 +0100
Message-ID: <20111215131727.83266xhan7tbcl8g@webmail.mnet-online.de>
References: <1317311577-29742-1-git-send-email-simon.budig@kernelconcepts.de>
 <1317311577-29742-2-git-send-email-simon.budig@kernelconcepts.de>
 <20111202145146.33d5b8be@wker> <4EE9D333.8050107@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33975 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab1LOMRp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Dec 2011 07:17:45 -0500
In-Reply-To: <4EE9D333.8050107@kernelconcepts.de>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ilya Yanok <yanok@emcraft.com>

Hi Simon,

Simon Budig <simon.budig@kernelconcepts.de> wrote:
...
> On 12/02/2011 02:51 PM, Anatolij Gustschin wrote:
>> there is a number of issues with this patch. Please check it
>> using 'scripts/checkpatch.pl' and fix them before posting next
>> patch version. Thanks! Please see a comment below.
>
> Ok, There are a lot of warnings/errors regarding my use of spaces for
> alignment of multi-line function calls.
>
> (i.e. use tabs for the logical indentation level plus spaces to align
> e.g. function arguments behind the opening parenthesis)
>
> <tab><tab>function (argument1,
> <tab><tab>          argument2);
>
> This has the advantage of not breaking alignment when changing tab
> width. Is this something acceptable in the kernel? It seems CodingStyle
> is open to interpretation there, not sure if the conding style is open
> for discussion though...  :)
>
> Or should I just globally replace 8 subsequent spaces with a tab?

My understanding is that CodingStyle insists on tabs for
indentation and tabs are always 8 characters wide. Additional
indentation for alignment of function arguments is done by
spaces, i.e.:

<tab>function(arg1,
<tab><tab>    arg2);

>> passing platform data for specifying reset_pin should be optional,
>> I think. There are hardware configurations without wired gpio for
>> /RST controlling, /RST is controlled by HW-circuitry. The driver
>> should be usable with such configurations, too. Can you please
>> change the driver so that controlling reset pin becomes optional?
>
> Will do.

Thanks,

Anatolij


