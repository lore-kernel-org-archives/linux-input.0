From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: Handling of large keycodes
Date: Fri, 6 Aug 2010 22:56:29 +0200
Message-ID: <20100806205629.GA24488@hardeman.nu>
References: <20100731091936.GA22253@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:44379 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935107Ab0HFVGv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Aug 2010 17:06:51 -0400
Content-Disposition: inline
In-Reply-To: <20100731091936.GA22253@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Input <linux-input@vger.kernel.org>, linux-media@vger.kernel.org, Jarod Wilson <jarod@redhat.com>, Maxim Levitsky <maximlevitsky@gmail.com>

On Sat, Jul 31, 2010 at 02:19:36AM -0700, Dmitry Torokhov wrote:
> +/**
> + * struct keymap_entry - used by EVIOCGKEYCODE/EVIOCSKEYCODE ioctls
> + * @scancode: scancode represented in machine-endian form.
> + * @len: length of the scancode that resides in @scancode buffer.
> + * @index: index in the keymap, may be used instead of scancode
> + * @by_index: boolean value indicating that kernel should perform
> + *	lookup in keymap by @index instead of @scancode
> + * @keycode: key code assigned to this scancode
> + *
> + * The structure is used to retrieve and modify keymap data. Users h=
ave

missing "the option" here?

> + * of performing lookup either by @scancode itself or by @index in
> + * keymap entry. EVIOCGKEYCODE will also return scancode or index
> + * (depending on which element was used to perform lookup).
> + */
> +struct keymap_entry {
> +	__u8  len;
> +	__u8  by_index;
> +	__u16 index;
> +	__u32 keycode;
> +	__u8  scancode[32];
>  };

Perhaps it would be a good idea to add a flags member to the struct,=20
either as an additional member or by replacing:
	__u8 by_index;
with:
	__u32 flags;

to help with any future extensions/changes/additions to the interface?


--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
