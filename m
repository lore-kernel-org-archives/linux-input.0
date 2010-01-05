From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Questions about Multi-touch Protocal
Date: Tue, 5 Jan 2010 09:49:35 -0800
Message-ID: <20100105174934.GA2854@core.coreip.homeip.net>
References: <4B42D998.4050303@samsung.com>
 <4B432BDB.3000103@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:41913 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab0AERtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2010 12:49:47 -0500
Received: by fxm25 with SMTP id 25so10013927fxm.21
        for <linux-input@vger.kernel.org>; Tue, 05 Jan 2010 09:49:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B432BDB.3000103@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, jkosina@suse.cz

On Tue, Jan 05, 2010 at 01:08:59PM +0100, Henrik Rydberg wrote:
> Hi Joonyoung,
> 
> > I have some questions about Multi-touch(MT) Protocal.
> 
> Let me start by answering your last question:
> 
> > Finally, what is difference of ABS_MT_TOUCH_MAJOR and
> > ABS_MT_WIDTH_MAJOR?
> 
> The TOUCH and WIDTH parameters have a geometrical interpretation; imagine
> looking through a window at someone gently holding a finger against the glass.
> You will see two regions, one inner region consisting of the part of the finger
> actually touching the glass, and one outer region formed by the perimeter of the
> finger. The diameter of the inner region is the ABS_MT_TOUCH_MAJOR, the diameter
> of the outer region is ABS_MT_WIDTH_MAJOR. Now imagine the person pressing the
> finger harder against the glass. The inner region will increase, and in general,
> the ratio ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR, which is always smaller than
> unity, is related to the finger pressure.
> 
> In addition to the MAJOR parameters, the oval shape of the finger can be
> described by adding the MINOR parameters, such that MAJOR and MINOR are the
> major and minor axis of an ellipse. Finally, the orientation of the oval shape
> can be describe with the ORIENTATION parameter.
> 
> > First, what is the purpose of ABS_MT_TOUCH_MAJOR event? I wonder how
> > it is used at userspace side.
> 
> In a graphical program it can of course be used as is, but in the specific
> application of creating gesture events, the TOUCH and WIDTH parameters can be
> used to, e.g., approximate finger pressure or distinguish between index finger
> and thumb. With the addition of the MINOR parameters, one can also distinguish
> between a sweeping finger and a pointing finger, and with ORIENTATION, one can
> detect twisting of fingers.
> 
> > Should the ABS_MT_TOUCH_MAJOR be the mininum set of events for multi
> > touch? I'm not sure whether this question is valid because of first
> > question.
> 
> Each finger packet should have an ABS_MT_TOUCH_MAJOR value. In can be computed
> from various types of sensory input, e.g., the size of the contact area or a
> pressure sensor.
> 
> Hope this explains it a bit further.
> 

Very nice explanation, Henrik. Any chance you could turn it into a patch
to Documentation/input/multi-touch-protocol.txt?

-- 
Dmitry
