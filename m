From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v5] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Fri, 1 Dec 2017 10:01:56 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1712011001320.11505@cbobk.fhfr.pm>
References: <20171012062143.39785-1-wnhuang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20171012062143.39785-1-wnhuang@google.com>
Sender: linux-doc-owner@vger.kernel.org
To: Wei-Ning Huang <wnhuang@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Henrik Rydberg <rydberg@bitmath.org>, Wei-Ning Huang <wnhuang@google.com>, dmitry.torokhov@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 12 Oct 2017, Wei-Ning Huang wrote:

> From: Wei-Ning Huang <wnhuang@chromium.org>
> 
> The current hid-multitouch driver only allow the report of two
> orientations, vertical and horizontal. We use the Azimuth orientation
> usage 0x3F under the Digitizer usage page to report orientation if the
> device supports it.
> 
> Changelog:
>   v1 -> v2:
>    - Fix commit message.
>    - Remove resolution reporting for ABS_MT_ORIENTATION.
>   v2 -> v3:
>    - Fix commit message.
>   v3 -> v4:
>    - Fix ABS_MT_ORIENTATION ABS param range.
>    - Don't set ABS_MT_ORIENTATION in ABS_DG_HEIGHT when it is already
>      set by ABS_DG_AZIMUTH.
>   v4 -> v5:
>    - Improve multi-touch-protocol.rst documentation.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>

This is now queued in for-4.16/hid-quirks-cleanup/multitouch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

