From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 0/3] Input/HID: joydev fixes for motion sensors
Date: Wed, 23 Aug 2017 11:08:02 +0200
Message-ID: <1503479282.24498.20.camel@hadess.net>
References: <20170818020156.23390-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:39581 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753572AbdHWJMl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 05:12:41 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 2E79F497294
        for <linux-input@vger.kernel.org>; Wed, 23 Aug 2017 11:08:06 +0200 (CEST)
In-Reply-To: <20170818020156.23390-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-17 at 19:01 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
<snip>
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
> property INPUT_PROP_COMPOSITE to determine this. I think having such
> flag is beneficial for userspace as well, since applications now get
> a hint
> that a device is part of a composite device without having to infer
> this from a EVIOCGPHYS / EVIOCGUINIQ match across devices.
> 
> Hopefully this patches will be accepted for 4.14, but maybe earlier
> if
> still possible as the next wave of distributions will likely be on
> 4.13
> with more users dealing with this issue.

FWIW, in iio-sensor-proxy, we'd probably be more interested in knowing
that the accelerometer is external to the machine, inside an external
device, than to know it's part of a "multi-device device", as most
sensors already are part of blocks containing other sensors such as
gyro, compass, etc.
