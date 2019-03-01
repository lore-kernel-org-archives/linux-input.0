From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
Date: Fri, 1 Mar 2019 10:48:44 +0100
Message-ID: <CAO-hwJ+9ft070W-shhEwxfTq9B5XyVB2v6Qx0b4nC4LdTiTEDg@mail.gmail.com>
References: <20190228135556.14713-1-nsaenzjulienne@suse.de>
 <BYAPR02MB56078ADD429292DF89F8C694ED750@BYAPR02MB5607.namprd02.prod.outlook.com>
 <a6ecd59f99aa64355ac7c176aa4310d32ce8969e.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a6ecd59f99aa64355ac7c176aa4310d32ce8969e.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "Junge, Terry" <Terry.Junge@plantronics.com>, Jiri Kosina <jikos@kernel.org>, "oneukum@suse.de" <oneukum@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Feb 28, 2019 at 7:01 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Thu, 2019-02-28 at 17:02 +0000, Junge, Terry wrote:
> > This could also be a parser error. In the HID specification section 6.2.2.8 it
> > states that the last declared Usage Page is applied to Usages when the Main
> > item is encountered.
> >
> > "If the bSize field = 1 or 2 then the Usage is interpreted as an unsigned
> > value
> > that selects a Usage ID on the currently defined Usage Page. When the parser
> > encounters a main item it concatenates the last declared Usage Page with a
> > Usage to form a complete usage value. Extended usages can be used to
> > override the currently defined Usage Page for individual usages."
> >
>
> Hi Terry, thanks for the comment.
> Just for the record the paragraph I cited on my patch is the following:
>
>         6.2.2.7 Global Items
>
>         [...]
>
>         Usage Page: Unsigned integer specifying the current Usage Page. Since a
>         usage are 32 bit values, Usage Page items can be used to conserve space
>         in a report descriptor by setting the high order 16 bits of a
>         subsequent usages. Any usage that follows which is defines* 16 bits or
>         less is interpreted as a Usage ID and concatenated with the Usage Page
>         to form a 32 bit Usage.
>
>         * This is a spec errata, I belive it should say "defined"
>
> As you can see they use the word "follows" which in my opinion contradicts the
> paragraph you pointed out. That said I may be wrong, I'm not too good at
> reading specs :).

I think you are both right (that is some decision making skills :-P).

I never saw a case where the Usage Page was after the Usage. And I
would lean towards Nicolas interpretation.
However, Terry's point is valid too, and by re-reading the two
paragraphs, one could argue that the "follows" of 6.2.2.7 could be
applied when the Main item is processed as in 6.2.2.8.

So I am going to base my decision on the "reference" driver. How well
behaves Windows with this particular keyboard?

If it behaves properly, then we better use the 6.2.2.8 version where
the Usage Page is only appended when there is a Main item. This means
we need to remember what size was the last Usage (and Min/Max), to
know if we should concatenate the 2.

Note that for every change that involves the generic parser, I'd like
a few tests added to `tests/test_keyboard.py in
https://gitlab.freedesktop.org/libevdev/hid-tools
Also note that the HID parser implementation in hid-tools follows the
kernel, so we might need to adjust it there too if we want to add high
level events. If you directly call `.call_input_event()` with raw
events, it should be fine.

>
> I checked the HID parser and it's indeed written assuming local items are
> preceded by a Usage Page. I'd be glad to fix it there, but it would be nice to
> have the mantainer's opinion on the matter first.
>

You've now got the opinion of one of the 2 maintainers, hope this helps :)

Cheers,
Benjamin
