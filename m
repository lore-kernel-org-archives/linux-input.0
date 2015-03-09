From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Sun, 8 Mar 2015 23:46:49 -0700
Message-ID: <20150309064649.GE17331@dtor-ws>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <CAN+gG=F7kJXmvCV7CiQxfdn9wv8a9EkcLjaj9G8fbV=hqkYecQ@mail.gmail.com>
 <CAN+gG=FwOGMS66q4GC=jTYvyRkO4Mi6s2wmVGfchLtx6i=BA7w@mail.gmail.com>
 <54EDE30C.3080208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:41420 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbbCIGqy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 02:46:54 -0400
Content-Disposition: inline
In-Reply-To: <54EDE30C.3080208@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Feb 25, 2015 at 03:58:20PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 25-02-15 15:36, Benjamin Tissoires wrote:
> >On Mon, Feb 16, 2015 at 10:23 PM, Benjamin Tissoires
> ><benjamin.tissoires@gmail.com> wrote:
> >>On Fri, Feb 6, 2015 at 3:04 PM, Benjamin Tissoires
> >><benjamin.tissoires@redhat.com> wrote:
> >>>Hi,
> >>>
> >>>This is the second episode of the Lenovo 2015 party :)
> >>>
> >>>Thanks to Andrew, we now have an idea within the driver of what are the extra
> >>>buttons aimed for, and the patch series looks cleaner.
> >>>Many thanks for your help.
> >>>
> >>>I marked only patches 1/7, 2/7 and 3/7 as stable because they are really
> >>>stable fixes. Without the rest of the series, user-space can cope with the
> >>>kernel result, and so there is IMO no need to backport too many patches in
> >>>stable. I bet distributions will cherry-pick the rest of the series however.
> >>>
> >>
> >>Guys,
> >>
> >>any chances we consider this for 3.20 (or whatever it will be numbered)?
> >>I'd really like to see this accepted upstream in one way or one other
> >>so we will prevent the mess we had to deal with last year.
> >>
> >
> >Hans, Dmitry,
> >
> >well, it's been 3 weeks since I received the loaner I have to support
> >these touchpads. I will have to return it next week or the week after
> >at most. That means that I will not be able to conduct more tests at
> >that point.
> >Can I ask you to please review the series?
> 
> Ah, sorry I missed you did a v2 (I did review v1).
> 
> Series looks good to me and is:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

I did a few edits of the patches in the 2 series so I created a separate
branch "synaptics" based on 3.19. I'd appreciate if you could give it q
quick spin before I will send it for 4.0.

Thanks.

-- 
Dmitry
