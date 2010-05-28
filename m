From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] User Guide for Sysfs and libudev
Date: Fri, 28 May 2010 19:07:15 +0200
Message-ID: <AANLkTimb1N3zQCBbWQAq4u4YwcLYhyXdtOWfPt00REPR@mail.gmail.com>
References: <4BFAC0B0.2060701@signal11.us> <AANLkTikDHib2QiQ51cJztYGxORojxo5PEwOGXvS5vCJ1@mail.gmail.com>
	<4BFF2A33.8060504@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49370 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab0E1RHe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 May 2010 13:07:34 -0400
In-Reply-To: <4BFF2A33.8060504@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, May 28, 2010 at 04:28, Alan Ott <alan@signal11.us> wrote:
> Also, would you please give me some text which describes the "online"
> and "offline" events? What types of devices do these come from? Are
> there any other types of events which are not listed?

Nothing really. They would not be added today. It's from the time
everybody added their favorite stuff to sysfs, and nobody had a real
idea in which direction the stuff was supposed to go. :)

We only need "add"/"remove" and "move" for renames or re-parenting,
and "change" when stuff changes.

The "online"/"offline" are not useful at all, and ideally should just
use "change" for their state and pass the state with variables or
sysfs files.

No new subsystem should ever use these events.

Kay
