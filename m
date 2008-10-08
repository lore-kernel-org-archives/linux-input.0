From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ThinkPad input device IDs
Date: Wed, 8 Oct 2008 19:56:46 -0400
Message-ID: <200810081956.46738.dmitry.torokhov@gmail.com>
References: <41840b750810072144g6e6becfby1c960eb24249869c@mail.gmail.com> <20081008134402.GA15645@khazad-dum.debian.net> <41840b750810081112p1c2e4071xd34f095091faa060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:34295 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYJHX4v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2008 19:56:51 -0400
Received: by yw-out-2324.google.com with SMTP id 9so701510ywe.1
        for <linux-input@vger.kernel.org>; Wed, 08 Oct 2008 16:56:49 -0700 (PDT)
In-Reply-To: <41840b750810081112p1c2e4071xd34f095091faa060@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shem Multinymous <multinymous@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-input@vger.kernel.org

On Wednesday 08 October 2008, Shem Multinymous wrote:
> On Wed, Oct 8, 2008 at 9:44 AM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
> > I guess it used "isa1600" because it talks to the EC over LPC3B port IO, and
> > the ports are in the 1600-161F range, over the LPC bus.
> 
> I see... But this is an ad-hoc port assignment by IBM and other
> machines may map different devices to port 1600h. Is it presently
> possible to write a udev rule that will match the (mainline) hdaps
> input device but not random junk at port 1600 on other machines?
>

'Phys' is supposed to be stable identifier within a box, not unique
ID across all boxes in existence, we'd need UUID for that. I wonder
if udev rule could match based on the name of the parent device
("hdaps")?
 
> 
> >> The out-of-tree tp_smapi version of hdaps followed the thinkpad-acpi
> >> convention so it now conflicts with mainline hdaps. Which should I
> >> follow?
> >
> > I think it is better to use the BUS_HOST convention for this, since HDAPS
> > really is just one of the services on LPC3B even if LPC3B really *is*
> > BUS_ISA, ports 1600-161F.  Dmitry would know better, though.  Dmitry?
> 
> For what it's worth, I should note that tp_smapi's hdaps input IDs
> were introduced in July 2007 [1] and are by now in widespread use by
> udev rules since they're needed for the reduced-interrupts mode of
> hdaps+hdapsd [2].
>

I modeled hdaps after i8042 which claims to be BUS_ISA with phys
"isa0060/serioX" after its data register (0x60). I don't particularly
care if you want to switch it to something else... Did we already have a
full release with hdaps marked as BUS_ISA? If so we may just have to use
2 rules, to cover both versions of hdaps.
  
-- 
Dmitry
