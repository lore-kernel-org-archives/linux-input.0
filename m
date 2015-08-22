From: Ari Entlich <atrigent@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Sat, 22 Aug 2015 14:33:31 -0400
Message-ID: <CANULwrT12R6NQDVqi0mZaR3xwU6TGXjD9G_V7b9-pn+UHdQbeQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34917 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbHVSdb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Aug 2015 14:33:31 -0400
Received: by ykbi184 with SMTP id i184so100013510ykb.2
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2015 11:33:31 -0700 (PDT)
In-Reply-To: <7A4B7432A86148988B9878D8EB50F969@cirque.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vadim Klishko <vadim@cirque.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?UGFsaSBSb2jvv71y?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, Masaki Ota <012nexus@gmail.com>, Tommy Will <tommywill2011@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Qiting Chen <qiting.chen@cn.alps.com>, Qiting Chen <elaineee66@gmail.com>

On Thu, Aug 13, 2015 at 8:25 PM, Vadim Klishko <vadim@cirque.com> wrote:
> OK, got it. It may take some time.

Just to make sure: are you saying that there definitely is some
incantation for v7 devices that the Linux driver doesn't know about
and that will allow sending commands directly to the trackpoint? If
so, that's awesome! From looking at the commit log for the alps
driver, it looks like ALPS people have been helping out a bit
recently, which is a great trend. Releasing the full spec would be the
ultimate gesture of good-will to the open-source community. If that
happens, I'll be happy for whatever small part I played in making it
happen.

However, for impatient people (such as me), I'm wondering whether it
would be possible to reveal specifically the passthrough incantation
in advance of the full spec, assuming it is not too complex. I know
how involved it can be to release hardware specs, and I'm anxious to
try some of this out.

Thanks!

Ari

> --
> This message and any attachment are confidential. It may also be privileged
> or otherwise protected by work product immunity or other legal rules. If
> you have received it by mistake, please let us know by e-mail reply and
> delete it from your system, you may not copy this message or disclose its
> contents to anyone.
> Cirque Corporation
