From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] synaptics: Change min/max quirk table to pnp-id matching
Date: Mon, 26 May 2014 13:47:31 +0200
Message-ID: <538329D3.1090902@redhat.com>
References: <1400266009-5436-1-git-send-email-hdegoede@redhat.com> <1400266009-5436-4-git-send-email-hdegoede@redhat.com> <20140518203535.GA13276@core.coreip.homeip.net> <5379C5FD.1040401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19573 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbaEZLrf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 07:47:35 -0400
In-Reply-To: <5379C5FD.1040401@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org

Hi Dmitry,

On 05/19/2014 10:51 AM, Hans de Goede wrote:
> Hi,
> 
> On 05/18/2014 10:35 PM, Dmitry Torokhov wrote:
>> On Fri, May 16, 2014 at 08:46:49PM +0200, Hans de Goede wrote:
>>> Most of the affected models share pnp-ids for the touchpad. So switching
>>> to pnp-ids give us 2 advantages:
>>> 1) It shrinks the quirk list
>>> 2) It will lower the new quirk addition frequency, ie the recently added W540
>>>    quirk would not have been necessary since it uses the same LEN0034 pnp ids
>>>    as other models already added before it
>>>
>>> As an added bonus it actually puts the quirk on the actual psmouse, rather then
>>> on the machine, which is technically more correct.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>  drivers/input/mouse/synaptics.c | 149 ++++++++++------------------------------
>>>  1 file changed, 36 insertions(+), 113 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>>> index 395ec9c..c5ec703 100644
>>> --- a/drivers/input/mouse/synaptics.c
>>> +++ b/drivers/input/mouse/synaptics.c
>>> @@ -117,6 +117,31 @@ void synaptics_reset(struct psmouse *psmouse)
>>>  }
>>>  
>>>  #ifdef CONFIG_MOUSE_PS2_SYNAPTICS
>>> +struct min_max_quirk {
>>> +	const char * const *pnp_ids;
>>> +	int x_min, x_max, y_min, y_max;
>>> +};
>>
>>
>> Why don't we define this as 1 quirk per PNP id?
>>
>> struct min_max_quirk {
>> 	const char *pnp_id;
>> 	int x_min, x_max, y_min, y_max;
>> };
>>
>> ?
> 
> 1) I thought it would be better to allow multiple ids for one min/max quad,
> since there seem to only be a few types of touchpads out there, which are
> sometimes referenced to by multiple ids. IE LEN0034 and LEN2004 refer to the
> exact same touchpad (exact same firmware and board id). Also this way we avoid
> people adding entries with values which are slightly off since determining
> the min/max range on a single model will give some noise.
> 
> 2) This way we can use one helper function for the matching for both the
> INPUT_PROP_TOPBUTTONPAD quirks and for the min/max quirks.

I've not heard back from you on this, does that mean that you are ok with
taking this patch-set as is ?

Regards,

Hans
