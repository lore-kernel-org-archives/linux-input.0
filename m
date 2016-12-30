From: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: mousedev - stop offering PS/2 to userspace by default
Date: Fri, 30 Dec 2016 09:44:46 +0100
Message-ID: <58661e80.43e61c0a.f871f.8af1@mx.google.com>
References: <20161229180731.GA5321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35163 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbcL3Iou (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Dec 2016 03:44:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id l2so44448754wml.2
        for <linux-input@vger.kernel.org>; Fri, 30 Dec 2016 00:44:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu 29. December 2016 19:07 Dmitry Torokhov wrote:
> Evdev interface has been available for many years and by now everyone
> is switched to using it, so let's stop offering /dev/input/mouseN
> and /dev/psaux by default.

Hi! There is one exception: gpm. Without /dev/input/mice it did not work 
correctly and IIRC gpm daemon is only one present in linux distributions 
for mouse support in linux console mode (ctrl+alt+f1). Disabling 
/dev/input/mice by default will lead to broken or non-working gpm.

-- 
Pali Rohár
pali.rohar@gmail.com
