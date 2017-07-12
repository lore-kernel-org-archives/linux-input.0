From: Paul Donohue <linux-kernel@PaulSD.com>
Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS -
 fix V8+ protocol handling (73 03 28)")
Date: Wed, 12 Jul 2017 12:28:41 -0400
Message-ID: <20170712162841.GI1855@TopQuark.net>
References: <e841f28c-4d63-170a-482f-8ef1deda1900@redhat.com>
 <KAWPR01MB1092C3572946C54C2CC4DEFBC7CD0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <75b84b97-5f36-a3be-bb4e-e43cd72d9921@redhat.com>
 <KAWPR01MB1092CFFDF4C4490669DCE92CC7C00@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170619184315.GF1855@TopQuark.net>
 <0995261b-8d19-64af-9b66-e1eab579a3d4@redhat.com>
 <20170619232026.GG1855@TopQuark.net>
 <s5hwp7f3rdc.wl-tiwai@suse.de>
 <20170711195821.GG1855@TopQuark.net>
 <s5hlgnuf7l0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from Lepton.TopQuark.net ([168.235.66.66]:55042 "EHLO
        Mail2.TopQuark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbdGLQ2n (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 12:28:43 -0400
Content-Disposition: inline
In-Reply-To: <s5hlgnuf7l0.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Laura Abbott <labbott@redhat.com>, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "scott.s.lowe@gmail.com" <scott.s.lowe@gmail.com>

On Wed, Jul 12, 2017 at 09:16:43AM +0200, Takashi Iwai wrote:
> On Tue, 11 Jul 2017 21:58:21 +0200,
> Paul Donohue wrote:
> > 
> > On Tue, Jul 11, 2017 at 05:50:07PM +0200, Takashi Iwai wrote:
> > > Hi, just joining to the party in the middle, as I'm also facing the
> > > same problem on Dell E7270 laptop.  Has this issue already been
> > > addressed?
> > > 
> > > If not, the following was my result:
> > > 
> > > - the first patch slowed the pointer movement a lot, it's even slower
> > >   than the old kernel (e.g. 4.4.x).
> > >   The two finger scroll works fine on all touchpad area now.
> > > 
> > > - the second patch made the pointer movement even faster than now (as
> > >   I feel, not quite sure).  The two finger scroll doesn't work at the
> > >   right side of the touchpad.
> > > 
> > > 
> > > The kernel output from the first patch is below:
> > >   psmouse serio1: alps: test1 pitch 37x37 num-electrodes 8x7 physical size 25x22mm res 69x69 max 1792x1536
> > > 
> > > Let me know if you have any further test.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > 
> > Do you have the kernel output from the second patch?
> 
> Here it is:
> 
> psmouse serio1: alps: test2 pitch 50x54 num-electrodes 20x11 physical size 95x54mm res 25x23 max 2432x1280

Thanks!

Wow, this is weird ... Values that cause scrolling issues for you work fine for me.

It looks like the priv->x_max value that is causing your problem, but perhaps you can confirm this with another test:
Revert the patches above, then just before the 'return' at the end of alps_update_device_area_ss4_v2() add the following line:
priv->x_max = 1792;
I suspect this line will make two-finger scrolling work again.

It might also help if you could experiment with other x_max values.  2432 is the correct value that causes problems for you..  Does a small value like 500 or a large value like 5000 change the behavior?

Another test you can try is to add a print statement in the 'case SS4_PACKET_ID_TWO' section of alps_decode_ss4_v2() and print out the f->mt[0].x and f->mt[1].x values.  With x_max set to 2432, what range of x values does this print when scrolling works, and what range of values are printed when scrolling doesn't work?

Thanks,
-Paul
