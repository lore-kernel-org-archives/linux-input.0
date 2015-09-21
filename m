From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] elan_i2c - Don't require known iap version
Date: Mon, 21 Sep 2015 09:17:40 -0700
Message-ID: <20150921161740.GB17389@dtor-ws>
References: <1442583495-4593-1-git-send-email-drake@endlessm.com>
 <20150919171047.GA7081@dtor-ws>
 <CAD8Lp44muN-edhKxs4Vn+eC-aoEgtmkboz9zywDtp65SH4yfpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36361 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbbIUQRn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 12:17:43 -0400
Received: by padbj2 with SMTP id bj2so10914820pad.3
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2015 09:17:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAD8Lp44muN-edhKxs4Vn+eC-aoEgtmkboz9zywDtp65SH4yfpQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: DusonLin <dusonlin@emc.com.tw>, =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>, linux-input@vger.kernel.org

On Mon, Sep 21, 2015 at 08:28:17AM -0600, Daniel Drake wrote:
> On Sat, Sep 19, 2015 at 11:10 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > I do not like the fact that the fact that the version of IAP is unknown
> > is not known to the driver until we try to flash the firmware. I'd
> > rather we check it upfront and warn user.
> >
> > How about the version of the patch below?
> 
> That looks fine and I also confirmed that the new patch is working as described.

Great, I am applying this then.

-- 
Dmitry
