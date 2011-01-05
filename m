From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] input/tc3589x: fix compile error
Date: Wed, 5 Jan 2011 11:20:16 +0300
Message-ID: <20110105082016.GD24847@bicker>
References: <20110104110820.GC1886@bicker>
 <AANLkTinmhwwzMn9Xnfv+_jE46CjvtaRVY3X8Uvwt4q7V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33761 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab1AEIUj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 03:20:39 -0500
Received: by gwj20 with SMTP id 20so6828909gwj.19
        for <linux-input@vger.kernel.org>; Wed, 05 Jan 2011 00:20:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinmhwwzMn9Xnfv+_jE46CjvtaRVY3X8Uvwt4q7V@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org

On Wed, Jan 05, 2011 at 02:01:01AM +0100, Linus Walleij wrote:
> 2011/1/4 Dan Carpenter <error27@gmail.com>:
> 
> > There was a semi-colon missing and it broke the compile.
> 
> How come my setup compiles then... Oh well, probably a more
> forgiving compiler.

The only explanation I can think of is that you're compiling the driver
into the kernel instead of as a module?  A lot of people like to have 
their keyboard compiled in instead of loaded later.

You could try a "make drivers/input/keyboard/tc3589x-keypad.i" and look
at the precompiled code.

regards,
dan carpenter

> Applied it.
> 
> Yours,
> Linus Walleij
