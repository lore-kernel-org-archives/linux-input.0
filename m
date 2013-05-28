From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] hid: driver for PS2/3 Buzz controllers
Date: Tue, 28 May 2013 14:53:15 +0200
Message-ID: <1369745595.12005.11.camel@novo>
References: <1369587150.4240.4.camel@roadrunner.fritz.box>
	  <alpine.LNX.2.00.1305271628540.3914@pobox.suse.cz>
	 <1369690865.2369.5.camel@roadrunner.fritz.box>
	 <alpine.LNX.2.00.1305281018250.3914@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:56175 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890Ab3E1M56 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 May 2013 08:57:58 -0400
In-Reply-To: <alpine.LNX.2.00.1305281018250.3914@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Colin Leitner <colin.leitner@googlemail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2013-05-28 at 10:19 +0200, Jiri Kosina wrote:
> On Mon, 27 May 2013, Colin Leitner wrote:
> 
> > This patch adds support for PS2/3 Buzz controllers into hid-sony
> 
> Thanks, now applied.

I would have preferred it if the single device (the USB adapter) showed
4 input devices each with 5 buttons and a LED, rather than a single
device with 4 LEDs and 20 buttons.

Cheers

