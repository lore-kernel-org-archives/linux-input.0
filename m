From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [alsa-devel] PC speaker beeps in 2.6.30?
Date: Sat, 27 Jun 2009 14:33:26 +0400
Message-ID: <4A45F576.7070909@msgid.tls.msk.ru>
References: <4A365DA6.8000102@msgid.tls.msk.ru>	<4A4464CA.4060006@msgid.tls.msk.ru> <s5hws6y86wl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([81.13.33.159]:42435 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbZF0Kd1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Jun 2009 06:33:27 -0400
In-Reply-To: <s5hws6y86wl.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

Takashi Iwai wrote:
> At Fri, 26 Jun 2009 10:03:54 +0400,
> Michael Tokarev wrote:
>> [Adding some more Cc's...]
>>
>> Am I the only concerned about this?  My 2.6.30 is still
>> silent w.r.t. old good PC speaker beeps, and I wasn't
>> able to make it to produce any sound.  Yes, as pointed
>> out by others there is a control now, in alsa, and I
>> can hear ugly and scary beeps from my stereo speakers
>> (when they're turned on and when the control is un-muted).
>> But that's.. not a solution/answer to the original
>> question... ;)
> 
> Try 2.6.31-rc1.  There was a fix regarding beep frequency.

You mean this one:

commit fa7979663190240b838ab8c8bad7f59e618bf77c
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue May 19 12:50:04 2009 +0200

     ALSA: hda - Fix digital beep tone calculation

?

Note it's about alsa/hda beep.  Probably to make my new
"alsa beeps" less scary.  But I'm asking about PC speaker --
see the $subject line.  I'm missing PC speaker beeps, not
alsa beeps.

Thanks!

/mjt
