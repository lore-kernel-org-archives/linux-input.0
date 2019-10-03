From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add input_get_poll_interval()
Date: Thu, 3 Oct 2019 11:57:37 -0700
Message-ID: <20191003185737.GC22365@dtor-ws>
References: <20191002215812.GA135681@dtor-ws>
 <CAO-hwJ+v1jJJ=APP__84SPrFdR+Te8nAxR6DirD8a9US_Bm4wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+v1jJJ=APP__84SPrFdR+Te8nAxR6DirD8a9US_Bm4wQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Thu, Oct 03, 2019 at 02:34:59PM -0400, Benjamin Tissoires wrote:
> Hi Dmitry,
> 
> On Wed, Oct 2, 2019 at 5:58 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Some drivers need to be able to know the current polling interval for
> > devices working in polling mode, let's allow them fetching it.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Not sure if you really need my input on this one, but, sure, looks good to me:
> Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!

I like for someone to have taken look at the stuff I write before I
commit it to the tree, and you are one of the most active developers in
linux-input, so I tend to copy you on random bits and pieces and I
really appreciate that you take time to check them out.

-- 
Dmitry
