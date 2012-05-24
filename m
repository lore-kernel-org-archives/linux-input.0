From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] Input updates for 3.5-rc0
Date: Thu, 24 May 2012 13:11:14 -0700
Message-ID: <CA+55aFxX+xidcuVXb1h4oFTemtHo+ANECaoOw=vxtKN231N+cA@mail.gmail.com>
References: <20120524083216.GD10562@core.coreip.homeip.net>
 <CA+55aFxw0HRpizzJZxhhA2oqPpzg4DPUvH2r7YoYfctXS6K=WQ@mail.gmail.com>
 <20120524180154.GA15036@core.coreip.homeip.net> <CA+55aFx0ww=BtYAj9WEbqMT2R30ZZpjd014cYCpC=b+HRtUf_A@mail.gmail.com>
 <20120524195851.GA15306@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:32828 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933225Ab2EXULg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 16:11:36 -0400
In-Reply-To: <20120524195851.GA15306@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, May 24, 2012 at 12:58 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>  Considering your
>
> =A0 =A0 =A0 =A0dev_set_name(&dev->dev, "input-%s", dev_name(dev->dev.=
parent));
>
> what happens if I unplug and replug my wacom tablet while event node =
is
> still opened and therefore all kobjects are still pinned into memory?

I'll let you think about just how stupid that comment was for a moment.

                  Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
