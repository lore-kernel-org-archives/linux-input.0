From: =?UTF-8?Q?Adrien_Verg=C3=A9?= <adrienverge@gmail.com>
Subject: Re: [PATCH] USB: quirks: Fix another ELAN touchscreen
Date: Mon, 23 Nov 2015 18:37:22 +0100
Message-ID: <CANsc=4Xj+3ySvvXxqnz660_iAr9syZwmgL5VLU2OAsUKtL-Lmw@mail.gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
	<alpine.LNX.2.00.1511231551330.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34122 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbbKWRhX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 12:37:23 -0500
In-Reply-To: <alpine.LNX.2.00.1511231551330.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Macpaul Lin <macpaul@gmail.com>, Vincent Palatin <vpalatin@chromium.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Yao-Wen Mao <yaowen@google.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org

2015-11-23 15:52 GMT+01:00 Jiri Kosina <jikos@kernel.org>:

> The drivers/hid part is
>
>         Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks.

> Makes one wonder however whether we shouldn't be applying ALWAYS_POLL to
> all ELAN devices by default anyway.

True! But I don't want to risk breaking anything on other models in this patch.

I'll submit a v2 with appropriate signed-off-by and acked-by.
