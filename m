From: =?ISO-8859-1?Q?R=E9mi_H=E9rilier?= <rherilier@yahoo.fr>
Subject: Re: wistron_btns-add-support-for-x86_64-systems.patch in -mm
Date: Sat, 05 Jan 2008 18:52:06 +0100
Message-ID: <477FC3C6.8070607@yahoo.fr>
References: <20071223144756.GA4827@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp107.plus.mail.mud.yahoo.com ([68.142.206.240]:45325 "HELO
	smtp107.plus.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753031AbYAERwS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Jan 2008 12:52:18 -0500
In-Reply-To: <20071223144756.GA4827@basil.nowhere.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dtor@mail.ru, linux-input@vger.kernel.org

Andi Kleen wrote:
> While looking for something else I stumbled over
> 
> wistron_btns-add-support-for-x86_64-systems.patch
> 
> in -mm. The patch looks very dubious to me. It basically
> calls a BIOS function in long mode. To work like implemented
> the BIOS would need to know magically what it was called
> from (32bit or 64bit) and then execute different code paths.
> 
> It's very unlikely that this works. Most likely 
> it will crash and if it happens to currently work 
> it will be extremly fragile and crash at some future
> point.
> 
> If anything you would need to set up a compat mode segment
> and call the BIOS from that, but there are other problems
> like interrupts not working etc (compat mode is somewhat
> limited). Early in the x86-64 port there was a decision
> to not call any BIOS calls from long mode because of these
> problems. 
> 
> The only sane way to call that code would be to do so
> from user space using some kind of emulator (e.g. like
> the x server does) 
> 
> So I think the patch should be dropped.
> 
> -Andi
> 
> 

Thanks you for your reply and these informations.

What about finding what does this BIOS function and writing
an equivalent in C? There would be no BIOS call anymore and
this module could be used in the x86-64 port.

But, is it a sane solution?


Remi




