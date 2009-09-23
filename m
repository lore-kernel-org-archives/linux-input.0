From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Ben_Nanonote keyboard driver bug
Date: Tue, 22 Sep 2009 23:37:26 -0700
Message-ID: <200909222337.26608.dmitry.torokhov@gmail.com>
References: <4AB33A1A.7090508@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:54708 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbZIWGh0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 02:37:26 -0400
Received: by ywh4 with SMTP id 4so557766ywh.33
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 23:37:30 -0700 (PDT)
In-Reply-To: <4AB33A1A.7090508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiangfu Liu <xiangfu.z@gmail.com>
Cc: "Hard- and Software Development, Kernel, Distribution, Roadmap" <developer@lists.qi-hardware.com>, linux-input@vger.kernel.org

On Friday 18 September 2009 12:43:22 am Xiangfu Liu wrote:
> Hi
> 
> with Dmitry's help, our keyboard is work.
> 
> we use the matrix_keypad.c driver. I found a problem.
> for example. the keypad is like this: (part of keypad)
> GPIO    GPIO    GPIO
> 
> a_______w_______u_____GPIO
> 
> |_______s_______j_____GPIO
> 
> Shift___Alt_____Ctrl__GPIO
> 
> first time press [Shift] + [a] it's output [a] not the [A]
> second time press [Shift] + [a] it's output [A]. correct.
> then all work fine.  but when I release the [Shift]. and press [a]
> it's will also output big [A]. but if the midifier and character not
> in same column GPIO. it will work fine.
> 
> other modifier all like this. same GPIO will cause problem.
> 
> I should look into the matrix_keypad.c to fix this, right?
> 

It would be interesting to see what events are being reported by either evbug 
module or evtest utility.

-- 
Dmitry
