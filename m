From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Tue, 23 Sep 2014 09:40:17 -0700
Message-ID: <20140923164017.GD40700@core.coreip.homeip.net>
References: <CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
 <20140915215728.GB13468@core.coreip.homeip.net>
 <CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
 <20140915225809.GA31798@core.coreip.homeip.net>
 <CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
 <8227f0fc35950a902241a8e053924ef3.squirrel@mungewell.org>
 <CAON4U=PT9k9j15QyuA-qjDtPQcXMz4Y9_Z0wFV4ydMqoOk8CAg@mail.gmail.com>
 <5418E762.5040802@valvesoftware.com>
 <CAON4U=PuRK3bpK5r5PA2a3dHoqWHit1bqBMbgYtAVg9KxxY_eQ@mail.gmail.com>
 <CAON4U=OdnD+zOSojh09mWz=GmBd5adTxnqXZbZcn363SD7cmxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41379 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaIWQkW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 12:40:22 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so6757782pdj.4
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 09:40:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAON4U=OdnD+zOSojh09mWz=GmBd5adTxnqXZbZcn363SD7cmxw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Wright <michaelwr@android.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Simon Wood <simon@mungewell.org>, David Herrmann <dh.herrmann@gmail.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Sep 22, 2014 at 02:36:57PM -0700, Michael Wright wrote:
> Just so I can figure out the next steps, are you still convinced that
> new LEDs should go in the led subsystem Dmitry?

At this point I would really prefer them not be part of input_dev
structure. Actually there are patches to convert input core to use
generic LEDs for the standard keyboard leds, sadly there is an open
question of how to handle access via legacy and the new API together so
I was not able to merge it [yet].

Thanks.

-- 
Dmitry
