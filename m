From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: xbox 360 wireless controller xpad360 driver
Date: Mon, 09 Aug 2010 14:16:24 +0200
Message-ID: <1281356184.20805.36.camel@lovely.krouter>
References: <AANLkTikSyCnE1FO_M0D3ofw4a8PL136G6fxZTUjKvx6q@mail.gmail.com>
	 <alpine.LNX.2.00.1008091136090.29919@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab0HIMNC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Aug 2010 08:13:02 -0400
Received: by bwz3 with SMTP id 3so1146257bwz.19
        for <linux-input@vger.kernel.org>; Mon, 09 Aug 2010 05:13:01 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1008091136090.29919@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Kenneth Ray Smith II <alittleknowhow@gmail.com>, georg@op-co.de, Oliver.Schwartz@gmx.de, gentoox@shallax.com, franz@caos.at, blackhawk@ivanhawkes.com, niklas@jahej.com, pyry.haulos@gmail.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, anssi.hannula@iki.fi

On Mon, 2010-08-09 at 11:36 +0200, Jiri Kosina wrote:
> On Fri, 6 Aug 2010, Kenneth Ray Smith II wrote:
> 
> > https://bugs.launchpad.net/ubuntu/+bug/365435
> > 
> > http://art.ubuntuforums.org/showthread.php?p=7412807
> 
> Hi,
> 
> as this is related to xpad driver, I am adding some relevant CCs. For the 
> future, please always send some short summary of the problem ... just 
> sending URLs with no explanation whatsoever makes it likely to be lost in 
> other noise.

Hi,

as I can see from https://bugs.launchpad.net/ubuntu/+bug/365435 it's
subject is: "xbox 360 wireless controller acts like curser or mouse."

But xpad.c doesn't use any relative axes. What it used were mouse
buttons, but this was fixed with following commit:

commit 7beae7028acec3bb235fa079fd7e45cc289c0fd7
Author: Christoph Fritz <chf.fritz@googlemail.com>
Date:   Tue Jul 13 09:42:33 2010 -0700

    Input: xpad - remove mouse buttons and axes for dance pads
    
    Dance pads don't have any axes/sticks, only buttons for directions. For
    example buttons like left+right will get triggered at once, an axis
    can't handle this anyway.  So this patch adds a module parameter named
    "sticks_to_null" for unknown devices. A known dance pad makes use of
    it by changing to a new mapping-option named DANCEPAD_MAP_CONFIG. Other
    tested devices may follow by adding this mapping-option too.
    
    Some buttons of xpad-devices are addressing mouse-buttons instead of
    gamepad-buttons. This gets fixed too.
    

And maybe we should make module param dpad_to_buttons work for known
pads too, so that a user can decide if the pressure should get measured
in simple key_events (0 or 1) or as an axis with "analog" values.
Because all programs (games) I know of don't like buttons reported as
axes. Even further, I was told that most xbox games don't make use of
this pressure-hitting-button-feature.
So if it would be up to me - I would remove the whole analog-button
thing or make option dpad_to_buttons default. Should I go for it?

 thanks,
  chf


