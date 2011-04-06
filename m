From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lenovo X220 Touchpad + Trackpoint BIOS issue workaround ?
Date: Wed, 6 Apr 2011 10:12:41 -0700
Message-ID: <20110406171241.GB5025@core.coreip.homeip.net>
References: <4D9B2CD0.20404@canonical.com>
 <4D9B522B.7080201@canonical.com>
 <20110405173940.GA13086@core.coreip.homeip.net>
 <4D9B5807.9090406@canonical.com>
 <20110405183001.GC13086@core.coreip.homeip.net>
 <4D9B9169.5090909@canonical.com>
 <4D9C9CE5.9070109@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:35812 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab1DFRMr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2011 13:12:47 -0400
Received: by pxi2 with SMTP id 2so915391pxi.10
        for <linux-input@vger.kernel.org>; Wed, 06 Apr 2011 10:12:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9C9CE5.9070109@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manoj <manoj.iyer@canonical.com>
Cc: linux-input@vger.kernel.org

Hi Manoj,

On Wed, Apr 06, 2011 at 12:03:33PM -0500, Manoj wrote:
> Dmitry,
> 
> Did you get a chance to look at this message? Can you pls nudge me
> in the right direction?
> 
> Manoj Iyer
> Ubuntu/Canonical
> Hardware Enablement
> 
> On 04/05/2011 05:02 PM, Manoj wrote:
> >Dmitry,
> >
> >I turned on i8042.debug and it produced a lot of noise, and I couldint
> >make out what it was trying to tell me. So I put some debug prints in
> >synaptic.c and psmouse-base.c. In the case where both touchpad and
> >trackpoint are enabled in the BIOS I get the following failure in
> >psmouse_probe(). I have attached the psmouse-base.c and synaptic.c for
> >you reference as to where the prints are coming from. Dont know why
> >psmouse_probe() PSMOUSE_CMD_GETID would fail on the pass-through device.
> >
> >[ 726.431405] DEBUG: psmouse_probe:931 probing for isa0060/serio1
> >[ 726.436949] DEBUG: psmouse_probe:937 got PSMOUSE_CMD_GETID 00
> >[ 727.349407] Synaptics Touchpad, model: 1, fw: 8.0, id: 0x1e2b1, caps:
> >0xd001a3/0x940300/0x120c00
> >[ 727.349415] Synaptics: Clickpad mode enabled
> >[ 727.349423] serio: Synaptics pass-through port at isa0060/serio1/input0
> >[ 727.349438] DEBUG: Synaptics: synaptics_init:828: psmouse->rate = 0x64
> >[ 727.349444] DEBUG: psmouse_switch_protocol:1266 selected_proto->type = 7
> >[ 727.407740] input: SynPS/2 Synaptics TouchPad as
> >/devices/platform/i8042/serio1/input/input9
> >[ 727.419607] DEBUG: psmouse_connect:1318 pass-though device detected
> >[ 727.425287] DEBUG: psmouse_deactivate:1028 deacivating isa0060/serio1
> >[ 727.425307] DEBUG: psmouse_probe:931 probing for synaptics-pt/serio0
> >[ 727.672729] DEBUG: psmouse_probe:934 failed to get PSMOUSE_CMD_GETID a5

Seeing the "noise" would be interesting here as it might give us an idea why
we are seeing a5 instead of the proper ID.

Also, adding psmouse_reset() before issuing GET_ID command is not the
best idea since the device connected might not be a mouse/keyboard at
all but some other device.

Thanks.

-- 
Dmitry
