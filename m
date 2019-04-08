From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Date: Mon, 8 Apr 2019 15:07:36 +0300
Message-ID: <20190408120736.GN9224@smile.fi.intel.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
 <20190328052917.GB18668@kroah.com>
 <20190328102755.GA26446@innovation.ch>
 <20190328112952.GA2232@kroah.com>
 <20190402024714.GA14213@innovation.ch>
 <20190402063326.GB7218@kroah.com>
 <20190407014613.GA14812@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190407014613.GA14812@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 06, 2019 at 06:46:13PM -0700, Life is hard, and then you die wrote:
> > On Mon, Apr 01, 2019 at 07:47:14PM -0700, Life is hard, and then you die wrote:
> > > On Thu, Mar 28, 2019 at 12:29:52PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Mar 28, 2019 at 03:27:55AM -0700, Life is hard, and then you die wrote:
> > > > > On Thu, Mar 28, 2019 at 06:29:17AM +0100, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> > > > > > > On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > > > > > > > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:

> > You can do dynamic debugging from the kernel command line, if your code
> > is built into the kernel (but why would a tiny driver under testing like
> > this, not be built into the kernel?) what specifically did not work for you?
> 
> This may be part of our disconnect: there's almost no reason (and
> several downsides) to building it into the kernel instead of as a
> module:
> 
> - When developing, being able to just reload the module instead of
>   rebooting is just so much faster and more convenient.

modprobe -r foo
modprobe foo dyndbg=...

Not an argument.

> - For other users, having them build the driver as a dkms managed
>   module is also by far the simplest and least error-prone approach -
>   explaning to users how to rebuild their kernel (something most of
>   them have never done) takes a bunch of time and effort on both
>   sides for essentially no gain.
> 
> - Once the driver is part of the regular kernel, practically all
>   distro's will build it as a module (at least I'm fairly certain
>   about this).

Above seems a sub-items to the first one. So, reloading module with dyndbg
parameter is quite flexible. What else?

> > You can enable/disable logging per-function, which is what you want,
> > right?
> 
> Yes'ish: the problem is that if they are just part of regular
> functions, A) the chances are higher that the function may get renamed
> and hence any existing debug instructions broken, and B) this doesn't
> work if there are multiple debug statements in a function. Hence my
> assertion that for this work well (and yes, it can work well) you
> basically need to create a separate function for each debug statement
> (which that contains just that debug statement) (a sort of stable
> labelling of each debug statement).

I guess you tried and have an examples?

-- 
With Best Regards,
Andy Shevchenko
