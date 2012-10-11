From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 02/06] input/rmi4: Core files
Date: Thu, 11 Oct 2012 17:37:15 +0200
Message-ID: <CACRpkdbRiwedVsvYo-8b5T0TVsUt69dFFkRpNwwGUPSuUYYLoQ@mail.gmail.com>
References: <1349496603-20775-1-git-send-email-cheiny@synaptics.com>
	<1349496603-20775-3-git-send-email-cheiny@synaptics.com>
	<CACRpkdZ0cQPQHDCYiyQb+Qb_8nGh=4rw2CixKgAFvb-3c1LpSg@mail.gmail.com>
	<BFABBC009FBA1C43B207B15FD485ABD922C22C06@USW-MAIL1.synaptics-inc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BFABBC009FBA1C43B207B15FD485ABD922C22C06@USW-MAIL1.synaptics-inc.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <Cheiny@synaptics.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 11, 2012 at 6:15 AM, Christopher Heiny <Cheiny@synaptics.com> wrote:
> On Thursday, October 11, 2012 02:21:53 AM I wrote:

>> > +union pdt_properties {
>> > +       struct {
>> > +               u8 reserved_1:6;
>> > +               u8 has_bsr:1;
>> > +               u8 reserved_2:1;
>> > +       } __attribute__((__packed__));
>> > +       u8 regs[1];
>>
>> I don't understand what this union is trying to achieve.
>>
>> regs[1] does not look right considering what you're trying to
>> achieve. Since the above fields require a regs[2] (9 bits!)
>> to be stored. Maybe write out what you're trying to do here
>> so I can understand it? (If everyone else in the world gets
>> it immediately, it's maybe me that need fixing instead...)
>>
>> Apart from these remarks it's looking real nice now!
>
> I only count 8 bits there, unless there's something about
> packing I'm not aware of.  Is there something else you
> found confusing about the union?

I just did bad maths, too many figured in the struct...

But consider Dmitry's suggestion that you might get rid
of this unionizing.

Yours,
Linus Walleij
