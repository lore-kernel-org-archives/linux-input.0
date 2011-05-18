From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v2 1/6] input: misc: AD714x: The interrupt status
 registers should be read in row.
Date: Wed, 18 May 2011 20:10:09 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF21C871@LIMKCMBX1.ad.analog.com>
References: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
 <544AC56F16B56944AEC3BD4E3D5917713AAF21C14E@LIMKCMBX1.ad.analog.com>
 <20110518071428.GA32284@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:41915
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933484Ab1ERTKV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2011 15:10:21 -0400
In-Reply-To: <20110518071428.GA32284@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

Dmitry Torokhov wrote on 2011-05-18:
> On Tue, May 17, 2011 at 12:01:27PM +0100, Hennerich, Michael wrote:
>> Hi Dmitry,
>>
>> I noticed you added patches 2/6, 3/6, 4/6 and 5/6 to your next tree.
>> But how about these ones?
>>
>> [PATCH v2 1/6] input: misc: AD714x: The interrupt status registers
>> should be read in row. [PATCH v2 6/6] input: misc: AD714x: Fix
>> endianness issues.
>>
>
> Hi Michael,
>
> Still pondering these two, give me a couple of days please...
>
> Thanks.
>

Hi Dmitry,

No Problem - let me know in case you need some further clarification.
Both patches are tested on several platforms and addresses real issues.

BTW - are you going to merge the adp5589 driver anytime soon?
Are there open issues you like to get addressed first?


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


