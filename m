From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 2/17] input: RMI4 core bus and sensor drivers.
Date: Tue, 25 Sep 2012 16:53:31 -0700
Message-ID: <506243FB.8010408@synaptics.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com> <1345241877-16200-3-git-send-email-cheiny@synaptics.com> <CACRpkdbxJ0=SLuw+av4xxkABWR2MbXrS_T=HYzfCaZdXVLeTjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:50458 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab2IYXxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Sep 2012 19:53:34 -0400
In-Reply-To: <CACRpkdbxJ0=SLuw+av4xxkABWR2MbXrS_T=HYzfCaZdXVLeTjw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <magnus.damm@gmail.com>

Sorry about the delay in following up on this one - we're going over the 
feedback, and realized we'd missed this comment.


On 08/23/2012 01:55 AM, Linus Walleij wrote:
>> +/* Create templates for given types */
>> >+#define simple_show_union_struct_unsigned(regtype, propname)\
>> >+simple_show_union_struct(regtype, propname, "%u\n")
>> >+
>> >+#define simple_show_union_struct_unsigned2(regtype, reg_group, propname)\
>> >+simple_show_union_struct2(regtype, reg_group, propname, "%u\n")
>> >+
>> >+#define show_union_struct_unsigned(regtype, reg_group, propname)\
>> >+show_union_struct(regtype, reg_group, propname, "%u\n")
>> >+
>> >+#define show_store_union_struct_unsigned(regtype, reg_group, propname)\
>> >+show_store_union_struct(regtype, reg_group, propname, "%u\n")
>> >+
>> >+#define show_repeated_union_struct_unsigned(regtype, reg_group, propname)\
>> >+show_repeated_union_struct(regtype, reg_group, propname, "%u")
>> >+
>> >+#define show_store_repeated_union_struct_unsigned(regtype, reg_group, propname)\
>> >+show_store_repeated_union_struct(regtype, reg_group, propname, "%u")
>> >+
>> >+/* Remove access to raw format string versions */
>> >+/*#undef simple_show_union_struct
>> >+#undef show_union_struct_unsigned
>> >+#undef show_store_union_struct
>> >+#undef show_repeated_union_struct
>> >+#undef show_store_repeated_union_struct*/
> This looks like trying to reimplement ioctl() in sysfs.
>
> If what you want is to send big structs in/out of the kernel,
> use either ioctl() on device nodes (should be trivial since input
> is using real device nodes) or use configfs.

I'm a little confused.  There's repeated emphasis in the kernel doc that 
you shouldn't use ioctl() anymore - use sysfs instead.  So we've been 
using sysfs, though it seems somewhat klutzy.  If it's actually OK to 
use ioctl(), that could simplify things.  On the other hand, using 
configfs might be more appropriate.
