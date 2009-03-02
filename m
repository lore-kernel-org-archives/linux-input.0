From: David Miller <davem@davemloft.net>
Subject: Re: lockdep and threaded IRQs
Date: Mon, 02 Mar 2009 14:46:47 -0800 (PST)
Message-ID: <20090302.144647.116847598.davem@davemloft.net>
References: <1236030106.5330.1553.camel@laptop>
	<200903021409.21344.david-b@pacbell.net>
	<1236032371.5330.1654.camel@laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34035
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754821AbZCBWrH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 17:47:07 -0500
In-Reply-To: <1236032371.5330.1654.camel@laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: a.p.zijlstra@chello.nl
Cc: dbrownell@users.sourceforge.net, tglx@linutronix.de, akpm@linux-foundation.org, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 02 Mar 2009 23:19:31 +0100

> I state that every !IRQF_DISABLED usage is a bug, either due to broken
> hardware or broken drivers.

We'll send you the bill to have everyone's hardware
replaced :-)
