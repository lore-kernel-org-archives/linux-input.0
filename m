From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v3 2/4] lib/hexdump.c: factor out generic hexdump
 formatting for reuse.
Date: Thu, 28 Mar 2019 03:29:28 -0700
Message-ID: <20190328102928.GB26446@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-3-ronald@innovation.ch>
 <CAHp75VebbroyOt6DPnqKVk99RowZsxgjuHbi6HoXf-tAuZLMqA@mail.gmail.com>
 <20190328003459.GG24753@innovation.ch>
 <20190328090350.GS9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328090350.GS9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


On Thu, Mar 28, 2019 at 11:03:50AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 27, 2019 at 05:34:59PM -0700, Life is hard, and then you die wrote:
> > 
> > On Wed, Mar 27, 2019 at 09:46:48AM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 27, 2019 at 3:49 AM Ronald Tschalär <ronald@innovation.ch> wrote:
> > > >
> > > > This introduces print_hex_dump_to_cb() which contains all the hexdump
> > > > formatting minus the actual printk() call, allowing an arbitrary print
> > > > function to be supplied instead. And print_hex_dump() is re-implemented
> > > > using print_hex_dump_to_cb().
> > > >
> > > > This allows other hex-dump logging functions to be provided which call
> > > > printk() differently or even log the hexdump somewhere entirely
> > > > different.
> 
> > > In any case, don't do it like this. smaller non-recursive printf() is
> > > better than one big receursive call.
> > > When it looks like an optimization, it's actually a regression.
> > 
> > Not sure where you see recursion here - are you referring to the
> > callback approach?
> 
> %pV is a recursive printf().

Ah!

> > Since dev_printk() ends up calling printk with a
> > dictionary as well as additional formatting, vs print_hex_dump()'s
> > stright use of printk, this seemed like the best way accommodate
> > various possible ways of logging the messages. But as per below I
> > guess this is moot.
> 
> I recommend to read this: https://lwn.net/Articles/780556/

Thanks, quite informative.


  Cheers,

  Ronald
