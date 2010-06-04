From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 1/4] input: Introduce buflock, a one-to-many circular
 buffer mechanism
Date: Fri, 04 Jun 2010 18:36:55 +0200
Message-ID: <4C092BA7.507@bitmath.org>
References: <1275552062-8153-1-git-send-email-rydberg@euromail.se> <1275552062-8153-2-git-send-email-rydberg@euromail.se> <20100604065658.GE21239@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp1.one.com ([195.47.247.21]:32811 "EHLO csmtp1.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660Ab0FDQhC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Jun 2010 12:37:02 -0400
In-Reply-To: <20100604065658.GE21239@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Oleg Nesterov <oleg@redhat.com>

>> +#define buflock_write(bw, buf, size, item)				\
>> +	do {								\
>> +		bw.next_head = (bw.head + 1) & ((size) - 1);		\
>> +		smp_wmb();						\
> 
> Why do we need the write barrier here?

I believe my first answer to this question was foggy indeed, so allow me to go
again, with a time line:

Scenario 1, correct write order:

writer              store_next_head   store_buf        store_head
reader  load_head   load_buf       load_next_head

Result: head != next_head, incoherent read detected

Scenario 2, incorrect write order:

writer              store_buf         store_next_head  store_head
reader  load_head   load_buf       load_next_head

Result: head == next_head, incoherent read not detected

Based on the assumption that scenario 2 could happen if the smp_wmb() is not
present, the barrier is needed.

Henrik
