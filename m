From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Problem with Mighty Mouse
Date: Fri, 18 Oct 2013 00:43:53 +0200
Message-ID: <1382049833.1817.0.camel@nuvo>
References: <1381621726.21761.7.camel@nuvo>
	 <CAN+gG=E3JgUZ9vGY7N-D3OYLGcRqy5OXu8w5WXjJ2YLuYW4UWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43686 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab3JQWoA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Oct 2013 18:44:00 -0400
In-Reply-To: <CAN+gG=E3JgUZ9vGY7N-D3OYLGcRqy5OXu8w5WXjJ2YLuYW4UWw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, 2013-10-17 at 15:30 -0400, Benjamin Tissoires wrote:
> Hi Bastien,
> 
> On Sat, Oct 12, 2013 at 7:48 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > Heya,
> >
> > I've tested a Bluetooth Apple Mighty Mouse (AA1197) and though I can
> > move the cursor without a problem, none of the buttons work. evtest
> > doesn't see any button events.
> >
> > Any ideas what I should look at, or which tool I could use to capture
> > the raw data?
> 
> you can use hid-recorder[1] to retrieve the raw events from hidraw (it
> mainly does a hexdump on /dev/hidrawX or you can use the kernel
> debugfs interface for some devices which are preventing hidraw to
> forward the events).
> 
> Ideally, you should give the output of evtest (or evemu) and
> hid-recorder at the same time so we can have an idea of the input and
> the output of the kernel driver.

Colour me confused, it works again. I'll bear those advices in mind if
and when it happens again.

Cheers

