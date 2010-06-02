From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
Date: Wed, 02 Jun 2010 17:25:32 +1000
Message-ID: <1275463532.1931.773.camel@pasglop>
References: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
	 <1275104126.1931.521.camel@pasglop> <4C050017.10905@ge.com>
	 <20100602062634.GA3713@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46308 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab0FBHZu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jun 2010 03:25:50 -0400
In-Reply-To: <20100602062634.GA3713@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Martyn Welch <martyn.welch@ge.com>, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org

On Tue, 2010-06-01 at 23:26 -0700, Dmitry Torokhov wrote:
> 
> FYI: i8042 core expects I8042_{KBD|AUX}_IRQ to be integers, however it
> is certainly fixable...

Let's not bother.

Cheers,
Ben.


