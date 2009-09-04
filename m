From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: (matrix_keypad driver) Re: qi_lb60_keypad driver question?
Date: Fri, 04 Sep 2009 19:38:09 +0800
Message-ID: <4AA0FC21.5090701@gmail.com>
References: <4A819D39.2040006@qi-hardware.com> <20090812024620.E4E10526EC9@mailhub.coreip.homeip.net> <4A9AA392.4060301@gmail.com> <20090901021034.6117F526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f177.google.com ([209.85.216.177]:55034 "EHLO
	mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754209AbZIDLiT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2009 07:38:19 -0400
Received: by pxi7 with SMTP id 7so683497pxi.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2009 04:38:21 -0700 (PDT)
In-Reply-To: <20090901021034.6117F526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry
sorry for the late reply. 
thanks for the info.
I will try to work on the console driver since our device don't have X.

will send report when I have any progress. 

Best Regards
Xiangfu




Dmitry Torokhov wrote:
> Hi,
> 
> On Mon, Aug 31, 2009 at 12:06:42AM +0800, Xiangfu Liu wrote:
>> Hi
>> now the keypad in Ben NanoNote[1] is work.  problem is I don't know
>> how to write the special assemble key of matrix_key driver. some kind
>> of 'SHIFT', like the red key in [2].  when I press the 'RED UP POINT'
>> + 'W' = '@'
>>
> 
> Historically our KEY_* definitions did not include defines for symbols
> like '@' because they do not have a dedicated key but rather being
> produced as a combination of a primary key + modifier; the mapping is
> done either in console driver or in X.
> 
> Looking at the picture of the device that you provided it appears that
> your device does not have a dedicated '@' key so it should work in the
> same fashion as above.
> 


-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
