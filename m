From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add keyboard input assist hid usages
Date: Mon, 20 Oct 2014 11:28:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1410201123240.30423@pobox.suse.cz>
References: <1413590019-1829-1-git-send-email-ogay@logitech.com> <20141017235937.GB22238@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54314 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbaJTJ2X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2014 05:28:23 -0400
In-Reply-To: <20141017235937.GB22238@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olivier Gay <ogay@logitech.com>, linux-input@vger.kernel.org, Mathieu Meisser <mmeisser@logitech.com>

On Fri, 17 Oct 2014, Dmitry Torokhov wrote:

> > Add keyboard input assist controls usages from approved
> > hid usage table request HUTTR42:
> > http://www.usb.org/developers/hidpage/HUTRR42c.pdf
> > 
> > Signed-off-by: Olivier Gay <ogay@logitech.com>
> > ---
> > 
> > Hi all,
> > 
> > this patch adds some currently missing hid usages to the
> > hid system.
> 
> Who is going to be using these codes? Do we have userspace consumers?

As review request #42 has been approved, I don't really have strong 
objections to adding this, as it means certain level of standardization by 
he USB Device Working Group HID Committee.

Dmitry, given your question, I am not applying the patch yet and waiting 
for your consideration/Ack.

Thanks,

-- 
Jiri Kosina
SUSE Labs
