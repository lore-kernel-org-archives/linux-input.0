From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 5/6] Input: psmouse - factor out common protocol probing
 code
Date: Thu, 3 Dec 2015 09:33:53 +0100
Message-ID: <565FFE71.4050404@redhat.com>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
 <1448774036-39040-6-git-send-email-dmitry.torokhov@gmail.com>
 <565F0C50.2090502@redhat.com> <20151202191839.GD15531@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46135 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013AbbLCIeA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Dec 2015 03:34:00 -0500
In-Reply-To: <20151202191839.GD15531@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org

Hi,

On 02-12-15 20:18, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Wed, Dec 02, 2015 at 04:20:48PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> Thanks for splitting out the series, patches 1 - 4 look good to me and are:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> I've some comments inline for this one.
>
> Thanks for spending time on reviewing this.
>
>>> @@ -1025,68 +1053,48 @@ static int psmouse_extensions(struct psmouse *psmouse,
>>>   	 * Trackpads.
>>>   	 */
>>>   	if (max_proto > PSMOUSE_IMEX &&
>>> -			cypress_detect(psmouse, set_properties) == 0) {
>>> -		if (IS_ENABLED(CONFIG_MOUSE_PS2_CYPRESS)) {
>>> -			if (cypress_init(psmouse) == 0)
>>> -				return PSMOUSE_CYPRESS;
>>> -
>>> -			/*
>>> -			 * Finger Sensing Pad probe upsets some modules of
>>> -			 * Cypress Trackpad, must avoid Finger Sensing Pad
>>> -			 * probe if Cypress Trackpad device detected.
>>> -			 */
>>> -			return PSMOUSE_PS2;
>>> -		}
>>> -
>>> -		max_proto = PSMOUSE_IMEX;
>>> +	    psmouse_try_protocol(psmouse, PSMOUSE_CYPRESS, &max_proto,
>>> +				 set_properties, true)) {
>>> +		return PSMOUSE_CYPRESS;
>>>   	}
>>
>> The protocols array has the CYPRESS entry wrapped in "#ifdef CONFIG_MOUSE_PS2_CYPRESS"
>> so this bit of the patches changes behavior of the probe order if
>> CONFIG_MOUSE_PS2_CYPRESS is not enabled. Before this patch the max_proto would
>> get limited to PSMOUSE_IMEX, but now the:
>>
>> 	proto = __psmouse_protocol_by_type(type);
>> 	if (!proto)
>> 		return false;
>>
>> Part of psmouse_try_protocol will trigger and then max_proto will stay unmodified.
>>
>> I think this can best be fixed by always including CYPRESS in the proto array,
>> and have init be a stub which always fails when CYPRESS is not actually enabled.
>
> I would not want to do that as that would make cypress be in the list of
> supported protocols whereas it is actually compiled out.
>
> BUT, there is actually no problem, the original code was misleading.
> cypress_detect() is already a stub returning -ENOSYS when
> CONFIG_MOUSE_PS2_CYPRESS is not enabled, so we would never went into
> that "if" body in that case.

Ah, so the whole "if (IS_ENABLED(CONFIG_MOUSE_PS2_CYPRESS))" check in the original
code was not really necessary, I see.

> I'll make a patch cleaning it up, but won't repost the whole series so
> as to not clutter the list.

Ack.

>>>
>>>   	if (max_proto > PSMOUSE_IMEX) {
>>> -		if (psmouse_do_detect(genius_detect,
>>> -				      psmouse, set_properties) == 0)
>>> +		if (psmouse_try_protocol(psmouse, PSMOUSE_GENPS,
>>> +					 &max_proto, set_properties, true))
>>>   			return PSMOUSE_GENPS;
>>>
>>> -		if (psmouse_do_detect(ps2pp_init,
>>> -				      psmouse, set_properties) == 0)
>>> +		if (psmouse_try_protocol(psmouse, PSMOUSE_PS2PP,
>>> +					 &max_proto, set_properties, true))
>>>   			return PSMOUSE_PS2PP;
>>
>> The PS2PP entry in the protocols table has an init function, by passing
>> in true here you are causing this to get called, where as it was not
>> being called before.
>
> No, it has detect function only (but called ps2pp_init), I'll post the
> patch renaming it to ps2pp_detect.

Right, I misread that as it having an init function.

>> p.s.
>>
>> After this change, a whole lot of the code has the form of:
>>
>> 	if (max_proto >= PSMOUSE_FOO &&
>> 	    psmouse_try_protocol(psmouse, ...)) {
>> 		return PSMOUSE_BAR;
>> 	}
>>
>> Maybe you can do a follow-up which makes PSMOUSE_FOO a parameter to
>> psmouse_try_protocol and move the test into psmouse_try_protocol?
>
> I considered it, but some protocols we detect unconditionally and some
> conditionally, passing a parameter woudl somewhat hide it. Plus
> try_protocol() already has a lot of parameters.

Ok.

>> Also you may want to consider to drop the {} around the single return
>> statement most of this code-blocks now have. Maybe best to do
>> this in a followup patch to keep the diff readable.
>
> I like to keep the braces if "if" condition is multi-line to better see
> where condition ends and body starts.

Fair enough, I've no problem with that.

With the above explanations this patch is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
