From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/4] Input: synaptics - add multitouch packet support
Date: Sat, 18 Dec 2010 10:55:59 -0600
Message-ID: <AANLkTimrNrfTXGh675_8zhOg_+9+NKgOmzJq9rafyh+6@mail.gmail.com>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
	<1292683981-6908-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53478 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab0LRQ4A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Dec 2010 11:56:00 -0500
In-Reply-To: <1292683981-6908-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

On Sat, Dec 18, 2010 at 8:52 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> From: Chase Douglas <chase.douglas@canonical.com>
>
> Synaptics 2.7 series of touchpads support a mode for reporting 2 sets
> of X/Y/Pressure data (multi-touch). =A0These same devices default mod=
e
> report single finger data and do not report finger counts.
>
> Enabling MT mode makes finger count reporting start working in same
> fashion as touchpads that claim that capability. Up to three fingers
> can be reported this way.
>
> While in MT mode and two or three fingers are touching, two sets of
> data are sent. =A0The first is a new format buffer with lower resolut=
ion
> reporting of stationary finger and the second is standard data format
> reporting movement.

We should probably update this comment and remove parts that mention
stationary and movement.  It appears to be doing finger tracking and
first packet is always first touch... except we are getting reports
that clickpads/integrated button pads may not be consistently like
this.

This tracking is partly why type B protocol is being used in later patc=
hes.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
