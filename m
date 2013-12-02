From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input:Add support for DualPoint device on Dell XT2
 model
Date: Sun, 1 Dec 2013 22:39:07 -0800
Message-ID: <20131202063907.GC21404@core.coreip.homeip.net>
References: <1384524702-3411-1-git-send-email-yunkang.tang@cn.alps.com>
 <20131127001822.GB15452@core.coreip.homeip.net>
 <CA+F6ckOPi2tmQxLtsWkcyvEb3ZnP2BK50Jj-9iZrXpBm11M56A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:58785 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3LBGjK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 01:39:10 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so17495368pdj.3
        for <linux-input@vger.kernel.org>; Sun, 01 Dec 2013 22:39:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+F6ckOPi2tmQxLtsWkcyvEb3ZnP2BK50Jj-9iZrXpBm11M56A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, david turvene <dturvene@dahetral.com>, linux-input@vger.kernel.org, Niels de Vos <ndevos@redhat.com>, Justin Clift <jclift@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>

On Wed, Nov 27, 2013 at 04:19:05PM +0800, Tommy Will wrote:
> Hi Dmitry,
> 
> Thanks for your reply.
> 
> >
> > It would help greatly if you could document what parameters the new
> > initialization routine sets.
> >
> Ok, please let me explain what I did in initialization.
> 
> >+static int alps_hw_init_v6(struct psmouse *psmouse)
> >+{
> >+     unsigned char param[2] = {0xC8, 0x14};
> >+
> >+     /* Enter passthrough mode to let trackpoint enter 6byte raw mode */
> >+     if (alps_passthrough_mode_v2(psmouse, true))
> >+             return -1;
> 
> In order to initialize the trackpoint, we must first send command to
> enter passthrough mode so that the following
> command can directly be sent to trackpoint device.
> 
> +
> >+     if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
> >+         ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
> >+         ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11) ||
> >+         ps2_command(&psmouse->ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
> >+         ps2_command(&psmouse->ps2dev, &param[1], PSMOUSE_CMD_SETRATE))
> >+             return -1;
> >+
> 
> Here are the commands to let trackpoint device enter 6byte raw mode.
> Because of the special MPU being
> used in this device, trackpoint's packet would always be encapsulated
> to the same packet size as Touchpad's.
> So, when touchpad is in 6byte mode, we should also let trackpoint in
> 6byte mode or trackpoint's output data would be messed.
> That's what spec requested.
> 
> +     if (alps_passthrough_mode_v2(psmouse, false))
> +             return -1;
> +
> 
> Stop talking with trackpoint.
> 
> +     if (alps_absolute_mode_v6(psmouse)) {
> +             psmouse_err(psmouse, "Failed to enable absolute mode\n");
> +             return -1;
> +     }
> +
> 
> Let touchpad enter 6byte raw mode.
> 
> +     return 0;
> +}
> 
> And in alps_absolute_mode_v6() function. Please notice that there are
> two kinds of
> 6byte mode for this device. Let's temporary define them as RawModeA & RawModeB.
> Method to enter RawModeA:   Send ALPS magic knock commad [F5 F5 F5
> F5]. (Same as protocol v2)
> Method to enter RawModeB:   Write 0x181 to 0x000 register. (New)
> 
> I checked spec and found RawModeB was suggested and now being used in
> Windows driver.
> Maybe the reason is it could provide a more accurate data output.
> In RawModeA, data output range is X:[0-1023], Y:[0-767], but
> in RawModeB, its range is X:[0-2047], Y:[0-1535].
> 
> #Probably have any other reason that I did not know, so, I chose a
> safety way that was suggested
> by the spec although it needs adding much more source code.
> 
> 
> > +static int alps_absolute_mode_v6(struct psmouse *psmouse)
> > +{
> > +     u16 reg_val = 0x181;
> > +     int ret = -1;
> > +
> 
> What we want to do is write 0x181 to 0x000 register. That would let
> device enter RawModeB.
> 
> > +     /* enter monitor mode, to write the register */
> > +     if (alps_monitor_mode(psmouse, true))
> > +             return -1;
> > +
> > +     ret = alps_monitor_mode_write_reg(psmouse, 0x000, reg_val);
> > +
> > +     if (alps_monitor_mode(psmouse, false))
> > +             ret = -1;
> > +
> > +     return ret;
> > +}
> 
> 
> >>    3. Add new packet process logic.
> >
> > I am curious why we need the new packet processing logic. Apparently the
> > touchpad can work in the original mode that we already know how to
> > parse; we just need to make sure the trackpoint is initialized properly.
> > Or yet another protocol flavor is a must?
> >
> Yes, you're right, as long as initialized trackpoint to 6byte raw mode
> and add decode logic into
> alps_process_packet_v1_v2(), both touchpad and trackpoint can work correctly.
> 
> However, as I wrote in previous, spec suggested me to use another
> protocol to co-work with
> trackpoint's 6byte mode. So, I just did follow the spec.
> 
> BTW, could you please let me know if you have any concern of adding a
> new protocol?
> In my opinion, assume that there would be no side-effect by using
> original touchpad
> protocol + new 6byte trackpoint protocol, although I could reuse the
> alps_process_packet_v1_v2(),
> I had to add a new flag to adjust the original logic to support
> trackpoint's 6byte decoding,
> which would also make source code harder to understand.

OK, fair enough. I will apply the patch, but I think the ALPS driver is
becoming a bit too unwieldy. It looks like we should split it into
alps-st (that woudl handle older single-touch models) and alps-mt (for
the newer multi-touch ones) and maybe a support library for the common
code.

Thanks.

-- 
Dmitry
