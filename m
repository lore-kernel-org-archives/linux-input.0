From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: multitouch: Add quirk for N-trig (1b96:1B05)
Date: Fri, 18 Sep 2015 09:27:04 -0400
Message-ID: <CAN+gG=Evj=9aHxQSKYN=29XXwNiT4qErX+JZ-rxk0saVUu-F9A@mail.gmail.com>
References: <1442502394-21214-1-git-send-email-daniel.martin@secunet.com>
	<CADscph2McwY0Fi1CNM7XHHHK2+Qt5uNNmZ7AEhxNYz3PFD8mcA@mail.gmail.com>
	<CAN+gG=FX+UF91t=Mhpxt0w4b8Gw7RCJdM_i1AqdDzUOuNeyqVg@mail.gmail.com>
	<CADscph3UxU4RH1u8YyELP_xGWOZMtD5Jbhp2iLFTA_Wmsri6cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36128 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbbIRN1F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2015 09:27:05 -0400
Received: by wicgb1 with SMTP id gb1so32505927wic.1
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2015 06:27:04 -0700 (PDT)
In-Reply-To: <CADscph3UxU4RH1u8YyELP_xGWOZMtD5Jbhp2iLFTA_Wmsri6cg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Martin <consume.noise@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

[re-adding the lists, I went off-list to clarify]

On Fri, Sep 18, 2015 at 9:12 AM, Daniel Martin <consume.noise@gmail.com> wrote:
> On 18 September 2015 at 13:54, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> On Fri, Sep 18, 2015 at 7:50 AM, Daniel Martin <consume.noise@gmail.com> wrote:
>>> What's the problem with last minute fixes, which look so simple that
>>> they can't cause any harm?
>>> ... This patch is discarded! :/
>>
>> Either I am missing something, either you misinterpret me. I never
>> said that your patch should be discarded.
>>
>> Could you elaborate a little bit more (by setting the context) please?
>
> With this patch (including my last minute changes) we may end up with
> stuck ghost touches.
>
> - We have to increase num_received in mt_complete_slot() if we see and
> skip a suspicious contact. Otherwise we don't send the sync report
> when necessary. Atm. we just return.
> - But, then I noticed that even this is not sufficient. I had to add
> MT_QUIRK_NOT_SEEN_MEANS_UP. Which bugs me, cause the reports looked
> okay - I always saw a tipswitch=0. Either I didn't saw it or there's
> another problem in the slot number computation.
>
> For now, I'm going home and take some homework with me.
>
> Cheers,
>     Daniel
>
> PS: With my last minute changes I removed an obvious facepalm, which
> looked okay at the beginning, though ...
>     slotnum = contactid % maxcontacts can't be right. ;)

OK thanks for the explanations. Jiri, please note not to pull this one :)

Cheers,
Benjamin
