From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: evdev - get rid of old workaround for EVIOCGBIT
Date: Tue, 29 Apr 2014 10:06:57 +0200
Message-ID: <CANq1E4TF_LpG2bbTrB3dbQEVL+x4yKAtjoGEZw_t_9MmAYyFWw@mail.gmail.com>
References: <20140424052719.GA29764@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140424052719.GA29764@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Thu, Apr 24, 2014 at 7:27 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> We put this workaround in 2008 and the offending userspace has been fixed
> up long time ago; the link in the message is no longer valid either, so it
> is time to retire it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Yes, pleeeease!

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David
