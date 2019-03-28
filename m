From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Date: Thu, 28 Mar 2019 06:29:17 +0100
Message-ID: <20190328052917.GB18668@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328002817.GF24753@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> 
> On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > > instead of straight printk() to match other dev_xxx() logging functions.
> > > ---
> > >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/device.h | 15 +++++++++++++++
> > >  2 files changed, 58 insertions(+)
> > 
> > No signed-off-by?
> 
> Aargh! Apologies, fixed for the future.
> 
> > Anyway, no, please do not do this.  Please do not dump large hex values
> > like this to the kernel log, it does not help anyone.
> > 
> > You can do this while debugging, sure, but not for "real" kernel code.
> 
> As used by this driver, it is definitely called for debugging only and
> must be explicitly enabled via a module param. But having the ability
> for folks to easily generate and print out debugging info has proven
> quite valuable.

We have dynamic debugging, no need for module parameters at all.  This
isn't the 1990's anymore :)

thanks,

greg k-h
