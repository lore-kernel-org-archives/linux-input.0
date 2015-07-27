From: Douglas Christman <douglaschristman@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Mon, 27 Jul 2015 19:38:20 -0400
Message-ID: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
	<20150720065446.GA13879@dtor-ws>
	<20150720072548.GA25910@pali>
	<CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
	<20150721071218.GA27290@pali>
	<CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
	<20150722072116.GA22138@pali>
	<CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
	<55B0B48D.7010603@redhat.com>
	<CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
	<55B65EEA.5080404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37828 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbbG0XiV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 19:38:21 -0400
Received: by igbpg9 with SMTP id pg9so99106148igb.0
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2015 16:38:20 -0700 (PDT)
In-Reply-To: <55B65EEA.5080404@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

On Mon, Jul 27, 2015 at 12:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>
> OK, please let me know soon, I would like to get to the bottom
> of this, and knowing the exact commit causing the problem will
> help a lot.
>
> Regards,
>
> hans

I've verified that reverting 92bac83d on a clean v4.1 kernel
(b953c0d2) resolves the issue.

Doug
