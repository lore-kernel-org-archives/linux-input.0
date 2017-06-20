From: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>
Subject: Re: [PATCH v2] Input: goodix: Add support for capacitive home button found on some x86 tablets
Date: Tue, 20 Jun 2017 22:25:44 +1000
Message-ID: <1497989032.bHbb80yipc@z12>
References: <1749277.ynzOHhpSB9@z12> <1497959259.2559.18.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from forward12p.cmail.yandex.net ([87.250.241.138]:45986 "EHLO
        forward12p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751022AbdFTMa1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 08:30:27 -0400
In-Reply-To: <1497959259.2559.18.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, russianneuromancer@ya.ru, linux-input@vger.kernel.org

On Tuesday, 20 June 2017 21:47:39 +10 Bastien Nocera wrote:
> On Tue, 2017-06-20 at 21:08 +1000, Sergei A. Trusov wrote:
> > On some x86 tablets with a goodix touchscreen the windows logo on the
> 
> "Goodix" and "Windows", comma after "touchscreen".
> 
> > front is a capacitive home button. Touching this button results in a
> > touch
> > with bit 4 of the first byte set, while normally only the lower 4
> > bits
> 
> Add "(0-3)" after "bits".
> 
> > are used to indicate the number of touches.
> > 
> > Detect this and report a KEY_LEFTMETA press when this happens. Note 
> 
> You can remove the "Detect this and".
> 
> > the
> > hardware might support more than one button, the number of a button
> > is
> > reported by the 'id' byte of coor_data.
> 
> "Note that the hardware might support more than one button, in which
> case the "id" byte of coor_data would identify the button in question.
> This is not implemented as we don't have access to hardware with
> multiple buttons."
> 
> >  Now we ignore button id.
> 
> Remove that last sentence.
> 
> > 
> > Signed-off-by: Sergei A. Trusov <sergei.a.trusov@ya.ru>
> 
> Looks good from me. Sergei, Dmitry, let me know if you want me to re-
> send the patch with a fixed up commit message.

Thanks for all these corrections and patience (with a newbe like me). I think
it would be better if you re-send the correct patch. I just do not know what
should I do with this now.

> 
> Acked-by: Bastien Nocera <hadess@hadess.net>
> 
> Cheers
> 


