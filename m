From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/6] hid: new driver for PicoLCD device
Date: Thu, 25 Mar 2010 23:56:57 -0700
Message-ID: <20100326065656.GC26602@core.coreip.homeip.net>
References: <20100324233707.7243b04d@neptune.home>
 <20100324234022.0361bd80@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100324234022.0361bd80@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 24, 2010 at 11:40:22PM +0100, Bruno Pr=E9mont wrote:
> +	for (i =3D 0; i < PICOLCD_KEYS; i++) {
> +		int key =3D ((int *)idev->keycode)[i];

Keycodes are now short, not int. Also, just do:

		input_set_capability(idev, EV_KEY, data->keycode[i]);

> +		if (key < KEY_MAX && key >=3D 0)
> +			input_set_capability(idev, EV_KEY, key);
--=20
Dmitry
