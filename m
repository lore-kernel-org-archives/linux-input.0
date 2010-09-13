From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [Patch v2] input:rohm based bu21013 touch panel controller driver
 support
Date: Mon, 13 Sep 2010 16:36:51 +0200
Message-ID: <4C8E3703.50303@euromail.se>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local> <20100909155918.GB19937@core.coreip.homeip.net> <20100909160140.GC19937@core.coreip.homeip.net> <4C8926E0.3040400@euromail.se> <81C3A93C17462B4BBD7E272753C1057918FC1CDAA7@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:34865 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752107Ab0IMOhd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 10:37:33 -0400
In-Reply-To: <81C3A93C17462B4BBD7E272753C1057918FC1CDAA7@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <tsoni@codeaurora.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On 09/13/2010 12:12 PM, Naveen Kumar GADDIPATI wrote:
[...]
>>>>> +static bool bu21013_verify_delta(int x1, int y1, int x2, int y2)

>>>>> +{
>>>>> +       int delta_x, delta_y;
>>>>> +
>>>>> +       if ((x1 != 0) && (y1 != 0)) {
>>>>> +               delta_x = x2 - x1;
>>>>> +               if (x1 > x2)
>>>>> +                       delta_x = x1 - x2;
>>>>> +               delta_y = y2 - y1;
>>>>> +               if (y1 > y2)
>>>>> +                       delta_y = y1 - y2;
>>>>> +               if ((delta_x < DELTA_MIN) || (delta_y < DELTA_MIN))
>>>>> +                       return false;
>>>>> +       }
>>>>> +       return true;
[...]

>> I do not understand why deltas are verified in the first place.
>> Either one can rely on the identity of the fingers, in which
>> case MT slots is simpler to handle, or one cannot rely on it,
>> in which case the above code is wrong, since it assumes the
>> values compared have the same identity.

> 
> 	This case according to controller specification, when the two fingers delta is of
> 	16 either in x or y, we should ignore those co-ordinates and report as pen-up.


And not as a single finger with larger perimeter? It would be interesting to
know how this driver has been tested. There are some applications that can help
examining the quality of MT output, one of them can be found at
http://bitmath.org/code/mtview/.

Henrik
