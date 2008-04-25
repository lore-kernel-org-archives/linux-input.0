From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] Input/Joystick Driver: add support AD7142 joystick driver (v2)
Date: Fri, 25 Apr 2008 18:09:52 +0800
Message-ID: <386072610804250309j5f2222cfj2f58b3b92d091a3a@mail.gmail.com>
References: <1206643110-8789-1-git-send-email-cooloney@kernel.org>
	 <20080418131149.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:61116 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759683AbYDYKKJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 06:10:09 -0400
Received: by yw-out-2324.google.com with SMTP id 5so488075ywh.1
        for <linux-input@vger.kernel.org>; Fri, 25 Apr 2008 03:09:52 -0700 (PDT)
In-Reply-To: <20080418131149.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: khali@linux-fr.org, andre@bitwigglers.org, linux-input@vger.kernel.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org, vapier.adi@gmail.com, Michael Hennerich <michael.hennerich@analog.com>

On Sat, Apr 19, 2008 at 1:15 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Bryan,
>
>
>  On Thu, Mar 27, 2008 at 11:38:30AM -0700, Bryan Wu wrote:
>  > +     input->keybit[BIT_WORD(BTN_BASE)] = BIT_MASK(BTN_BASE) |
>  > +                                             BIT_MASK(BTN_BASE2) |
>  > +                                             BIT_MASK(BTN_BASE3) |
>  > +                                             BIT_MASK(BTN_BASE4);
>  > +     input->keybit[BIT_WORD(KEY_UP)] |=  BIT_MASK(KEY_UP) |
>  > +                                             BIT_MASK(KEY_DOWN) |
>  > +                                             BIT_MASK(KEY_LEFT) |
>  > +                                             BIT_MASK(KEY_RIGHT);
>  > +
>
>  Why don't you use REL_X/REL_Y to report directional movement? Using
>  buttons for that is pretty unusual.
>

In our development board, it includes UP/DOWN/LEFT/RIGHT 4 buttons. So
this driver matches this.
Please found some information about the hardware as below:
http://docs.blackfin.uclinux.org/doku.php?id=capacitance_touch_sensors&s[]=ad7142

Thanks
-Bryan
