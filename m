From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH v5] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Wed, 29 Nov 2017 23:33:58 +0100
Message-ID: <fe447cdd-767e-0211-f20c-f1ce74a0841b@bitmath.org>
References: <20171012062143.39785-1-wnhuang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171012062143.39785-1-wnhuang@google.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Wei-Ning Huang <wnhuang@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Wei-Ning Huang <wnhuang@google.com>, dmitry.torokhov@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/12/2017 08:21 AM, Wei-Ning Huang wrote:
> From: Wei-Ning Huang <wnhuang@chromium.org>
>
> The current hid-multitouch driver only allow the report of two
> orientations, vertical and horizontal. We use the Azimuth orientation
> usage 0x3F under the Digitizer usage page to report orientation if the
> device supports it.
>
> Changelog:
>    v1 -> v2:
>     - Fix commit message.
>     - Remove resolution reporting for ABS_MT_ORIENTATION.
>    v2 -> v3:
>     - Fix commit message.
>    v3 -> v4:
>     - Fix ABS_MT_ORIENTATION ABS param range.
>     - Don't set ABS_MT_ORIENTATION in ABS_DG_HEIGHT when it is already
>       set by ABS_DG_AZIMUTH.
>    v4 -> v5:
>     - Improve multi-touch-protocol.rst documentation.
>
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>   Documentation/input/multi-touch-protocol.rst |  9 ++---
>   drivers/hid/hid-multitouch.c                 | 52 +++++++++++++++++++++++++---
>   include/linux/hid.h                          |  1 +
>   3 files changed, 54 insertions(+), 8 deletions(-)

    Reviewed-by: Henrik Rydberg <rydberg@bitmath.org>

Thank you, Wei-Ning, and sorry for the delay. Dmitry, did you plan to 
add this to your pull request already?

Henrik

