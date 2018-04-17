From: Nandor Han <nandor.han@ge.com>
Subject: Re: EXT: Re: [PATCHv1] Input: atmel_mxt_ts - fix the firmware update
Date: Tue, 17 Apr 2018 09:37:54 +0300
Message-ID: <18fcfdcc-d43a-6ee3-07d5-af618b600e12@ge.com>
References: <20180322164330.24809-1-sebastian.reichel@collabora.co.uk>
 <20180323194736.7fhgb6qjkwbivsvx@hairyalien>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323194736.7fhgb6qjkwbivsvx@hairyalien>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-input@vger.kernel.org

On 23/03/18 21:47, Nick Dyer wrote:
> On Thu, Mar 22, 2018 at 05:43:30PM +0100, Sebastian Reichel wrote:
>> The automatic update mechanism will trigger an update if the
>> info block CRCs are different between maxtouch configuration
>> file (maxtouch.cfg) and chip.
>>
>> The driver compared the CRCs without retrieving the chip CRC,
>> resulting always in a failure and firmware flashing action
>> triggered. The patch will fix this issue by retrieving the
>> chip info block CRC before the check.
> 
> Thanks for raising this, I agree it's definitely something we want to
> fix.
> 
> However, I'm not convinced you're solving the problem in the best way.
> You've attached it to the read_t9_resolution() code path, whereas the
> info block is common between T9 and T100 and works in the same way.
> 
> Would you mind trying the below patch? I've dusted it off from some
> work that I did back in 2012 and it should solve your issue.
> 
> It also has the benefit that by reading the information block and the
> object table into a contiguous region of memory, we can verify the
> checksum at probe time. This means we make sure that we are indeed
> talking to a chip that supports object protocol correctly.
> 

Thanks Nick. This looks like a better solution.
Sebastian will test this and we can see the results.


Nandor
