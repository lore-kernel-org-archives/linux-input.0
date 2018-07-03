From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: debug: check length before copy_to_user()
Date: Tue, 3 Jul 2018 11:55:48 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1807031155040.2273@cbobk.fhfr.pm>
References: <20180702235937.111619-1-drosen@google.com> <CAO-hwJLocBwuS7TGaXW88B-V8xSheATNDuvobv-Vk+hU0hei0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJLocBwuS7TGaXW88B-V8xSheATNDuvobv-Vk+hU0hei0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Daniel Rosenberg <drosen@google.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, kernel-team@android.com, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 3 Jul 2018, Benjamin Tissoires wrote:

> > If our length is greater than the size of the buffer, we
> > overflow the buffer
> >
> > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> 
> Looks good:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Indeed, thanks a lot for fixing this. Now queued, I'll push it for 4.18.

-- 
Jiri Kosina
SUSE Labs
