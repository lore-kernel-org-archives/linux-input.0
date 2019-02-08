From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
Date: Fri, 08 Feb 2019 16:51:53 +0100
Message-ID: <fad6ebf83d088d676f0ba825ad4572ed@dk-develop.de>
References: <20190207222740.GA38612@dtor-ws>
 <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
 <20190208073102.GA31622@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208073102.GA31622@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 2019-02-08 08:31, Dmitry Torokhov wrote:
> On Thu, Feb 07, 2019 at 06:03:03PM -0500, Sven Van Asbroeck wrote:
>> On Thu, Feb 7, 2019 at 5:27 PM Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> >
>> > +       flush_work(&drvdata->tx_work.work);
>> 
>> Would cancel_work_sync() be better than flush_work() ?
> 
> No, because we want to have interrupt and gpios in a consistent state.
> If we cancel then we need to see if we should disable it or it may
> already be disabled, etc. This way we know it is enabled after
> flush_delayed_work() returns, and we need to disable it.
> 
> Thanks.

I agree with Dmitry - thanks for the fix.

Acked-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
