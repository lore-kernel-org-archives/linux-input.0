From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v2] Another approach to IR
Date: Thu, 3 Dec 2009 09:31:06 -0800
Message-ID: <20091203173105.GA776@core.coreip.homeip.net>
References: <9e4733910912020930t3c9fe973k16fd353e916531a4@mail.gmail.com> <4B16BE6A.7000601@redhat.com> <20091202195634.GB22689@core.coreip.homeip.net> <2D11378A-041C-4B56-91FF-3E62F5F19753@wilsonet.com> <20091202201404.GD22689@core.coreip.homeip.net> <4B16CCD7.20601@redhat.com> <20091202205323.GF22689@core.coreip.homeip.net> <4B16D87F.7080701@redhat.com> <87tyw8ujsr.fsf@tac.ki.iif.hu> <4B17E874.5020003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756138AbZLCRbI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B17E874.5020003@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Ferenc Wagner <wferi@niif.hu>, Jarod Wilson <jarod@wilsonet.com>, Jarod Wilson <jarod@redhat.com>, Jon Smirl <jonsmirl@gmail.com>, Devin Heitmueller <dheitmueller@kernellabs.com>, Maxim Levitsky <maximlevitsky@gmail.com>, awalls@radix.net, j@jannau.net, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, superm1@ubuntu.com, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 03, 2009 at 02:33:56PM -0200, Mauro Carvalho Chehab wrote:
> Ferenc Wagner wrote:
> > Mauro Carvalho Chehab <mchehab@redhat.com> writes:
> 
> We should not forget that simple IR's don't have any key to select the address,
> so the produced codes there will never have KEY_TV/KEY_DVD, etc.

Wait, wait, KEY_TV, KEY_DVD, KEY_TAPE - they should be used to select
media inputs in a device/application. My receiver accepts codees like
that.

-- 
Dmitry
