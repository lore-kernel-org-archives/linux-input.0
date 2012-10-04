From: "Przemo Firszt" <przemo@firszt.eu>
Subject: Re: [PATCH] USB: input: wacom_sys.c: format OLED image in kernel
Date: Thu, 4 Oct 2012 09:15:19 +0100
Message-ID: <3b6f1beb0a048e1d02a7f684447c46b8.squirrel@webmail.firszt.eu>
References: <1347219438-2598-1-git-send-email-przemo@firszt.eu>
    <20121004072528.GD14217@core.coreip.homeip.net>
Reply-To: przemo@firszt.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121004072528.GD14217@core.coreip.homeip.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Przemo Firszt <przemo@firszt.eu>, rob@landley.net, pinglinux@gmail.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Dnia 4 Pa=BCdziernika 2012, 8:25 am, Cz, Dmitry Torokhov napisa=B3(a):
> Hi Przemo,
Hi Dmitry,
>
> On Sun, Sep 09, 2012 at 03:37:18PM -0400, Przemo Firszt wrote:
>> This patch adds a new way of handling Wacom Intuos4 family OLEDs.
>> Previously the images had to be 'scrambled' by userland application.=
 Now
>> the 'scrambling' is done in the kernel module, so user space can sen=
d
>> simple 64x32 pixels 4-bit grayscale (2 pixels per byte) 0,0 in top l=
eft
>> corner
>> images straight to a wacom OLED sysfs entry. An example:
>>
>> dd bs=3D1024 if=3Dimage_file \
>> of=3D/sys/bus/usb/drivers/wacom/[DevNo]/wacom_led/button[No]_formatt=
edimg
>> \
>> count=3D1
>>
>> This patch greatly simplifies user space preparation of the image.
>> The raw image sysfs enties are still present to avoid breaking API.
>
> I do not not believe that we should add code to the kernel for tasks =
that
> can be just as easily performed in userspace.
>
> Thanks!
>
> --
> Dmitry
>
OK, thanks for the explanation!

--=20
Regards,
Przemo Firszt

