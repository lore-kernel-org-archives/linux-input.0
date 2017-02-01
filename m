From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Why hid-sensor-hub's IIO doesn't work properly in >= 4.3
 (possibly badly bisected)
Date: Wed, 01 Feb 2017 15:57:52 -0800
Message-ID: <1485993472.18380.73.camel@linux.intel.com>
References: <1484927552.21721.17.camel@hadess.net>
         <CAJZ5v0hYwyV+j+38rdqo81x0p5jWyLzHijYFY5RmnODzRUK0qg@mail.gmail.com>
         <1485869863.5845.54.camel@hadess.net> <4663686.yGs8knaWTY@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4663686.yGs8knaWTY@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bastien Nocera <hadess@hadess.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Richard Hughes <richard@hughsie.com>
List-Id: linux-input@vger.kernel.org

On Thu, 2017-02-02 at 00:38 +0100, Rafael J. Wysocki wrote:
> + Srinivas
> 
> On Tuesday, January 31, 2017 02:37:43 PM Bastien Nocera wrote:
> > 
> > Hey Rafael,
> > 
> > On Fri, 2017-01-27 at 00:07 +0100, Rafael J. Wysocki wrote:
> > > 
> > > On Thu, Jan 26, 2017 at 4:15 PM, Bastien Nocera <hadess@hadess.ne
> > > t>
> > > wrote:
> > > > 
> > > > On Fri, 2017-01-20 at 16:52 +0100, Bastien Nocera wrote:
> > > > > 
> > > > > Hey,
> > > > > 
> > > > > TLDR:
> > > > > # first bad commit:
> > > > > [50ba22479c324c0d9dc8134d519dcba92d83a8a7]
> > > > > Merge
> > > > > back earlier ACPI PM material for v4.3.
> > > > > 
> > > > > hid-sensor-hub devices only start sending events through the
> > > > > IIO
> > > > > trigger after a suspend/resume cycle.


> Srinivas, does it sound like anything familiar to you?

I guess this is related to
https://github.com/hadess/iio-sensor-proxy/issues/82

There is some race between user space and iio. So the driver powerup
never gets called back to power a hub during system boot. So the
workaround was to add to systemd unit file for iio-sensor-proxy 
[Unit]
After=multi-user.target

Something changed timings in the kernel, which triggered this issue.
I never got chance to root cause this.

Thanks,
Srinivas


