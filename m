From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] Input: ps2-gpio - flush TX work when closing port
Date: Fri, 8 Feb 2019 11:21:39 -0500
Message-ID: <CAGngYiU=7k_5cP+UJBFePC=ZmN+YT57PEbZiDv58synviQXX0A@mail.gmail.com>
References: <20190207222740.GA38612@dtor-ws> <CAGngYiWzC92Lw+Z-BAtPfEHgys0vcQOxdxo7g_JHKHF36-Hm7Q@mail.gmail.com>
 <20190208073102.GA31622@dtor-ws> <fad6ebf83d088d676f0ba825ad4572ed@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fad6ebf83d088d676f0ba825ad4572ed@dk-develop.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 8, 2019 at 10:51 AM Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:
>
> I agree with Dmitry
>

So do I, you guys are absolutely right.
As far as I can see, this patch fixes the user-after-free.
So, after Dmitry changes flush_work() to flush_delayed_work() :

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
