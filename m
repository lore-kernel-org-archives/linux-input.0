From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Accutouch: Add driver for ELO Accutouch 2216 USB
 Touchscreens
Date: Wed, 22 Mar 2017 09:27:12 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703220926090.31814@cbobk.fhfr.pm>
References: <1487081876-9743-1-git-send-email-martyn.welch@collabora.co.uk> <alpine.LSU.2.20.1703211504180.31814@cbobk.fhfr.pm> <CAKdAkRSH0pVFwmnDzurbngNK0ea51c0+Omf0sjGx7RL-ZKx92g@mail.gmail.com> <alpine.LSU.2.20.1703212046570.31814@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50307 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758838AbdCVI1n (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Mar 2017 04:27:43 -0400
In-Reply-To: <alpine.LSU.2.20.1703212046570.31814@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Tue, 21 Mar 2017, Jiri Kosina wrote:

> Sorry, I messed up. I exchanged this patch with another one that fixed 
> report descriptor (which we can't yet, although I have been thinking about 
> ways how to do this properly).

FTR, this is now also dropped from hid.git. Thanks again for catching my 
brainfart, Dmitry.

-- 
Jiri Kosina
SUSE Labs

