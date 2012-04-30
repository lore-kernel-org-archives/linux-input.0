From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: serio_raw - signal EFAULT even if read/write
 partially succeeds
Date: Mon, 30 Apr 2012 22:26:03 +0100
Message-ID: <20120430222603.7a92b5de@pyramind.ukuu.org.uk>
References: <20120430064450.GA29212@core.coreip.homeip.net>
	<20120430111223.4941a9f0@pyramind.ukuu.org.uk>
	<20120430163442.GA2316@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53962 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2D3VXZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 17:23:25 -0400
In-Reply-To: <20120430163442.GA2316@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Che-Liang Chiou <clchiou@chromium.org>, David Herrmann <dh.herrmann@googlemail.com>

> If a read() is interrupted by a signal after it has successfully read
> some data, it shall return the number of bytes read."

Fair point - I guess technically EFAULT is not a signal. I still think
its a better behaviour to not lose bytes but objection withdrawn.

> No, we'd only go into wait_event_interruptible() if we haven't read
> anything yet so we won't lose any data here.

Ok

Alan
