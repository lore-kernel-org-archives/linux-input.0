Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55D17C220
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779583554; cv=none; b=KJ5hIERZAoo9gMSvQofnqf91UyA2cVrp1zgAQA7nGztnJ2b9HdIDHbeQ43k0Ki0myDQ3wJjOrhaisUTkF2cEwmGpaMKGOy4EHH7mKeypOk2UH0gH65enJ+Ba+VJeEJb3WrKu0+8rBRdUSiQMCUaf7EahJa8Y42uUX1aqcQi8+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779583554; c=relaxed/simple;
	bh=Ryub3bxAg3HpGHhCb7j373fGB0gxrB+niXyRt01reSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxsUMjoGz1xjOsB3xTTTH8TYkBHaVPOHPffppHGWPaXKbJ+CPiKqpqKLAWhXw1vrQf+0KZ41uF6HRlszRJhzPzn3O3Gu6SMQIW6N5pO9yuA1qGxxUI49GTTKVyPPe6/gNjhpAwrad98mSQXX8uXE7+pLJHlyjhufi8G7dKSfIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=bZEzkTdy; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="bZEzkTdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1779583551;
	bh=D+Xx070geJuEoMzvoHusFzySwWHtQQrule6PO7vsn1c=;
	h=From:Subject:Date:Message-ID;
	b=bZEzkTdyUDEqiVzEVPbdMlFgUv/ZZLClxIAWGVGhsgT/O/VygQxPlQm6MzHM3LMi/
	 Du0+uYWHmjkkYEaE73NOmbKwyAcjR6DTlHIfgZddLJcOSbcb8Dv9UCx66tyy+Vg9/y
	 /E5dq++BuBDXhFe91Pp28jn3BOWRHreo26iDErFw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A124A3000002425; Sun, 24 May 2026 08:45:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7600346685065
X-SMAIL-UIID: 94A8564010E24E2D842BA3C8B0851FEE-20260524-084539-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com>,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
Date: Sun, 24 May 2026 08:45:24 +0800
Message-ID: <20260524004526.1046-1-hdanton@sina.com>
In-Reply-To: <20260522073508.VfBubDl8@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 09:35:08 +0200 Sebastian Andrzej Siewior wrote:
> On 2026-05-22 15:21:43 [+0800], Hillf Danton wrote:
> > > > On RT spinlock is replaced with mutex, and softirq can be raised in the
> > > > irq that could come any moment after spin_lock_irqsave().
> > > 
> > > That is true on the other hand. That means having raised another tasklet
> > > could lead to the backtrace. But it would have been two different locks,
> > > not blocking on each other.
> > >
> > The last question, by two different locks, do you mean that the
> > tasklet_sync_callback.cb_lock is per cpu?
> 
> Yes, it is but this does not matter. kbd_led_trigger_activate() does
> tasklet_disable(&keyboard_tasklet) so you can't have kbd_bh() running
> and led_set_brightness() which would kick the softirq again. Not from
> kbd_led_trigger_activate().
> 
> Even if another component would raise a softirq in that window, you
> could run tasklets, yes, but never kbd_bh(). Not in this window.
> 
After a look at fd4e876f59b7 ("softirq: Provide a handshake for canceling
tasklets via polling") add a shameless question (obvious the above one is
not last), any chance for cutting tasklet_sync_callback off if wait_on_bit()
for TASKLET_STATE_RUN is used in tasklet_unlock_spin_wait()?
