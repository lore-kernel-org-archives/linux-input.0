From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Issues detecting i8042 AUX port
Date: Thu, 29 Oct 2009 10:02:16 -0700
Message-ID: <200910291002.16733.dmitry.torokhov@gmail.com>
References: <4ACB533A.7080001@urbanec.net> <alpine.LRH.2.00.0910082315070.12171@twin.jikos.cz> <4AE989D0.1070302@urbanec.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:55949 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbZJ2RCS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Oct 2009 13:02:18 -0400
Received: by pxi9 with SMTP id 9so1298594pxi.4
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2009 10:02:22 -0700 (PDT)
In-Reply-To: <4AE989D0.1070302@urbanec.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Urbanec <vger.kernel.org.input@urbanec.net>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Thursday 29 October 2009 05:25:52 am Peter Urbanec wrote:
> Jiri Kosina wrote:
> > On Wed, 7 Oct 2009, Peter Urbanec wrote:
> >> In a nutshell, I can run the same kernel on the same hardware and on
> >> some boots the AUX port will not be detected and on other boots it will
> >> come up fine.
> >
> > Does booting with 'i8042.noloop' improve the situation?
> 
> Jirko,
> 
> Thanks for the suggestion. I have been testing the i8042.noloop
> workaround for a few weeks now. So far I have not not experienced any
> problems when booting with that option. I would say that the workaround
> can be declared as being effective.
> 
> I also applied Dmitry's patch to log the timeout condition when
> detecting the AUX port. Without the i8042.noloop option, the AUX port
> detection fails intermittently, but when it does, it causes an aux irq
> test timeout, which coincides with uhci_hcd USB hub initialisation.
> Perhaps the USB code somehow causes the loss of this interrupt.
> 
> Adding the DMI info for the machine to the i8042_dmi_noloop_table is
> perhaps not the most correct fix for the underlying problem, but it does
> get results.
> 

I ended up just disabling aux irq delivery test in 2.6.32 on all laptops and 
portables (as long as they have sane PNP data)... There are just too many 
failures and the vast majority of them use PS/2 touchpads/trackpoints.

-- 
Dmitry
