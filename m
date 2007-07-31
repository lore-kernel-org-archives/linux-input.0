From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [patch] Refresh lid state on resume
Date: Tue, 31 Jul 2007 09:53:50 -0300
Message-ID: <20070731125350.GC19965@khazad-dum.debian.net>
References: <1184670921.8890.2.camel@work> <1185808891.18821.25.camel@queen.suse.de> <1185809610.24649.3.camel@hughsie-laptop> <200707311108.42947.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200707311108.42947.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Richard Hughes <hughsient@gmail.com>, trenn@suse.de, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Kay Sievers <kay.sievers@vrfy.org>
List-Id: linux-input@vger.kernel.org

On Tue, 31 Jul 2007, Rafael J. Wysocki wrote:
> > I guess it's up to the BIOS, and I don't think this refresh hurts any
> > machines that implement a notify on resume, and fixes a fair few
> > machines that don't.
> 
> AFAICS, the notify doesn't seem to work very well on some machines.

I have noticed thinkpad-acpi gets notifications during *early resume*
sometimes, and certainly *well* before its own resume handlers are called.

That might be part of the problem.

> Are there any downsides of the $subject patch?

None that I know.  I am doing something like that in thinkpad-acpi for
input-layer switches, and it helps a great deal.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
