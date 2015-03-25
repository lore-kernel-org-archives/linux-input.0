From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics: min_max quirk for Thinkpad E440
Date: Wed, 25 Mar 2015 10:22:12 -0700
Message-ID: <20150325172212.GB40952@dtor-ws>
References: <1427246428-7070-1-git-send-email-filipayazi@gmail.com>
 <CADscph30SsHY-UxzzixGamALzapbwQ9LoR+az8iYm58jpQxwjw@mail.gmail.com>
 <CAO7PdF_rBe1UjP3wkxhk5xh80GFFsDceGcEmWNod0zNhrQ=HkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO7PdF_rBe1UjP3wkxhk5xh80GFFsDceGcEmWNod0zNhrQ=HkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ramiro Morales <cramm0@gmail.com>
Cc: linux-kernel@vger.kernel.org, Daniel Martin <consume.noise@gmail.com>, Filip Ayazi <filipayazi@gmail.com>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 25, 2015 at 09:57:51AM -0300, Ramiro Morales wrote:
> On Wed, Mar 25, 2015 at 6:04 AM, Daniel Martin <consume.noise@gmail.com> wrote:
> > On 25 March 2015 at 02:20, Filip Ayazi <filipayazi@gmail.com> wrote:
> >> Sets min_max_quirk values for LEN2006 touchpad found in Lenovo Thinkpad E440
> >> (board_id=2691).
> >
> > Dmitry already applied a patch for the E440:
> >     http://www.spinics.net/lists/linux-input/msg37497.html
> 
> There are two great things about this second submission from Filip.
> 
> First, it confirms the values sent by the hardware in a second laptop
> as reported by touchpad-edge-detector.
> 
> Second, it reveals I made a stupid mistake transcribing the y_max
> value to the quirks able. The correct value is 4832 and my patch
> wrongly contains 4632.
> 
> I'm very sorry for this. I see my patch has already been pushed to the
> 'for-linus' branch and I don't know which process should we follow to
> fix the issue.

My 'for-linus' branch is stable so we need a fixup on top on the
incorrect patch, the same way as if it was already in mainline.

Thanks.

-- 
Dmitry
