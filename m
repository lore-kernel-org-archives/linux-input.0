From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID
 switch exported by ACPI
Date: Mon, 19 Jun 2017 02:16:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CED142E@SHSMSX101.ccr.corp.intel.com>
References: <1AE640813FDE7649BE1B193DEA596E886CED0386@SHSMSX101.ccr.corp.intel.com>
 <20170615064715.GA6195@jelly>
 <1AE640813FDE7649BE1B193DEA596E886CED047B@SHSMSX101.ccr.corp.intel.com>
 <20170615075755.GA10001@jelly>
 <1AE640813FDE7649BE1B193DEA596E886CED0A03@SHSMSX101.ccr.corp.intel.com>
 <20170616072322.GL5085@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CED0AC1@SHSMSX101.ccr.corp.intel.com>
 <20170616080950.GM5085@mail.corp.redhat.com>
 <1AE640813FDE7649BE1B193DEA596E886CED0C5E@SHSMSX101.ccr.corp.intel.com>
 <33C872C7-EFB2-4CA0-8CAD-8B6E8916180C@hadess.net>
 <20170616163255.GA3461@gardel-login>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170616163255.GA3461@gardel-login>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>, Bastien Nocera <hadess@hadess.net>
Cc: "Brown, Len" <len.brown@intel.com>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lv Zheng <zetalog@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi, Lennart

> From: Lennart Poettering [mailto:mzxreary@0pointer.de]
> Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID switch exported by ACPI
> 
> On Fri, 16.06.17 11:06, Bastien Nocera (hadess@hadess.net) wrote:
> 
> > > Let's consider this case with delay:
> > > After resume, gnome-setting-daemon queries SW_LID and got "close".
> > > Then it lights up the wrong monitors.
> > > Then I believe "open" will be delivered to it several seconds later.
> > > Should gnome-setting-daemon light-up correct monitors this time?
> > > So it just looks like user programs behave with a delay accordingly because of the "platform
> turnaround" delay.
> >
> > If you implement it in such a way that GNOME settings daemon behaves weirdly, you'll get my revert
> request in the mail. Do. Not. Ever. Lie.
> 
> Just to mention this:
> 
> the reason logind applies the timeout and doesn't immediately react to
> lid changes is to be friendly to users, if they quickly close and
> reopen the lid. It's not supposed to be a work-around around broken
> input drivers.

I see, it's same reason for button driver to prepare "lid_report_interval".

I think all old user reports are meaningless to us.
At that time, we found 2 problems in systemd (version below 229):
1. If no "open" event received after resume, systemd suspends the platform.
2. If an "open" event received after a "close" event, the suspend cannot be
   cancelled, systemd still suspends the platform.
It looks the 2 problems are 1 single issue that has already been fixed in
recent systemd (I confirmed that this has been fixed in 233).
It's hard for a kernel driver to work these 2 problems around.

> 
> I am very sure that input drivers shouldn't lie to userspace. If you
> don't know the state of the switch, then you don#t know it, and should
> clarify that to userspace somehow.

Without considering "Surface Pro 1" case which requires a quirk anyway.

For my version 2 solution, for all other platforms, there is no "lie".
There is only a delay, and it's likely there is only 1 platform suffering
from such a delay.

Considering a platform that suffers from such a delay:
Before the platform sends the "open" event, the old cached state is "close".
And input layer automatically filters redundant "close".
Thus systemd won't see any event after resume.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Then after several seconds, (can be configured by HoldoffTimeoutSec),
The lid status is turned into correct and systemd can see an "open".
So there won't be a problem.
I can tell you that I tested systemd 229/233, no problem can be seen with
version 2 solution on all those platforms.

Since everything works, I mean why we need to change the ACPI driven
SW_LID into a "fade-in/out" input node.

On the contrary:
1. I feel the delay is common:
If an HID device is built on top of USBIP, there is always delays
(several seconds as network turnaround) for its SW_xxx keys if any.
So do we need to change all HID device drivers to export SW keys into
fade-in/out style just because the underlying transport layer may change?
For the case we are discussing, it's just the underlying transport layer
is the platform hardware/firmware and some of them have a huge delay.
2. I feel the delay is inevitable:
If kernel must ensure to resume userspace after determining the wakeup
reason and after the related wakeup source hardware or firmware driver
has synchronized the states. It then will be a long-time-consuming
suspend/resume cycle and cannot meet the fast-idle-entry/exit
requirements of the modern idle platforms. And even worse thing is,
for most of the hardware/firmware drivers, they don't even know that
the hardware/firmware driven by them are the waking the platform up.

I feel it's too early to say that we need such a big change.
We can wait and see if there are any further use cases requiring us to
handle before making such a big change.

Cheers,
Lv
