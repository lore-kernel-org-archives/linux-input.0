From: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 2/7] [media] doc-rst: switch to new names for Full
 Screen/Aspect keys
Date: Thu, 21 Mar 2019 09:20:07 -0300
Message-ID: <20190321092007.3eb2fd2a@coco.lan>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
        <20190118233037.87318-2-dmitry.torokhov@gmail.com>
        <20190218072606.GG242714@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218072606.GG242714@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Em Sun, 17 Feb 2019 23:26:06 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> On Fri, Jan 18, 2019 at 03:30:32PM -0800, Dmitry Torokhov wrote:
> > We defined better names for keys to activate full screen mode or
> > change aspect ratio (while keeping the existing keycodes to avoid
> > breaking userspace), so let's use them in the document.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  Documentation/media/uapi/rc/rc-tables.rst | 4 ++--  
> 
> Mauro, do you want to take this through your tree or I should pick it up
> with the patch that does renames in uapi header?

Feel free to apply it via your tree. It probably makes sense to keep it
with the series that add the new codes.

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> Thanks!
> 
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/media/uapi/rc/rc-tables.rst b/Documentation/media/uapi/rc/rc-tables.rst
> > index c8ae9479f842..57797e56f45e 100644
> > --- a/Documentation/media/uapi/rc/rc-tables.rst
> > +++ b/Documentation/media/uapi/rc/rc-tables.rst
> > @@ -616,7 +616,7 @@ the remote via /dev/input/event devices.
> >  
> >      -  .. row 78
> >  
> > -       -  ``KEY_SCREEN``
> > +       -  ``KEY_ASPECT_RATIO``
> >  
> >         -  Select screen aspect ratio
> >  
> > @@ -624,7 +624,7 @@ the remote via /dev/input/event devices.
> >  
> >      -  .. row 79
> >  
> > -       -  ``KEY_ZOOM``
> > +       -  ``KEY_FULL_SCREEN``
> >  
> >         -  Put device into zoom/full screen mode
> >  
> > -- 
> > 2.20.1.321.g9e740568ce-goog
> >   
> 



Thanks,
Mauro
