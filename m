From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
Date: Sat, 17 Oct 2015 09:38:47 -0700
Message-ID: <20151017163847.GB13470@dtor-ws>
References: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com>
 <20151016085808.GA32193@pd.tnic>
 <CAKT61h95dJjXUx9cp5kCqOvsEMQBbYZqhnoUfQbf1bJqVKi7jQ@mail.gmail.com>
 <20151016102155.GD31612@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35194 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbbJQQiv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 12:38:51 -0400
Content-Disposition: inline
In-Reply-To: <20151016102155.GD31612@pd.tnic>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Wan ZongShun <mcuos.com@gmail.com>, Huang Rui <ray.huang@amd.com>, Vincent Wan <Vincent.Wan@amd.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, Oct 16, 2015 at 12:21:55PM +0200, Borislav Petkov wrote:
> On Fri, Oct 16, 2015 at 05:35:40PM +0800, Wan ZongShun wrote:
> > 2015-10-16 16:58 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> > > On Fri, Oct 16, 2015 at 09:27:00AM -0400, Vincent Wan wrote:
> > >> Detecting platform supports i8042 or not, AMD resorted to
> > >> BIOS's FADT i8042 flag.
> > >>
> > >> Signed-off-by: Vincent Wan <Vincent.Wan@amd.com>
> > >> ---
> > >>  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
> > >>  1 file changed, 6 insertions(+)
> > 
> > >>  /*
> > >> @@ -1047,6 +1048,11 @@ static int __init i8042_platform_init(void)
> > >>       /* Just return if pre-detection shows no i8042 controller exist */
> > >>       if (!x86_platform.i8042_detect())
> > >>               return -ENODEV;
> > >> +
> > >> +     if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> > >
> > > Why the vendor check if you're accessing a bit defined in the ACPI spec?
> > 
> > From intel's 'x86_platform.i8042_detect' implementation, I doubt if
> > their BIOS is providing this i8024 flag.
> 
> Why would you doubt that - it is at least in ACPI v4, if not earlier. If
> you still doubt that, go and check it or ask Intel people.
> 
> > So I have to implement my codes carefully.
> 
> What are you people talking about?!
> 
> It is in the ACPI spec - this bit is either set or not. If it is not

Well, the fact that is is in a spec does not mean that vendors follow
it (and BTW I do not think that AMD as a CPU vendor can vouch for a
random notebook or desktop vendor that acquired and then hacked on some
version of some BIOS from some BIOS vendor so I agree that this check is
a no-go).

Historically we did not trust BIOS data with regard to i8042 on x86.
Maybe we should now using certain date cutoff (anything manufactured
past 201[2345?]).

Does Windows respect this flag? If it does then we could also trust it,
and not only on AMD but for all x86 CPUs.

Thanks.

-- 
Dmitry
