From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] Input: touchscreen: AD7879: prevent invalid finger data
 reports
Date: Mon, 25 Oct 2010 12:02:48 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D59177130945B1B98@LIMKCMBX1.ad.analog.com>
References: <1287408804-19789-1-git-send-email-michael.hennerich@analog.com>
 <20101022050007.GB10493@core.coreip.homeip.net>
 <544AC56F16B56944AEC3BD4E3D59177130945B1763@LIMKCMBX1.ad.analog.com>
 <20101022163049.GA20816@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:64476 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab0JYLCx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Oct 2010 07:02:53 -0400
In-Reply-To: <20101022163049.GA20816@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>

Dmitry Torokhov wrote on 2010-10-22:
> On Fri, Oct 22, 2010 at 08:16:48AM +0100, Hennerich, Michael wrote:
>> Dmitry Torokhov wrote on 2010-10-22:
>>> Hi Michael,
>>>
>>> On Mon, Oct 18, 2010 at 03:33:24PM +0200,
>>> michael.hennerich@analog.com
>>> wrote:
>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>
>>>> Considering following scenario - the touch is present on the screen
>>>> at the beginning of the last conversion sequence, but by the time the
>>>> last sequence is finished, the finger is lift off. The AD7879 data
>>>> available interrupt signals (DAV) completion, however some X,Y values
>>>> are not valid because the screen inputs were floating during the
>>>> acquisition.
>>>>
>>>> The AD7877 acts differently here, since it only asserts DAV if
>>>> the touch is still present when the conversion sequence finished.
>>>>
>>>> Based on the fact that this can only happen in the last sample of
>>>> the repeated conversion sequence. We simply skip the last. (Short
>>>> glitches are filtered by the AD7879 internal median and average
>>>> filters) This doesn't cause noticeable side effects, since the
>>>> minimum conversion interval is 9.44ms. We receive ~100 waypoint
>>>> samples per second, so we simply delay the result by 9.44ms.
>>>>
>>>> Actually this patch repeats the first waypoint twice and then
> skips
>>> the last.
>>>
>>> Input core won't actually pass the 2nd instance through. I think the
>>> whole thing should look like the patch below.
>>
>> I know input core suppresses identical events.
>> Your patch looks nicer, however it will delay the first response by
>> one Interrupt. Considering the minimum automatic conversion interval
>> of 9.44ms
>> - Not sure how much this really matters.
>>
>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>>
>
> Thanks Michael. I think 10-15ms delay should not be noticeable for
> user input, however you have the hardware, any chance you could try and see?

I can confirm that 10ms delay is not noticeable. However this version of the patch
may skip if the touch is very short, so it also implements event filtering of contacts
shorter than 20ms.

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif


