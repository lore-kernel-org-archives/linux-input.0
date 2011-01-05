From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [patch] input/tc3589x: fix compile error
Date: Wed, 5 Jan 2011 11:55:36 +0100
Message-ID: <AANLkTi=C6mYL-9Q9WPvg7i8ceDx7+RgSpmaZx-cdPG_v@mail.gmail.com>
References: <20110104110820.GC1886@bicker>
	<AANLkTinmhwwzMn9Xnfv+_jE46CjvtaRVY3X8Uvwt4q7V@mail.gmail.com>
	<20110105082016.GD24847@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40762 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab1AEKzh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 05:55:37 -0500
Received: by pzk35 with SMTP id 35so1633728pzk.19
        for <linux-input@vger.kernel.org>; Wed, 05 Jan 2011 02:55:37 -0800 (PST)
In-Reply-To: <20110105082016.GD24847@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org

2011/1/5 Dan Carpenter <error27@gmail.com>:
> On Wed, Jan 05, 2011 at 02:01:01AM +0100, Linus Walleij wrote:
>> 2011/1/4 Dan Carpenter <error27@gmail.com>:
>>
>> > There was a semi-colon missing and it broke the compile.
>>
>> How come my setup compiles then... Oh well, probably a more
>> forgiving compiler.
>
> The only explanation I can think of is that you're compiling the driver
> into the kernel instead of as a module?

Yes that's it, hm the macro __MODULE_INFO() resolves to
nothing if compiled-in and resolves to something needing
a semicolon otherwise.

This makes some errors pass under the radar, looks
syntactically unsound to me :-(

I'll cook up a patch.

Yours,
Linus Walleij
