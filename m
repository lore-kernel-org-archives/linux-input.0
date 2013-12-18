From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv2] Input: fix typos in Documentation/input/gamepad.txt
Date: Wed, 18 Dec 2013 08:39:53 -0800
Message-ID: <20131218163953.GB30922@core.coreip.homeip.net>
References: <52AF51EA.8090400@infradead.org>
 <1387280024-12213-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43799 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab3LRQj5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Dec 2013 11:39:57 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so8658492pbc.35
        for <linux-input@vger.kernel.org>; Wed, 18 Dec 2013 08:39:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387280024-12213-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Tue, Dec 17, 2013 at 12:33:44PM +0100, Antonio Ospite wrote:
> Fix some typos and while at it also use "PS" as the name for the central
> "HOME" button on Sony controllers, this is how Sony itself calls it.
> 
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Applied, thank you.

> ---
> 
> Changes since v1:
>   - Fix one of the fixes: use "advise" (verb) in place of "advice" (noun)
> 
> Thanks Randy.
> 
>  Documentation/input/gamepad.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/input/gamepad.txt b/Documentation/input/gamepad.txt
> index 31bb6a4..3f6d8a5 100644
> --- a/Documentation/input/gamepad.txt
> +++ b/Documentation/input/gamepad.txt
> @@ -68,7 +68,7 @@ features that you need, first. How each feature is mapped is described below.
>  Legacy drivers often don't comply to these rules. As we cannot change them
>  for backwards-compatibility reasons, you need to provide fixup mappings in
>  user-space yourself. Some of them might also provide module-options that
> -change the mappings so you can adivce users to set these.
> +change the mappings so you can advise users to set these.
>  
>  All new gamepads are supposed to comply with this mapping. Please report any
>  bugs, if they don't.
> @@ -150,10 +150,10 @@ Menu-Pad:
>                    BTN_START
>    Many pads also have a third button which is branded or has a special symbol
>    and meaning. Such buttons are mapped as BTN_MODE. Examples are the Nintendo
> -  "HOME" button, the XBox "X"-button or Sony "P" button.
> +  "HOME" button, the XBox "X"-button or Sony "PS" button.
>  
>  Rumble:
> -  Rumble is adverticed as FF_RUMBLE.
> +  Rumble is advertised as FF_RUMBLE.
>  
>  ----------------------------------------------------------------------------
>    Written 2013 by David Herrmann <dh.herrmann@gmail.com>
> -- 
> 1.8.5.1
> 

-- 
Dmitry
