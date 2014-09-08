From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: EVIOCSFF macro inconsistency
Date: Mon, 8 Sep 2014 20:14:13 +0200
Message-ID: <CADbOyBRcKFntUAruYTGcqzt2Vi=MHJDFoZK5v4fE8WLFjT0viw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:59066 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbaIHSOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Sep 2014 14:14:14 -0400
Received: by mail-vc0-f172.google.com with SMTP id hy10so2180808vcb.3
        for <linux-input@vger.kernel.org>; Mon, 08 Sep 2014 11:14:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi everyone,

After inspecting the <linux/input.h> header file, I found that there
is one single ioctl value macro that is inconsistent w.r.t. the other
macros that do an IOC_WRITE :
    EVIOCSFF   _IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))
Why not define it as follows? :
    EVIOCSFF   _IOW('E', 0x80, struct ff_effect)
Apart from having a more readable definition, it also explicitly
reveals type info ("struct ff_effect").
Is it worth to create a patch to fix it?

Thanks,
Elias
