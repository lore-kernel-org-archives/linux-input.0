From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 8/17] input: RMI4 F09 Built-In Self Test
Date: Tue, 4 Sep 2012 17:21:13 -0700
Message-ID: <50469AF9.7010508@synaptics.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com> <1345241877-16200-9-git-send-email-cheiny@synaptics.com> <CACRpkdaq7StwG_jg+hZCcU668=VrcUeZa7qP6R_2v9ugkkX38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:29084 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab2IEAVP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Sep 2012 20:21:15 -0400
In-Reply-To: <CACRpkdaq7StwG_jg+hZCcU668=VrcUeZa7qP6R_2v9ugkkX38w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Henrik Rydberg <rydberg@euromail.se>

On 08/27/2012 03:07 PM, Linus Walleij wrote:
[snip]
>> >+static struct device_attribute attrs[] = {
>> >+       __ATTR(status, RMI_RW_ATTR,
>> >+                  rmi_f09_status_show, rmi_f09_status_store),
>> >+       __ATTR(limitRegisterCount, RMI_RO_ATTR,
>> >+              rmi_f09_limit_register_count_show, rmi_store_error),
>> >+       __ATTR(hostTestEnable, RMI_RW_ATTR,
>> >+              rmi_f09_host_test_enable_show, rmi_f09_host_test_enable_store),
>> >+       __ATTR(internalLimits, RMI_RO_ATTR,
>> >+              rmi_f09_internal_limits_show, rmi_store_error),
>> >+       __ATTR(resultRegisterCount, RMI_RO_ATTR,
>> >+              rmi_f09_result_register_count_show, rmi_store_error),
>> >+       __ATTR(overall_bist_result, RMI_RO_ATTR,
>> >+              rmi_f09_overall_bist_result_show, rmi_store_error),
>> >+       __ATTR(test_number_control, RMI_RW_ATTR,
>> >+              rmi_f09_test_number_control_show,
>> >+              rmi_f09_test_number_control_store),
>> >+       __ATTR(test_result1, RMI_RO_ATTR,
>> >+              rmi_f09_test_result1_show, rmi_store_error),
>> >+       __ATTR(test_result2, RMI_RO_ATTR,
>> >+              rmi_f09_test_result2_show, rmi_store_error),
>> >+       __ATTR(run_bist, RMI_RW_ATTR,
>> >+              rmi_f09_run_bist_show, rmi_f09_run_bist_store),
>> >+       __ATTR(f09_control_test1, RMI_RW_ATTR,
>> >+              rmi_f09_control_test1_show, rmi_f09_control_test1_store),
>> >+       __ATTR(f09_control_test2, RMI_RW_ATTR,
>> >+              rmi_f09_control_test2_show, rmi_f09_control_test2_store),
>> >+};
> If this is*only*  for tests, then for sure this should be in debugfs?

F09 is used in the final product (for example, a phone or tablet) both 
on the production line and to diagnose failures in returned products. 
We can't be certain that the phone/tablet/whatever manufacturer will 
include debugfs in their production kernel, and if they don't they 
almost certainly won't want to install a different kernel on the 
production line to run a test, so we provided a sysfs interface to this.

>
>> >+static int rmi_f09_alloc_memory(struct rmi_function_container *fc)
> (...)
>> >+static void rmi_f09_free_memory(struct rmi_function_container *fc)
> Why do you need separate functions for these two?
>
> If they are only used from one place (which I suspect) then just
> put the code at that site.

Some of the other modules have fairly large and complicated 
alloc_memory() and free_memory() implementations, so we adopted this as 
a general convention in all the RMI function implementations.  But as 
you suggested elsewhere, using devm_kzalloc could tidy things up a lot, 
in which case the functions could be merged back into their callers.

[snip]
