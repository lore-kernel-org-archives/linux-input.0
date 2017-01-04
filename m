From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 7/7] misc: intel-ish-client: add intel ishtp clients
 driver
Date: Wed, 04 Jan 2017 09:11:34 -0800
Message-ID: <1483549894.4497.55.camel@linux.intel.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
         <1482456149-4841-7-git-send-email-even.xu@intel.com>
         <20170104130316.GA8378@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104130316.GA8378@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Even Xu <even.xu@intel.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, arnd@arndb.de, andriy.shevchenko@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2017-01-04 at 14:03 +0100, Greg KH wrote:
> On Fri, Dec 23, 2016 at 09:22:29AM +0800, Even Xu wrote:
> > 
> > Intel ISHFW supports many different clients, in
> > hid/intel-ish-hid/ishtp bus driver, it creates following client
> > devices:
> > HID client:
> > 	interface of sensor configure and sensor event report.
> > SMHI client:
> > 	interface of sensor calibration, ISHFW debug, ISHFW performance
> > 	analysis and manufacture support.
> > Trace client:
> > 	interface of ISHFW debug log output.
> > Trace configure client:
> > 	interface of ISHFW debug log configuration, such as output
> > port,
> > 	log level, filter.
> > ISHFW loader client:
> > 	interface of customized ISHFW loader.
> > HID client has been handle by hid/intel-ish-hid/intel-ishtp-hid
> > client
> > driver, and rest of the clients export interface using
> > miscellaneous
> > drivers. This interface is used by user space tools for debugging
> > and
> > calibration of sensors.
> > 
> > Signed-off-by: Even Xu <even.xu@intel.com>
> > Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
> > Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c
> > om>
> > ---
> >  drivers/misc/Kconfig                               |   1 +
> >  drivers/misc/Makefile                              |   1 +
> >  drivers/misc/intel-ish-client/Kconfig              |  15 +
> >  drivers/misc/intel-ish-client/Makefile             |   8 +
> >  .../misc/intel-ish-client/intel-ishtp-clients.c    | 884
> > +++++++++++++++++++++
> >  include/uapi/linux/intel-ishtp-clients.h           |  73 ++
> 
> 
> Why create a whole new subdirectory for just one .c file?  Is that
> really needed?
The other option is to move this .c file to drivers/hid/intel-ish-hid/.
I think the folders inside drivers/hid/ is mostly for just implementing
transport layer for hid devices.


> 
> And I'm not quite sure why you need a misc driver, what exactly is
> this
> code doing?
As described in the description, this driver is a companion driver for
ISH user space tools for calibration, production and debug.

Basically the ISH provided a standalone low power processor to
developers and manufacturers  to do download some custom algorithms for
sensors, which may not be compliant to USB HID sensor specifications
(mostly for IOT space). In that case the user space for those can
communicate using misc driver interface, without adding new kernel
drivers.

Thanks,
Srinivas
