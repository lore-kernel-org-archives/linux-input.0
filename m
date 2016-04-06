From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] HID: simplify implement() a bit
Date: Wed, 6 Apr 2016 14:31:18 -0700
Message-ID: <CAD=FV=UuiHGEeAq_265tBK0vmeZcdFcfs+Z7R54m=JcmmW-zAA@mail.gmail.com>
References: <20160406171958.GA39482@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33640 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbcDFVbU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2016 17:31:20 -0400
Received: by mail-vk0-f44.google.com with SMTP id k1so75632745vkb.0
        for <linux-input@vger.kernel.org>; Wed, 06 Apr 2016 14:31:19 -0700 (PDT)
In-Reply-To: <20160406171958.GA39482@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dmitry,

On Wed, Apr 6, 2016 at 10:19 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> The 'size' variable is not really needed, and we can also shift constant
> in the loop body when masking off existing bits.
>
> Also we do not have to us 64 bit calculations if we take an extra
> branch.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/hid/hid-core.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
