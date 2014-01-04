From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Another ALPS touchpad
Date: Fri, 3 Jan 2014 21:40:21 -0800
Message-ID: <20140104054021.GB32576@core.coreip.homeip.net>
References: <20140103045915.GB30008@whitehail.bostoncoop.net>
 <5612072.Tm4gq8bhLq@dtor-d630.eng.vmware.com>
 <CA+F6ckPRj0NrerBC7j41QOE6ZsV7tPQ35gZEfk8cFZws7sT1vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:39278 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaADFkY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jan 2014 00:40:24 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so16538979pab.34
        for <linux-input@vger.kernel.org>; Fri, 03 Jan 2014 21:40:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+F6ckPRj0NrerBC7j41QOE6ZsV7tPQ35gZEfk8cFZws7sT1vg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Dylan Paul Thurston <dpthurst@indiana.edu>, linux-input@vger.kernel.org

Hi Tommy,

On Sat, Jan 04, 2014 at 01:27:24PM +0800, Tommy Will wrote:
> Hi Dmitry,
> 
> > Do you have anything in works to support this new model? Or it is
> > not an ALPS device at all?
> 
> Yes, it's an ALPS device and we're now preparing the patch for this new one.
> BTW, since it's a ClickPad without seperate buttons, simple resting
> finger logic would be added.

Hmm, what finger resting logic? We already properly support clickpads in
X driver (as long as the kernel tells userspace that the device is a
clickpad) so what is missing?

Thanks.

-- 
Dmitry
