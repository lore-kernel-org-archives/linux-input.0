From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH] HID: sony: disable descriptor fixup for FutureMax Dance
 Mat
Date: Mon, 25 Jul 2016 18:25:03 +0300
Message-ID: <cd3e71a8-055b-3aa3-076e-cf96b9835232@kapsi.fi>
References: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
 <20160718142837.GK4663@mail.corp.redhat.com>
 <78cafd15-850f-3110-f63e-bb41f6b69c5c@kapsi.fi>
 <20160721183439.3edddbc6312555afda517f8c@ao2.it>
 <20160725091404.GD19383@mail.corp.redhat.com>
 <20160725130547.6c9b80c23fef6dfe50ad9979@ao2.it>
 <0888e980-5511-af8f-bd00-e94916cb6356@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:49233 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311AbcGYPZF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 11:25:05 -0400
In-Reply-To: <0888e980-5511-af8f-bd00-e94916cb6356@kapsi.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

On 07/25/16 18:23, Mikko Perttunen wrote:
> On 07/25/16 14:05, Antonio Ospite wrote:
>> You can also find out the length of the raw output report with trial and
>> error, start with a line like this:
>>
>> $ sudo hexdump -v -e '49/1 "%02x " "\n"' /dev/hidraw0
>>
>> and increase/decrease the value (49 works with original controllers)
>> until you see a regular pattern when comparing lines.
>>
>
> /dev/hidraw0 seems to be all zeroes straight from the beginning

Actually, pressing some buttons on the pad, it seems that the report 
length is two bytes

>
>> Anyways this is just for curiosity, we are not going to spend too much
>> time on that... or are we? :)
>
> At least it's some reference information.. :)
>
>>
>> Thanks,
>>    Antonio
>>
>
> Cheers,
> Mikko.
>

