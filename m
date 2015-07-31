From: Douglas Christman <douglaschristman@gmail.com>
Subject: Re: ALPS DualPoint double click bug
Date: Fri, 31 Jul 2015 17:12:56 -0400
Message-ID: <CANuv8Qyx3zPDmWvV-2XRQXEiSVnOa10GYPGiYaF1B9iru10_9A@mail.gmail.com>
References: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
	<20150721071218.GA27290@pali>
	<CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
	<20150722072116.GA22138@pali>
	<CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
	<55B0B48D.7010603@redhat.com>
	<CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
	<55B65EEA.5080404@redhat.com>
	<CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
	<55BA31F3.3070807@redhat.com>
	<20150730144643.GG26714@pali>
	<55BA3C28.3080506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34156 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbbGaVM5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2015 17:12:57 -0400
Received: by obre1 with SMTP id e1so62884964obr.1
        for <linux-input@vger.kernel.org>; Fri, 31 Jul 2015 14:12:56 -0700 (PDT)
In-Reply-To: <55BA3C28.3080506@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

On Thu, Jul 30, 2015 at 11:00 AM, Hans de Goede <hdegoede@redhat.com> w=
rote:
> Hi,
>
> On 30-07-15 16:46, Pali Roh=C3=A1r wrote:
>> What about introducing new flag ALPS_<something> instead calling
>> dmi_name_in_vendors() function every time when we need to process
>> packet?
>
> That is a good idea. Douglas can you test the attached version
> instead of the previous one please ?
>
> Thanks & Regards,
>
> Hans

This patch works for me.

Doug
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
