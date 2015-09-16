From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [PATCH 2/3] devicetree: bindings: use input-event-codes.h for
 evdev codes
Date: Wed, 16 Sep 2015 15:40:43 +0100
Message-ID: <1442414443.18856.110.camel@hellion.org.uk>
References: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
	 <1442064372-3030-3-git-send-email-hdegoede@redhat.com>
	 <1442316292.3549.386.camel@hellion.org.uk> <55F97C3D.5020702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from benson.vm.bytemark.co.uk ([212.110.190.137]:60019 "EHLO
	benson.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbbIPOk6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2015 10:40:58 -0400
In-Reply-To: <55F97C3D.5020702@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Wed, 2015-09-16 at 10:27 -0400, Hans de Goede wrote:
> Hi,
> 
> On 09/15/2015 07:24 AM, Ian Campbell wrote:
> > On Sat, 2015-09-12 at 15:26 +0200, Hans de Goede wrote:
> > > Add a symlink to uapi/linux/input-event-codes.h, and include that
> > > instead
> > > of (re)defining all the evdev type and code values in
> > > dt-bindings/input/input.h. This way we do not need to keep all the
> > > event codes synced manually.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >   include/dt-bindings/input/input-event-codes.h |   1 +
> > >   include/dt-bindings/input/input.h             | 510 +--------------
> > > -----
> > > ------
> > >   2 files changed, 2 insertions(+), 509 deletions(-)
> > >   create mode 120000 include/dt-bindings/input/input-event-codes.h
> > > 
> > > diff --git a/include/dt-bindings/input/input-event-codes.h
> > > b/include/dt
> > > -bindings/input/input-event-codes.h
> > > new file mode 120000
> > > index 0000000..693bbcd
> > > --- /dev/null
> > > +++ b/include/dt-bindings/input/input-event-codes.h
> > > @@ -0,0 +1 @@
> > > +../../uapi/linux/input-event-codes.h
> > > \ No newline at end of file
> > 
> > Hrm, I think this is going to cause trouble for the split DT repository
> > at
> > https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-reba
> > sing.git/
> > 
> > Since ../../ == include in both trees I think I can make it work by
> > including include/uapi/linux in the conversion, either wholesale
> > (easiest)
> > or partially (potentially cleaner).
> > 
> > Any opinions on that?
> 
> The intend of the symlink was that the conversion script would copy the target,
> rather then follow the symlink. This sorta assumes that there are will be not
> symlinks under dt-bindings which link to files inside dt-bindings and thus
> should be preserved as symlinks.
> 
> If the copy done in the script will follow the symlink then nothing should
> really change for the split DT repo.

Interesting idea. I'll see if I can make the conversion routine do that.

TBH I have a horrid feeling that this is going to be beyond git rewrite
-branch, at least in the mode it is used in today.

> > In principal I ought to regenerate the tree from scratch such that
> > include/uapi/linux was "always" there and has history but I think we
> > can
> > live with it just appearing at some point in time wen the conversion
> > script
> > was updated?
> > 
> > AIUI these values are required to only be used with properties whose
> > names
> > are of the form "linux,*", otherwise there would be strong complaints
> > about
> > include Linux uapi stuff into a generic device-tree binding.
> 
> Correct, these values are only for linux,* properties, which is why I
> initially put them in a file named dt-bindings/input/linux-event-codes.h

I think that would be a better name for the symlink (but not the target of
that symlink) and usage in the .dts*, given it's (hopefully) going to turn
into a regular file in the exported repo.

Ian.
