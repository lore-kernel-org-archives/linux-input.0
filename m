From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input synaptics-rmi4: Use put_device() and device_type.release()
 to free storage.
Date: Tue, 11 Feb 2014 18:17:57 -0800
Message-ID: <52FAD9D5.5070900@synaptics.com>
References: <1392160410-8293-1-git-send-email-cheiny@synaptics.com> <20140212015929.GZ1706@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:20884 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbaBLCR6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Feb 2014 21:17:58 -0500
In-Reply-To: <20140212015929.GZ1706@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Courtney Cavin <courtney.cavin@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 02/11/2014 05:59 PM, Courtney Cavin wrote:
> On Wed, Feb 12, 2014 at 12:13:30AM +0100, Christopher Heiny wrote:
>> For rmi_sensor and rmi_function device_types, use put_device() and
>> the assocated device_type.release() function to clean up related
>> structures and storage in the correct and safe order.
>>
>> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Linux Walleij <linus.walleij@linaro.org>
>> Cc: David Herrmann <dh.herrmann@gmail.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>> Cc: Courtney Cavin <courtney.cavin@sonymobile.com>
>
> I'm not a huge fan of you taking my patches, re-formatting them and
> sending them as your own.  More out of principle then actually caring
> about ownership.  You at least cc'd me on this one....

Sorry - no slight was intended at all!  I wasn't sure what the protocol 
was for picking up an idea from someone else's patch and building on 
that idea, so I just went with the CC.  I definitely prefer to attribute 
sources correctly - if you could clarify what should be done (beyond the 
CC) to acknowledge the author of the original patch, I'd appreciate it.

>
>>
>> ---
>>
>>   drivers/input/rmi4/rmi_bus.c    | 65 +++++++++++++++--------------------------
>>   drivers/input/rmi4/rmi_driver.c | 11 ++-----
>>   2 files changed, 25 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
>> index 96a76e7..1b9ad80 100644
>> --- a/drivers/input/rmi4/rmi_bus.c
>> +++ b/drivers/input/rmi4/rmi_bus.c
> [...]
>> @@ -185,6 +153,23 @@ static void rmi_function_teardown_debugfs(struct rmi_function *fn)
>>   }
>>
>>   #endif
>> +static void rmi_release_function(struct device *dev)
>> +{
>> +	struct rmi_function *fn = to_rmi_function(dev);
>> +	rmi_function_teardown_debugfs(fn);
>> +	kfree(fn->irq_mask);
>
> If you are going to do this, then you need to remove the other call to
> free this mask in rmi_free_function_list().

Okidoki.

>
>> +	kfree(fn);
>> +}
>
> -Courtney
