From: Nick Crews <ncrews@chromium.org>
Subject: Re: [PATCH] HID: intel-ish-hid: ISH firmware loader client driver
Date: Wed, 27 Mar 2019 10:01:49 -0600
Message-ID: <CAHX4x86DKshGWj8D4nYje3fUvETG14jD4jNt+VgpejmzU2Dnog@mail.gmail.com>
References: <1553339772-25012-1-git-send-email-rushikesh.s.kadam@intel.com>
 <31755c704928710da998353192157ddfd903080c.camel@linux.intel.com>
 <CAHX4x87iQgjX8wHOYNCD7nYQJZKoirgCimPax11bMX_DGMEudw@mail.gmail.com> <de917efc4ded94b3fbc70913207881b3a0c10b52.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de917efc4ded94b3fbc70913207881b3a0c10b52.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>, benjamin.tissoires@redhat.com, jikos@kernel.org, jettrink@chromium.org, gwendal@google.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 26, 2019 at 8:22 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2019-03-26 at 18:39 -0600, Nick Crews wrote:
> > Hi Rushikesh, I know I've been reviewing this on Chromium, but I have
> > some more larges-scale design thoughts.
> Hi Nick.
>
> Does this fundamentally change, the way it is done here or can wait for
> subsequent revisions later?

I don't have any official stakes in this, as I'm not the maintainer or
anything, so
I'm just preaching what I think would be good design :)

I think I would like to see most of my suggestions addressed. At the
very least there
are some actual bugs (infinite loops, accessing bad memory, not
reporting all errors)
 that need to get fixed. Of course I'm not the one that has to write
or test it, but I imagine
that the one large design change I proposed of where memory is
allocated shouldn't be too
hard either. I worry that "subsequent revisions" to upstream won't
happen, since it's hard enough
to get a patch accepted. Maybe that concern isn't warranted though, I
don't have that
much experience on the LKML.

Is there a really tight deadline for this? If so then I would say we
should apply what
we currently have to the Chromium tree, and upstream the final version
when it's done.

Thanks,
Nick

>
> Thanks,
> Srinivas
>
