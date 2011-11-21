From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: matrix_keyboard based driver
Date: Mon, 21 Nov 2011 09:27:15 -0800
Message-ID: <20111121172715.GA2362@core.coreip.homeip.net>
References: <CAH9NwWd+40pC=UQFZnQcXoYp7J_Ui=cfcGh0WLaXV6niOjfF4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55373 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1KUR1V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 12:27:21 -0500
Received: by iage36 with SMTP id e36so7556059iag.19
        for <linux-input@vger.kernel.org>; Mon, 21 Nov 2011 09:27:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAH9NwWd+40pC=UQFZnQcXoYp7J_Ui=cfcGh0WLaXV6niOjfF4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org

Hi CHristian,

On Mon, Nov 21, 2011 at 02:52:17PM +0100, Christian Gmeiner wrote:
> Hi all,
> 
> today I started with a basic matrix_keyboard based keypad driver. It
> seems to work quite
> well but I have some questions.
> 
> Is it possible to define following values from user space?
> 
> * debounce time in [ms]

No as it is mostly hardware property, not user preference.

> * auto repeat time in [ms]

Yes: EVIOCSREP (kbdrate or similar). Note that X ignores kernel
autorepeat and implements its own.

> * multi click abort time in [ms]

I have no idea what that is, so apparently no ;)

> 
> I am also not sure about the default keymap I should use in the
> platform_data. At
> the moment it looks like:
> 
> static const uint32_t ot200_keymap[] = {
> 	KEY(0, 1, 0x01),
> 	KEY(0, 2, 0x02),
> 	KEY(0, 3, 0x03),
> 	KEY(0, 4, 0x04),
> 	KEY(0, 5, 0x05),
> 	KEY(0, 6, 0x06),
> 	KEY(0, 7, 0x07),
> 	KEY(0, 8, 0x08),
> 	KEY(0, 9, 0x09),
> ...
> ...
> 	KEY(9, 6, 0x96),
> 	KEY(9, 7, 0x97),
> 	KEY(9, 8, 0x98),
> 	KEY(9, 9, 0x99),

The last items in triplets should be KEY_* constant defined in
include/linux/input.h

> };
> 
> I need to configure the mapping from userspace and it is be done via loadkeys
> if I am not wrong.

To adjust mapping of the input device itself one should use 'setkeycode'
or some other utility issuing EVIOCGKEYCODE/EVIOCSKEYCODE ioctls.

loadkeys adjusts higher level keymap used by the console.

> Does the input core handle cases like SHIFT key and
> CAPS lock?

No, that is the task for higher layers (console, X, etc...).

Thanks.

-- 
Dmitry
