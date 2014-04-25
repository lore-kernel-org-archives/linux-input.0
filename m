From: Olivier Gay <ogay@logitech.com>
Subject: Re: [PATCH v3] HID: add missing hid usages
Date: Fri, 25 Apr 2014 20:25:06 +0200
Message-ID: <CAFLMSp_egiMOXMV2yX41Rk4e-7NQFy5z6xft2x_AE1aeURkHjA@mail.gmail.com>
References: <1398413623-19233-1-git-send-email-ogay@logitech.com> <20140425163828.GA12355@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na6sys009bog017.obsmtp.com ([74.125.150.74]:52796 "EHLO
	na6sys009bog017.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754395AbaDYSdA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2014 14:33:00 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so3910293wgg.21
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2014 11:32:58 -0700 (PDT)
In-Reply-To: <20140425163828.GA12355@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Mathieu Meisser <mmeisser@logitech.com>

On Fri, Apr 25, 2014 at 6:38 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Apr 25, 2014 at 10:13:43AM +0200, Olivier Gay wrote:
> This table already has entries for KEY_BRIGHTNESS_UP/DOWN, you are
> overriding them. I'd rather we did not define gratuitous aliases
> (sometimes aliasing is necessary when we got the name wrong, but UP/DOWN
> vs INC/DEC for brightness is not the case here).

Done. You didn't mention KEY_BRIGHTNESS_TOGGLE so I kept it.

> I was looking through keycodes again and we have:
>
> #define KEY_BRIGHTNESS_ZERO|----244|----/* brightness off, use ambient */
>
> which seems to be exactly the same as KEY_BRIGHTNESS_AUTO, but here I
> agree that old name is not the best. Could you please change its
> definition earlier in the file to:
>
> #define KEY_BRIGHTNESS_AUTO     224     /* Set Auto Brightness: manual
>                                           brightness control is off,
>                                           rely on ambient */
> #define KEY_BRIGHTNESS_ZERO     KEY_BRIGHTNESS_AUTO

Changes done. I'm sending v4 right now.

Best regards,

Olivier
