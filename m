From: "Michael Gruber" <lists.mg@googlemail.com>
Subject: Re: [PATCH 1/2] xpad - Allow mapping D-pad to buttons for all pads
Date: Fri, 9 May 2008 02:20:28 +0200
Message-ID: <74d457500805081720i36fdc887ue34b7bc7fdef8d86@mail.gmail.com>
References: <20080505103400.284050@gmx.net>
	 <20080507111713.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:36854 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472AbYEIAVQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2008 20:21:16 -0400
Received: by yw-out-2324.google.com with SMTP id 9so586693ywe.1
        for <linux-input@vger.kernel.org>; Thu, 08 May 2008 17:21:00 -0700 (PDT)
In-Reply-To: <20080507111713.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, May 7, 2008 at 5:19 PM, Dmitry Torokhov wrote:
> Hi Michael,
>
> On Mon, May 05, 2008 at 12:34:00PM +0200, Michael Gruber wrote:
>> From: Michael Gruber <lists.mg@googlemail.com>
>>
>> If the new module option force_dpad_to_buttons is set, the directional pad will
>> be mapped to 4buttons instead of 2axes for all controllers. This includes those
>> in the list of known controllers which are not affected by the existing option
>> dpad_to_buttons.
>>
>
> The option was there to adapt mappings for the new controllers we
> don'ty know about yet. Coudl you explain why one would want to map
> axes to buttons on a controller that is known to be not a d-pad?
>
> Thanks!
>
> --
> Dmitry


For me being able to choose between 2axis or 4buttons is an additional feature.
Currently this feature is only offered if the controller is unknown which means
that if you have a known controller you end up with less features, which is
paradox.
Possible usage scenario: A user wants to play a first person shooter; he needs
2axes to look around and 2axes to move. Those 4axes are provided by the two
thumbsticks; the dpad and the trigger axes are useless for this player but he
might need a lot of buttons: fire, zoom, jump, duck, sprint, reload, switch
weapons, grenades, flashlight, and more; hence he would profit from having more
buttons; if the triggers acted as buttons then he could bind fire to the
trigger and if the directional pad acted as 4 buttons then he could for example
use them as shortcuts to his four favourite weapons.
A lot of Xbox360 games use the triggers and dpad axes for actions that can
usually only be bound to buttons in PC games. Thus a Xbox-user might be
expecting an easy way to get the same functionality with the linux driver.
