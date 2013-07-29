From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix key release for Fn keys with Samsung series 5 ultra
Date: Sun, 28 Jul 2013 19:14:56 -0700
Message-ID: <12081355.tI48ExGXTL@dtor-d630.eng.vmware.com>
References: <20130728070827.32e7cd31@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:41102 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab3G2CO7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 22:14:59 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so742048pbc.37
        for <linux-input@vger.kernel.org>; Sun, 28 Jul 2013 19:14:58 -0700 (PDT)
In-Reply-To: <20130728070827.32e7cd31@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: linux-input@vger.kernel.org

Hi Mauro,

On Sunday, July 28, 2013 07:08:27 AM Mauro Carvalho Chehab wrote:
> Samsung series 5 ultra notebooks don't produce release events for certain
> keys (Fn+F1, Fn+F11, Fn+F12 and Fn Lock). Add those keys at the release
> fixup table.
> 
> Note: Fn Lock actually produces two scancodes: 0xa8 and 0xa9.

Please add a quirk to udev to handle this please.

Thanks.

-- 
Dmitry
