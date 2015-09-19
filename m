From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Fix typo in MT documentation
Date: Sat, 19 Sep 2015 11:28:58 -0700
Message-ID: <20150919182858.GG7081@dtor-ws>
References: <1442502100-21039-1-git-send-email-daniel.martin@secunet.com>
 <CAN+gG=HXTi8JHnRBMOpK4ZPmuG0inKRz9jh9SXFZ3uhZMo+Qkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36473 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbbISS3B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Sep 2015 14:29:01 -0400
Received: by padhk3 with SMTP id hk3so78677617pad.3
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2015 11:29:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN+gG=HXTi8JHnRBMOpK4ZPmuG0inKRz9jh9SXFZ3uhZMo+Qkw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Daniel Martin <daniel.martin@secunet.com>, linux-input <linux-input@vger.kernel.org>, Daniel Martin <consume.noise@gmail.com>

On Thu, Sep 17, 2015 at 04:31:36PM -0400, Benjamin Tissoires wrote:
> On Thu, Sep 17, 2015 at 11:01 AM, Daniel Martin
> <daniel.martin@secunet.com> wrote:
> > Section "Event Computation" had this:
> >     ...
> >     ABS_MT_TOOL_X := C_X
> >     ABS_MT_TOOL_X := C_Y
> >
> > Replace the second ABS_MT_TOOL_X with ABS_MT_TOOL_Y.
> >
> > Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> > ---
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> >  Documentation/input/multi-touch-protocol.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
> > index b85d000..c51f114 100644
> > --- a/Documentation/input/multi-touch-protocol.txt
> > +++ b/Documentation/input/multi-touch-protocol.txt
> > @@ -361,7 +361,7 @@ For win8 devices with both T and C coordinates, the position mapping is
> >     ABS_MT_POSITION_X := T_X
> >     ABS_MT_POSITION_Y := T_Y
> >     ABS_MT_TOOL_X := C_X
> > -   ABS_MT_TOOL_X := C_Y
> > +   ABS_MT_TOOL_Y := C_Y
> >
> >  Unfortunately, there is not enough information to specify both the touching
> >  ellipse and the tool ellipse, so one has to resort to approximations.  One
> > --
> > 2.1.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
