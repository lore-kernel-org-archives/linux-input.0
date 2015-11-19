From: Edwin <Edwin@Velds.nl>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech G920
 Wheel
Date: Fri, 20 Nov 2015 00:19:56 +0100
Message-ID: <564E591C.60204@Velds.nl>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
 <1447345535-2912-2-git-send-email-simon@mungewell.org>
 <alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
 <20151119183106.GC24773@dtor-ws>
 <029e8be19f95a6a1a89d7609de42fb64.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <029e8be19f95a6a1a89d7609de42fb64.squirrel@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Michal_Mal=c3=bd?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On 19-11-15 19:35, Simon Wood wrote:
> On Thu, November 19, 2015 11:31 am, Dmitry Torokhov wrote:
> > On Thu, Nov 19, 2015 at 02:50:51PM +0100, Jiri Kosina wrote:
> >
> >> On Thu, 12 Nov 2015, Simon Wood wrote:
> >>
> >>
> >>> When plugged in the Logitech G920 wheel starts with USBID 046d:c261
> >>> and behaviors as a vendor specific class. If a 'magic' byte sequence is
> >>> sent the wheel will detach and reconnect as a HID device with the
> >>> USBID 046d:c262.
> >>>
> >>>
> >>> Signed-off-by: Simon Wood <simon@mungewell.org>
> >>>
> >>
> >> Adding Dmitry to CC.
> >>
> >>
> >> Dmitry, I am planning to take this through my tree together with the
> >> rest of the actual HID support for that device if you Ack this.
> >
> > Hmm, I have an incoming series for xbox that night clash with this... If
> > you'll put it in a clean branch off 4.3 I'd pull it and then get more
> > changes on top.
> >
> > Can we also change the subject as it is not about adding a minimal
> > support. Something like "Input: xpad - switch Logitech G920 Wheel into HID
> > mode"
>
> Will spin a 'v3' with this and Benjamin's suggestion.
>
> Cheers,
> Simon.
>

I'll put out the force feedback patch right (or as close as I can) after v3.

Edwin
