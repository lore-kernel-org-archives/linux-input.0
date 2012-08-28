From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Mon, 27 Aug 2012 17:12:11 -0700
Message-ID: <CACRpkdZs1V3S0gDxZqnq-fzP6SRzTwftuFhG_zwci_MvHbUM6A@mail.gmail.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com>
	<CACRpkda6Aq_rmYjMx6fcYvPnEexZ47dhaiA3hsCozLyUT0Mikw@mail.gmail.com>
	<503C00C5.60602@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <503C00C5.60602@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 27, 2012 at 4:20 PM, Christopher Heiny <cheiny@synaptics.com> wrote:

> EARLY_SUSPEND/LATE_RESUME and other power management stuff.  We're caught in
> a bind here.  Most of our customers are using some flavor of Android.  They
> have the expectation that our driver will (a) support the Android power
> management model, and (b) be contributed into the mainline kernel without
> change.  Yes, I know these are contradictory requirements, given that
> Android specific features are not in the mainline.
>
> With the upcoming rebase of the code to more modern kernels, we'll be able
> to eliminate a bunch of those dependencies.  But the only way to eliminate
> them entirely would be to maintain mainline and Android versions of the
> driver, which would drain resources from developing core features and fixing
> bugs.  So for now we've got a single code base. When we finally submit a
> patch and the only response is "everything is fine but that Android stuff",
> we'll probably change that policy within 48 hours (to include time needed
> for celebration and subsequent hangover recovery :-) ).

I'd suggest you rebase and test them with Android and the android hooks
all over the place, but when you send it out to community, remove these
#ifdef sections.

This way the delta between what's in the mainline kernel and what you're
maintaining internally will ideally be reduced to a few Android-enablement
patches.

But it's all up to the subsystem maintainer, so I'd ask Dmitry about this.

By the way, this patch set has come a long way, and I would suggest
to try merging core support and touch to begin with, so you have the
core in place, then you can work on individual function drivers one at
a time. This would make the patch bombs a bit smaller.

Yours,
Linus Walleij
