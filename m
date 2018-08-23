From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Date: Thu, 23 Aug 2018 11:42:19 -0700
Message-ID: <20180823184219.GA53155@dtor-ws>
References: <20180823183057.247630-1-hcutts@chromium.org>
 <20180823183057.247630-2-hcutts@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180823183057.247630-2-hcutts@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jiri.kosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 23, 2018 at 11:30:55AM -0700, Harry Cutts wrote:
> This event code represents scroll reports from high-resolution wheels,
> and will be used by future patches in this series. See the linux-input
> "Reporting high-resolution scroll events" thread [0] for more details.
> 
> [0]: https://www.spinics.net/lists/linux-input/msg57380.html
> 
> Signed-off-by: Harry Cutts <hcutts@chromium.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Jiri, Benjamin, feel free to merge through HID tree if the rest is
acceptable.

Thanks.

-- 
Dmitry
