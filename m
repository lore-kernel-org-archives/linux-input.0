From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: (matrix_keypad driver) Re: qi_lb60_keypad driver question?
Date: Wed, 09 Sep 2009 15:35:21 +0800
Message-ID: <4AA75AB9.60406@gmail.com>
References: <4A819D39.2040006@qi-hardware.com> <20090812024620.E4E10526EC9@mailhub.coreip.homeip.net> <4A9AA392.4060301@gmail.com> <20090901021034.6117F526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f201.google.com ([209.85.222.201]:42372 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbZIIHf3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 03:35:29 -0400
Received: by pzk39 with SMTP id 39so3869867pzk.15
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2009 00:35:32 -0700 (PDT)
In-Reply-To: <20090901021034.6117F526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

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
thanks Dmitry.
can you point me which file I need look into,
I am newbie in kernel. 

-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
