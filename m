From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/6] hid: add framebuffer support to PicoLCD device
Date: Sat, 20 Mar 2010 20:25:22 -0700
Message-ID: <20100321032522.GD29360@core.coreip.homeip.net>
References: <20100320170014.440959a8@neptune.home>
 <20100320170415.6ee219c8@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44276 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab0CUDZ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 23:25:28 -0400
Content-Disposition: inline
In-Reply-To: <20100320170415.6ee219c8@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sat, Mar 20, 2010 at 05:04:15PM +0100, Bruno Pr=E9mont wrote:
> +static inline int picolcd_fb_send_tile(struct hid_device *hdev, int =
chip,
> +		int tile)
> +{

You seemt o be fond of the 'inline; attribute ;) I don't think that a
40 lines function qualifies. Please lose inlines on functions that are
not in .h files and are not stubs.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
