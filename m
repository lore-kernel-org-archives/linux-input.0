From: Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [systemd-devel] [WIP PATCH 0/4] Rework the unreliable LID switch
 exported by ACPI
Date: Fri, 16 Jun 2017 18:32:55 +0200
Message-ID: <20170616163255.GA3461@gardel-login>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <33C872C7-EFB2-4CA0-8CAD-8B6E8916180C@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Brown, Len" <len.brown@intel.com>, "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lv Zheng <zetalog@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 16.06.17 11:06, Bastien Nocera (hadess@hadess.net) wrote:

> > Let's consider this case with delay:
> > After resume, gnome-setting-daemon queries SW_LID and got "close".
> > Then it lights up the wrong monitors.
> > Then I believe "open" will be delivered to it several seconds later.
> > Should gnome-setting-daemon light-up correct monitors this time?
> > So it just looks like user programs behave with a delay accordingly because of the "platform turnaround" delay.
> 
> If you implement it in such a way that GNOME settings daemon behaves weirdly, you'll get my revert request in the mail. Do. Not. Ever. Lie.

Just to mention this:

the reason logind applies the timeout and doesn't immediately react to
lid changes is to be friendly to users, if they quickly close and
reopen the lid. It's not supposed to be a work-around around broken
input drivers.

I am very sure that input drivers shouldn't lie to userspace. If you
don't know the state of the switch, then you don#t know it, and should
clarify that to userspace somehow.

Lennart

-- 
Lennart Poettering, Red Hat
