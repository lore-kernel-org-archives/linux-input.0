From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 17:54:03 -0700
Message-ID: <20140916005403.GA21751@core.coreip.homeip.net>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
 <CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
 <CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
 <20140915215728.GB13468@core.coreip.homeip.net>
 <CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
 <20140915225809.GA31798@core.coreip.homeip.net>
 <CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:53162 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbaIPAyI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 20:54:08 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so7344756pdj.38
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 17:54:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Wright <michaelwr@android.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Sep 15, 2014 at 04:41:42PM -0700, Michael Wright wrote:
> > LEDs should be controlled via LED subsystem. The fact that they happen
> > to be located on a given device does not mean they belong to input
> > subsystem. The same as LEds on network card are not part of network stack,
> > etc.
> 
> I think the fundamental difference for me is that the primary input
> standard does
> have a specification for how to interact with LEDs,

... That predates LED subsystem. When we saw that it is not flexible enough LED
subsystem was created. Input, for better or worse, has "sound" support as well,
but I do not think anyone would want to to enhance it to support 7.1 surround
output ;)

> and right now the LED
> subsystem has no knowledge of HID whatsoever.

Then that is something that needs to be changed.

> 
> Even if I did add the plumbing for HID over into the LED subsystem, is there an
> easy way to correlate input devices and their LEDs from userspace?

What does it mean "their led"? The led that happens to share the same physical
package?

Thanks.

-- 
Dmitry
