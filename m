From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] genirq: assert that irq handlers are indeed run in hardirq
 context.
Date: Mon, 02 Mar 2009 16:13:32 +0100
Message-ID: <1236006812.5330.632.camel@laptop>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	 <200902271350.32380.david-b@pacbell.net>
	 <20090227140907.f159be9b.akpm@linux-foundation.org>
	 <200902271518.58246.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:52628 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbZCBPOS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Mar 2009 10:14:18 -0500
In-Reply-To: <200902271518.58246.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>

On Fri, 2009-02-27 at 15:18 -0800, David Brownell wrote:
> But these handlers are *NOT* running in hardirq context;

Ah, let us stop this tinkering dead in its tracks

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/irq/handle.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index c87d146..b75d73b 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -354,6 +354,8 @@ irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action)
 	irqreturn_t ret, retval = IRQ_NONE;
 	unsigned int status = 0;
 
+	BUG_ON(!in_irq());
+
 	if (!(action->flags & IRQF_DISABLED))
 		local_irq_enable_in_hardirq();
 


