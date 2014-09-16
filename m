From: Michael Wright <michaelwr@android.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 21:06:43 -0700
Message-ID: <CAON4U=PT9k9j15QyuA-qjDtPQcXMz4Y9_Z0wFV4ydMqoOk8CAg@mail.gmail.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
	<CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
	<CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
	<20140915215728.GB13468@core.coreip.homeip.net>
	<CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
	<20140915225809.GA31798@core.coreip.homeip.net>
	<CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
	<8227f0fc35950a902241a8e053924ef3.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36320 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaIPEGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2014 00:06:44 -0400
Received: by mail-lb0-f169.google.com with SMTP id p9so5743829lbv.14
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 21:06:43 -0700 (PDT)
In-Reply-To: <8227f0fc35950a902241a8e053924ef3.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Sep 15, 2014 at 7:00 PM,  <simon@mungewell.org> wrote:
> One problem that exists is that many HID devices don't have an (embedded)
> serial number, so identification can be confused if you have more that one
> identical device.


That's a pretty serious problem since this is explicitly for multiple
gamepads connected to the same device, which will most likely be all
the same type.

-- 
Michael Wright
Android Frameworks
