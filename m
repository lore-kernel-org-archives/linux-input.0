From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH v2] elan_i2c - Don't require known iap version
Date: Mon, 21 Sep 2015 08:28:17 -0600
Message-ID: <CAD8Lp44muN-edhKxs4Vn+eC-aoEgtmkboz9zywDtp65SH4yfpQ@mail.gmail.com>
References: <1442583495-4593-1-git-send-email-drake@endlessm.com>
	<20150919171047.GA7081@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36953 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbbIUO2T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 10:28:19 -0400
Received: by wicfx3 with SMTP id fx3so114119671wic.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2015 07:28:18 -0700 (PDT)
In-Reply-To: <20150919171047.GA7081@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: DusonLin <dusonlin@emc.com.tw>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>, linux-input@vger.kernel.org

On Sat, Sep 19, 2015 at 11:10 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I do not like the fact that the fact that the version of IAP is unknown
> is not known to the driver until we try to flash the firmware. I'd
> rather we check it upfront and warn user.
>
> How about the version of the patch below?

That looks fine and I also confirmed that the new patch is working as described.

Thanks
Daniel
