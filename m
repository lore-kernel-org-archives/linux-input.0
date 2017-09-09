From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS touchpad ot correctly recognized: GlidePoint vs DualPoint
Date: Sat, 9 Sep 2017 11:12:18 -0700
Message-ID: <20170909181218.GA29107@dtor-ws>
References: <ada750eb-daeb-c9ae-2452-fcf027a4e704@posteo.net>
 <201709080848.53286@pali>
 <52f87b68-8a6b-1d9c-f341-1e488ff43441@posteo.net>
 <201709091036.06899@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34966 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdIISMV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 9 Sep 2017 14:12:21 -0400
Received: by mail-pg0-f54.google.com with SMTP id 188so9382997pgb.2
        for <linux-input@vger.kernel.org>; Sat, 09 Sep 2017 11:12:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201709091036.06899@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Juanito <juam+kernel@posteo.net>, "masaki.ota@jp.alps.com" <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, Paul Donohue <linux-kernel@paulsd.com>

On Sat, Sep 09, 2017 at 10:36:06AM +0200, Pali Rohár wrote:
> On Saturday 09 September 2017 10:12:42 Juanito wrote:
> > Hello,
> > 
> > On 09/08/2017 08:48 AM, Pali Rohár wrote:
> > > On Friday 08 September 2017 07:00:34 Juanito wrote:
> > >>> ThinkPad with ALPS? Should not be it Synaptic? Maybe
> > >>> miss-detection?
> > >> 
> > >> Sorry, I forgot to mention this. The ThinkPad came with a clickpad
> > >> I **really** disliked, so I bought this on the Internet.
> > > 
> > > So, here is a problem. ThinkPads works with Synaptic touchpads, not
> > > with ALPS.
> > 
> > There definitely seems to be a problem here :)
> > 
> > Do you mean that the alps code might not be detecting the trackpoint
> > because probably the red thingie works with synaptics?
> > 
> > So could this be the situation:
> > ALPS driver: Hey touchpad! Do you have a trackstick?
> > ALPS touchpad: No, I don't.
> > AD: Ok! (and thinks 'I am going to have to ignore all trackstick
> > packets that might arrive')
> > 
> > So the driver understands that there can't possibly be any buttons
> > because there is no trackstick?
> 
> IIRC ALPS touchpad hardware itself does not work with non-ALPS 
> trackpoint.
> 
> Masaki, any comments?
> 
> > >> If by trackstick you mean the red thingie, it is **not** working.
> > > 
> > > Ok. And it is working with your patch?
> > 
> > No, it isn't :(
> 
> I expected... You just created franken-hardware.
> 
> Looks like with your hack patch it is possible to make buttons working, 
> but I suspect that trackstick would.
> 
> Maybe Masaki can provide more information about this fact if we can do 
> anything.
> 
> Dmitry, what you as maintainer going to do with this problem?

It really depends on Ota-san response. If ALPS needs a special version
of firmware flashed for proper trackstick identification, then I guess
Juanito will have to carry a local patch. I do not think we want to
complicate the driver any further for supporting such after-market
modification.

Does booting with psmouse.proto=imps makes trackstick work?

Thanks.

-- 
Dmitry
