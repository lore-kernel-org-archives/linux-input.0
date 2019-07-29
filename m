From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Date: Mon, 29 Jul 2019 20:43:06 +0200
Message-ID: <20190729184306.GA767@penguin>
References: <1564415994-22871-1-git-send-email-info@metux.net>
 <20190729172607.GB755@penguin>
 <b2912c1d-a6d8-ad2a-3e37-19e4d3d1bd3b@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b2912c1d-a6d8-ad2a-3e37-19e4d3d1bd3b@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 29, 2019 at 08:14:52PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 29.07.19 19:26, Dmitry Torokhov wrote:
> 
> Hi,
> 
> > As I think I mentioned a while back I would prefer to get gpiolob >
> > support swnode-backed properties so that the driver would not need
> to> know about differences between ACPI, DT and static board files.
> Indeed would be nice. But I think we should get rid of raw gpio IDs in
> favour of gpiod lookup tables first.
> 
> > I just recently re-posted patches for this, let's see if we can get them > landed in the kernel.
> Can you give me a pointer ?

https://patchwork.kernel.org/cover/11042915/

I tried putting you on CC list there, did you not get them?

Thanks.

-- 
Dmitry
