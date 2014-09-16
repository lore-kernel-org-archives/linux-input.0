From: Michael Wright <michaelwr@android.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 18:02:22 -0700
Message-ID: <CAON4U=MPr4QA0XxZGzsZb04eV_Xs90H3z1Dp+DhRCaVWQL55kA@mail.gmail.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
	<CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
	<CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
	<20140915215728.GB13468@core.coreip.homeip.net>
	<CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
	<20140915225809.GA31798@core.coreip.homeip.net>
	<CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
	<20140916005403.GA21751@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:45222 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbaIPBCY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 21:02:24 -0400
Received: by mail-la0-f53.google.com with SMTP id ge10so5917284lab.12
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 18:02:22 -0700 (PDT)
In-Reply-To: <20140916005403.GA21751@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Sep 15, 2014 at 5:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> ... That predates LED subsystem. When we saw that it is not flexible enough LED
> subsystem was created. Input, for better or worse, has "sound" support as well,
> but I do not think anyone would want to to enhance it to support 7.1 surround
> output ;)

When I said standard I meant HID, not the input subsystem. I totally
understand wanting to create a better separation of responsibilities
internally.

> What does it mean "their led"? The led that happens to share the same physical
> package?

Sure, but in this case we really care that they're part of the same
physical package. We're lighting up the LED for the first player's
input device, so we *need* this ability to correlate.

LEDs also don't appear to have any uapi headers. Is the sysfs entry
considered stable API? Are we supposed to classify what they're for
(e.g. PLAYER_1 vs. PLAYER_2) by their name?

-- 
Michael Wright
Android Frameworks
