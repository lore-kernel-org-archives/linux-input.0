From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/2] HID: input: fix assignment of .value
Date: Tue, 23 Apr 2019 15:36:50 -0400
Message-ID: <20190423193650.GQ17719@sasha-vm>
References: <20190423154615.18257-2-benjamin.tissoires@redhat.com>
 <20190423172117.CC66520835@mail.kernel.org>
 <37009110-5a11-7ed4-3315-e87b98cc45b7@nurealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37009110-5a11-7ed4-3315-e87b98cc45b7@nurealm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: James Feeney <james@nurealm.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 23, 2019 at 11:54:07AM -0600, James Feeney wrote:
>On 4/23/19 11:21 AM, Sasha Levin wrote:
>> Hi,
>>
>> [This is an automated email]
>>
>> This commit has been processed because it contains a "Fixes:" tag,
>> fixing commit: 2dc702c991e3 HID: input: use the Resolution Multiplier for high-resolution scrolling.
>>
>> The bot has tested the following trees: v5.0.9.
>>
>> v5.0.9: Failed to apply! Possible dependencies:
>>     724f54bc0063 ("HID: input: make sure the wheel high resolution multiplier is set")
>>
>>
>> How should we proceed with this patch?
>>
>> --
>> Thanks,
>> Sasha
>>
>
>This patch will only apply *after* the application of the first patch, since they "overlap".
>
>Yes, that is probably not the best circumstance.  I think Benjamin wanted to keep the issue in patch 2/2 distinct.
>
>Was the first patch applied before attempting application of the second patch?

My script messed up and listed it as a dependency (even though it's not
upstream) rather than applying it. I'll look into it, sorry for the
noise.

--
Thanks,
Sasha
