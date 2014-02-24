From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: Questions about the documentation/specification of Linux
 ForceFeedback input.h
Date: Mon, 24 Feb 2014 22:50:24 +0100
Message-ID: <CADbOyBTckzuJzV=LquzNYq9E=f0qTzkhf2UcJUyMJPK103W_ag@mail.gmail.com>
References: <CADbOyBSeNKe6hZWdLMnE+SPyu__NwD4WKHv_cAmOz-NTKuzxSA@mail.gmail.com>
	<52FECB6E.4000004@iki.fi>
	<CADbOyBQ1iA_7c4Rik7nBPvqAwVouoQDL33L3PE2RiVLnmFz1YQ@mail.gmail.com>
	<52FF73D7.6030108@iki.fi>
	<CADbOyBROrPtqptnnh+Xtb9+X7EhGMudaHRai2wQLga5vca=rxg@mail.gmail.com>
	<52FFF276.1060704@iki.fi>
	<CADbOyBSYeCLLa=WE72dwNpsexq7gDsL4iJiOfrpKgLOp3+A7tA@mail.gmail.com>
	<CADbOyBQhHExwBgfuhcYZscZoi4o-cTqs6TOqDj6Z4Uzpm6TgWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:46140 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbaBXVuZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Feb 2014 16:50:25 -0500
Received: by mail-vc0-f171.google.com with SMTP id le5so6390107vcb.16
        for <linux-input@vger.kernel.org>; Mon, 24 Feb 2014 13:50:24 -0800 (PST)
In-Reply-To: <CADbOyBQhHExwBgfuhcYZscZoi4o-cTqs6TOqDj6Z4Uzpm6TgWA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru, Johann Deneux <johann.deneux@gmail.com>, linux-input@vger.kernel.org

On Wed, Feb 19, 2014 at 7:54 PM, Elias Vanderstuyft <elias.vds@gmail.com> wrote:
> Today, I noticed something strange: an explicit saturation of zero in
> DInput (or at least using the most recent driver for my Logitech MOMO
> wheel), appears to be transformed to max saturation! (This is why I
> chose to quote your "sat_right = 0x0000" part, however that's not the
> point I want to make in this mail)
>
> E.g:
>     pos_sat = 10000    ->    Max saturation send to device
>     pos_sat =  5000    ->    Half saturation send to device
>     ...
>     pos_sat =     1    ->    Zero saturation send to device (because
> it appears to be rounded to zero)
>     pos_sat =     0    ->    Max saturation send to device (?!)
>
> Also interesting is that the FEdit tool (from MS DirectX SDK) sets all
> 'saturation' values to zero by default. This is not the case for the
> 'coefficient' values: they are set to maximum. The resulting default
> conditional force generates a maxed out conditional effect on my MOMO
> wheel.
> The weird thing is, that MSDN does not explicitly say anything about
> this: http://msdn.microsoft.com/en-us/library/windows/desktop/microsoft.directx_sdk.reference.dicondition%28v=vs.85%29.aspx
> "dwPositiveSaturation:
>     Maximum force output on the positive side of the offset, in the
> range from 0 through 10,000.
>     If the device does not support force saturation, the value of this
> member is ignored.
> "
>
> So, my question is:
>     - Should Wine's translation layer convert a 0 dinput saturation to
> max linux saturation?
>     - or Should the Linux FF drivers send a max saturation command
> when the linux saturation equals zero?
>     - or Should we forget about this? (but that will result Wine's
> behaviour to be different from Windows', at least for my MOMO wheel (I
> don't have another capable (non-Logitech?) wheel to test it with))
>

On Thu, Feb 20, 2014 at 9:52 AM, Elias Vanderstuyft <elias.vds@gmail.com> wrote:
> Another question:
> There is written on /include/uapi/linux/input.h:1058 :
>     "@phase: 'horizontal' shift"
> where 'horizontal' most likely means time dimension, not phase of the
> waveform, right?
>

Hi Anssi,

Any thoughts about my previous 2 mails' questions?
(I just need be sure of these things to finish my Wine FF patchset,
however, if you don't have time, no problem, it can wait for some time)

Best regards,
Elias
