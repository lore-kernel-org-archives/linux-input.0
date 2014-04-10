From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/4] serio: Add pnp_id to struct serio
Date: Thu, 10 Apr 2014 10:03:21 +0200
Message-ID: <53465049.1070305@redhat.com>
References: <1397052181-22768-1-git-send-email-hdegoede@redhat.com> <1397052181-22768-2-git-send-email-hdegoede@redhat.com> <20140409180652.GA3060@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20633 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965073AbaDJIDZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Apr 2014 04:03:25 -0400
In-Reply-To: <20140409180652.GA3060@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi,

On 04/09/2014 08:06 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Wed, Apr 09, 2014 at 04:02:59PM +0200, Hans de Goede wrote:
>> Serio device drivers need access to the pnp_id of the serio port, windows
>> drivers bind by the pnp-id and some drivers need to know the exact pnp-id
>> used so they know exactly with which hardware model / revision they are
>> dealing with.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  include/linux/serio.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/serio.h b/include/linux/serio.h
>> index 9f779c7..6532440 100644
>> --- a/include/linux/serio.h
>> +++ b/include/linux/serio.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/device.h>
>>  #include <linux/mod_devicetable.h>
>> +#include <linux/pnp.h>
>>  #include <uapi/linux/serio.h>
>>  
>>  struct serio {
>> @@ -28,6 +29,7 @@ struct serio {
>>  	bool manual_bind;
>>  
>>  	struct serio_device_id id;
>> +	struct pnp_id *pnp_id;
> 
> Why do we need this if we are already adding generic 'firmware_id'
> attribute?

In patch 4/4 we do pnp-id matching in synaptics.c to set the new
INPUT_PROP_TOPBUTTONPAD property on relevant touchpads. Since the kernel
has a special pnp_id type + pnp_id matching code, the correct thing to
do is to use that for in kernel pnp-id matching, which means that we
need to propagate the pnp-id to the serio drivers.

Regards,

Hans
