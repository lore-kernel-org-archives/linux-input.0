From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 04/05] input synaptics-rmi4: rmi_driver - Export some
 symbols and functions for use by reflash.
Date: Mon, 10 Mar 2014 15:54:59 -0700
Message-ID: <531E42C3.5000800@synaptics.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com> <1394245795-17347-4-git-send-email-cheiny@synaptics.com> <20140310150448.GD18578@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:23298 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaCJWzB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 18:55:01 -0400
In-Reply-To: <20140310150448.GD18578@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 03/10/2014 08:04 AM, Courtney Cavin wrote:
> On Sat, Mar 08, 2014 at 03:29:54AM +0100, Christopher Heiny wrote:
>> Reflash functionality will need to unload the existing functions and
>> rescan the PDT before starting reflash; then reload the functions
>> afterwards.
>>
>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>> Signed-off-by: Vincent Huang <vincent.huang@tw.synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Linux Walleij <linus.walleij@linaro.org>
>> Cc: David Herrmann <dh.herrmann@gmail.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>>
>> ---
>>
>>   drivers/input/rmi4/rmi_driver.c | 165 ++++++++++++++++++++++------------------
>>   drivers/input/rmi4/rmi_driver.h |  22 +++---
>>   2 files changed, 101 insertions(+), 86 deletions(-)
> [...]
>> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> [...]
>> -int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
>> -			u16 pdt_address);
>> +#define RMI_SCAN_CONTINUE	0
>> +#define RMI_SCAN_DONE		1
>> +
>> +int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
>> +		 int (*callback)(struct rmi_device *rmi_dev,
>> +				 void *ctx, const struct pdt_entry *entry));
>
> I don't really like this callback.  The main reason for it is early
> abort of PDT scanning, right?  It is really that beneficial?

Well, the main reason for adding this that there are several places 
where we perform a PDT scan, and they were proving vulnerable to 
cut-and-paste errors and code drift.  The boilerplate code of the 
process of doing a PDT scan was also obscuring the actual purpose of 
each PDT scan.

Early abort of the PDT scan is also important - in some of the scans you 
want to quit as soon as you've found the function(s) of interest, or if 
you detect that the device is still in bootloader mode.  Since there are 
256 possible RMI4 pages to scan, stopping early provides serious time 
savings at boot time and during the reflash process.  It also simplifies 
the code when the device comes up in bootloader mode.


>>
>>   bool rmi_is_physical_driver(struct device_driver *);
>>   int rmi_register_physical_driver(void);
>> @@ -113,4 +109,10 @@ void rmi_unregister_physical_driver(void);
>>   int rmi_register_f01_handler(void);
>>   void rmi_unregister_f01_handler(void);
>>
>> +int check_bootloader_mode(struct rmi_device *rmi_dev,
>> +			  const struct pdt_entry *pdt);
>
> This is a silly function name to put in a header. rmi_* perhaps?

Yes, I noticed that too while preparing the patch, along with a lot of 
other instances.  I decided to do an overall namespace cleanup later, 
and not piggyback it onto this particular patchset.  I'll fix this one 
if it's a blocking issue.

>
>> +void rmi_free_function_list(struct rmi_device *rmi_dev);
>> +int rmi_driver_detect_functions(struct rmi_device *rmi_dev);
>> +
>> +
>>   #endif
>
> -Courtney
>


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
