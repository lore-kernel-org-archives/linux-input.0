From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] input: driver for USB VoIP phones with CM109 chipset
Date: Mon, 3 Mar 2008 23:13:23 +0100
Message-ID: <20080303221323.GK13869@elf.ucw.cz>
References: <47AB5012.20509@db.org> <20080209191206.GD5139@ucw.cz> <47CC7686.5030600@db.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56877 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYCCWM6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Mar 2008 17:12:58 -0500
Content-Disposition: inline
In-Reply-To: <47CC7686.5030600@db.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2008-03-03 23:07:02, Alfred E. Heggestad wrote:
> Pavel Machek wrote:
>> Hi!
>>
>>> + Komunikate KIP1000 Keyboard Matrix
>>> +
>>> +     -> -- 1 -- 2 -- 3  --> GPI pin 4 (0x10)
>>> +      |    |    |    |
>>> +     <- -- 4 -- 5 -- 6  --> GPI pin 5 (0x20)
>>> +      |    |    |    |
>>> +     END - 7 -- 8 -- 9  --> GPI pin 6 (0x40)
>>> +      |    |    |    |
>>> +     OK -- * -- 0 -- #  --> GPI pin 7 (0x80)
>>> +      |    |    |    |
>>> +
>>> +     /|\  /|\  /|\  /|\
>>> +      |    |    |    |
>>> +GPO
>>> +pin:  3    2    1    0
>>> +     0x8  0x4  0x2  0x1
>>> +
>>> + */
>>> +static int keymap_kip1000(int scancode)
>>> +{
>>> +	switch (scancode) {			 /* phone key:   */
>>> +	case 0x82: return KEY_0;		 /*   0   */
>>> +	case 0x14: return KEY_1;		 /*   1   */
>>> +	case 0x12: return KEY_2;		 /*   2   */
>>> +	case 0x11: return KEY_3;		 /*   3   */
>>> +	case 0x24: return KEY_4;		 /*   4   */
>>> +	case 0x22: return KEY_5;		 /*   5   */
>>> +	case 0x21: return KEY_6;		 /*   6   */
>>> +	case 0x44: return KEY_7;		 /*   7   */
>>> +	case 0x42: return KEY_8;		 /*   8   */
>>> +	case 0x41: return KEY_9;		 /*   9   */
>>> +	case 0x81: return KEY_LEFTSHIFT | KEY_3 << 8; /*  #          */
>>
>> That's a very dirty hack, right?
>>
>
> yeah, that is a dirty hack which we should avoid by defining
> a new key called e.g. KEY_KPPOUND for the '#'-key.

Yes please. Phones are pretty common these days.

> the CM109 driver is based on the Yealink driver
> (drivers/input/misc/yealink.c) so the same hack exists there..

Fix it too ;-).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
