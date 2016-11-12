From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] Input: byd - use DMI detection
Date: Sat, 12 Nov 2016 10:01:56 -0800
Message-ID: <CAHc7Qt2MjsFKauODtXMSfO5fY8+KJrewE0ki61u+qP+-82Afqw@mail.gmail.com>
References: <20161111235759.11988-1-chris@diamand.org> <201611121604.43032@pali>
 <CAHc7Qt2xPTsWbjZdy1FBWCT5Lz43=9Tzj5FVpsn87=6VfFmPGg@mail.gmail.com> <201611121848.13617@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35677 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966530AbcKLSB6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 13:01:58 -0500
Received: by mail-qk0-f182.google.com with SMTP id n204so54784503qke.2
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 10:01:57 -0800 (PST)
In-Reply-To: <201611121848.13617@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Chris Diamand <chris@diamand.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

> I understand... it is hard to get some information...
>
> One option is to trying to ask BYD again, another is to try reverse
> engineer or sniff data exchange from windows driver.

That's how we've gotten this far with the linux driver, by
intercepting and reverse engineering the protocol using the
Windows driver.
