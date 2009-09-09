From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: (matrix_keypad driver) Re: qi_lb60_keypad driver question?
Date: Wed, 9 Sep 2009 01:36:25 -0700
Message-ID: <20090909090955.1473A526EC9@mailhub.coreip.homeip.net>
References: <4A819D39.2040006@qi-hardware.com> <20090812024620.E4E10526EC9@mailhub.coreip.homeip.net> <4A9AA392.4060301@gmail.com> <20090901021034.6117F526EA5@mailhub.coreip.homeip.net> <4AA75AB9.60406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:36244 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbZIIIg3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 04:36:29 -0400
Received: by qyk30 with SMTP id 30so3376886qyk.5
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2009 01:36:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AA75AB9.60406@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Xiangfu,

On Wed, Sep 09, 2009 at 03:35:21PM +0800, Xiangfu Liu wrote:
> Dmitry Torokhov wrote:
> > Hi,
> > 
> > On Mon, Aug 31, 2009 at 12:06:42AM +0800, Xiangfu Liu wrote:
> >> Hi
> >> now the keypad in Ben NanoNote[1] is work.  problem is I don't know
> >> how to write the special assemble key of matrix_key driver. some kind
> >> of 'SHIFT', like the red key in [2].  when I press the 'RED UP POINT'
> >> + 'W' = '@'
> >>
> > 
> > Historically our KEY_* definitions did not include defines for symbols
> > like '@' because they do not have a dedicated key but rather being
> > produced as a combination of a primary key + modifier; the mapping is
> > done either in console driver or in X.
> > 
> thanks Dmitry.
> can you point me which file I need look into,

I believe you already discovered loadkeys and the keyboard maps that are
used in console mode. I believe you just need to make your 'up point'
key a modifier and make sure that 'W' with that particular modifier
emits '@'.

-- 
Dmitry
