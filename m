From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date: Tue, 11 Jun 2019 00:55:58 +0800
Message-ID: <7da443d0-f433-c5a5-5194-707362eb2ee5@canonical.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <20190609165551.GB90002@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190609165551.GB90002@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cheiny@synaptics.com, aduggan@synaptics.com, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org


On 6/10/19 12:55 AM, Dmitry Torokhov wrote:
> Hi Aaron,
> 
> On Wed, Feb 20, 2019 at 05:41:59PM +0100, Aaron Ma wrote:
>> rmi4 got spam data after S3 resume on some ThinkPads.
>> Then TrackPoint lost when be detected by psmouse.
>> Clear irqs status before set irqs will make TrackPoint back.
> Could you please give me an idea as to what this spam data is?
> 

It should be some data 0 during suspend/resume.
Actually I don't know how these data 0 is produced.
Not all synaptics touchpads have this issue.

> In F03 probe we clear all pending data before enabling the function,

Yes we did, but not after resume.

> maybe the same needs to be done on resume, instead of changing the way
> we handle IRQ bits?

This patch is supposed to clear irq status like it in fn probe. Not
changing IRQ bits.

Thanks,
Aaron

> 
> Thanks,
> 
> -- Dmitry
> 
