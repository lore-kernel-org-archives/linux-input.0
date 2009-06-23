From: Ferenc Wagner <wferi@niif.hu>
Subject: multiple keys in one irq
Date: Tue, 23 Jun 2009 20:15:31 +0200
Message-ID: <87hby6ke9o.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:40345 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbZFWSPa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 14:15:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe.Kleine-Koenig@digi.com
Cc: linux-input@vger.kernel.org

Hi Uwe and linux-input folks,

Commit 57ffe9d5 (Input: gpio-keys - optimize interrupt handler) moved
into a rather unfortunate direction for me.  Of course regardless of
this change the whole gpio_keys module isn't (and wasn't) prepared to
handle multiple GPIO keys on the same irq.

Now I'd like to generalize to code to cope with this, but I'm not
experienced in kernel hacking, so decided to ask for some commentary
beforehand.  Are there any land mines around?

For a start, I need shared irqs, are they best requested with a lone
IRQF_SHARED flag?  Will they always be level triggered, or should I
explicitly request that as well by additional flags?  A sample is
already working for me, but I'd like to shake it into acceptable form.

(Please Cc me, I'm not subscribed.)
-- 
Thanks,
Feri.
