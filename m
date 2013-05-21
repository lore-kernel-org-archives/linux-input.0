From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: rotary_encoder
Date: Tue, 21 May 2013 12:13:22 -0700
Message-ID: <2575756.Fe0zP7tL6X@dtor-d630.eng.vmware.com>
References: <CAH9NwWdZ0uj7pCtB6TOtTbGP7iU4HBYd2nBWajvARO6haOn1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:64990 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab3EUTNZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 May 2013 15:13:25 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so1018842pab.7
        for <linux-input@vger.kernel.org>; Tue, 21 May 2013 12:13:25 -0700 (PDT)
In-Reply-To: <CAH9NwWdZ0uj7pCtB6TOtTbGP7iU4HBYd2nBWajvARO6haOn1iw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: jhovold@gmail.com, linux-input@vger.kernel.org

On Tuesday, May 21, 2013 10:38:44 AM Christian Gmeiner wrote:
> Hi
> 
> I have a device with a rotary encoder and I got the device working with
> the generic driver for rotary encoders connected to GPIO lines. Now my
> goal is to send two different key codes - depending on the rotation
> direction.
> 
> left ->ALT + tab
> right -> tab
> 
> Is there a way to extend the current encoder, which is accepted for mainline
> inclusion or should I do this step in user space?

Userspace please.

-- 
Dmitry
