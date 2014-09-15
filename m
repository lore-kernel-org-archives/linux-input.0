From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 14:57:28 -0700
Message-ID: <20140915215728.GB13468@core.coreip.homeip.net>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
 <CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
 <CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:51003 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbaIOV5e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 17:57:34 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so7091543pdj.20
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 14:57:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Wright <michaelwr@android.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Sep 15, 2014 at 11:03:47AM -0700, Michael Wright wrote:
> > Why not introduce all 8 player LEDs as described in the document? You
> > should be safe increasing LED_MAX to 0x1f.
> 
> Wasn't sure if it was safe to bump it since it could potentially break apps
> until they recompile against the new API.

I'd rather we did not add any new input LED definitions but rather
looked into switching to LED subsystem, at least for new LEDs.

Thanks.

-- 
Dmitry
