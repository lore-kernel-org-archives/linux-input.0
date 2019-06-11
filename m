From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date: Tue, 11 Jun 2019 10:35:45 -0700
Message-ID: <20190611173545.GE143729@dtor-ws>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <20190609165551.GB90002@dtor-ws>
 <7da443d0-f433-c5a5-5194-707362eb2ee5@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7da443d0-f433-c5a5-5194-707362eb2ee5@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cheiny@synaptics.com, aduggan@synaptics.com, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On Tue, Jun 11, 2019 at 12:55:58AM +0800, Aaron Ma wrote:
> 
> On 6/10/19 12:55 AM, Dmitry Torokhov wrote:
> > Hi Aaron,
> > 
> > On Wed, Feb 20, 2019 at 05:41:59PM +0100, Aaron Ma wrote:
> >> rmi4 got spam data after S3 resume on some ThinkPads.
> >> Then TrackPoint lost when be detected by psmouse.
> >> Clear irqs status before set irqs will make TrackPoint back.
> > Could you please give me an idea as to what this spam data is?
> > 
> 
> It should be some data 0 during suspend/resume.
> Actually I don't know how these data 0 is produced.
> Not all synaptics touchpads have this issue.
> 
> > In F03 probe we clear all pending data before enabling the function,
> 
> Yes we did, but not after resume.

Yes, I understand that. The question I was asking: if we add code
consuming all pending data to f03->suspend(), similarly to what we are
doing at probe time, will it fix the issue with trackstick losing
synchronization and attempting disconnect?

> 
> > maybe the same needs to be done on resume, instead of changing the way
> > we handle IRQ bits?
> 
> This patch is supposed to clear irq status like it in fn probe. Not
> changing IRQ bits.

What I meant is changing how we enable IRQ bits. I would really prefer
we did not lose IRQ state for other functions when we enable interrupts
for given function.

Thanks.

-- 
Dmitry
