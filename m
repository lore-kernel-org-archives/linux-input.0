From: Ari Entlich <atrigent@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Thu, 21 Jan 2016 22:38:57 -0500
Message-ID: <CANULwrRY4YZfWC24GrL8OAarhT4ufULvcyt84ifQs1_rBpHhdg@mail.gmail.com>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
	<20150807132639.GB21627@pali>
	<CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
	<20150807141214.GD21627@pali>
	<CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
	<20150813110317.GC20040@pali>
	<20150813224839.GC15693@dtor-ws>
	<17D6F4B6F11B44BBB1A2C8EB95A9CF84@cirque.local>
	<20150814001833.GD15693@dtor-ws>
	<7A4B7432A86148988B9878D8EB50F969@cirque.local>
	<20160121121203.GC7192@pali>
	<497C6C7E7BB2424DB3AC56CD7FF593F6@cirque.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37852 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbcAVDi7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 22:38:59 -0500
Received: by mail-wm0-f54.google.com with SMTP id n5so111814693wmn.0
        for <linux-input@vger.kernel.org>; Thu, 21 Jan 2016 19:38:58 -0800 (PST)
In-Reply-To: <497C6C7E7BB2424DB3AC56CD7FF593F6@cirque.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vadim Klishko <vadim@cirque.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Masaki Ota <012nexus@gmail.com>, Tommy Will <tommywill2011@gmail.com>, Qiting Chen <qiting.chen@cn.alps.com>, Qiting Chen <elaineee66@gmail.com>

On Thu, Jan 21, 2016 at 8:50 PM, Vadim Klishko <vadim@cirque.com> wrote:
> However, it looks like you already know everything there is to know about
> how to set the trackpad in pass-thru mode and how to check if there is a
> trackstick behind the trackpad. The code is already in alps.c

The original question was specifically about devices which use the v7
protocol. It looks to me like alps.c only includes code for
passthrough on v2 and v3 devices, unless alps_passthrough_mode_v2 or
alps_passthrough_mode_v3 would also work on v7 devices. I believe we
would also need to know whether passthrough support is always present
on v7 devices with tracksticks or whether its presence needs to be
detected somehow.

Also, neither of these passthrough modes are being used to provide a
full serio device for the trackstick, but that might just be a
limitation of the driver.

Thanks.

Ari
