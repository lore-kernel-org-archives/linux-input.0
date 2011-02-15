From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Add teletext/color keys - gyration remote - EU version
 (GYAR3101CKDE)
Date: Tue, 15 Feb 2011 10:30:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102151030310.2160@pobox.suse.cz>
References: <20110214195348.568f92b3@grobi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56789 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab1BOJak (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 04:30:40 -0500
In-Reply-To: <20110214195348.568f92b3@grobi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steffen Barszus <steffenbpunkt@googlemail.com>
Cc: linux-input@vger.kernel.org

On Mon, 14 Feb 2011, Steffen Barszus wrote:

> Dear List/Jiri,
> 
> This patch adds support for 5 keys which can be found
> only on the EU version of the gyration remote, which has been not
> mapped before. 
> 
> Signed-off-by: Steffen Barszus <steffenbpunkt[AT]googlemail[DOT]com>
> --- linux-2.6/drivers/hid/hid-gyration.c.orig	2010-09-13 08:16:36.353369149 +0200
> +++ linux-2.6/drivers/hid/hid-gyration.c	2010-09-13 08:17:56.629965460 +0200
> @@ -43,6 +43,11 @@ static int gyration_input_mapping(struct
>  	case 0x048: gy_map_key_clear(KEY_MEDIA);	break;
>  	case 0x049: gy_map_key_clear(KEY_CAMERA);	break;
>  	case 0x04a: gy_map_key_clear(KEY_VIDEO);	break;
> +	case 0x05a: gy_map_key_clear(KEY_TEXT);		break;
> +	case 0x05b: gy_map_key_clear(KEY_RED);		break;
> +	case 0x05c: gy_map_key_clear(KEY_GREEN);	break;
> +	case 0x05d: gy_map_key_clear(KEY_YELLOW);	break;
> +	case 0x05e: gy_map_key_clear(KEY_BLUE);		break;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
