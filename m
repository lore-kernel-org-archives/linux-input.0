From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: private ioctls in input driver
Date: Mon, 28 Sep 2009 10:02:00 -0700
Message-ID: <20090928170200.GA21455@core.coreip.homeip.net>
References: <5d5443650909240451s17165707x6d3c7d3cf3228287@mail.gmail.com> <20090925040204.GD416@core.coreip.homeip.net> <5d5443650909250151h55b0eeefx7ce91f32bb287e3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39093 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbZI1RCH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2009 13:02:07 -0400
Received: by fxm18 with SMTP id 18so3825023fxm.17
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2009 10:02:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5d5443650909250151h55b0eeefx7ce91f32bb287e3b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Sep 25, 2009 at 02:21:40PM +0530, Trilok Soni wrote:
> Hi Dmitry,
> 
> On Fri, Sep 25, 2009 at 9:32 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Trilok,
> >
> > On Thu, Sep 24, 2009 at 05:21:09PM +0530, Trilok Soni wrote:
> >> Hi Dmitry,
> >>
> >> Is there any way of creating private ioctls in the input driver? I see
> >> that all the input framework handled
> >> by the framework itself and there is no way to call private ioctls if
> >> it doesn't match the standard ones.
> >>
> >
> > You are right, event devices only allow standard ioctl. What kind of
> > ictl are you considering? Normally device-specific controls are done via
> > sysfs attached to the parent device (see atkbd, psmouse, etc).
> 
> sysfs might good for purpose when you can associate one file per
> value, so for more data we can't simply create one file per the data.
> Say five fingers touch data (I know we have MT_* support but here it
> is just for example) , say id, x, y, z etc., per finger, then we can't
> create one file for each of them.

Maybe use configfs if sysfs is not suitable? I am not sure.

I would like to not-have driver-specific ioctls in evdev/input core but
rather keep them with device/driver itself. Input core should only have
stuff that makes sense for multiple devices.

-- 
Dmitry
