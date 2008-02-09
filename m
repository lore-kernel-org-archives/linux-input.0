From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] input: driver for USB VoIP phones with CM109 chipset
Date: Sat, 9 Feb 2008 19:12:07 +0000
Message-ID: <20080209191206.GD5139@ucw.cz>
References: <47AB5012.20509@db.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1692 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754797AbYBITPC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Feb 2008 14:15:02 -0500
Content-Disposition: inline
In-Reply-To: <47AB5012.20509@db.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> + Komunikate KIP1000 Keyboard Matrix
> +
> +     -> -- 1 -- 2 -- 3  --> GPI pin 4 (0x10)
> +      |    |    |    |
> +     <- -- 4 -- 5 -- 6  --> GPI pin 5 (0x20)
> +      |    |    |    |
> +     END - 7 -- 8 -- 9  --> GPI pin 6 (0x40)
> +      |    |    |    |
> +     OK -- * -- 0 -- #  --> GPI pin 7 (0x80)
> +      |    |    |    |
> +
> +     /|\  /|\  /|\  /|\
> +      |    |    |    |
> +GPO
> +pin:  3    2    1    0
> +     0x8  0x4  0x2  0x1
> +
> + */
> +static int keymap_kip1000(int scancode)
> +{
> +	switch (scancode) {			 /* phone 
> key:   */
> +	case 0x82: return KEY_0;		 /*   0   
> */
> +	case 0x14: return KEY_1;		 /*   1   
> */
> +	case 0x12: return KEY_2;		 /*   2   
> */
> +	case 0x11: return KEY_3;		 /*   3   
> */
> +	case 0x24: return KEY_4;		 /*   4   
> */
> +	case 0x22: return KEY_5;		 /*   5   
> */
> +	case 0x21: return KEY_6;		 /*   6   
> */
> +	case 0x44: return KEY_7;		 /*   7   
> */
> +	case 0x42: return KEY_8;		 /*   8   
> */
> +	case 0x41: return KEY_9;		 /*   9   
> */
> +	case 0x81: return KEY_LEFTSHIFT | KEY_3 << 8; /*  
> #          */

That's a very dirty hack, right?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
