From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: [Patch v2] input:rohm based bu21013 touch panel controller
 driver support
Date: Mon, 13 Sep 2010 12:12:44 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057918FC1CDAA7@EXDCVYMBSTM005.EQ1STM.local>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local>
 <20100909155918.GB19937@core.coreip.homeip.net>
 <20100909160140.GC19937@core.coreip.homeip.net>
 <4C8926E0.3040400@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:46059 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751867Ab0IMKNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 06:13:04 -0400
In-Reply-To: <4C8926E0.3040400@euromail.se>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Henrik,

Thanks for your comments.

> >>> +static bool bu21013_verify_delta(int x1, int y1, int x2, int y2)
> >>> +{
> >>> +       int delta_x, delta_y;
> >>> +
> >>> +       if ((x1 != 0) && (y1 != 0)) {
> >>> +               delta_x = x2 - x1;
> >>> +               if (x1 > x2)
> >>> +                       delta_x = x1 - x2;
> >>> +               delta_y = y2 - y1;
> >>> +               if (y1 > y2)
> >>> +                       delta_y = y1 - y2;
> >>> +               if ((delta_x < DELTA_MIN) || (delta_y < DELTA_MIN))
> >>> +                       return false;
> >>> +       }
> >>> +       return true;
> >>
> >> Hmm, I remember - the fuzz handling indeed will not work for MT A
> protocol.
> >> Still, I do not think it is correct. Don't you need to do
> >> "abs(delta_x) < DELTA_MIN"?
> 
> 
> True, fuzz wont be processed in the kernel, but the information can be
> used
> outside the kernel, like in mtdev.
> 
> I do not understand why deltas are verified in the first place. Either
> one can
> rely on the identity of the fingers, in which case MT slots is simpler
> to
> handle, or one cannot rely on it, in which case the above code is
> wrong, since
> it assumes the values compared have the same identity.
> 

	This case according to controller specification, when the two fingers delta is of
	16 either in x or y, we should ignore those co-ordinates and report as pen-up.


> Perhaps the logic could be inverted so that the case when the total
> number is
> zero is treated first, to avoid repeated tests below.
> 
> >>> +               if ((finger2_pos_x != 0) && (finger2_pos_y != 0)) {
> >>> +                       if ((finger1_pos_x == 0) || (finger1_pos_y
> == 0))
> >>> +                               return 0;
> 
> 
> So zero is some kind of null value? No continuation here?
> 
> >>> +                       ret = bu21013_verify_delta(finger1_pos_x,
> >>> +                               finger1_pos_y, finger2_pos_x,
> finger2_pos_y);
> >>> +                       if (!ret)
> >>> +                               total_number_of_active_sensors = 0;
> >>> +               }
> 
> 
> So this is a tracking-plus-filtering solution? Unless the form factor
> forbids
> it, having driver-specific tracking solutions in the kernel is not
> encouraged.
> Two fingers might be borderline.
	
	We need to keep this filtering solution according to the controller specification.

Thanks & Regards,
Naveen
