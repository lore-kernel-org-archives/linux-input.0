From: Todd Fischer <todd.fischer@ridgerun.com>
Subject: Re: [PATCH 10/32] input/tps6507x-ts: use system_wq instead of dedicated
 workqueue
Date: Mon, 03 Jan 2011 09:34:43 -0700
Message-ID: <4D21FAA3.8030505@ridgerun.com>
References: <1294062595-30097-1-git-send-email-tj@kernel.org> <1294062595-30097-11-git-send-email-tj@kernel.org> <20110103143926.GX1886@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110103143926.GX1886@bicker>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dan,

Polling is only necessary because I was given brain dead hardware.  I 
was expecting updated hardware with the interrupt signal connected 
properly, but haven't received it yet.

Any reasonable hardware will not need tps6507x-ts polling.  I was under 
the impression I could only push patches that I have tested.  Since I 
haven't tested an interrupt version of the driver, I didn't include a 
patch that removes the polling and replaces it with interrupts.

I have another customer planning on using the TPS6507x chip for touch 
screen.  I expect their hardware in around 3 weeks.

Todd

On 01/03/2011 07:39 AM, Dan Carpenter wrote:
> On Mon, Jan 03, 2011 at 02:49:33PM +0100, Tejun Heo wrote:
>> With cmwq, there's no reason to use a separate workqueue.  Drop
>> tps6507x_ts->wq and use system_wq instead.
>>
>> Signed-off-by: Tejun Heo<tj@kernel.org>
>> Cc: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>> Cc: linux-input@vger.kernel.org
>> Cc: Dan Carpenter<error27@gmail.com>
>> Cc: Todd Fischer<todd.fischer@ridgerun.com>
>> ---
>> Only compile tested.  Please feel free to take it into the subsystem
>> tree or simply ack - I'll route it through the wq tree.
>>
> This is that driver that polls every 30 ms.  :/  Todd, is there no way
> to avoid this?  What was the status on that?
>
> regards,
> dan carpenter
>
>
