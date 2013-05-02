From: Todd Showalter <todd@electronjump.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 16:30:01 -0400
Message-ID: <CAFmpkyg9WHn4Kt5mYUUmvR8HXZ+1=smcfqc0UHXArqaDTxVKoA@mail.gmail.com>
References: <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
	<CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
	<20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
	<CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
	<CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
	<CAFmpkyj+MV0+v8zKiKVAYX4uQHLv3jdCo=VR4nb=-M9NOUGYWg@mail.gmail.com>
	<20130502163824.GA28625@core.coreip.homeip.net>
	<CAFmpkyjO8WwUxOJ2BtULwOTcfYs7sjdWMS_=Fcho996VijEFHg@mail.gmail.com>
	<20130502182935.GD28625@core.coreip.homeip.net>
	<CAFmpkyhRSi5Q2uwsJ7eH6VYJ40zFzp2T6=6fFU9eU09dWkg0zA@mail.gmail.com>
	<20130502201807.GE28625@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:48484 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760667Ab3EBUaD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 16:30:03 -0400
Received: by mail-qa0-f44.google.com with SMTP id o13so4835qaj.17
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 13:30:02 -0700 (PDT)
In-Reply-To: <20130502201807.GE28625@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 2, 2013 at 4:18 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> No, I do not think so. Kernel provides a level of abstraction, but so
> does X, ALSA, given desktop environment and so forth. If a task does not
> require hardware access (and translating input events form one type to
> another does not) one should think really hard whether it should be
> done in kernel.

    What's the scope of acceptable changes in-kernel?  I'd like to fix
as much of this as possible in the kernel; if the rest has to happen
in a library, so be it.

    Would you be open to considering some sort of ioctl() that exports
a mapping table?  The PS3 controller mappings are completely wonky,
and even the xbox and xbox 360 controllers are less than ideal.  If we
could pull a mapping table out of the dev node at least it would let
us fix the common cases.

                                      Todd.

--
 Todd Showalter, President,
 Electron Jump Games, Inc.
