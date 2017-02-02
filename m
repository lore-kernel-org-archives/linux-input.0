From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Why hid-sensor-hub's IIO doesn't work properly in >= 4.3
 (possibly badly bisected)
Date: Thu, 02 Feb 2017 13:42:22 +0100
Message-ID: <1486039342.2316.1.camel@hadess.net>
References: <1484927552.21721.17.camel@hadess.net>
         <1485993472.18380.73.camel@linux.intel.com>
         <1486031705.16399.1.camel@hadess.net> <2492725.VHRXfnWZmy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2492725.VHRXfnWZmy@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Richard Hughes <richard@hughsie.com>
List-Id: linux-input@vger.kernel.org

On Thu, 2017-02-02 at 12:33 +0100, Rafael J. Wysocki wrote:
> On Thursday, February 02, 2017 11:35:05 AM Bastien Nocera wrote:
> > On Wed, 2017-02-01 at 15:57 -0800, Srinivas Pandruvada wrote:
> > > On Thu, 2017-02-02 at 00:38 +0100, Rafael J. Wysocki wrote:
> > > > + Srinivas
> > > > 
> > > > On Tuesday, January 31, 2017 02:37:43 PM Bastien Nocera wrote:
> > > > > 
> > > > > Hey Rafael,
> > > > > 
> > > > > On Fri, 2017-01-27 at 00:07 +0100, Rafael J. Wysocki wrote:
> > > > > > 
> > > > > > On Thu, Jan 26, 2017 at 4:15 PM, Bastien Nocera <hadess@had
> > > > > > ess.
> > > > > > ne
> > > > > > t>
> > > > > > wrote:
> > > > > > > 
> > > > > > > On Fri, 2017-01-20 at 16:52 +0100, Bastien Nocera wrote:
> > > > > > > > 
> > > > > > > > Hey,
> > > > > > > > 
> > > > > > > > TLDR:
> > > > > > > > # first bad commit:
> > > > > > > > [50ba22479c324c0d9dc8134d519dcba92d83a8a7]
> > > > > > > > Merge
> > > > > > > > back earlier ACPI PM material for v4.3.
> > > > > > > > 
> > > > > > > > hid-sensor-hub devices only start sending events
> > > > > > > > through
> > > > > > > > the
> > > > > > > > IIO
> > > > > > > > trigger after a suspend/resume cycle.
> > > 
> > > 
> > > > Srinivas, does it sound like anything familiar to you?
> > > 
> > > I guess this is related to
> > > https://github.com/hadess/iio-sensor-proxy/issues/82
> > > 
> > > There is some race between user space and iio. So the driver
> > > powerup
> > > never gets called back to power a hub during system boot. So the
> > > workaround was to add to systemd unit file for iio-sensor-proxy 
> > > [Unit]
> > > After=multi-user.target
> > > 
> > > Something changed timings in the kernel, which triggered this
> > > issue.
> > 
> > I don't think it's simply "timings", or at least it's a big enough
> > window of opportunity that I can reproduce the bug 100% of the time
> > when not adding timeouts to iio-sensor-proxy's timeout.
> > 
> > Putting the machine on suspend and resuming it also fixes the
> > problem
> > (for a machine I've been testing that can be suspended, it's not an
> > option for all of them).
> > 
> > > I never got chance to root cause this.
> > 
> > Well, at least the root cause is limited to a single commit, shame
> > it's
> > a merge one.
> 
> In fact this is a merge that doesn't change any code by itself (I
> thought it
> did, but that was not correct), so if that had been more than
> timings, you'd
> have seen breakage on at least one of the merged branches.
> 
> Moreover, it merges the commits under 3431e490b503 back on top of
> material
> that went into 4.2, so if you only see the problem in 4.3 and later,
> this has to
> be the 3431e490b503 branch.
> 
> Can you double check 3431e490b503 alone, please?

I don't understand what you're asking of me. I'm not a git master, and
I've never had to deal with merge commits.

Did you want me to run "git reset --hard 3431e490b503" and test the
resulting kernel? I'm pretty sure that's equivalent what my 3 runs of
bisection have done, and it failed.

Cheers
