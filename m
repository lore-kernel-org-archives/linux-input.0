From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 3/3] psmouse: Add support for detecting FocalTech PS/2
 touchpads
Date: Mon, 15 Sep 2014 19:42:43 +0200
Message-ID: <54172513.5000802@redhat.com>
References: <1410512912-11609-1-git-send-email-hdegoede@redhat.com> <1410512912-11609-4-git-send-email-hdegoede@redhat.com> <20140913002629.GA12622@core.coreip.homeip.net> <5413FBEF.3020101@redhat.com> <20140915173957.GA14457@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807AbaIORmv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 13:42:51 -0400
In-Reply-To: <20140915173957.GA14457@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

Hi,

On 09/15/2014 07:39 PM, Dmitry Torokhov wrote:
> On Sat, Sep 13, 2014 at 10:10:23AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 09/13/2014 02:26 AM, Dmitry Torokhov wrote:
>>> Hi Hans,
>>>
>>> On Fri, Sep 12, 2014 at 11:08:32AM +0200, Hans de Goede wrote:
>>>> +/* Always check for focaltech, this is safe as it uses pnp-id matching */
>>>> +	if (psmouse_do_detect(focaltech_detect, psmouse, set_properties) == 0) {
>>>> +		if (!set_properties || focaltech_init(psmouse) == 0) {
>>>> +			/* Not supported yet, use bare protocol */
>>>> +			psmouse_max_proto = PSMOUSE_PS2;
>>>
>>> I do not believe we need to muck with psmouse_max_proto here, so I'll
>>> drop it and apply.
>>
>> Oh, but we do need to set psmouse_max_proto, otherwise this won't work, as
>> I already tried to explain in the review of v1 (but clearly failed to do so).
>>
>> psmouse_initialize() checks psmouse_max_proto, and if it is not set to
>> PSMOUSE_PS2 does things which upsets these touchpads.
> 
> Ouch.. so even basic set rate/set resolution messes it up?

Yes, this is one of the reasons why baking this patch took longer then
expected, because my initial version failed as it did not set psmouse_max_proto.

Regards,

Hans
