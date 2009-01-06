From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Force feedback in Linux
Date: Tue, 6 Jan 2009 11:02:30 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901061102000.5377@jikos.suse.cz>
References: <bb829a0b0901020434q6ab51b86na945179c56f79e9@mail.gmail.com>  <alpine.LNX.1.10.0901051104390.5377@jikos.suse.cz> <bb829a0b0901051155k710b0ec8w42de31da0305f9e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:55186 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751552AbZAFKCb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jan 2009 05:02:31 -0500
In-Reply-To: <bb829a0b0901051155k710b0ec8w42de31da0305f9e7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?KOI8-R?B?88XSx8XKIOLFzNHbz9c=?= <sergey.belyashov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 5 Jan 2009, ?????? ??????? wrote:

>    My joystick Logitech Force 3D Pro (0x046d:0xc286) successfully
> detected by current kernel (I have 2.6.27). But force feedback cannot
> work properly (it works only with one axis). This joystick have 2 FF
> axises (X and Y), but kernel supports only one (fftest program moves
> only in X-axis): I cannot found any IOCTLs which can be used for
> switching axises for force feedback effects. Also, it is no any
> discussion about that.
>    I want to impliment neccessary functionality but kernel redesign is
> required, I think.

I don't think I fully understand, sorry. What's wrong with the 'direction' 
field of struct ff_effect?

-- 
Jiri Kosina
SUSE Labs
