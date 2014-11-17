From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: LEN2006 Synaptics touchpad min max fix
Date: Sun, 16 Nov 2014 18:26:03 -0800
Message-ID: <20141117022603.GB4930@dtor-ws>
References: <CAK4AR+_pycN0MCqcjM_svpd5UjMWacXVr5QTWJeU-Ean4sD-Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62977 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaKQC0J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Nov 2014 21:26:09 -0500
Received: by mail-ie0-f175.google.com with SMTP id at20so5524175iec.6
        for <linux-input@vger.kernel.org>; Sun, 16 Nov 2014 18:26:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAK4AR+_pycN0MCqcjM_svpd5UjMWacXVr5QTWJeU-Ean4sD-Kg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Sagal <bensagal@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, Nov 15, 2014 at 11:09:22PM +0200, Ben Sagal wrote:
> RE bug: https://bugzilla.kernel.org/show_bug.cgi?id=88211
> 
> The LEN2006 Synaptics touchpad (as found in my thinkpad E540) returns
> wrong min max values.
> 
> touchpad-edge-detector output:
> >  Touchpad SynPS/2 Synaptics TouchPad on /dev/input/event6
> >  Move one finger around the touchpad to detect the actual edges
> >  Kernel says:    x [1472..5674], y [1408..4684]
> >  Touchpad sends: x [1264..5675], y [1171..4688]
> 
> the patch is against 3.17.2
> 
> Signed-off-by: Binyamin Sagal <bensagal@gmail.com>

Applied, thank you.

> ---
> 
> diff -uNr linux.org/drivers/input/mouse/synaptics.c
> linux/drivers/input/mouse/synaptics.c
> --- linux.org/drivers/input/mouse/synaptics.c 2014-11-14
> 12:18:39.000000000 +0200
> +++ linux/drivers/input/mouse/synaptics.c 2014-11-14 08:25:05.963395004 +0200
> @@ -143,6 +143,10 @@
>   (const char * const []){"LEN2001", NULL},
>   1024, 5022, 2508, 4832
>   },
> + {
> + (const char * const []){"LEN2006", NULL},
> + 1264, 5675, 1171, 4688
> + },
>   { }
>  };

-- 
Dmitry
