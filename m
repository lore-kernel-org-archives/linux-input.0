From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
	in driver
Date: Sat, 22 Aug 2009 15:02:04 -0300
Message-ID: <20090822180204.GB4894@khazad-dum.debian.net>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090302112400.GA2356@khazad-dum.debian.net> <1236164049.3936.17.camel@hughsie-work.lan> <20090304120439.GA31850@khazad-dum.debian.net> <1250625730.2257.11.camel@hidalgo> <20090818201002.GA32638@srcf.ucam.org> <1250627230.2257.15.camel@hidalgo> <20090818204508.GA886@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090818204508.GA886@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Yves-Alexis Perez <corsac@debian.org>, Ali Abdallah <aliov@xfce.org>, Richard Hughes <hughsient@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-acpi <linux-acpi@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 18 Aug 2009, Matthew Garrett wrote:
> On Tue, Aug 18, 2009 at 10:27:10PM +0200, Yves-Alexis Perez wrote:
> > On mar, 2009-08-18 at 21:10 +0100, Matthew Garrett wrote:
> > > 
> > > > It seems that this patch is still not in master?
> > > 
> > > Correct. We can't change the existing semantics without breaking 
> > > existing userspace applications.
> > 
> > Hmh ok, but is it planned?
> 
> No. We'd break userspace.

Indeed.  I am not merging any changes to SUSPEND/HIBERNATE keymaps,
until some interested party comes up with a PROPER migration plan and
helps implementing it across the entire kernel and userspace.

This obviously mean new keycodes for S3 and S4-specific sleep, that
won't change the meaning of the old ones.  There is also the generic
(whatever the system think its best) sleep.

X.org's braindead limit of 255 keycodes won't help any.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
