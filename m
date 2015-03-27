From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/2] tc3589x OF only enforcement
Date: Fri, 27 Mar 2015 10:04:39 +0100
Message-ID: <CACRpkdZC-+fZXRAqnir2+pyq-es=-zA9jS2qGUiOF75KqzSLqQ@mail.gmail.com>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35039 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbbC0JEj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 05:04:39 -0400
Received: by obcjt1 with SMTP id jt1so66488173obc.2
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 02:04:39 -0700 (PDT)
In-Reply-To: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Input <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Mar 19, 2015 at 3:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> These two patches removes the non-DT probe/config path from the
> TC3589x driver. I suggest merging both through the MFD tree if
> Dmitry can ACK the input patch.

Lee it seems Dmitry ACKed these patches, can you merge those
two patches into MFD? I don't think there will be any cross-tree deps
so you can just carry them  in MFD without any immutable branch business.

Yours,
Linus Walleij
