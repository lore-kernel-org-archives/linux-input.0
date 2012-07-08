From: Cedric Sodhi <manday@gmx.net>
Subject: Re: Regression in hid-multitouch?
Date: Sun, 8 Jul 2012 23:19:58 +0200
Message-ID: <20120708211958.GA9260@engine.Speedport_W723_V_Typ_A_1_00_092>
References: <20120707215541.GB2484@slate.Speedport_W723_V_Typ_A_1_00_092>
 <20120707224832.GA2074@slate.Speedport_W723_V_Typ_A_1_00_092>
 <CAN+gG=Ewk-wNszs+iaiQ+v31QMbrGom+fjN4WoCeA2o++sRxww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:43310 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752431Ab2GHVQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Jul 2012 17:16:39 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=Ewk-wNszs+iaiQ+v31QMbrGom+fjN4WoCeA2o++sRxww@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: linux-input@vger.kernel.org

On Sat, Jul 07, 2012 at 08:26:01PM +0200, Benjamin Tissoires wrote:
> Hi Cedric,
> 
> I'm a little bit lost there. You still have the same problems than the
> one described in the thread in xorg-devel? I don't get the "though the
> touchpoints are correctly recognized"...

Hello Benjamin,

yes, the same problems as described on xorg-devel - For instance when I
single click somewhere, I get behaviour similar to if I had dragged.
I've posted to Xorg-devel

http://www.mail-archive.com/xorg-devel@lists.x.org/msg31772.html ff.

I'm now partly convinced this is a bug in X.org/evdev, as I said there.

If I change my mind, I'll sure let you know ;)

In the meantime, if you still like the dmesg, etc., let me know. As for
which kernel version I get the bug on, it's on all kernels. The
touchpoint bug was successfully fixed by your commit and did *not*
return. Everything seems to be all right on the kernel's side of things.

best regards,
Cedric

> 
> Can you send us your dmesg output and the trace from evtest?
> I also would like to know which kernel version is working and which is not.
> 
> Thanks,
> Benjamin
> 
> On Sun, Jul 8, 2012 at 12:48 AM, Cedric Sodhi <manday@gmx.net> wrote:
> > Sorry, this is not a regression. I just reverted to said commit and I
> > still have those problems (described in detail, here:
> >
> > http://comments.gmane.org/gmane.comp.freedesktop.xorg.devel/31159
> >
> > - though the touchpoints are correctly recognized).
> >
> > On Sat, Jul 07, 2012 at 11:55:41PM +0200, Cedric Sodhi wrote:
> >> What previously seems to have been fixed by
> >>
> >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=3ac36d15557d1bedfb1151d9911b9587b2d40759
> >>
> >> has again stopped working in 3.5.0-rc5 - at least I get the exact same
> >> problems I used to have before 3ac36d... although the code from 3ac36d
> >> is still there.
> >>
> >> regards,
> >> Cedric
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
