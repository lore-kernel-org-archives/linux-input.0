From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] serio driver: speed up resume
Date: Fri, 27 Jun 2008 18:03:47 +0200
Message-ID: <200806271803.48164.rjw@sisk.pl>
References: <1213607375.31950.2.camel@sli10-desk.sh.intel.com> <1214272978.29380.2.camel@sli10-desk.sh.intel.com> <alpine.LFD.1.10.0806271148140.2988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37590 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727AbYF0QCI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2008 12:02:08 -0400
In-Reply-To: <alpine.LFD.1.10.0806271148140.2988@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux acpi <linux-acpi@vger.kernel.org>, Linux Power Management List <linux-pm@lists.osdl.org>

On Friday, 27 of June 2008, Len Brown wrote:
> 
> <rafael and linux-pm cc'd>
> 
> On Tue, 24 Jun 2008, Shaohua Li wrote:
> 
> > On Mon, 2008-06-16 at 17:09 +0800, Shaohua Li wrote:
> > > serio_resume will call into psmouse_extensions(). In my test, the
> > > routine is very slow, it blocks resume about 1 sec. Below patch (move
> > > resume to kseriod, just like boot time probe) cures the issue in my
> > > test, and seems no side effect. I'm no familiar with serio driver, so
> > > please check.
> 
> > Any comments from input guys?
> 
> none that i can see.
> 
> Rafael,
> can you put this patch in with your suspend test patches?
> I would do so, but as I'll be out for a bit I'll not
> be here to babysit it if something breaks.

I will, but my series has been a bit out of order recently.  I'm going to fix
it up shortly, though.

Thanks,
Rafael
