From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add keyboard input assist hid usages
Date: Mon, 20 Oct 2014 21:04:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1410202104210.24255@pobox.suse.cz>
References: <1413590019-1829-1-git-send-email-ogay@logitech.com> <20141017235937.GB22238@dtor-ws> <alpine.LNX.2.00.1410201123240.30423@pobox.suse.cz> <3689204.uK3UlfOp53@dtor-glaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36560 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972AbaJTTE5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2014 15:04:57 -0400
In-Reply-To: <3689204.uK3UlfOp53@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olivier Gay <ogay@logitech.com>, linux-input@vger.kernel.org, Mathieu Meisser <mmeisser@logitech.com>

On Mon, 20 Oct 2014, Dmitry Torokhov wrote:

> > As review request #42 has been approved, I don't really have strong
> > objections to adding this, as it means certain level of standardization by
> > he USB Device Working Group HID Committee.
> > 
> > Dmitry, given your question, I am not applying the patch yet and waiting
> > for your consideration/Ack.
> 
> Please merge with my Ack for the new codes - I was not against adding them,
> just wanted to make sure they are going to be used instead of just adding them
> as placehoders.

That was my understanding, but I wanted to be sure.

Thanks everybody, now queued in hid.git#for-3.18/upstream-fixes

-- 
Jiri Kosina
SUSE Labs
