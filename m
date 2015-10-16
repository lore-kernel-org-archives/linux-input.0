From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
Date: Fri, 16 Oct 2015 12:21:55 +0200
Message-ID: <20151016102155.GD31612@pd.tnic>
References: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com>
 <20151016085808.GA32193@pd.tnic>
 <CAKT61h95dJjXUx9cp5kCqOvsEMQBbYZqhnoUfQbf1bJqVKi7jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52057 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbbJPKWD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2015 06:22:03 -0400
Content-Disposition: inline
In-Reply-To: <CAKT61h95dJjXUx9cp5kCqOvsEMQBbYZqhnoUfQbf1bJqVKi7jQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>, Huang Rui <ray.huang@amd.com>
Cc: Vincent Wan <Vincent.Wan@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Ray.Huang@amd.com

On Fri, Oct 16, 2015 at 05:35:40PM +0800, Wan ZongShun wrote:
> 2015-10-16 16:58 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> > On Fri, Oct 16, 2015 at 09:27:00AM -0400, Vincent Wan wrote:
> >> Detecting platform supports i8042 or not, AMD resorted to
> >> BIOS's FADT i8042 flag.
> >>
> >> Signed-off-by: Vincent Wan <Vincent.Wan@amd.com>
> >> ---
> >>  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> 
> >>  /*
> >> @@ -1047,6 +1048,11 @@ static int __init i8042_platform_init(void)
> >>       /* Just return if pre-detection shows no i8042 controller exist */
> >>       if (!x86_platform.i8042_detect())
> >>               return -ENODEV;
> >> +
> >> +     if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> >
> > Why the vendor check if you're accessing a bit defined in the ACPI spec?
> 
> From intel's 'x86_platform.i8042_detect' implementation, I doubt if
> their BIOS is providing this i8024 flag.

Why would you doubt that - it is at least in ACPI v4, if not earlier. If
you still doubt that, go and check it or ask Intel people.

> So I have to implement my codes carefully.

What are you people talking about?!

It is in the ACPI spec - this bit is either set or not. If it is not
set, then that's a problem. But then it is the problem of this one BIOS.
Vendor checks have nothing to do in vendor-agnostic code.

Besides, there's intel_mid_i8042_detect() which is platform-specific and
Intel can supply a specific ->detect() function if, in the very distant
chance, they don't implement that bit.

Still no need for a vendor check!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
