From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: usbhid: Add HID_QUIRK_NO_INIT_REPORTS for
 Oculus Rift CV1
Date: Thu, 8 Jun 2017 09:29:22 +0200
Message-ID: <20170608072922.GJ16591@mail.corp.redhat.com>
References: <20170607055435.25988-1-philipp.zabel@gmail.com>
 <20170607055435.25988-2-philipp.zabel@gmail.com>
 <20170607071100.GC16591@mail.corp.redhat.com>
 <CA+gwMccJqUfKdnyQfyaMWvBBY5rdZS_cmfy_j+Xem5KwX4PXKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+gwMccJqUfKdnyQfyaMWvBBY5rdZS_cmfy_j+Xem5KwX4PXKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, linux-usb <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Jun 08 2017 or thereabouts, Philipp Zabel wrote:
> Hi Benjamin,
> 
> On Wed, Jun 7, 2017 at 9:11 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > Hi Philip,
> >
> > On Jun 07 2017 or thereabouts, Philipp Zabel wrote:
> [...]
> > 2 things:
> > - the 2 patches should be squashed together. There is no point having a
> >   single patch for just 2 defines not used anywhere else.
> > - I believe you don't even need this quirk in the development version of
> >   the hid tree. Would you mind trying a plain v4.12-rcX and report if
> >   you still need the quirk?
> 
> Thanks, you are right. I just checked on v4.12-rc4 and now it works without
> the quirk. Sorry for the noise.

No worries. It's always interesting to know that we introduced a patch
that actually fixes hardware :)

So thanks for the report and the attempt :)

Cheers,
Benjamin
