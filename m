From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Wed, 11 Oct 2017 15:30:28 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710111529360.14384@jbgna.fhfr.qr>
References: <20171010041631.22093-1-wnhuang@google.com> <20171010065740.GA22909@mars.bitmath.org> <CAE_wzQ_jPP54_1GgEuPZWHjs57=owTTP35ygO6dafYmxgDZYPQ@mail.gmail.com> <20171011085451.GG865@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011085451.GG865@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dtor@chromium.org>, Henrik Rydberg <rydberg@bitmath.org>, Wei-Ning Huang <wnhuang@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>
List-Id: linux-input@vger.kernel.org

On Wed, 11 Oct 2017, Benjamin Tissoires wrote:

> I am not sure if libinput even uses ABS_MT_ORIENTATION

I don't think it does, so that should be okay. However ...

> , but I'd go for fixing the documentation. And re-reading it, it's not 
> clear that the doc tells us to have [0,90]. It mentions negative values 
> and out of ranges too, so we might just as well simply clarify that we 
> rather have [-90,90], with 0 being "north".

... I'd like the documentation fix to go in together in one go with this 
patch if possible.

Thanks,

-- 
Jiri Kosina
SUSE Labs
