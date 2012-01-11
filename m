From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Key mapping question
Date: Wed, 11 Jan 2012 22:35:50 +0000
Message-ID: <20120111223550.202a9604@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:39845 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934155Ab2AKWfA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 17:35:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, khnz@users.sourceforge.net


I'm currently adding the Fujitsu Q550 to the fujitsu-tablet driver
(http://sourceforge.net/projects/fjbtndrv/files/fjbtndrv/)

The Q550 has 3 buttons - a direction flipping button, a keyboard button
and a ctrl-alt-delete button.

It's labelled as such, it acts as such and I'm tempted to map it as such
including modifiers but that does rather violate the usual behaviour we
expect.

So how should it be mapped ?

I'll send Robert Gerlach a patch once I have a good answer on that one.
It would also be nice to get the kernel bits for this driver upstream.
Barring some trivial printk/pr_debug things it looks to me to be in
perfectly good shape to go upstream, and it's kind of handy when the
buttons work on your tablet !

Alan
