From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH trivial] HID: Spelling s/Keayboard/Keyboard/
Date: Tue, 6 Jan 2015 22:20:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501062219520.25732@pobox.suse.cz>
References: <1420531753-10668-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49694 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756183AbbAFVUO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2015 16:20:14 -0500
In-Reply-To: <1420531753-10668-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Jan 2015, Geert Uytterhoeven wrote:

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/hid/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 230b6f887cd86e9b..303b295a5413d39b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -388,7 +388,7 @@ config HID_LOGITECH_HIDPP
>  	Say Y if you want support for Logitech devices relying on the HID++
>  	specification. Such devices are the various Logitech Touchpads (T650,
>  	T651, TK820), some mice (Zone Touch mouse), or even keyboards (Solar
> -	Keayboard).
> +	Keyboard).

Applied to hid.git#for-3.20/upstream.

Thanks,

-- 
Jiri Kosina
SUSE Labs
