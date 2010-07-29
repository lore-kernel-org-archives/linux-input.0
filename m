From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] irq: rename IRQF_TIMER to IRQF_NO_SUSPEND
Date: Thu, 29 Jul 2010 10:49:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007291045060.2471@localhost.localdomain>
References: <1280314445.24292.90.camel@zakaz.uk.xensource.com> <1280314467-5637-1-git-send-email-ian.campbell@citrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280314467-5637-1-git-send-email-ian.campbell@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Campbell <ian.campbell@citrix.com>
Cc: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Grant Likely <grant.likely@secretlab.ca>, xen-devel@lists.xensource.com, linux-input@vger.kernel.org, linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-input@vger.kernel.org

On Wed, 28 Jul 2010, Ian Campbell wrote:

> Continue to provide IRQF_TIMER as an alias to IRQF_NO_SUSPEND since I
> think it is worth preserving the nice self-documenting name (where it
> is used appropriately). It also avoid needing to patch all the many
> users who are using the flag for an actual timer interrupt.

I'm not happy about the alias. What about:

#define __IRQF_TIMER		0x00000200
#define IRQF_NO_SUSPEND		0x00000400

#define IRQF_TIMER    (__IRQF_TIMER | IRQF_NO_SUSPEND)

Thanks,

	tglx
