From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: rotary_encoder
Date: Tue, 21 May 2013 10:38:44 +0200
Message-ID: <CAH9NwWdZ0uj7pCtB6TOtTbGP7iU4HBYd2nBWajvARO6haOn1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:46799 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3EUIjF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 May 2013 04:39:05 -0400
Received: by mail-qc0-f170.google.com with SMTP id s11so184876qcw.29
        for <linux-input@vger.kernel.org>; Tue, 21 May 2013 01:39:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jhovold@gmail.com, linux-input@vger.kernel.org

Hi

I have a device with a rotary encoder and I got the device working with
the generic driver for rotary encoders connected to GPIO lines. Now my
goal is to send two different key codes - depending on the rotation direction.

left ->ALT + tab
right -> tab

Is there a way to extend the current encoder, which is accepted for mainline
inclusion or should I do this step in user space?

thanks
--
Christian Gmeiner, MSc
