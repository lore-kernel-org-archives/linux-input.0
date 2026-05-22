Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60B226D18
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434537; cv=none; b=D0YscIMnHBxn2emyh9wUi6GW85n95iOBu4dVOcfqSUgj4vhQ1iCs3dHFls7rPjICuzVkbWGiMQ3QrvU9/lUNPUwgNKXP/G7OWEKFWtTl74g/PYkuogx2uMt1z7rgZapdfgs+pAn/PestM47uC8ITLlPVaOzD5+87geR4vy/TSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434537; c=relaxed/simple;
	bh=ifDGBFABrqgJ5tv4Gpht1jfnJuGN3lDVgmj8eYXlD/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UunsG5brSdHzhlhKj1oIjyOJxCsFc0iVPaldayP+xM0i8K9EoNy7ns+V8+RqYHrhHPVyxTOarTT50w5Pdk8PKSUWQ3euPIbj5GYFUrQ4zaVjzl31NgD5UjLgHGI3nn9IkqmQoxRO7q8gOVKKeGZwfM8yquV/ctqWTjsnLyM5Rhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Syn5eHi0; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Syn5eHi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1779434534;
	bh=CqJhosHL3QuV8yTfbm714TjlLFKM8FJPFMarQlpArUU=;
	h=From:Subject:Date:Message-ID;
	b=Syn5eHi0Ua5AIs7MSRWMvZ856u7Iua//Z5wA2Qthf0+Lvuo385oU9hvXXx6pq4hzW
	 3cPSfG/QBfhyvtArMYRP0QcaRzqJWDyP793UvLRTzom22HU4/wz1wxvHrbl2QlE31w
	 IGz2lWOMicbX/RA1L/0vMxU99Hp8wIpvX3gsCrOQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 6A10041100003D1E; Fri, 22 May 2026 15:21:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7199236291973
X-SMAIL-UIID: 7AC66D6DBC8B4ED2BFFC2B5332317570-20260522-152154-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com>,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
Date: Fri, 22 May 2026 15:21:43 +0800
Message-ID: <20260522072144.934-1-hdanton@sina.com>
In-Reply-To: <20260522063938.ewKum8vW@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 08:39:38 +0200 Sebastian Andrzej Siewior wrote:
> On 2026-05-22 06:35:14 [+0800], Hillf Danton wrote:
> > input_inject_event() is invoked in the brightness_set callback [1] for
> > example.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/input-leds.c#n142
> > 
> > > Now, input_inject_event() does spin_lock_irqsave() and alloc_skb() does
> > > local_bh_disable()/ local_bh_enable(). On !RT this is not legal. On RT
> > 
> > Can you please specify why that is illegal on !RT?
> 
> So if you do
> 	spin_lock_irq();
> 	local_bh_disable();
> 
> then the
> 	local_bh_enable();
> 
> has lockdep_assert_irqs_enabled() which will yell. Then there is also

Ah got it, thanks.

> this local_irq_enable() which will enable interrupts before the unlock
> which bad, again. Also, should softirqs been raised within this section,
> the this enable will invoke the required callback which again, enable
> interrupts.
> 
> > > it is okay but then local_bh_enable() here should not invoke any
> > > softirqs because none were raised within the section (alloc_skb()).
> > 
> > On RT spinlock is replaced with mutex, and softirq can be raised in the
> > irq that could come any moment after spin_lock_irqsave().
> 
> That is true on the other hand. That means having raised another tasklet
> could lead to the backtrace. But it would have been two different locks,
> not blocking on each other.
>
The last question, by two different locks, do you mean that the
tasklet_sync_callback.cb_lock is per cpu?
