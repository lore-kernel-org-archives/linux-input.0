From: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: evdev.c(EVIOCGBIT): Suspicious buffer size 511,
Date: Wed, 20 Aug 2008 09:31:07 -0700
Message-ID: <dd18b0c30808200931x2aea0dc6t2986b7a4c3daeff9@mail.gmail.com>
References: <dd18b0c30808172310u7cf7836ai15e19485908ae0ce@mail.gmail.com>
	 <20080820000040.55015b48.akpm@linux-foundation.org>
	 <20080820092806.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:23792 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbYHTQbI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2008 12:31:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so643705wfd.4
        for <linux-input@vger.kernel.org>; Wed, 20 Aug 2008 09:31:07 -0700 (PDT)
In-Reply-To: <20080820092806.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Wed, Aug 20, 2008 at 6:31 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Aug 20, 2008 at 12:00:40AM -0700, Andrew Morton wrote:
>> On Sun, 17 Aug 2008 23:10:54 -0700 "Justin Mattock" <justinmattock@gmail.com> wrote:
>>
>> > I'm noticing:
>> > evdev.c(EVIOCGBIT): Suspicious buffer size 511, limiting output to 64
>> > bytes. See http://userweb.kernel.org/~dtor/eviocgbit-bug.html
>> > with rc-3 not with rc2.
>> > Did the patch to synaptics, seems
>> > my xorg is not reading /usr/X11R6/lib/modules/input/synaptics_drv.o
>> > only /usr/lib/xorg/modules/input/synaptics_drv.so
>> > is there any easy fix, or do I have to recompile xorg?
>> > regards;
>> >
>>
>> (cc's added)
>>
>
> You can just copy the updated file manually into
> /usr/lib/xorg/modules/input/.
>
> I tried rebuilding synaptics from here:
>
> git://anongit.freedesktop.org/git/xorg/driver/xf86-input-synaptics
>
> but unfortunately it fails with some automake crap that I don't have
> time to trace through at the moment.
>
> --
> Dmitry
>

Cool, I'll have a try at it again.
What I did was copy /usr/lib/X11R6/lib/modules/input/synaptics_drv.o
to /usr/lib/xorg/modules/input/   then renamed it to synaptics_drv.so
the module loads but is broken.  When given time today I'll try and
reinstall, and see if I can get it working.


-- 
Justin P. Mattock
