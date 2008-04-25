From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC / PATCH] [SOUND] add a private field for ac97-device drivers
 and let ucb1400 be its first user
Date: Fri, 25 Apr 2008 08:30:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804250830030.7882@tm8103.perex-int.cz>
References: <20080424153753.GD26452@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.perex.cz ([212.20.107.53]:40754 "EHLO mail1.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214AbYDYGam (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 02:30:42 -0400
In-Reply-To: <20080424153753.GD26452@Chamillionaire.breakpoint.cc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, alsa-devel@alsa-project.org, linux-input@vger.kernel.org

On Thu, 24 Apr 2008, Sebastian Siewior wrote:

> From: Sebastian Siewior <bigeasy@linutronix.de>
> 
> Currently the UCB1400 driver discovers the interrupt via probing. This works
> probably only on x86. This patch adds a private field to the ac97 struct
> where the ac97 driver can deposit informations for the device driver that
> serves a device which is attached to the ac97 bus.
> This patch also converts the UCB1400 driver to use this information if available.
> 
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>

Thanks. I applied your patch to our tree.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

