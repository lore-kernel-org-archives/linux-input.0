From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: IR raw input is not sutable for input system
Date: Thu, 26 Nov 2009 19:36:18 +0100
Message-ID: <m3bpipuo9p.fsf@intrepid.localdomain>
References: <200910200956.33391.jarod@redhat.com>
	<200910200958.50574.jarod@redhat.com> <4B0A765F.7010204@redhat.com>
	<4B0A81BF.4090203@redhat.com> <m36391tjj3.fsf@intrepid.localdomain>
	<20091123173726.GE17813@core.coreip.homeip.net>
	<4B0B6321.3050001@wilsonet.com>
	<1259105571.28219.20.camel@maxim-laptop>
	<Pine.LNX.4.58.0911241918390.30284@shell2.speakeasy.net>
	<1259155734.4875.23.camel@maxim-laptop>
	<20091125213246.GA44831@atlantis.8hz.com>
	<m3d43644q6.fsf@intrepid.localdomain>
	<1259189522.15916.1.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:32980 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbZKZSgP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 13:36:15 -0500
In-Reply-To: <1259189522.15916.1.camel@maxim-laptop> (Maxim Levitsky's message
	of "Thu, 26 Nov 2009 00:52:02 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Sean Young <sean@mess.org>, Trent Piepho <xyzzy@speakeasy.org>, Jarod Wilson <jarod@wilsonet.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Jarod Wilson <jarod@redhat.com>, linux-kernel@vger.kernel.org, Mario Limonciello <superm1@ubuntu.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Janne Grunau <j@jannau.net>, Christoph Bartelmus <lirc@bartelmus.de>

Maxim Levitsky <maximlevitsky@gmail.com> writes:

> But devices that send raw pulse/space data should be handled in lirc
> that will feed the data back to the kernel via uinput.

I still do want the in-kernel RCx decoding. And lirc pulse/space.
-- 
Krzysztof Halasa
