From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] GPIO button wth wakeup attribute is supposed to wake
 the system up
Date: Thu, 19 Jun 2014 11:40:06 +0100
Message-ID: <20140619114006.72ac8e06@alan.etchedpixels.co.uk>
References: <53A2340D.9030503@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43144 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbaFSKk0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jun 2014 06:40:26 -0400
In-Reply-To: <53A2340D.9030503@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 19 Jun 2014 08:51:25 +0800
"Li, Aubrey" <aubrey.li@linux.intel.com> wrote:

> When the wakeup attribute is set, the GPIO button is capable of
> waking up the system from sleep states, including the "freeze"
> sleep state.  For that to work, its driver needs to pass the
> IRQF_NO_SUSPEND flag to devm_request_any_context_irq(), or the
> interrupt will be disabled by suspend_device_irqs() and the
> system won't be woken up by it from the "freeze" sleep state.
> 
> The suspend_device_irqs() routine is a workaround for drivers
> that mishandle interrupts triggered when the devices handled
> by them are suspended, so it is safe to use IRQF_NO_SUSPEND in
> all drivers that don't have that problem.
> 
> The affected/tested machines include Dell Venue 11 Pro and Asus T100TA.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Alan Cox <alan@linux.intel.com>

