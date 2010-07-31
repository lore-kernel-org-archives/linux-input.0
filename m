From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sat, 31 Jul 2010 14:56:24 -0500
Message-ID: <AANLkTinNYjG8EaU_SXvWQO9_7rrp7s8T80FoP4BkN_AE@mail.gmail.com>
References: <4C1FD2B0.1080504@tudelft.nl>
	<4C1FD454.4050807@tudelft.nl>
	<20100721033655.GA9070@core.coreip.homeip.net>
	<4C532009.4020103@tudelft.nl>
	<4C533DC3.9070001@euromail.se>
	<4C53471A.9080001@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57010 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0GaT40 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 15:56:26 -0400
Received: by qyk8 with SMTP id 8so779690qyk.19
        for <linux-input@vger.kernel.org>; Sat, 31 Jul 2010 12:56:25 -0700 (PDT)
In-Reply-To: <4C53471A.9080001@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, Jul 30, 2010 at 4:41 PM, =C9ric Piel <E.A.B.Piel@tudelft.nl> wr=
ote:
>
> Op 30-07-10 23:01, Henrik Rydberg schreef:
> > On 07/30/2010 08:55 PM, =C9ric Piel wrote:
> :
> >>> I am concerned what happens when you put one finger first and the=
n add
> >>> another one. Would not that couse the cursor to jump?
> >
> >
> > I agree, I have seen this behavior before and it is not quite what =
you want. The
> > average point does jump.
> >

This is basically same approach as what synaptics hardware is
reporting.  Their  Synaptics PS/2 TouchPad Interfacing Guide mentions
current hardware reports an x/y closer to first finger during multiple
fingers and that older hardware reports a value closer to center.
Both cases, you can see movement when either finger is moving.

There are a few existing X side bug reports I've seen related to this
behaviour.  On newer synaptics pad its easiest to see if you touch 1st
finger on left side of pad, 2nd finger on right side of pad, and then
release 1st finger then you will see a big cursor jump as hardware is
force to transition over to 2nd finger x/y (make sure 2 finger
scrolling is disabled as that feature can fix issue).

I've seen xf86-input-synaptics patches floating around that try to
detect jumps-because-of-averaging from the size of delta and discard
but it is easy to be mistaken.  Probably its better to detect
BTN_TOOL_DOUBLETAP transitions back to 0 and treating similar to both
fingers being lifted to account for expected jump.

So an option is to do something similar to below and clearly document
that user space needs to account for known reporting behaviour when
BTN_TOOL_DOUBLETOUCH transitions back to 0.

input_report_abs(dev, ABS_X, x1 + (x2 & 7));
input_report_abs(dev, ABS_Y, y1 + (y2 & 7));

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
