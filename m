From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] Input: wacom - add support for three new Intuos devices
Date: Fri, 4 Oct 2013 11:15:59 -0700
Message-ID: <CAF8JNhJk7OJs3mnLt+XHfmF6G-6skpMF4Mr00rQNswk3UG2Prw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:59025 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3JDSQB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Oct 2013 14:16:01 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so3517602lab.40
        for <linux-input@vger.kernel.org>; Fri, 04 Oct 2013 11:15:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

On Fri, Oct 4, 2013 at 9:47 AM, Jason Gerecke <killertofu@gmail.com> wrote:
>
> On Thu, Oct 3, 2013 at 2:54 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thursday, October 03, 2013 01:53:10 PM Ping Cheng wrote:
> >> This series of models added a hardware switch to turn touch
> >> data on/off. To report the state of the switch, SW_TOUCH_ENABLED
> >> is added in include/uapi/linux/input.h.
> >
> >
> > Hmm, should we just postpone creating of input device until touch is enabled
> > instead?
> >
> > --
> > Dmitry
> > --
>
> The idea of SW_TOUCH_ENABLED is to allow userspace to be a bit more
> helpful and display a "disabled" message rather than disappearing the
> device entirely when the switch is 'off'. In theory this could also be
> achieved through the libwacom support library (by scanning the list of
> event devices to see if any of the expected interfaces are missing),
> but the approach is somewhat fragile and I'm not convinced that
> linking the switch to device creation/removal is correct.


Good point, Jason. I thought Dmitry suggested to have SW_TOUCH_ENABLED
accepted before adding new devices. My misunderstanding did bring nice
feedbacks from Chris and Peter. Thank you guys.

Dmitry,

If you meant to check the status of the touch switch before creating
touch interface, that would also mean we need to delete the interface
if the switch is turned off. Otherwise, we are not supporting it
consistently. However, the switch is only an indicator of whether
tablet will post touch events or not. The actual touch device is not
removed. It is always there and connected to the system no matter what
state the switch is in. So, dynamically creating and removal of touch
interface can complicate user land support.

Does this make sense to you?

Ping
