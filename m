From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Input: hyperv-keyboard: Use in-place iterator API in the
 channel callback
Date: Tue, 20 Aug 2019 11:29:15 -0400
Message-ID: <20190820152915.GM30205@sasha-vm>
References: <1566270066-27546-1-git-send-email-decui@microsoft.com>
 <20190820031805.GO121898@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190820031805.GO121898@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: Dexuan Cui <decui@microsoft.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 19, 2019 at 08:18:05PM -0700, dmitry.torokhov@gmail.com wrote:
>On Tue, Aug 20, 2019 at 03:01:23AM +0000, Dexuan Cui wrote:
>> Simplify the ring buffer handling with the in-place API.
>>
>> Also avoid the dynamic allocation and the memory leak in the channel
>> callback function.
>>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>> ---
>>
>> Hi Dmitry, can this patch go through Sasha's hyperv tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>>
>> This is a purely Hyper-V specific change.
>
>Sure, no problem.
>
>Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Queued up for hyperv-fixes, thank you.

--
Thanks,
Sasha
