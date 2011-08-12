From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 1/6] input: misc: AD714x: The interrupt status registers
 should be read in row.
Date: Fri, 12 Aug 2011 10:58:27 +0200
Message-ID: <4E44EB33.7090302@analog.com>
References: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com> <544AC56F16B56944AEC3BD4E3D5917713AAF21C14E@LIMKCMBX1.ad.analog.com> <20110518071428.GA32284@core.coreip.homeip.net> <544AC56F16B56944AEC3BD4E3D5917713AAF21C871@LIMKCMBX1.ad.analog.com> <20110519080042.GA19405@core.coreip.homeip.net> <544AC56F16B56944AEC3BD4E3D59177143003C5938@LIMKCMBX1.ad.analog.com> <20110804075426.GB31276@core.coreip.homeip.net>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:15333
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751133Ab1HLI6T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 04:58:19 -0400
In-Reply-To: <20110804075426.GB31276@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On 08/04/2011 09:54 AM, Dmitry Torokhov wrote:
> On Wed, Aug 03, 2011 at 09:40:22AM +0100, Hennerich, Michael wrote:
>> Hennerich, Michael wrote on 2011-07-13:
>>> Dmitry Torokhov wrote on 2011-05-19:
>>>> On Wed, May 18, 2011 at 08:10:09PM +0100, Hennerich, Michael wrote:
>>>>> Dmitry Torokhov wrote on 2011-05-18:
>>>>>> On Tue, May 17, 2011 at 12:01:27PM +0100, Hennerich, Michael wrote:
>>>>>>> Hi Dmitry,
>>>>>>>
>>>>>>> I noticed you added patches 2/6, 3/6, 4/6 and 5/6 to your next tree.
>>>>>>> But how about these ones?
>>>>>>>
>>>>>>> [PATCH v2 1/6] input: misc: AD714x: The interrupt status
>>>>>>> registers should be read in row. [PATCH v2 6/6] input: misc:
>>>>>>> AD714x: Fix endianness issues.
>>>>>>>
>>>>>> Hi Michael,
>>>>>>
>>>>>> Still pondering these two, give me a couple of days please...
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>> Hi Dmitry,
>>>>>
>>>>> No Problem - let me know in case you need some further clarification.
>>>>> Both patches are tested on several platforms and addresses real issues.
>>>>>
>>>>> BTW - are you going to merge the adp5589 driver anytime soon?
>>>>> Are there open issues you like to get addressed first?
>>>>>
>>>> Oh, thanks for reminding me of it, I queued it for .40.
>>>>
>>>> Thanks.
>>>>
>>> Hi Dmitry,
>>>
>>> Still pondering these two?
>>>
>>> [PATCH v2 1/6] input: misc: AD714x:
>>>        The interrupt status registers should be read in row.
>>> [PATCH v2 6/6] input: misc: AD714x: Fix endianness issues.
>>>
>>> Greetings,
>>> Michael
>>>
>> Hi Dmitry,
>>
>> Are you going to apply these two missing patches?
>>
> Hi Michael,
>
> Yes, should be in the next pull (not todays one).
>
> Thanks.
>
Hi Dmitry,

Hmmm... Are you sure?
I can't find it.


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


