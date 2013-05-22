From: Vincent Palatin <vpalatin@chromium.org>
Subject: Re: [PATCH] HID: usbhid: ignore Jabra speakerphones HID interface
Date: Wed, 22 May 2013 14:35:01 -0700
Message-ID: <CAP_ceTxhMut6Gewj=WxqAREusK4ZpwOyptAOAm9YT=LvEJcXCQ@mail.gmail.com>
References: <1369257474-26389-1-git-send-email-vpalatin@chromium.org> <alpine.LNX.2.00.1305222327300.22195@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:55971 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3EVVfW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 May 2013 17:35:22 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so6526025iea.32
        for <linux-input@vger.kernel.org>; Wed, 22 May 2013 14:35:21 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1305222327300.22195@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Olof Johansson <olofj@chromium.org>

On Wed, May 22, 2013 at 2:27 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>
> Please do this in hid_ignore_list[] in drivers/hid/hid-core.c instead.

Thanks for the advice !
I will update the patch accordingly.

-- 
Vincent
