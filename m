From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/3] Input: synaptics - add multi-finger and semi-mt support
Date: Mon, 20 Dec 2010 10:20:13 -0600
Message-ID: <AANLkTin-o4VDnLS-bURhyzqb2Go5a9XJOoSCcdH2vkRT@mail.gmail.com>
References: <1292852364-19127-1-git-send-email-rydberg@euromail.se>
	<1292852364-19127-3-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:53206 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932780Ab0LTQUO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Dec 2010 11:20:14 -0500
In-Reply-To: <1292852364-19127-3-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 20, 2010 at 7:39 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> The Synaptics 2.7 series of touchpads support a mode for reporting tw=
o
> sets of X/Y/Pressure data (advanced gesture mode). By default, these
> devices report only single finger data, depriving userspace of the
> nowadays ubiquitous two-finger scroll gesture.
>
> Enabling advanced gesture mode also enables the multi-finger report,
> although the device does not claim that capability. Up to three
> fingers can be reported this way.
>
> While two or three fingers are touching, the normal packet is
> prepended by a reduced finger packet of lower resolution. From the tw=
o
> packets (which do not represent the actual fingers), the bounding
> rectangle of the individual contacts can be extracted. =A0This
> information is sufficient to perform scaling gestures and a limited
> form of rotation gesture. The behavior has been coined semi-mt
> capability, and is signaled to userspace via the INPUT_PROP_SEMI_MT
> device property.
>
> Work to decode the advanced gesture packet: Takashi Iwai.
> Cleanup and testing of the original patch: Chase Douglas.
> Minor cleanup and testing: Chris Bagwell.
> Finalization and semi-mt support: Henrik Rydberg.
>
> Reported-by: Tobyn Bertram
> Not-yet-signed-off-by: Takashi Iwai <tiwai@suse.de>
> Not-yet-signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> Not-yet-signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---


That turned out better.  You can keep my sign off on there.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
