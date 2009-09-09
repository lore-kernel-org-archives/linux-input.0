From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: (matrix_keypad driver) Re: qi_lb60_keypad driver question?
Date: Wed, 9 Sep 2009 02:14:19 -0700
Message-ID: <20090909094749.0FEB7526EC9@mailhub.coreip.homeip.net>
References: <4A819D39.2040006@qi-hardware.com> <20090812024620.E4E10526EC9@mailhub.coreip.homeip.net> <4A9AA392.4060301@gmail.com> <20090901021034.6117F526EA5@mailhub.coreip.homeip.net> <4AA75AB9.60406@gmail.com> <20090909090955.1473A526EC9@mailhub.coreip.homeip.net> <4AA76B82.2080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:59141 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbZIIJOV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 05:14:21 -0400
Received: by qyk30 with SMTP id 30so3394770qyk.5
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2009 02:14:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AA76B82.2080200@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 09, 2009 at 04:46:58PM +0800, Xiangfu Liu wrote:
> Dmitry Torokhov wrote:
> > Hi Xiangfu,
> > 
> > On Wed, Sep 09, 2009 at 03:35:21PM +0800, Xiangfu Liu wrote:
> >> Dmitry Torokhov wrote:
> >>> Hi,
> >>>
> >>> On Mon, Aug 31, 2009 at 12:06:42AM +0800, Xiangfu Liu wrote:
> >>>> Hi
> >>>> now the keypad in Ben NanoNote[1] is work.  problem is I don't know
> >>>> how to write the special assemble key of matrix_key driver. some kind
> >>>> of 'SHIFT', like the red key in [2].  when I press the 'RED UP POINT'
> >>>> + 'W' = '@'
> >>>>
> >>> Historically our KEY_* definitions did not include defines for symbols
> >>> like '@' because they do not have a dedicated key but rather being
> >>> produced as a combination of a primary key + modifier; the mapping is
> >>> done either in console driver or in X.
> >>>
> >> thanks Dmitry.
> >> can you point me which file I need look into,
> > 
> > I believe you already discovered loadkeys and the keyboard maps that are
> > used in console mode. I believe you just need to make your 'up point'
> > key a modifier and make sure that 'W' with that particular modifier
> > emits '@'.
> > 
> the keycode 94 is the 'up point'
> 
> the loadkeys always like:
> keycode 94 = Compose 
> compose 'w' 'w' to '@'
> 
> it's take three keys not two.
> I must press 'up point' + 'w' + 'w' then it's will display '@'.
> not 'up point' + 'w' = '@'
> 

You probably want to map your 'up point' to AltGr:

keycode 94 = AltGr
altgr keycode <w-keycode> = at

You will find additional information in 'man keymaps', also see
documentation that comes with 'kbd' package.

-- 
Dmitry
