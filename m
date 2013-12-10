From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] elantech: Properly differentiate between clickpads
 and normal touchpads
Date: Tue, 10 Dec 2013 09:37:08 +0100
Message-ID: <52A6D2B4.8060104@redhat.com>
References: <1386599551-2339-1-git-send-email-hdegoede@redhat.com> <CAN+gG=Eh72eBS67db_KNsUzXRNsOUXB8YkzuuHoJca22xRAkdQ@mail.gmail.com> <52A6169C.1020904@redhat.com> <CAN+gG=FgR9cBwJ_GFrU3RAmwma0XWzt8Wdi-HM2zEOOmdPNS+A@mail.gmail.com> <20131210061256.GA12524@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab3LJIhQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 03:37:16 -0500
In-Reply-To: <20131210061256.GA12524@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, Duson Lin <dusonlin@emc.com.tw>

Hi,

On 12/10/2013 07:12 AM, Dmitry Torokhov wrote:

<snip>

>>>> Small question here: if the touchpad is a clickpad, should'nt we also
>>>> remove the BTN_RIGHT bit too?
>>>
>>>
>>> We could, but I don't see much value in that, and it would also require
>>> if statements in the sync methods to ensure that we don't tree to send
>>> a button event for a button we don't advertise.
>>
>> We don't need this test in the sync method. The test is already
>> implemented in input_event. So now, it's just a matter of taste
>> regarding upper layers. Peter, any thoughts on this?
>
> We should not advertise events that device does not generate. This
> should help userspace to decide if emulation is needed or not. Input
> core will drop events that are not set up as valid for device, so if we
> clear BTN_RIGHT there it should all work.

Ok, v2 adding the clearing of the BTN_RIGHT bit is on its way.

Regards,

Hans
