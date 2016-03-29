From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to debug?
Date: Tue, 29 Mar 2016 12:21:59 +0200
Message-ID: <CAM4jgCo9a-6ati0tQWCZqBRyxM6E6NrQK6Cj0uGQAogCRMgrOA@mail.gmail.com>
References: <56F82C42.6020002@m-reimer.de>
	<CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
	<56F8F107.3050906@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37085 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbcC2KWG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 06:22:06 -0400
Received: by mail-ig0-f172.google.com with SMTP id l20so10770548igf.0
        for <linux-input@vger.kernel.org>; Tue, 29 Mar 2016 03:22:06 -0700 (PDT)
In-Reply-To: <56F8F107.3050906@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

2016-03-28 10:53 GMT+02:00 Manuel Reimer <mail+linux-input@m-reimer.de>=
:
> On 03/27/2016 09:11 PM, Cl=C3=A9ment VUCHENER wrote:
>>
>> Check the value of errno just after the failed call (and use strerro=
r
>> to get a nice error message).
>
>
> See the following output of my test program
>
>
> UI_FF_UPLOAD start
> UI_FF_UPLOAD middle
> first ioctl failed -1 Inappropriate ioctl for device
> second ioctl failed -1 Inappropriate ioctl for device
> UI_FF_UPLOAD end
>
>
>> You also need to check the event code, it must be UI_FF_UPLOAD.
>
>
>
>     else if (event.type =3D=3D EV_UINPUT) {
>       printf("EV_UINPUT %d\n", event.code);
>       if (event.code =3D=3D UI_FF_UPLOAD) {
>         printf("UI_FF_UPLOAD start\n");
>         struct uinput_ff_upload upload;
>         memset(&upload, 0, sizeof(upload));
>
>         upload.request_id =3D event.value;
>
>         printf("UI_FF_UPLOAD middle\n");mulitple
>         int ret;
>         ret =3D ioctl(args->fduinput, UI_BEGIN_FF_UPLOAD, &upload);
>         if (ret < 0) {
>           printf("first ioctl failed %d %s\n", ret, strerror(errno));
>         }
>
>         // Remember ID and motor values for playback
>         if (upload.effect.type =3D=3D FF_RUMBLE) {
>           effect_id =3D upload.effect.id;
>           strong =3D upload.effect.u.rumble.strong_magnitude;
>           weak =3D upload.effect.u.rumble.weak_magnitude;
>           printf("Effect uploaded\n");
>         }
>
>         ret =3D ioctl(args->fduinput, UI_END_FF_UPLOAD, &upload);
>         if (ret < 0) {
>           printf("second ioctl failed %d %s\n", ret, strerror(errno))=
;
>         }
>         printf("UI_FF_UPLOAD end\n");
>       }
>       else if (event.code =3D=3D UI_FF_ERASE) {
>         struct uinput_ff_erase erase;
>         memset(&erase, 0, sizeof(erase));
>
>         erase.request_id =3D event.value;
>
>         // Doesn't make sense to actually erase something...
>         ioctl(args->fduinput, UI_BEGIN_FF_ERASE, &erase);
>         ioctl(args->fduinput, UI_END_FF_ERASE, &erase);
>         printf("Event erased\n");
>       }
>     }
>

This looks fine to me (maybe you should make sure upload.retval is
correctly set before calling UI_END_FF_UPLOAD, but that is not related
to your problem).

>
> I report that my device only supports one effect at once. My idea was=
 that I
> maybe try to get ff-memless connected to uinput at a later time to ma=
ke it
> emulate the common "memless configuration" used by the kernel and ope=
rate my
> one-effect-rumble-only device.
>
> The above code works well as long as nothing was sent out to the open=
 uinput
> file descriptor.
>
> As soon as I press a button on my USB input device, it "wakes up" and=
 sends
> out information even if no button is pressed. This information is als=
o
> forwarded to uinput, so from this point on there is a regular informa=
tion
> stream from my code to the uinput module.
>
> Maybe I have to add that I run dual-threaded. The above code is from =
my
> "reception thread". The sending runs on a separate "sending thread".
>
> Did I currently find out that uinput is not multithread-safe?

I am using uinput with multiple threads without problems (one in a
reading loop like yours, others writing events). You must be doing
something wrong with that file descriptor in that other thread.

>
> Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
