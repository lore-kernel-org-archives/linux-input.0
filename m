From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 1/3] HID: Use existing parser for pre-scanning the report
 descriptors
Date: Fri, 16 Aug 2013 10:54:52 +0200
Message-ID: <520DE8DC.7020800@ahsoftware.de>
References: <1376405889-12378-1-git-send-email-benjamin.tissoires@redhat.com> <1376405889-12378-2-git-send-email-benjamin.tissoires@redhat.com> <20130813191731.GA8391@polaris.bitmath.org> <520BA464.9060200@redhat.com> <520BE280.6010407@ahsoftware.de> <CAN+gG=FEHefW-4XrCTkDY2_Jfj+uWZ=g_uc-2BsgFdW2My=VvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:42794 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab3HPI6d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Aug 2013 04:58:33 -0400
In-Reply-To: <CAN+gG=FEHefW-4XrCTkDY2_Jfj+uWZ=g_uc-2BsgFdW2My=VvA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Am 15.08.2013 19:36, schrieb Benjamin Tissoires:
> On Wed, Aug 14, 2013 at 10:03 PM, Alexander Holler <holler@ahsoftware.de> wrote:
>>>>> -       hid->group = HID_GROUP_GENERIC;
>>>>> +       parser = vzalloc(sizeof(struct hid_parser));
>>>>
>>>>
>>>> Argh, I realize it is inevitable for this patch, but it still makes my
>>>> eyes bleed. The parser takes quite a bit of memory...
>>>
>>>
>>> Yep, my first attempt was to remove it, then I re-added it with a small
>>> tear...
>>
>>
>> So you actually create a new parser and the subject (that existing) of this
>> patch is misleading.
> 
> Hi Alexander,
> 
> I think you misread what Henrik and I were discussing about:
> Henrik complained about using the heap for something which is just
> used in this function, and using the stack would have been better.
> However, the size of the parser is too big that the compiler complains
> when we declare it on the stack.
> 
> So this line is just a copy/paste from the function hid_open_report(),
> and thus, you can agree that I did not create a new parser.

Hmm, not really, you do instantiate a new parser, wherever that one lives.

Of course, the code for the parser already exists, but at first I've
read the subject such, that something will be used which already was in
use. That "existing" did mislead me.

I think "Use hid_parser for ..." would describe the change more verbose
as the patch changes runtime behaviour quite a bit (by dispatching
everything through the parser).

Regards,

Alexander Holler
