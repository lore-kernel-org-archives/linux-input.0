From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] hid/apple: add module parameter to swap the Command and
 Option keys
Date: Fri, 06 Mar 2009 23:13:07 +0100
Message-ID: <49B19FF3.2000605@gmail.com>
References: <87zlfz8bc1.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:50596 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbZCFWNP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2009 17:13:15 -0500
In-Reply-To: <87zlfz8bc1.fsf@burly.wgtn.ondioline.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Collins <paul@burly.ondioline.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 6.3.2009 06:33, Paul Collins wrote:
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -40,6 +40,11 @@ module_param(fnmode, uint, 0644);
>   MODULE_PARM_DESC(fnmode, "Mode of fn key on Apple keyboards (0 = disabled, "
>   		"[1] = fkeyslast, 2 = fkeysfirst)");
>
> +static unsigned int swapmodifiers = 0;

Nowadays compilers optimize this away already, but no need to initialize 
.bss stuff to zero anyway.

> +module_param(swapmodifiers, uint, 0644);
> +MODULE_PARM_DESC(fnmode, "Modifiers match labels or positions "

Weird first parameter => swapmodifiers.

Maybe this should rather be a bool instead of uint.

> +		 "([0] = labels, 1 = positions)");
> +
>   struct apple_sc {
>   	unsigned long quirks;
>   	unsigned int fn_on;
> @@ -123,6 +128,14 @@ static struct apple_key_translation apple_iso_keyboard[] = {
>   	{ }
>   };
>
> +static struct apple_key_translation apple_swap_modifiers[] = {

This might go into .rodata, right? => const

Anyway this is not feasible to do in this patch. Would you like to post 
a followup patch which will also modify the functions which use the 
translation tables?
