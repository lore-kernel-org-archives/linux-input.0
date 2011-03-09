From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 1/4] hid-multitouch: Auto detection of maxcontacts
Date: Wed, 9 Mar 2011 11:14:59 +0100
Message-ID: <AANLkTimQJpb41P-+xJX6BKCGWmNSF0rwGFwP7U97prA4@mail.gmail.com>
References: <1299601979-4871-1-git-send-email-benjamin.tissoires@enac.fr>
	<1299601979-4871-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110309084222.GA3569@polaris.bitmath.org>
	<AANLkTin4KsPWRfFEEYXkjWdnEnXyiMyDGc6eEWFA_kWx@mail.gmail.com>
	<20110309093809.GA3980@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61222 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757141Ab1CIKPB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Mar 2011 05:15:01 -0500
In-Reply-To: <20110309093809.GA3980@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 9, 2011 at 10:38, Henrik Rydberg <rydberg@euromail.se> wrote:
> On Wed, Mar 09, 2011 at 10:03:45AM +0100, Benjamin Tissoires wrote:
>> On Wed, Mar 9, 2011 at 09:42, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > Hi Benjamin,
>> >
>> >> This patch enables support of autodetection of maxcontacts.
>> >> We can still manually provide maxcontact in case the device
>> >> lies on it.
>> >>
>> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> >
>> > It seems quite alright to let the classes contain the expected number
>> > of contacts, so I do not really see the reason for that part of the
>> > patch. How about keeping the maxcontacts in the class, and then do
>> > max(hid-provided-maxcontacts, default-maxcontacts)?
>> >
>>
>> Yep, I've got three particular reasons:
>> - 3M: there are two devices now, 1968 and 2256. The first one is a 10
>> touches only, whereas the second one is a 60 touches.
>
> Right, so increasing the number of touches based on device information
> seems like a good idea.

So the patch is useful.

>
>> - autodetection of multitouch devices. I have some patches on my tree
>> (that we do not want to go upstream right now for some reasons) that
>> allows us to plug any unknown multitouch devices and to let
>> hid-multitouch handling it. As most of the devices are 2 touches only,
>> and as the generic way to work with a multitouch devices is to iterate
>> over all the slots, using 10 touches by default infers a lot of
>> instructions that can be avoided.
>
> Right, so keeping the default number of touches per class seems like a
> good idea.

That's the way the patch works: we can still manually provide the
maxcontact per class, but if it's not needed (the device sends proper
value), then we can skip it.

>
>> - finally, it simplifies the writing of the new CLS (we just need to
>> know how the device works to add the right quirks).
>
> Right, we always need to know how the device works. :-)

What I meant was the dynamic behavior of the device, not the static
capabilities. ;)

Am I right if I take your reply as an Ack?

Cheers,
Benjamin
