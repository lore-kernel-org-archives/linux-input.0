From: Balaji Rao <balajirrao@gmail.com>
Subject: Re: 2.6.25-rc5.git4 regression PS/2 mouse not detected/working
Date: Wed, 2 Apr 2008 23:00:13 +0530
Message-ID: <200804022300.14164.balajirrao@gmail.com>
References: <1205775229.25146.11.camel@indigo.declera.com> <200804022038.33245.balajirrao@gmail.com> <20080402113043.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:10256 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbYDBRgW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Apr 2008 13:36:22 -0400
Received: by yw-out-2324.google.com with SMTP id 5so353460ywb.1
        for <linux-input@vger.kernel.org>; Wed, 02 Apr 2008 10:36:21 -0700 (PDT)
In-Reply-To: <20080402113043.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yanko Kaneti <yaneti@declera.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>

On Wednesday 02 April 2008 09:03:28 pm Dmitry Torokhov wrote:
> Hi Blaji,
> 
> On Wed, Apr 02, 2008 at 08:38:33PM +0530, Balaji Rao wrote:
> > 
> > Coincidentally even I hit upon this bug a couple of days ago after enabling 
> > HPET in my BIOS. A quick check told me that IRQ 12 which the patch assigns to 
> > the HPET device is used by the PS/2 mouse as well. This makes the mouse 
> > inactive.
> > 
> > I am working on this.. I am not sure if the PS/2 code is misbehaving though..
> >
> 
> Normally IRQ12 can not be shared on X86 if PS/2 mouse is present.
> If PCI side tries to grab the IRQ then ISA (legacy) side will never
> see its interrupts coming.
> 
OK. So, I need to specifically check for IRQ12 being assigned and avoid it ?

-- 
regards,
balaji rao
Dept. of Mechanical Engineering,
National Institute of Technology Karnataka, India
