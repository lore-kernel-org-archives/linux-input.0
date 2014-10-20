From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add keyboard input assist hid usages
Date: Mon, 20 Oct 2014 11:07:06 -0700
Message-ID: <3689204.uK3UlfOp53@dtor-glaptop>
References: <1413590019-1829-1-git-send-email-ogay@logitech.com> <20141017235937.GB22238@dtor-ws> <alpine.LNX.2.00.1410201123240.30423@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56345 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaJTSHK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2014 14:07:10 -0400
Received: by mail-pa0-f51.google.com with SMTP id lj1so5641973pab.24
        for <linux-input@vger.kernel.org>; Mon, 20 Oct 2014 11:07:09 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1410201123240.30423@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Olivier Gay <ogay@logitech.com>, linux-input@vger.kernel.org, Mathieu Meisser <mmeisser@logitech.com>

Hi Jiri,

On Monday, October 20, 2014 11:28:19 AM Jiri Kosina wrote:
> On Fri, 17 Oct 2014, Dmitry Torokhov wrote:
> > > Add keyboard input assist controls usages from approved
> > > hid usage table request HUTTR42:
> > > http://www.usb.org/developers/hidpage/HUTRR42c.pdf
> > > 
> > > Signed-off-by: Olivier Gay <ogay@logitech.com>
> > > ---
> > > 
> > > Hi all,
> > > 
> > > this patch adds some currently missing hid usages to the
> > > hid system.
> > 
> > Who is going to be using these codes? Do we have userspace consumers?
> 
> As review request #42 has been approved, I don't really have strong
> objections to adding this, as it means certain level of standardization by
> he USB Device Working Group HID Committee.
> 
> Dmitry, given your question, I am not applying the patch yet and waiting
> for your consideration/Ack.

Please merge with my Ack for the new codes - I was not against adding them,
just wanted to make sure they are going to be used instead of just adding them
as placehoders.

Thanks.

-- 
Dmitry
