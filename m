From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: Re: [RFC / PATCH] [SOUND] add a private field for ac97-device
	drivers and let ucb1400 be its first user
Date: Fri, 25 Apr 2008 09:28:47 +0200
Message-ID: <20080425072847.GB4460@Chamillionaire.breakpoint.cc>
References: <20080424153753.GD26452@Chamillionaire.breakpoint.cc> <Pine.LNX.4.61.0804250830030.7882@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:46047 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753425AbYDYH2t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 03:28:49 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804250830030.7882@tm8103.perex-int.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

* Jaroslav Kysela | 2008-04-25 08:30:40 [+0200]:

>On Thu, 24 Apr 2008, Sebastian Siewior wrote:
>
>> From: Sebastian Siewior <bigeasy@linutronix.de>
>> 
>> Currently the UCB1400 driver discovers the interrupt via probing. This works
>> probably only on x86. This patch adds a private field to the ac97 struct
>> where the ac97 driver can deposit informations for the device driver that
>> serves a device which is attached to the ac97 bus.
>> This patch also converts the UCB1400 driver to use this information if available.
>> 
>> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
>
>Thanks. I applied your patch to our tree.

Cool thanks. I hope the input folks don't mind getting things touched by
others but in this case they might be glad.

>						Jaroslav
Sebastian
