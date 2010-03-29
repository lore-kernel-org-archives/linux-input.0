From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 6/6] hid: add experimental access to PicoLCD device's
 EEPROM and FLASH
Date: Mon, 29 Mar 2010 11:44:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1003291142400.24576@pobox.suse.cz>
References: <20100324233707.7243b04d@neptune.home> <20100324235835.0e7e1bcb@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100324235835.0e7e1bcb@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, 24 Mar 2010, Bruno Pr=C3=A9mont wrote:

> +static ssize_t picolcd_debug_reset_open(struct inode *inode, struct =
file *f)
> +{
> +	return single_open(f, picolcd_debug_reset_show, inode->i_private);
> +}
> +

struct file_operations->open is supposed to return int (filedescriptor)=
,=20
not ssize_t.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
