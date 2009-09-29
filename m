From: Barry Song <21cnbao@gmail.com>
Subject: Re: private ioctls in input driver
Date: Tue, 29 Sep 2009 10:50:15 +0800
Message-ID: <3c17e3570909281950q3a391cb6ld33ec69af765549d@mail.gmail.com>
References: <5d5443650909240451s17165707x6d3c7d3cf3228287@mail.gmail.com>
	<20090925040204.GD416@core.coreip.homeip.net> <5d5443650909250151h55b0eeefx7ce91f32bb287e3b@mail.gmail.com>
	<20090928170200.GA21455@core.coreip.homeip.net> <5d5443650909281005u37503ab0rc6b62effe73f8046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:40701 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbZI2Cub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2009 22:50:31 -0400
Received: by gxk4 with SMTP id 4so3373069gxk.8
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2009 19:50:35 -0700 (PDT)
In-Reply-To: <5d5443650909281005u37503ab0rc6b62effe73f8046@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org

On Tue, Sep 29, 2009 at 1:05 AM, Trilok Soni <soni.trilok@gmail.com> wr=
ote:
>
> Hi Dmitry,
>
> On Mon, Sep 28, 2009 at 10:32 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Fri, Sep 25, 2009 at 02:21:40PM +0530, Trilok Soni wrote:
> >> Hi Dmitry,
> >>
> >> On Fri, Sep 25, 2009 at 9:32 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > Hi Trilok,
> >> >
> >> > On Thu, Sep 24, 2009 at 05:21:09PM +0530, Trilok Soni wrote:
> >> >> Hi Dmitry,
> >> >>
> >> >> Is there any way of creating private ioctls in the input driver=
? I see
> >> >> that all the input framework handled
> >> >> by the framework itself and there is no way to call private ioc=
tls if
> >> >> it doesn't match the standard ones.
> >> >>
> >> >
> >> > You are right, event devices only allow standard ioctl. What kin=
d of
> >> > ictl are you considering? Normally device-specific controls are =
done via
> >> > sysfs attached to the parent device (see atkbd, psmouse, etc).
> >>
> >> sysfs might good for purpose when you can associate one file per
> >> value, so for more data we can't simply create one file per the da=
ta.
> >> Say five fingers touch data (I know we have MT_* support but here =
it
> >> is just for example) , say id, x, y, z etc., per finger, then we c=
an't
> >> create one file for each of them.
> >
> > Maybe use configfs if sysfs is not suitable? I am not sure.
> >
> > I would like to not-have driver-specific ioctls in evdev/input core=
 but
> > rather keep them with device/driver itself. Input core should only =
have
> > stuff that makes sense for multiple devices.
>
> I mean on the similar line only, we won't add any driver-specific
> ioctls in evdev/input core, but just transfer their control to resp.
> device/driver itself, may be similar in the line of how v4l2 does.
Sometimes, we really have this kind of requirement. Now there are more
and more kinds of input devices. Some devices have special controls
which should not belong to generic input layer. How about add a case
item in  evdev_do_ioctl() to handle these commands and call drivers'
ioctl directly?

>
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
