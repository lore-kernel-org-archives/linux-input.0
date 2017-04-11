From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Revert "HID: rmi: Handle all Synaptics touchpads using
 hid-rmi"
Date: Tue, 11 Apr 2017 11:31:49 +0200
Message-ID: <20170411093149.GD20965@mail.corp.redhat.com>
References: <alpine.LSU.2.20.1704111122410.28004@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdDKJb7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 05:31:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1704111122410.28004@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>, aduggan@synaptics.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Nick Dyer <nick@shmanahar.org>, Christopher Heiny <cheiny@synaptics.com>, Jason Ekstrand <jason@jlekstrand.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Apr 11 2017 or thereabouts, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> This reverts commit 279967a65b320d174a507498aea7d44db3fee7f4.
> 
> Multiple regressions [1] [2] [3] have been reported. The hid-rmi
> support would have to fixed and redone in 4.11+.
> 
> [1] http://lkml.kernel.org/r/b79b88c8-770a-13f6-5668-c3a94254e5e0@gmail.com
> [2] http://lkml.kernel.org/r/375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=195287
> 
> Reported-by: Cameron Gutman <aicommander@gmail.com>
> Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Reported-by: Lorenzo J. Lucchini <ljlbox@tiscali.it>
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 86bbd8a1fd4a..d162f0dc76e3 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -819,8 +819,7 @@ static int hid_scan_report(struct hid_device *hid)
>  		hid->group = HID_GROUP_WACOM;
>  		break;
>  	case USB_VENDOR_ID_SYNAPTICS:
> -		if (hid->group == HID_GROUP_GENERIC ||
> -		    hid->group == HID_GROUP_MULTITOUCH_WIN_8)
> +		if (hid->group == HID_GROUP_GENERIC)
>  			if ((parser->scan_flags & HID_SCAN_FLAG_VENDOR_SPECIFIC)
>  			    && (parser->scan_flags & HID_SCAN_FLAG_GD_POINTER))
>  				/*
> -- 
> Jiri Kosina
> SUSE Labs
> 
