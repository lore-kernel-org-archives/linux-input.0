From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to
 debug?
Date: Mon, 28 Mar 2016 10:53:27 +0200
Message-ID: <56F8F107.3050906@m-reimer.de>
References: <56F82C42.6020002@m-reimer.de>
 <CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:34529 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbcC1JB6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Mar 2016 05:01:58 -0400
In-Reply-To: <CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Cl=c3=a9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 03/27/2016 09:11 PM, Cl=C3=A9ment VUCHENER wrote:
> Check the value of errno just after the failed call (and use strerror
> to get a nice error message).

See the following output of my test program


UI_FF_UPLOAD start
UI_FF_UPLOAD middle
first ioctl failed -1 Inappropriate ioctl for device
second ioctl failed -1 Inappropriate ioctl for device
UI_FF_UPLOAD end


> You also need to check the event code, it must be UI_FF_UPLOAD.


     else if (event.type =3D=3D EV_UINPUT) {
       printf("EV_UINPUT %d\n", event.code);
       if (event.code =3D=3D UI_FF_UPLOAD) {
         printf("UI_FF_UPLOAD start\n");
         struct uinput_ff_upload upload;
         memset(&upload, 0, sizeof(upload));

         upload.request_id =3D event.value;

         printf("UI_FF_UPLOAD middle\n");
         int ret;
         ret =3D ioctl(args->fduinput, UI_BEGIN_FF_UPLOAD, &upload);
         if (ret < 0) {
           printf("first ioctl failed %d %s\n", ret, strerror(errno));
         }

         // Remember ID and motor values for playback
         if (upload.effect.type =3D=3D FF_RUMBLE) {
           effect_id =3D upload.effect.id;
           strong =3D upload.effect.u.rumble.strong_magnitude;
           weak =3D upload.effect.u.rumble.weak_magnitude;
           printf("Effect uploaded\n");
         }

         ret =3D ioctl(args->fduinput, UI_END_FF_UPLOAD, &upload);
         if (ret < 0) {
           printf("second ioctl failed %d %s\n", ret, strerror(errno));
         }
         printf("UI_FF_UPLOAD end\n");
       }
       else if (event.code =3D=3D UI_FF_ERASE) {
         struct uinput_ff_erase erase;
         memset(&erase, 0, sizeof(erase));

         erase.request_id =3D event.value;

         // Doesn't make sense to actually erase something...
         ioctl(args->fduinput, UI_BEGIN_FF_ERASE, &erase);
         ioctl(args->fduinput, UI_END_FF_ERASE, &erase);
         printf("Event erased\n");
       }
     }


I report that my device only supports one effect at once. My idea was=20
that I maybe try to get ff-memless connected to uinput at a later time=20
to make it emulate the common "memless configuration" used by the kerne=
l=20
and operate my one-effect-rumble-only device.

The above code works well as long as nothing was sent out to the open=20
uinput file descriptor.

As soon as I press a button on my USB input device, it "wakes up" and=20
sends out information even if no button is pressed. This information is=
=20
also forwarded to uinput, so from this point on there is a regular=20
information stream from my code to the uinput module.

Maybe I have to add that I run dual-threaded. The above code is from my=
=20
"reception thread". The sending runs on a separate "sending thread".

Did I currently find out that uinput is not multithread-safe?

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
