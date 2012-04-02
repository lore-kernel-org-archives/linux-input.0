From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/2] HID: hid-lg4ff: Use Private Data
Date: Mon, 02 Apr 2012 19:30:42 +0200
Message-ID: <4F79E242.5090300@suse.cz>
References: <a4e40aa5c43be934d83240849aa25f3b.squirrel@mungewell.org>    <1333378444-3117-1-git-send-email-simon@mungewell.org>    <4F79D486.5090605@suse.cz> <44acbf3ff0b6aa62eab2831ee6ecea80.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44090 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab2DBRar (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 13:30:47 -0400
In-Reply-To: <44acbf3ff0b6aa62eab2831ee6ecea80.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>

On 04/02/2012 07:01 PM, simon@mungewell.org wrote:
> 
>>> +	struct lg4ff_device_entry *uninitialized_var(entry);
>>> +	struct lg_drv_data *uninitialized_var(drv_data);
>>
>> You don't need uninitialized_var bloat anymroe, right?
> 
> I guess I don't fully understand the 'unitialized_var()' macro, and was
> just following the previous uses in the code.
> 
> Google'ing doesn't really help either. Is there a definitive guide as when
> to use and not?

The simple answer is: never.

It serves the purpose to shut up the compiler when it complains that the
variable might be uninitialized, but the programmer is sure it cannot.
In your case, the compiler should not even complain about that.

Advantage of the macro is that it adds no assembly, but still silents
the compiler.

thanks,
-- 
js
suse labs


