From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
Date: Thu, 7 Feb 2019 23:31:02 -0800
Message-ID: <20190208073102.GA31622@dtor-ws>
References: <20190207222740.GA38612@dtor-ws>
 <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-input@vger.kernel.org, Danilo Krummrich <danilokrummrich@dk-develop.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Feb 07, 2019 at 06:03:03PM -0500, Sven Van Asbroeck wrote:
> On Thu, Feb 7, 2019 at 5:27 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > +       flush_work(&drvdata->tx_work.work);
> 
> Would cancel_work_sync() be better than flush_work() ?

No, because we want to have interrupt and gpios in a consistent state.
If we cancel then we need to see if we should disable it or it may
already be disabled, etc. This way we know it is enabled after
flush_delayed_work() returns, and we need to disable it.

Thanks.

-- 
Dmitry
