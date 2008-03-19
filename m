From: Yanko Kaneti <yaneti@declera.com>
Subject: Re: 2.6.25-rc5.git4 regression PS/2 mouse not detected/working
Date: Wed, 19 Mar 2008 10:35:39 +0200
Message-ID: <1205915739.20210.4.camel@indigo.declera.com>
References: <1205775229.25146.11.camel@indigo.declera.com>
	 <20080317145429.ZZRA012@mailhub.coreip.homeip.net>
	 <1205780323.25146.13.camel@indigo.declera.com>
	 <20080318114711.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from indigo.declera.com ([212.116.131.21]:34537 "HELO
	indigo.declera.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757944AbYCSTmZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2008 15:42:25 -0400
In-Reply-To: <20080318114711.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


On Tue, 2008-03-18 at 11:54 -0400, Dmitry Torokhov wrote:
> On Mon, Mar 17, 2008 at 08:58:43PM +0200, Yanko Kaneti wrote:
> > 
> > On Mon, 2008-03-17 at 14:55 -0400, Dmitry Torokhov wrote:
> > > Hi,
> > > 
> > > On Mon, Mar 17, 2008 at 07:33:49PM +0200, Yanko Kaneti wrote:
> > > > Hi
> > > > 
> > > > My PS/2 mouse stops being detected between kernels 2.6.24.3-12.fc8 and
> > > > 2.6.25-0.121.rc5.git4.fc9 (which I believe do not carry any patches in
> > > > that area). Its an ASUS P5E-VM DO motherboard , bios revision 0506. The
> > > > PS/2 keyboard still works.
> > > > 
> > > > Attached are both dmesg logs with i8042.debug=1, dmidecode, lspci -vvnn
> > > > Tried i8042.noloop and both the mouse and keyboard stop working.
> > > > 
> > > 
> > > Could you please send me dmesg from booting with i8042.noloop. I would
> > > expect this option to help in your case so I am curious what went wrong.
> > 
> > Attached
> > 
> 
> Hmm, it looks the kernel does the right thing in case of i8042.noloop,
> except that it does not work :(. Kernel triest to query the mouse but
> it does not respond.
> 
> Can you try taking contents of drivers/input/serio from 2.6.25 and
> copy it in .24? It will most likely compile... If that works I'm
> afraid I will ahve to ask you to do git biscect to find the offending
> commit.

It works. I am afraid I don't know when/if I'll be able to do the
bisecting thing :(

It would be really nice if someone has written a guide or something for
most hassle-free way of doing it on a Fedora system.

Regards
Yanko

