From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Date: Thu, 28 Mar 2019 03:27:55 -0700
Message-ID: <20190328102755.GA26446@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
 <20190328052917.GB18668@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328052917.GB18668@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Thu, Mar 28, 2019 at 06:29:17AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> > 
> > On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > > > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > > > instead of straight printk() to match other dev_xxx() logging functions.
> > > > ---
> > > >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/device.h | 15 +++++++++++++++
> > > >  2 files changed, 58 insertions(+)
> > > 
> > > No signed-off-by?
> > 
> > Aargh! Apologies, fixed for the future.
> > 
> > > Anyway, no, please do not do this.  Please do not dump large hex values
> > > like this to the kernel log, it does not help anyone.
> > > 
> > > You can do this while debugging, sure, but not for "real" kernel code.
> > 
> > As used by this driver, it is definitely called for debugging only and
> > must be explicitly enabled via a module param. But having the ability
> > for folks to easily generate and print out debugging info has proven
> > quite valuable.
> 
> We have dynamic debugging, no need for module parameters at all.  This
> isn't the 1990's anymore :)

I am aware of dynamic debugging, but there are several issues with it
from the perspective of the logging I'm doing here (I mentioned these
in response to an earlier review already):

  1. Dynamic debugging can't be enabled at a function or line level on
     the kernel command line, so this means that to debug issues
     during boot you have to enable everything, which can be way too
     verbose

  2. The expressions to enable the individual logging statements are
     quite brittle (in particular the line-based ones) since they
     (may) change any time the code is changed - having stable
     commands to give to users and put in documentation (e.g.
     "echo 0x200 > /sys/module/applespi/parameters/debug") is
     quite valuable.

     One way to work around this would be to put every single logging
     statement in a function of its own, thereby ensuring a stable
     name is associated with each one.

  3. In at least two places we log different types of packets in the
     same lines of code (protected by a "if (log_mask & PKT_TYPE)") -
     dynamic-debug would only allow enabling or disabling logging of
     all packets. This could be worked around by creating a separate
     (but essentially duplicate) logging function for each packet type
     and some lookup table to call the appropriate one. Not very
     pretty IMO, though.

  4. In a couple places we log both the sent command and the received
     response, with the log-mask determining for which types of
     packets to do this. With a log mask there is one bit to set to
     get both logged; with dynamic debugging you'd have to enable the
     writing and receiving parts separately (not a huge deal, but yet
     one place where things are a bit more complicated than
     necessary).

Except for the first, none of these are insurmountable, but together
they don't make dynamic debugging very attractive for this sort of
logging.


  Cheers,

  Ronald
