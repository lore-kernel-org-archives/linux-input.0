From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 6/6] hid: add experimental access to PicoLCD device's
 EEPROM and FLASH
Date: Sat, 20 Mar 2010 20:08:02 -0700
Message-ID: <20100321030802.GB29360@core.coreip.homeip.net>
References: <20100320170014.440959a8@neptune.home>
 <20100320171119.193c5615@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100320171119.193c5615@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sat, Mar 20, 2010 at 05:11:19PM +0100, Bruno Pr=E9mont wrote:
> The PicoLCD device has a small amount of EEPROM and also provides
> access to its FLASH where firmware and splash image are saved.
> In flasher mode FLASH access is the only active feature.
>=20
> Give read/write access to both via debugfs files.
>=20

It looks you are allowing multiple users access to these files. What
will happen if 2 processes try to write EEPROM at the same time?

> +
> +static inline int picolcd_init_devfs(struct picolcd_data *data,
> +		struct hid_report *eeprom_r, struct hid_report *eeprom_w,
> +		struct hid_report *flash_r, struct hid_report *flash_w,
> +		struct hid_report *reset)
> +{

I don't think this should be forced inline.

Thanks.

--=20
Dmitry
