From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] Input: trackpoint - force 3 buttons if 0 button is
 reported
Date: Sun, 21 Jan 2018 21:10:50 +0100
Message-ID: <20180121201049.GA23310@beacon.debie>
References: <20180112064658.25019-1-aaron.ma@canonical.com>
 <20180112083940.p36qj6ltzzwtuhng@dtor-ws>
 <06bbeca0-8a90-8935-9be3-f154db0b9fe9@canonical.com>
 <20180112181830.ccpkltghgkj3oh3e@dtor-ws>
 <6a96ce54-9f8a-2424-1e48-34ec6445cb8f@canonical.com>
 <20180116230713.rppztybwe5ufhoxo@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:53216 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbeAUUK6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 15:10:58 -0500
Content-Disposition: inline
In-Reply-To: <20180116230713.rppztybwe5ufhoxo@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 16, 2018 at 03:07:13PM -0800, Dmitry Torokhov wrote:
Hi Dmitry,

> 
> On Sat, Jan 13, 2018 at 10:34:19AM +0800, Aaron Ma wrote:
> > Will your patch go to stable kernel?
> > If yes, that's fine.
> 
> Hmm, it looks like we need this patch after all as we do have screwy
> Lenovos with apparently 0x01 devices reporting 0 buttons. From
> https://bugzilla.kernel.org/show_bug.cgi?id=196253
> 
>  thinkpad_acpi: ThinkPad BIOS R0DET87W (1.87 ), EC unknown
>  thinkpad_acpi: Lenovo ThinkPad E470, model 20H1004SGE
> 
>  psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 0/0
> 
> I'll ask them to try my patch and if it is indeed 0x01 device I'll apply
> your patch.

It is quite strange. In the past,for commit 293b915fd9be 
"Input: trackpoint - assume 3 buttons when buttons detection fails" there was
success reported for lenovo e470 and I see the same success report in that
bugzilla ticket.  I can also report success on lenovo e570.

But some seem to have problems, could it be that they are not including that
commit in the kernel they are running ? Or did a bios upgrade change the
behaviour ?
It would be best when we have a confirmation from a e470 owner that without the
proposed patch from Aaron the middle button does not work on his e470, and it
works with it.


Kind regards,
Ulrik
