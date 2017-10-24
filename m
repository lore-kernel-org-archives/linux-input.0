From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usb/input/gtco: slab-out-of-bounds in parse_hid_report_descriptor
Date: Mon, 23 Oct 2017 22:30:05 -0700
Message-ID: <20171024053005.gleghx4szbdfoj63@dtor-ws>
References: <CAAeHK+zkQKsWwPd0CSLdwudL2tR_Z=iXniNdu_L+YtkyUcGceg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAeHK+zkQKsWwPd0CSLdwudL2tR_Z=iXniNdu_L+YtkyUcGceg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 23, 2017 at 01:24:23PM +0200, Andrey Konovalov wrote:
> Hi!
> 
> I've got the following report while fuzzing the kernel with syzkaller.
> 
> On commit 3e0cc09a3a2c40ec1ffb6b4e12da86e98feccb11 (4.14-rc5+).
> 
> parse_hid_report_descriptor() has a while (i < length) loop, which
> only guarantees that there's at least 1 byte in the buffer, but the
> loop body can read multiple bytes which causes out-of-bounds access.

Ugh, this whole driver should be moved over to HID, but I am not sure
who has hardware to test... I just sent a patch plugging this hole.

Thanks for the report.

-- 
Dmitry
