From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] Input: byd - use DMI detection
Date: Sat, 12 Nov 2016 09:33:57 -0800
Message-ID: <CAHc7Qt2xPTsWbjZdy1FBWCT5Lz43=9Tzj5FVpsn87=6VfFmPGg@mail.gmail.com>
References: <20161111235759.11988-1-chris@diamand.org> <58270744.cf3fc20a.1e77d.30f0@mx.google.com>
 <20161112144814.wt3yct4iztil6a3e@peridot.local.diamand.org> <201611121604.43032@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34650 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966604AbcKLRd6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 12:33:58 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so54354115qke.1
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 09:33:58 -0800 (PST)
In-Reply-To: <201611121604.43032@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Chris Diamand <chris@diamand.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

> How is windows detecting presence of BYD touchpads? Should we use
> something similar? Or are not there some (public) documentation about
> it?

Windows doesn't detect it correctly without BYD's kernel driver installed.

The only publicly available info on these can be found here:

http://bydit.com/doce/products/microelectronics/2474.html

Iv'e already tried getting mroe info from BYD, all they could find was a PDF
which enumerated the gesture types and the packet id used for each (byte 4).
No info there regarding protocol, etc.

best,
-Richard
