From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Driver for Logitech M560
Date: Thu, 9 Apr 2015 14:41:54 +0200
Message-ID: <20150409144154.36fbce15dcdf4556544ee8a7@ao2.it>
References: <5404C6F4.1000800@inwind.it>
	<CAN+gG=HMUJBWQj65OKRfoPiyzzRPXLVveA6V2S_a1dSJXKJc3g@mail.gmail.com>
	<5409F740.9000706@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:39893 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbbDIMma (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Apr 2015 08:42:30 -0400
In-Reply-To: <5409F740.9000706@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kreijack@inwind.it
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Dario Righelli <drighelli@gmail.com>

On Fri, 05 Sep 2014 19:47:44 +0200
Goffredo Baroncelli <kreijack@inwind.it> wrote:

> On 09/03/2014 11:36 PM, Benjamin Tissoires wrote:
> > Hi Goffredo,
> > 
> > On Mon, Sep 1, 2014 at 3:20 PM, Goffredo Baroncelli <kreijack@inwind.it> wrote:
> >> Hi Benjamin,
> >>
> >> following the Nestor suggestion, I rewrote the driver for the
> >> mouse Logitech M560 on the basis of your work (branch "for-whot").
> > 
> > Just for the record. This branch is located here:
> > https://github.com/bentiss/hid-logitech-dj/tree/for-whot and I
> > *really* need to finish this work so that everything can go upstream
> > :(
>

Hi Benjamin, any news about upstreaming this work?

> :-) For me this is not a problem. I solved my issue (I made a dkms
> package for this mouse), but I want to share my effort..
> 

Goffredo, is this the latest version of your dkms-enabled external
module?
https://github.com/kreijack/hid-logitech-dj/tree/m560-dkms

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
