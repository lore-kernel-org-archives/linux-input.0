From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [RESEND PATCH V2 1/2] input: misc: da9063: OnKey driver
Date: Fri, 24 Apr 2015 18:53:39 +0200
Message-ID: <1429894419.2927.61.camel@x220>
References: <cover.1429272200.git.stwiss.opensource@diasemi.com>
	 <b9068c6e41a08b620c9e1674e17e508ab0d76d55.1429272200.git.stwiss.opensource@diasemi.com>
	 <1429343726.16771.129.camel@x220>
	 <6ED8E3B22081A4459DAC7699F3695FB7014B217581@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B217581@SW-EX-MBX02.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On Fri, 2015-04-24 at 13:45 +0000, Opensource [Steve Twiss] wrote:
> That seems to be a fairly common mistake in the kernel. 

It's an easy mistake to make. And as long as people pick an ident that
passes license_is_gpl_compatible() the module will build and load just
fine.

> When I did a
> straw-poll,  around 10% of files came up with "GPL v2" and contained
>  "any later version" text.

That seems plausible.

I'm inclined to think the difference between "GPL" and "GPL v2" is
mainly an accident of history (see https://lkml.org/lkml/2015/3/11/188
for some background). But apparently were stuck with these two idents.
Anyhow, in the last two months I've not come up with a better plan than
regularly check patches for mismatches like the one you made. If you
have a better idea, I'll be all ears.

Thanks,


Paul Bolle
