From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - switch t460s 20FN to use RMI4 over
 SMBus
Date: Tue, 27 Jun 2017 09:53:05 +0200
Message-ID: <20170627075305.GZ26073@mail.corp.redhat.com>
References: <CAE4xfVLxhF29jLoFWwa4o6_0G_5VMQ8YN1BVP4=8+Y3u_BERPw@mail.gmail.com>
 <20170626082626.797-1-benjamin.tissoires@redhat.com>
 <CAE4xfV+Z8Yq=5rGP7H5CcWYfJrNLDPVjgqFOb_ebk0QOYat7Hw@mail.gmail.com>
 <CAE4xfV+ygZ5Z9VsFdzmkQQgZZyH79zM4Jr2PHS2s0b9NYG7fqQ@mail.gmail.com>
 <20170626153856.GV26073@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdF0HxN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Jun 2017 03:53:13 -0400
Content-Disposition: inline
In-Reply-To: <20170626153856.GV26073@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Bachner <b.christopher.92@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 26 2017 or thereabouts, Benjamin Tissoires wrote:
> On Jun 26 2017 or thereabouts, Christopher Bachner wrote:
> > Hello,
> > 
> > I am assuming that if the inertouch message is not showing up in dmesg,
> > then it is working. Is that a correct assumption?
> > 
> > Either way I also attached my dmesg.
> > 
> > I am not sure, though, why the scroll mode still freezes if I move the my
> > fingers quickly on the touchpad while also using the trackpoint. Is that
> > maybe a future fix and this change is just the foundation for it? Overall
> > the usage of the trackpoint is better now for sure.
> 
> Sadly, you are also hit by:
> [    6.355378] i801_smbus 0000:00:1f.4: BIOS is accessing SMBus registers
> [    6.355380] i801_smbus 0000:00:1f.4: Driver SMBus register access inhibited
> 
> Which disables entirely the RMI4 over SMBus module. And then we can not
> probe for it, meaning you are stuck with the PS/2 crappy mode.
> 
> We are aware of this bug and we'll try to fix that. I think the test you
> provides are valid (the patch works as expected), but a different bug
> prevents rmi-smbus to fully initialize the touchpad :(

Could you try applying Lyude's patch: http://patchwork.ozlabs.org/patch/780865/
(on top of mine, of course).

In the dmesg, you should see a Synaptics TMXXXX device appearing after
trying to set up the SMBus companion.

Cheers,
Benjamin

