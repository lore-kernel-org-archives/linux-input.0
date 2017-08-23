From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 0/3] Input/HID: joydev fixes for motion sensors
Date: Wed, 23 Aug 2017 11:04:52 +0200
Message-ID: <1503479092.24498.18.camel@hadess.net>
References: <20170818020156.23390-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44941 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753613AbdHWJE4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 05:04:56 -0400
In-Reply-To: <20170818020156.23390-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-17 at 19:01 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Hi,
> 
> Some weeks ago we submitted an earlier version of this patch set,
> which attempted to blacklist dualshock 3 / 4 motion sensor devices
> from joydev. The motion sensor devices got picked up since the hid-
> sony
> driver in recent months split the motion sensors of in separate
> devices.
> 
> The earlier version of this patch set, added a filter to joydev to
> ignore devices which have INPUT_PROP_ACCELEROMETER set. Dmitry
> pointed
> out that often you could use a motion sensor device as a joystick. He
> felt the issue is with composite devices.
> 
> The discussion didn't result in a conclusion. This patch set only
> filters out motion sensors if they are part of a composite device.
> Since there is no way during driver initialization to determine
> whether we are dealing with a composite device, we introduce a new
> property INPUT_PROP_COMPOSITE to determine this.

Would have a way to know how many pieces make up that composite device
be useful?

> I think having such
> flag is beneficial for userspace as well, since applications now get
> a hint
> that a device is part of a composite device without having to infer
> this from a EVIOCGPHYS / EVIOCGUINIQ match across devices.

Not that much, udev already does all that for user-space.

> Hopefully this patches will be accepted for 4.14, but maybe earlier
> if
> still possible as the next wave of distributions will likely be on
> 4.13
> with more users dealing with this issue.

I'm not sure I fully understand the problem you're trying to solve.

Is it "old software which relies on joydev is too basic to allow
selecting the correct joystick device"? Or "some system components are
picking up the joypad's accelerometer like it inferred the screen's
positioning"?

Cheers
