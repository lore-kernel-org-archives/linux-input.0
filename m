From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/3] Matrix keypad
Date: Tue, 7 Apr 2009 15:16:51 +0200
Message-ID: <200904071516.51773.marek.vasut@gmail.com>
References: <200807090341.20397.marek.vasut@gmail.com> <5d5443650904070437h3d651f70l7aaab428d0e28d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:26789 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758014AbZDGNQs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Apr 2009 09:16:48 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1057730fkq.5
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2009 06:16:45 -0700 (PDT)
In-Reply-To: <5d5443650904070437h3d651f70l7aaab428d0e28d6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-input@vger.kernel.org

On Tuesday 07 of April 2009 13:37:50 Trilok Soni wrote:
> Hi Marek Vasut,
>
> On Wed, Jul 9, 2008 at 7:11 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Hi,
> > this is the gpio driven matrix keypad. Final version.
> > I also CCed it to linux-input since it might interest them.
>
> Is there any interest for this patch to get mainlined through input
> subsystem ?

Yes, I'd like to see it mainlined as I need it on some devices. I haven't 
gotten to rewriting it as Dmitry Torokhov requested me to (see his reply in 
linux-input) though.
