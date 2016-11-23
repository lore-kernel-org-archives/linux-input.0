From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH 4/8] HID: sony: Report DS4 motion sensors through a
 separate device
Date: Wed, 23 Nov 2016 16:17:44 -0700
Message-ID: <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
    <1479938833-26424-5-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:38386 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933571AbcKWXRs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 18:17:48 -0500
In-Reply-To: <1479938833-26424-5-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, November 23, 2016 3:07 pm, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>
>
> The DS4 motion sensors are currently mapped by the hid-core driver
> to non-existing axes in between ABS_MISC and ABS_MT_SLOT, because the
> device already exhausted ABS_X-ABS_RZ. For a part the mapping by hid-core
> is accomplished by a fixup in hid-sony as the motion axes actually use
> vendor specific usage pages.

We probably all agree that sending Acc/Gyro data across the joystick
interface is not the best thing in the world, so I would have some doubts
about whether spinning up another separate interface is quite the 'correct
thing' either.

A while back I did some 'tinkering' on the SixAxis to see if 'we' could
use the IIO interface to report accelerometer data.
https://patchwork.kernel.org/patch/6589061/

I think that the timestamps are critical to get correct interpretation of
the data, and note that PS Move and PS VR both return multiple sets of
acc/gyro data in a single HID report.

>
> This patch makes the DS4 use a separate input device for the motion
> sensors and reports acceleration data through ABS_X-ABS_Z and gyroscope
> data through ABS_RX-ABS_RZ. In addition it extends the event spec to allow
> gyroscope data through ABS_RX-ABS_RZ when INPUT_PROP_ACCELEROMETER is set.
> This change was suggested by
> Peter Hutterer during a discussion on linux-input.

Do you have a link?

Also, can you confirm whether this change would break '/dev/hidrawX', I
know a number of projects that read that directly to do their thing.

Thanks,
Simon.

