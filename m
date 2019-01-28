From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.20 148/304] Input: rotary-encoder - don't log
 EPROBE_DEFER to kernel log
Date: Mon, 28 Jan 2019 14:08:53 -0500
Message-ID: <20190128190852.GI3973@sasha-vm>
References: <20190128154341.47195-1-sashal@kernel.org>
 <20190128154341.47195-148-sashal@kernel.org>
 <20190128182405.GA30191@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128182405.GA30191@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 28, 2019 at 10:24:05AM -0800, Dmitry Torokhov wrote:
>Hi Sasha,
>
>On Mon, Jan 28, 2019 at 10:41:05AM -0500, Sasha Levin wrote:
>> From: Uwe Kleine-König <uwe@kleine-koenig.org>
>>
>> [ Upstream commit 0832e93632c61987d504e251b927a2be769dd21a ]
>>
>> When a driver fails to bind because a resource it still missing it's not
>> helpful to report this as (usually) probing is repeated later.
>
>I do not think that patch that merely suppresses a harmless warning in
>dmesg belongs in stable.

I'll drop it.

FWIW, my experience with users is that unexplained warnings in dmesg
sometimes end up being even more trouble than an actual bug :)

--
Thanks,
Sasha
