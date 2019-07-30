From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: applespi - register touchpad device
 synchronously in probe
Date: Tue, 30 Jul 2019 15:39:27 +0300
Message-ID: <20190730123927.GN23480@smile.fi.intel.com>
References: <20190721070523.24695-1-ronald@innovation.ch>
 <20190729132203.GB1201@penguin>
 <20190730065648.GA20206@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190730065648.GA20206@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mao Wenan <maowenan@huawei.com>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 29, 2019 at 11:56:48PM -0700, Life is hard, and then you die wrote:
> On Mon, Jul 29, 2019 at 03:22:03PM +0200, Dmitry Torokhov wrote:
> > On Sun, Jul 21, 2019 at 12:05:23AM -0700, Ronald Tschalär wrote:

> > Question: is it possible to read command response synchronously as well?
> > I.e. I was wondering if we could add 2 (or 1?) more read xfers for the
> > actual result that is coming after the status response, and then we
> > could use spi_sync() to send the command and read the whole thing.
> 
> Yes'ish. But you still need to wait for the GPE to know when to read
> the response, and while you're doing so any number of keyboard and
> trackpad events may arrive (i.e. you may need to do any number of read
> xfers). I suppose those events could all just be discarded, though. So
> something like this:
> 
>     assemble-info-cmd(write_msg)

>     spi_sync(write_msg)
>     
>     while (1) {
>         wait_event_timeout(wait_queue, gpe_received, timeout)
>         spi_sync(read_msg)
>         if (is-info-cmd-response(read_msg))
>             break
>     }

Just a side note if you ever going to implement such loops.

Consider in this or similar case do {} while approach with more straight exit
conditional.

Like

	assemble-info-cmd(write_msg)

	do {
		spi_sync(read_msg)
		wait_event_timeout(wait_queue, gpe_received, timeout)
	} while (!is-info-cmd-response(read_msg)

> and also modify the gpe-handler to wake the wait_queue instead of
> issuing an spy_async() while doing the above.
> 
> I guess the advantage would certainly be the need to avoid the
> spi-flushing in case of a timeout, at the expense of some slight
> duplication of some of the received-message handling logic (would
> refactor make most re-usable, of course).
> 
> So would this be the preferred approach then?

-- 
With Best Regards,
Andy Shevchenko
