From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Tue, 4 Jun 2019 10:53:12 +0200
Message-ID: <CAO-hwJJWWRf8cCLCB3JdfFGCGPnp9ar9HC_QAg7crJ0y+pA-hg@mail.gmail.com>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com> <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com> <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
 <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com>
 <e431dafc-0fb4-4be3-ac29-dcf125929090@redhat.com> <CAO-hwJ+5UYJMnuCS0UL4g45Xc181LraAzc-CMuYB2rcqKGe_Sw@mail.gmail.com>
 <4548d196-b75f-c4d0-8f3c-3e734b9a758c@redhat.com> <c05929f4-00b6-e098-cd69-cd6539ccd3f1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c05929f4-00b6-e098-cd69-cd6539ccd3f1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dave Hansen <dave.hansen@intel.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 4, 2019 at 10:36 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 04-06-19 10:05, Hans de Goede wrote:
>
> <snip>
>
> >>>> We should likely just remove c52f from the list of supported devices.
> >>>> C52f receivers seem to have a different firmware as they are meant to
> >>>> work with different devices than C534. So I guess it is safer to not
> >>>> handle those right now and get the code in when it is ready.
> >>>
> >>> Ack. Can you prepare a patch to drop the c52f id?
> >>
> >> Yes. I have an other revert never submitted that I need to push, so I
> >> guess I can do a revert session today.
> >>
> >> I think I'll also buy one device with hopefully the C52F receiver as
> >> the report descriptors attached in
> >> https://bugzilla.kernel.org/show_bug.cgi?id=203619 seems different to
> >> what I would have expected.
> >
> > They are actually what I expected :)
> >
> > The first USB interface is a mouse boot class device, since this is a mouse
> > only receiver. This means that the mouse report is unnumbered and we need to
> > extend the unnumbered mouse-report handling to handle this case. Also the
> > device is using the same highres mouse-reports as the gaming receiver is.
> >
> > I'm actually preparing a patch right now which should fix this. Still might
> > be better to do the revert for 5.2 and get proper support for the c52f
> > receiver into 5.3.
>
> I've attached a patch to the bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=203619

Cool, thanks.

>
> Which should fix this. It is quite simple and safe, so if we get testing
> feedback relatively soon, we could go with the fix instead of dropping the
> product-id, your call.

I should receive the M280 tomorrow, hopefully with the C52F. If the
receiver is correct and the tests are successful, I'd prefer to take
this one over the revert :)

Cheers,
Benjamin
