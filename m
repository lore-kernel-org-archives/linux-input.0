From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: force retrieving of Win8 signature blob
Date: Tue, 8 Mar 2016 08:43:59 +0100
Message-ID: <20160308074359.GI22340@mail.corp.redhat.com>
References: <1457344958-9987-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1603072343330.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbcCHHoF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2016 02:44:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1603072343330.3656@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mar 07 2016 or thereabouts, Jiri Kosina wrote:
> On Mon, 7 Mar 2016, Benjamin Tissoires wrote:
> 
> > The Synaptics 0x11e5 over I2C found in the Asus T100-CHI requires to
> > fetch the signature blob to actually start sending events.
> > 
> > With this patch, we should be close enough to the Windows driver which
> > checks the content of the blob at plugin to validate or not the
> > touchscreen.
> 
> I have brought the 'Link' and 'Fixes' headers into slightly better shape 
> :) and applied.

Hehe. That seems better now, indeed.

> 
> I will likely not be pushing this to Linus this week, but will make sure 
> this ends up in -stable once this lands in his tree during the upcoming 
> merge window, if you agree?

OK for me. Thanks!

Cheers,
Benjamin
