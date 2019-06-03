From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Mon, 3 Jun 2019 15:55:53 +0200
Message-ID: <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm> <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com> <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com> <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com> <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dave Hansen <dave.hansen@intel.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jun 3, 2019 at 11:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Again,
>
> On 03-06-19 11:11, Hans de Goede wrote:
> <snip>
>
> >> not sure about the rest of logitech issues yet) next week.
> >
> > The main problem seems to be the request_module patches. Although I also

Can't we use request_module_nowait() instead, and set a reasonable
timeout that we detect only once to check if userspace is compatible:

In pseudo-code:
if (!request_module_checked) {
  request_module_nowait(name);
  use_request_module = wait_event_timeout(wq,
        first_module_loaded, 10 seconds in jiffies);
  request_module_checked = true;
} else if (use_request_module) {
  request_module(name);
}


> > have 2 reports of problems with hid-logitech-dj driving the 0xc52f product-id,
> > so we may need to drop that product-id from hid-logitech-dj, I'm working on
> > that one...
>
> Besides the modprobe hanging issue, the only other issues all
> (2 reporters) seem to be with 0xc52f receivers. We have a bug
> open for this:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=203619
>
> And I've asked the reporter of the second bug to add his logs
> to that bug.

We should likely just remove c52f from the list of supported devices.
C52f receivers seem to have a different firmware as they are meant to
work with different devices than C534. So I guess it is safer to not
handle those right now and get the code in when it is ready.

Cheers,
Benjamin
