From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/7] input/nomadik-ske: move key scanning to delayed work
Date: Thu, 24 May 2012 11:50:36 +0200
Message-ID: <CACRpkdaH=wTGdM_23khEnsNc42c6-LmEitC+qcjtmyHCJL8BjQ@mail.gmail.com>
References: <1336913049-10153-1-git-send-email-linus.walleij@stericsson.com>
	<20120516183327.GB14471@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56964 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab2EXJui (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 05:50:38 -0400
Received: by qcro28 with SMTP id o28so5495674qcr.19
        for <linux-input@vger.kernel.org>; Thu, 24 May 2012 02:50:37 -0700 (PDT)
In-Reply-To: <20120516183327.GB14471@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-input@vger.kernel.org, NaveenKumar Gaddipati <naveen.gaddipati@stericsson.com>

On Wed, May 16, 2012 at 8:33 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Hi Linus,
>
> On Sun, May 13, 2012 at 02:44:09PM +0200, Linus Walleij wrote:
>> From: Karl-Johan Perntz <karl-johan.perntz@stericsson.com>
>>
>> Move the key scanning to a delayed work thread, drop the threaded
>> IRQ since all the IRQ work can now be done quickly.
>
> Justification for the change is missing. What are the benefits of doing
> such move, why threaded IRQ does not work for you.

I'll try to hunt down the reason for this, could you apply patches
1 thru 4 in the meantime, and we put 5-7 on hold? They are not
dependent in any way.

Yours,
Linus Walleij
