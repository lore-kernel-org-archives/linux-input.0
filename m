From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Wed, 29 Nov 2017 14:39:30 -0800
Message-ID: <20171129223930.3jmfafkqe3bqwms2@dtor-ws>
References: <20171012062143.39785-1-wnhuang@google.com>
 <fe447cdd-767e-0211-f20c-f1ce74a0841b@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33407 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdK2Wje (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 17:39:34 -0500
Content-Disposition: inline
In-Reply-To: <fe447cdd-767e-0211-f20c-f1ce74a0841b@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Wei-Ning Huang <wnhuang@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, Wei-Ning Huang <wnhuang@google.com>, corbet@lwn.net, linux-doc@vger.kernel.org

On Wed, Nov 29, 2017 at 11:33:58PM +0100, Henrik Rydberg wrote:
> On 10/12/2017 08:21 AM, Wei-Ning Huang wrote:
> > From: Wei-Ning Huang <wnhuang@chromium.org>
> > 
> > The current hid-multitouch driver only allow the report of two
> > orientations, vertical and horizontal. We use the Azimuth orientation
> > usage 0x3F under the Digitizer usage page to report orientation if the
> > device supports it.
> > 
> > Changelog:
> >    v1 -> v2:
> >     - Fix commit message.
> >     - Remove resolution reporting for ABS_MT_ORIENTATION.
> >    v2 -> v3:
> >     - Fix commit message.
> >    v3 -> v4:
> >     - Fix ABS_MT_ORIENTATION ABS param range.
> >     - Don't set ABS_MT_ORIENTATION in ABS_DG_HEIGHT when it is already
> >       set by ABS_DG_AZIMUTH.
> >    v4 -> v5:
> >     - Improve multi-touch-protocol.rst documentation.
> > 
> > Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> > Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> > Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> > ---
> >   Documentation/input/multi-touch-protocol.rst |  9 ++---
> >   drivers/hid/hid-multitouch.c                 | 52 +++++++++++++++++++++++++---
> >   include/linux/hid.h                          |  1 +
> >   3 files changed, 54 insertions(+), 8 deletions(-)
> 
>    Reviewed-by: Henrik Rydberg <rydberg@bitmath.org>
> 
> Thank you, Wei-Ning, and sorry for the delay. Dmitry, did you plan to add
> this to your pull request already?

This should go through Jiri's tree as it is all HID stuff.

Thanks.

-- 
Dmitry
