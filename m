From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Why hid-sensor-hub's IIO doesn't work properly in >= 4.3 (possibly badly bisected)
Date: Thu, 02 Feb 2017 00:38:04 +0100
Message-ID: <4663686.yGs8knaWTY@aspire.rjw.lan>
References: <1484927552.21721.17.camel@hadess.net> <CAJZ5v0hYwyV+j+38rdqo81x0p5jWyLzHijYFY5RmnODzRUK0qg@mail.gmail.com> <1485869863.5845.54.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1485869863.5845.54.camel@hadess.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Richard Hughes <richard@hughsie.com>
List-Id: linux-input@vger.kernel.org

+ Srinivas

On Tuesday, January 31, 2017 02:37:43 PM Bastien Nocera wrote:
> Hey Rafael,
> 
> On Fri, 2017-01-27 at 00:07 +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 26, 2017 at 4:15 PM, Bastien Nocera <hadess@hadess.net>
> > wrote:
> > > On Fri, 2017-01-20 at 16:52 +0100, Bastien Nocera wrote:
> > > > Hey,
> > > > 
> > > > TLDR:
> > > > # first bad commit: [50ba22479c324c0d9dc8134d519dcba92d83a8a7]
> > > > Merge
> > > > back earlier ACPI PM material for v4.3.
> > > > 
> > > > hid-sensor-hub devices only start sending events through the IIO
> > > > trigger after a suspend/resume cycle.
> > > > 
> > > > Other IIO drivers don't seem to exhibit those problems.
> > > 
> > > I had another go, trying to break into the merge commit, and it's
> > > slightly more precise, but still doesn't make any sense to me.
> > > 
> > > # first bad commit: [3431e490b50356b56084305a2e93b3a980802b22]
> > > Merge
> > > branch 'acpi-scan' into acpi-pm
> > > 
> > > Any ideas? I'm running out of them...
> > 
> > The parents of this merge are 5af310a8ee70 and 1dcc3d3362b0.
> > 
> > Can you please check if the problem is present in any of them alone?
> 
> Both of those were already in the git bisect output:
> # good: [5af310a8ee70dd6a588c8ee1d4487a230a7b7b65] Merge tag 'ib-mfd-base-acpi-dma-v4.3' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into acpi-pm
> git bisect good 5af310a8ee70dd6a588c8ee1d4487a230a7b7b65
> 
> # good: [1dcc3d3362b0c97e48290f7786be85b4cec2a147] ACPI / bus: Move ACPI bus type registration
> git bisect good 1dcc3d3362b0c97e48290f7786be85b4cec2a147
> 
> Or did I do this wrong?
> 
> > If not, it is theoretically possible that the merge itself had
> > introduced it (as this is not a trivial merge).
> 
> Yeah, I tried diving into the merge, but never managed to do so.

Srinivas, does it sound like anything familiar to you?

Thanks,
Rafael

