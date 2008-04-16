From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: xpad - Rename buttons to avoid conflict with mouse input
Date: Wed, 16 Apr 2008 21:56:12 +0300
Message-ID: <48064BCC.5020203@gmail.com>
References: <74d457500804150313n3487e672r35261b9dd75b0303@mail.gmail.com> <48062E1D.40805@gmail.com> <20080416143149.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:39536 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308AbYDPS4X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 14:56:23 -0400
In-Reply-To: <20080416143149.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Gruber <lists.mg@googlemail.com>, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wed, Apr 16, 2008 at 07:49:33PM +0300, Anssi Hannula wrote:
>> Michael Gruber wrote:
>>> From: Michael Gruber <lists.mg@googlemail.com>
>>>
>>> BTN_LEFT, BTN_RIGHT and BTN_BACK are listed as mouse buttons according to
>>> input.h. Rename them to make sure they do not interfere with mouse input.
>>>
>>> Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
>>>
>>> ---
>>>
>>> When I set up the driver to use MAP_DPAD_TO_BUTTONS the controller starts
>>> acting as mouse. Touching the d-pad issues left and right mouse click events
>>> and the back button acts like one of my other mouse buttons.
>> Patch seems correct to me.
>>
>> Acked-by: Anssi Hannula <anssi.hannula@gmail.com>
>>
> 
> The original author of d-pad mode did that so the pad withh work
> with stepmania. If left/right/0/1 are the defaults used there
> we might break existing setups...

With a quick test there seem to be no default mappings for game
controllers, but they are manually defined.

IMO having to redefine keys after a major kernel upgrade is ok, and
certainly a lesser trouble than having dancepad directionals act as
mouse buttons.

> Do you know of other applications
> using dance pads?

Nope.

-- 
Anssi Hannula
