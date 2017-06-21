From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID
 switch exported by ACPI
Date: Wed, 21 Jun 2017 12:23:08 +0200
Message-ID: <1498040588.2559.30.camel@hadess.net>
References: <20170601184632.2980-1-benjamin.tissoires@redhat.com>
         <20170607074848.GE27006@gardel-login>
         <20170613100617.GD29589@mail.corp.redhat.com>
         <1AE640813FDE7649BE1B193DEA596E886CED0386@SHSMSX101.ccr.corp.intel.com>
         <20170615064715.GA6195@jelly>
         <1AE640813FDE7649BE1B193DEA596E886CED047B@SHSMSX101.ccr.corp.intel.com>
         <20170615075755.GA10001@jelly>
         <1AE640813FDE7649BE1B193DEA596E886CED0A03@SHSMSX101.ccr.corp.intel.com>
         <20170616072322.GL5085@mail.corp.redhat.com>
         <1AE640813FDE7649BE1B193DEA596E886CED0AC1@SHSMSX101.ccr.corp.intel.com>
         <20170616080950.GM5085@mail.corp.redhat.com>
         <1AE640813FDE7649BE1B193DEA596E886CED0C5E@SHSMSX101.ccr.corp.intel.com>
         <33C872C7-EFB2-4CA0-8CAD-8B6E8916180C@hadess.net>
         <1AE640813FDE7649BE1B193DEA596E886CED1419@SHSMSX101.ccr.corp.intel.com>
         <1497910127.2559.1.camel@hadess.net>
         <1AE640813FDE7649BE1B193DEA596E886CED1C41@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57186 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbdFUKXQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Jun 2017 06:23:16 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED1C41@SHSMSX101.ccr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Lennart Poettering <mzxreary@0pointer.de>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 2017-06-20 at 02:45 +0000, Zheng, Lv wrote:
> Hi,
> 
> > From: Bastien Nocera [mailto:hadess@hadess.net]
> > Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable
> > LID switch exported by ACPI
> > 
> > On Mon, 2017-06-19 at 01:43 +0000, Zheng, Lv wrote:
> > > <snip>
> > > > 
> > > > If you implement it in such a way that GNOME settings daemon
> > > > behaves weirdly, you'll get my revert
> > > > request in the mail. Do. Not. Ever. Lie.
> > > 
> > > First, I don't know what should be reverted...
> > > I have 2 solutions here for review, and Benjamin has 1.
> > > And none of them has been upstreamed.
> > > We are just discussing.
> > 
> > The discussion is getting tiring quite frankly. We've been over
> > this
> > for nearly a year now, and with no end in sight.
> 
> We have concerns to introduce too complicated logics to such a
> simple button driver especially the logics are related to platform
> firmware, input ABI and user space behaviors.
> 
> I understand the situation.
> Anyway this shouldn't be a big deal.
> Let's prepare a smarter series to collect all fixes and solutions
> with runtime configurables and get that to the end users.
> So that we can figure out which is the simplest solution.
> 
> But before that, let me ask several questions about gnome-setting-
> deamon.
> 
> > 
> > > However we need to get 1 of them upstreamed in next cycle.
> > > 
> > > I think users won't startup gnome-setting-daemon right after
> > > resume.
> > > It should have already been started.
> > > 
> > > There is only 1 platform may see delayed state update after
> > > resume.
> > > Let's see if there is a practical issue.
> > > 1. Before suspend, the "lid state" is "close", and
> > > 2. After resume, the state might remain "close" for a while
> > >    Since libinput won't deliver close to userspace,
> > >    and gnome-setting-daemon listens to key switches, there is no
> > > wrong behavior.
> > 
> > It doesn't. It listens to UPower, which tells user-space whether
> > there
> > is a lid switch, and whether it's opened or closed.
> 
> Thanks for the information.
> However I don't see differences here.
> 
> > 
> > > 3. Then after several seconds, "open" arrives.
> > >    gnome-setting-daemon re-arrange monitors and screen layouts in
> > > response to the new event.
> > 
> > Just how is anyone supposed to know that there is an event coming?
> 
> Will UPower deliver EV_SW key events to gnome-setting-daemon?
> 
> > 
> > > So there is no problem. IMO, there is no need to improve for
> > > post-
> > > resume case.
> > > 
> > > Users will just startup gnome-setting-daemon once after boot.
> > > And it's likely that when it is started, the state is correct.
> > 
> > You cannot rely on when gnome-settings-daemon will be started to
> > make
> > *any* decision. Certainly not decisions on how the kernel should
> > behave.
> 
> My bad wording, I just meant:
> When gnome-settings-daemon is started is not related to what we are
> discussing.
> 
> Do you want to fix regressions?
> Or you want to fix new issues on recent platforms?
> If you want to fix regressions, I think Benjamin has submitted a
> revision
> to use old method mode, there shouldn't be regressions for
> gnome-settings-daemon.
> 
> What else we want to do is to fix regressions related to systemd when
> we go back to default method mode. Since there is no issue with
> systemd
> 233 and after just applying a small change, systemd 229 can also be
> worked around, I mean dynamically add/remove input node is not
> strictly
> required for achieving our purposes.
> 
> But if you want to fix new issues on new platforms, we can discuss
> further and determine which program should be changed and which
> program
> is the best candidate to stop all problems - the ACPI button driver
> or
> the user space.

I'm happy with Benjamin's patches which don't introduce any
dependencies on new user-space, and don't rely on undocumented
heuristics. What was the API is still the API.
