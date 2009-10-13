From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [bisected regression] Touchpad "paste" stops working after
	suspend to RAM
Date: Tue, 13 Oct 2009 16:57:01 -0700
Message-ID: <20091013235701.GB28819@core.coreip.homeip.net>
References: <20091012090224.GB7403@core.coreip.homeip.net> <20091012100929.GA4402@Pilar.aei.mpg.de> <20091013032414.GC2887@core.coreip.homeip.net> <20091013121109.GB4619@Pilar.aei.mpg.de> <20091013182643.GC21593@core.coreip.homeip.net> <20091013190819.GA7555@Pilar.aei.mpg.de> <20091013194654.GD21593@core.coreip.homeip.net> <20091013202459.GE21593@core.coreip.homeip.net> <20091013231641.GA4404@Pilar.aei.mpg.de> <20091013235607.GA28819@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761666AbZJMX5U@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091013235607.GA28819@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 13, 2009 at 04:56:08PM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 14, 2009 at 01:16:41AM +0200, Carlos R. Mafra wrote:
> > [restoring Cc: list]
> > 
> > On Tue 13.Oct'09 at 13:24:59 -0700, Dmitry Torokhov wrote:
> > >
> > > Could you please try this patch (again if you could post dmesg that
> > > would be great). Thank you!
> > 
> > The patch quoted below also fixes the problem. I attached the
> > syslog with i8042.debug (with a s2ram in the middle) to the
> > bugzilla: 
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=14392
> > 
> 
> Still not quite happy, although it is better. I don't understand why
> your box likes to reply on AUX port when command is sent via keyboard
> port.
> 
> Could you please try booting with atkbd.reset (I assume keyboard is
> built in) and send me yet another dmesg.
> 

Oh, yes, keep the last patch applied. Thanks!

-- 
Dmitry
