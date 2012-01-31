From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [PATCH] Input: Document the device properties
Date: Tue, 31 Jan 2012 21:33:50 +0800
Message-ID: <CAGS+omD+jWXFOJQ0GC1yxAJrkK=5yxxdsvxjGu73kmdi5QnpHA@mail.gmail.com>
References: <1327912546-16960-1-git-send-email-rydberg@euromail.se>
 <4F268BCC.4000008@canonical.com> <4F26CDF3.5080606@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48617 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab2AaNeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jan 2012 08:34:10 -0500
Received: by iacb35 with SMTP id b35so851890iac.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2012 05:34:10 -0800 (PST)
In-Reply-To: <4F26CDF3.5080606@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>, =?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?= <cywang@google.com>
Cc: Jussi Pakkanen <jussi.pakkanen@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 31, 2012 at 1:05 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
>
> On 01/30/2012 01:23 PM, Jussi Pakkanen wrote:
> > On 01/30/2012 10:35 AM, Henrik Rydberg wrote:
> >> +INPUT_PROP_SEMI_MT:
> >> +------------------
> >> +Some touchpads, most common between 2008 and 2011, can detect the=
 presence
> >> +of multiple contacts without resolving the individual positions; =
only the
> >> +number of contacts and the corresponding bounding box is known. F=
or such
> >> +touchpads, the semi-mt property should be set.
> >
> > A "corresponding bounding box" usually means "a bounding box that
> > contains all touches on the touchpad". I've been told (though I hav=
e not
> > checked it myself) that there are devices that don't do this. They =
only
> > report a bounding box for some subset of touches. If this is the ca=
se,
> > it should be documented here.
>
> Yeah, I thought Henrik's definition was correct for a long time, but
> when Derek Foreman (I think) proposed some patches for the latest
> synaptics devices I took a closer look at my semi-mt synaptics trackp=
ad.
> The coordinates it gave were locations based on two of the touches. W=
hen
> three touches are on the touchpad, it gave a bounding box of two of t=
he
> touches, and there's no way to tell which two.

This is correct.  At least some of the Synaptics touchpads for which
the "semi-mt" path through the kernel driver is used, the firmware
tries to report the actual positions for two contacts.  However, due
to limitations of their 'profile sensor' design, if the two fingers
get too close together, or even cross in the X or Y dimension, the
firmare tracking gets confused and can start reporting the "X" of one
contact with the "Y" of another.  Thus, the safest behavior is to pair
[min(X1, X2), min(Y1, Y2)] and [max(X1, X2), max(Y1, Y2)], and treat
these two points as the corners of a 'bounding box'.  If a third
contact is on the pad, there is no guarantee that it will be in this
box.

-Daniel


>
> -- Chase
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
