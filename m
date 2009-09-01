From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: (matrix_keypad driver) Re: qi_lb60_keypad driver question?
Date: Mon, 31 Aug 2009 18:37:56 -0700
Message-ID: <20090901021034.6117F526EA5@mailhub.coreip.homeip.net>
References: <4A819D39.2040006@qi-hardware.com> <20090812024620.E4E10526EC9@mailhub.coreip.homeip.net> <4A9AA392.4060301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f175.google.com ([209.85.222.175]:59000 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbZIABh4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Aug 2009 21:37:56 -0400
Received: by mail-pz0-f175.google.com with SMTP id 5so3270143pzk.21
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2009 18:37:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A9AA392.4060301@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On Mon, Aug 31, 2009 at 12:06:42AM +0800, Xiangfu Liu wrote:
> Hi
> now the keypad in Ben NanoNote[1] is work.  problem is I don't know
> how to write the special assemble key of matrix_key driver. some kind
> of 'SHIFT', like the red key in [2].  when I press the 'RED UP POINT'
> + 'W' = '@'
> 

Historically our KEY_* definitions did not include defines for symbols
like '@' because they do not have a dedicated key but rather being
produced as a combination of a primary key + modifier; the mapping is
done either in console driver or in X.

Looking at the picture of the device that you provided it appears that
your device does not have a dedicated '@' key so it should work in the
same fashion as above.

-- 
Dmitry
