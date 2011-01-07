From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [patch] input/tc3589x: fix compile error
Date: Fri, 7 Jan 2011 11:12:38 +0100
Message-ID: <AANLkTi=izTVZ2OH+drgimtB3o=e9Ksu5G+a+VHFDPk=j@mail.gmail.com>
References: <20110104110820.GC1886@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50130 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab1AGKMj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Jan 2011 05:12:39 -0500
Received: by pwj3 with SMTP id 3so2313222pwj.19
        for <linux-input@vger.kernel.org>; Fri, 07 Jan 2011 02:12:38 -0800 (PST)
In-Reply-To: <20110104110820.GC1886@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org, Dan Carpenter <error27@gmail.com>

2011/1/4 Dan Carpenter <error27@gmail.com>:

> There was a semi-colon missing and it broke the compile.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Dmitry can you take this fixup into the input tree?
Russell pulled the tc3589x driver into his tree and Torvalds
pulled it into his tree, so if you are based on Torvalds' tree
for today it should apply fine.

(Sorry for the mistake, I've attempted to fix the root cause
by a patch to make this throw compile errors under all
circumstances to Rusty Russell.)

Yours,
Linus Walleij
