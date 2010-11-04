From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [PATCHv1] staging: Synaptics RMI4 touchpad driver support
Date: Thu, 4 Nov 2010 00:45:45 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530468A82CF3@dlee03.ent.ti.com>
References: <1288699725-14405-1-git-send-email-naveen.gaddipati@stericsson.com>
 <20101102140337.GC9387@kroah.com> <4CD01CD8.3090206@stericsson.com>
 <20101102154029.GH11778@core.coreip.homeip.net>
 <20101103181058.GE7441@kroah.com>
 <20101103190752.GA4552@core.coreip.homeip.net>
 <20101103191958.GA9912@kroah.com>
 <27F9C60D11D683428E133F85D2BB4A530468A82B1A@dlee03.ent.ti.com>
 <81C3A93C17462B4BBD7E272753C105791945AAD82C@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34899 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754187Ab0KDFpy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Nov 2010 01:45:54 -0400
In-Reply-To: <81C3A93C17462B4BBD7E272753C105791945AAD82C@EXDCVYMBSTM005.EQ1STM.local>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Greg KH <greg@kroah.com>

Hi Naveen, Dmitry,

> From: Naveen Kumar GADDIPATI [mailto:naveen.gaddipati@stericsson.com]
> 
> Hi Arce,
> 
> I'm also the GPIO pin for interrupt with request threaded irq .
> I'm passing the irq_type from the platform data.
> Which irq_type are you using for your platform?
> 

I am using the following flags

  IRQF_DISABLED | IRQF_TRIGGER_LOW | IRQF_TRIGGER_FALLING

Should I get rid of the first one, IRQF_DISABLED?

  IRQF_DISABLED - keep irqs disabled when calling the action handler

Best Regards
Abraham

