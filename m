From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Re: Chipone icn85xx support in x86 linux kernel
Date: Wed, 4 May 2016 05:43:49 +0000
Message-ID: <CA+V1LzqSwgDzV4v1-rzTGYrz-i-YqTJgRB1cGG61Zqfwv8ykTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34797 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbcEDFnu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 01:43:50 -0400
Received: by mail-qg0-f67.google.com with SMTP id e35so2438413qge.1
        for <linux-input@vger.kernel.org>; Tue, 03 May 2016 22:43:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gregor:

>In particular, a new driver should be a patch against the respective kernel
>branch, which means it should live in the appropriate directory in the kernel
>tree and include an addendum to the Kconfig/Makefile there. Standalone
>Makefiles are nice when building drivers out-of-tree, but they are not
>suitable for kernel code.

Yep, agree but:

Without proprietary firmware touch will be not working!
Also there is doubts -  we have discussed this here
http://www.spinics.net/lists/linux-input/msg43564.html - I could not
say at the moment that this Chipone original code because due absence
of full specs -  I have ported and modified and rewrote driver code,
as "specs" I've used mentioned before rk3128 driver.
So thats why it is standalone, not sure that it ever been added to mainline.

Will be happy if someone clear this moment, licencing is tricky moment.

Regards,
               Serge.
