From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH 0/2] Add Apple SPI keyboard and trackpad driver
Date: Tue, 5 Feb 2019 05:14:30 -0800
Message-ID: <20190205131430.GA4225@innovation.ch>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <cdca5121-4f2b-2f74-8a1c-63fda385ee6f@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cdca5121-4f2b-2f74-8a1c-63fda385ee6f@bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


  Hi Henrik,

On Mon, Feb 04, 2019 at 09:47:55PM +0100, Henrik Rydberg wrote:
> Hi Ronald,
> 
> > This changeset adds a driver for the SPI keyboard and trackpad on recent
> > MacBook's and MacBook Pro's. The driver has seen a fair amount of use
> > over the last 2 years (basically anybody running linux on these
> > machines), with only relatively small changes in the last year or so.
> > For those interested, the driver development has been hosted at
> > https://github.com/cb22/macbook12-spi-driver/  (as well as my clone at
> > https://github.com/roadrunner2/macbook12-spi-driver/).
> > 
> > The first patch is just a placeholder for now and is provided in case
> > somebody wants to compile the driver while it's being reviewed here; the
> > real patch has been submitted to dri-devel and is being discussed there,
> > with the intent/hope that I can get an Ack and permission to merge it
> > through the input subsystem tree here as part of this patch series.
> 
> Great to see this upstream. The patch obviously has a lot in common with the
> previous keyboard and touchpad drivers; foremost this is a change of
> transport protocol and not functionality. That said, the code is compact and
> clear enough to make it hard to motivate any major effort to share more of
> existing code, at least initially.

Yes, some pieces have been copy-pasted from the existing drivers.
However, when I last reviewed those pieces they seemed a bit small and
I had a hard time seeing how to share them usefully at least for some
of it.

The pieces in question on the keyboard side (from the hid-apple
driver) are really the 'applespi_fn_codes' and 'apple_iso_keyboard'
tables, the corresponding 'applespi_find_translation()' function, and
some bits in the of the 'applespi_code_to_key()' function. Pulling out
the tables and maybe the applespi_find_translation() function into a
common include might be a simple change and take care of most of the
shared stuff.

A few lines were also lifted from the bcm5974 driver, basically the
'struct tp_finger' and the 'report_tp_state()' function. Though here
it's even harder to see how to share, as there are various small
differences scattered throughout the implemenation of that function.

> Barring detailed comments that are likely
> to produce new revisions, this looks like really good work.

Thank you for looking at this.


  Cheers,

  Ronald
