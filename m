From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCHv2] hid: remove duplicate ID for D-WAV eGalax 0x7224
Date: Mon, 13 May 2013 11:21:40 +0200
Message-ID: <CAN+gG=GFahJ9YG02nFYNyH4dEjkKfD0CMh9hPcdiZ5XyGBrcSA@mail.gmail.com>
References: <1367937493-16844-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<51891425.5070300@redhat.com>
	<1367997792.29283.23.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39967 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3EMJVm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 May 2013 05:21:42 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so6147292lbv.13
        for <linux-input@vger.kernel.org>; Mon, 13 May 2013 02:21:40 -0700 (PDT)
In-Reply-To: <1367997792.29283.23.camel@smile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

On Wed, May 8, 2013 at 9:23 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2013-05-07 at 16:48 +0200, Benjamin Tissoires wrote:
>> On 05/07/2013 04:38 PM, Andy Shevchenko wrote:
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > ---
>>
>> I bet it will be easier to track for Jiri if you resend the full series:
>> - the egalax reordering
>> - the remove of the duplicate ID
>>
>> As mentioned previously, also remove the entry in hid-multitouch (the
>> one containing MT_CLS_EGALAX, not the _SERIAL one).
>
> Then it repeats v1, doesn't it?

I can not speak for Jiri, but IMO, it's easier to say:
"Hey Jiri, pick up the patch series  v3 for this topic", instead of
"Hey Jiri, please pick the patch 1 from v1 and patch 2 from v4 about
this topic."

So I would say yes, repeat v1 but add a comment in the cover letter
explaining the changes (for example, no changes in patch 1/2, patch
2/2 amended like this and that).

>
> The difference between MT_USB_DEVICE and HID_USB_DEVICE macros is
> in .group member. Does it somehow affect device matching?
>

It does internally to some extend, but it won't change the final handling.
MT_USB_DEVICE is cleaner because it will ask to grab only the MT
interface. HID_USB_DEVICE will introduce a race with hid-generic to
handle the non-MT interfaces, which are not present in the eGalax case
IIRC. So basically, we just missed that HID_USB_ / MT_USB_ problem
when including the patch upstream.

Cheers,
Benjamin
