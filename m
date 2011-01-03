From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Corrected errors and warnings reported by
 "checkpatch.pl" utility.
Date: Sun, 2 Jan 2011 23:03:50 -0800
Message-ID: <20110103070350.GD26703@core.coreip.homeip.net>
References: <1294027991-2537-1-git-send-email-user@linux-mint>
 <1294027991-2537-3-git-send-email-user@linux-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47639 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1ACHD4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Jan 2011 02:03:56 -0500
Received: by ywl5 with SMTP id 5so5177693ywl.19
        for <linux-input@vger.kernel.org>; Sun, 02 Jan 2011 23:03:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294027991-2537-3-git-send-email-user@linux-mint>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Grahovac <steve.grahovac@gmail.com>
Cc: linux-input@vger.kernel.org, Steve Grahovac <steve.grahovac@microchip.com>

On Sun, Jan 02, 2011 at 10:13:11PM -0600, Steve Grahovac wrote:
> From: Steve Grahovac <steve.grahovac@microchip.com>
> 
> diff --git a/include/linux/serio.h b/include/linux/serio.h
> index b555256..13fd94b 100644
> --- a/include/linux/serio.h
> +++ b/include/linux/serio.h
> @@ -197,5 +197,6 @@ static inline void serio_continue_rx(struct serio *serio)
>  #define SERIO_W8001	0x39
>  #define SERIO_DYNAPRO	0x3a
>  #define SERIO_HAMPSHIRE	0x3b
> +#define SERIO_MCHPAR1XXX	0x3c
>  

0x3c has already been taken.

-- 
Dmitry
