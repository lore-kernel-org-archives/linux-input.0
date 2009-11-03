From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] input: fix locking context in ml_ff_set_gain
Date: Mon, 2 Nov 2009 21:53:58 -0800
Message-ID: <20091102215358.5398c8c1@infradead.org>
References: <20091031141925.149c9874@infradead.org>
	<20091102063818.GB3354@core.coreip.homeip.net>
	<20091103054446.GB3212@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59912 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbZKCFwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2009 00:52:37 -0500
In-Reply-To: <20091103054446.GB3212@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Anssi Hannula <anssi.hannula@gmail.com>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-input@vger.kernel.org

> 
> OK, it ended up being pretty simple. Anssi, any chance you could test
> it to make sure I did not screw up? Thanks!
> 
@@ -371,35 +370,34 @@ static void ml_effect_timer(unsigned long
timer_data) 
 	debug("timer: updating effects");
 
-	spin_lock(&ml->timer_lock);
+	spin_lock_irq(&dev->event_lock);
 	ml_play_effects(ml);
-	spin_unlock(&ml->timer_lock);
+	spin_unlock_irq(&dev->event_lock);
 }

this bit looks evil.

might be better off as irqsave...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
