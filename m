From: Jaikumar Ganesh <jaikumarg@android.com>
Subject: Re: [PATCH] HID: magicmouse: ignore 'ivalid report id' while
 switching modes
Date: Thu, 18 Aug 2011 12:45:54 -0700
Message-ID: <CAA8bQNgOZTqGMZhHF0MOm25ZUD5_G0i9F=rMsCOdiD3DYAWhTw@mail.gmail.com>
References: <1313611182-19924-1-git-send-email-jaikumarg@android.com>
 <4E4D3CFC.7000700@canonical.com> <CAA8bQNjQ2s4EY=2r455z-3r7yyV0uwSjhQ6m5g2+TCyMRvu0sQ@mail.gmail.com>
 <4E4D426F.607@canonical.com> <4E4D68B0.8000703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:52000 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab1HRTqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 15:46:17 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p7IJkGJW008808
	for <linux-input@vger.kernel.org>; Thu, 18 Aug 2011 12:46:16 -0700
Received: from gxk22 (gxk22.prod.google.com [10.202.11.22])
	by hpaq11.eem.corp.google.com with ESMTP id p7IJj9Eu005476
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Thu, 18 Aug 2011 12:46:14 -0700
Received: by gxk22 with SMTP id 22so2283395gxk.30
        for <linux-input@vger.kernel.org>; Thu, 18 Aug 2011 12:46:14 -0700 (PDT)
In-Reply-To: <4E4D68B0.8000703@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Chase:

On Thu, Aug 18, 2011 at 12:32 PM, Chase Douglas
<chase.douglas@canonical.com> wrote:
>
> On 08/18/2011 09:48 AM, Chase Douglas wrote:
> > On 08/18/2011 09:36 AM, Jaikumar Ganesh wrote:
> >> Hi Chase
> >>
> >> On Thu, Aug 18, 2011 at 9:25 AM, Chase Douglas
> >> <chase.douglas@canonical.com <mailto:chase.douglas@canonical.com>>=
 wrote:
> >>
> >> =A0 =A0 On 08/17/2011 12:59 PM, Jaikumar Ganesh wrote:
> >> =A0 =A0 > From: Jiri Kosina <jkosina@suse.cz <mailto:jkosina@suse.=
cz>>
> >> =A0 =A0 >
> >> =A0 =A0 > 23746a introduced this commit but was reverted in c3a492=
=2E
> >> =A0 =A0 > The trackpad uses report Ids which are not present in th=
e
> >> =A0 =A0 > report descriptor. These reports ids are not documented
> >> =A0 =A0 > anywhere. There are devices in the market (Apple magic t=
racpkad,
> >> =A0 =A0 > BT version 2.0 is one such device) with the same device =
id,
> >> =A0 =A0 > which fail when we use 0xd7 as the report id. So we need=
 the EIO
> >> =A0 =A0 > change of 23746a as a failsafe to work with these device=
s.
> >> =A0 =A0 >
> >> =A0 =A0 > Original Author: Jiri Kosina <jkosina@suse.cz
> >> =A0 =A0 <mailto:jkosina@suse.cz>>
> >> =A0 =A0 >
> >> =A0 =A0 > Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com
> >> =A0 =A0 <mailto:jaikumarg@android.com>>
> >>
> >> =A0 =A0 I worry this may just be papering over a bug elsewhere in =
the system
> >> =A0 =A0 again. I'm going to try to git bisect this today.
> >>
> >>
> >> The original commit explains in detail why it used to work before,=
 so
> >> its not a regression in that sense. The commit was present in 2.6.=
39
> >> stable tree too but was reverted in 3.0 tree.
> >
> > It was reverted because it was papering over a bug in the bluetooth
> > stack, and when that bug was fixed this commit broke things again.
> >
> > I've determined that there's a bug between Ubuntu's 3.0-1.2 and 3.0=
-2.3
> > kernels. There does not appear to be any Ubuntu specific patches th=
at
> > went in between those versions that would affect this, but there wa=
s a
> > rebase from upstream 3.0-rc3 to 3.0-rc4. There is likely a bug
> > introduced sometime in there.
> >
> > I'll be digging deeper...
>
> After some more digging I realized that the bluetooth fix for some
> devices went in at 3.0-rc4, just as the reversion of this patch went =
in.
> Thus, my bisect of ubuntu kernels was unhelpful.
>
> I decided to try a few tests:
>
> 3.0-rc0 kernel with the bluetooth fix and this patch reverted
> 2.6.39 kernel with the bluetooth fix (this patch was not committed ye=
t)
>
> Both failed to properly initialize the magic trackpad. The only
> conclusion I can come up with is that there are some hardware
> differences between the machine I am currently testing with, and the
> machine I previously had the magicmouse working with.
>
> If that's the case, the safest thing to do would be to apply this pat=
ch
> with a tweak. Don't check only that -EIO is returned. Check for eithe=
r
> success or -EIO is returned. This should allow good and bad behaving
> hardware to still function.

I also tracked down two Apple magic trackpads - both with the same
Bluetooth version.
One which needs this patch (as it returns an invalid report id) and
the other which doesn't need this patch.
Both use the same device id.

>
> Jiri, do you want me to send a rework of the patch, or do you want to=
 do
> it yourself?
>
> -- Chase
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
