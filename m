From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: gyration remote - europe/QWERTZ version (GYAR3101CKDE)
Date: Tue, 21 Sep 2010 16:19:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211618440.26813@pobox.suse.cz>
References: <20100809083831.76426571@grobi> <AANLkTin4bsd4SAfy35SzaEMR-S+moALGcNMfzttmJQ6U@mail.gmail.com> <alpine.LNX.2.00.1008201111220.1019@pobox.suse.cz> <20100913082219.2d8ebbbc@grobi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58867 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab0IUOTZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 10:19:25 -0400
In-Reply-To: <20100913082219.2d8ebbbc@grobi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steffen Barszus <steffenbpunkt@googlemail.com>
Cc: linux-input@vger.kernel.org

On Mon, 13 Sep 2010, Steffen Barszus wrote:

> > I haven't been CCed on your original mail, was I?
> 
> No
> 
> > Anyway, would you be able to send the patch properly to me, so that I 
> > could apply it? (i.e. not line-wrapped and whitespace damaged, with
> > proper Signed-off-by line, etc -- see Documentation/SubmittingPatches
> > if in doubt).
> 
> Hope this time its correct. Please let me know if you miss something.
> 
> > Thanks,
> > 
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
>  
>  	default:
>  		return 0;

Almost there :) Please also include changelog (short description of what 
the patch does, which device contains these keys, etc) together with the 
actual patch, so that I could apply it.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
