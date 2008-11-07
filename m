From: "J.R. Mauro" <jrm8005@gmail.com>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report protocol
Date: Fri, 7 Nov 2008 09:57:55 -0500
Message-ID: <3aaafc130811070657o63894848l3c11989c9b0f2911@mail.gmail.com>
References: <49142351.9080805@euromail.se>
	 <3aaafc130811070534p54eebeb6q9b57d3e847ed859a@mail.gmail.com>
	 <49145016.7090206@euromail.se>
	 <3aaafc130811070636g681accf5qae252679c2edcdb9@mail.gmail.com>
	 <49145628.7030804@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:5528 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYKGO55 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Nov 2008 09:57:57 -0500
In-Reply-To: <49145628.7030804@euromail.se>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 7, 2008 at 9:52 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> Have you worked with MPX? Or was a vanilla-X11 driver simple enough?
>> How does this all get presented to userspace applications? Multiple
>> mouse inputs or special stuff that applications would need a rewrite
>> to leverage?
>
> MPX is about making use of multiple pointers. The MT protocol is about
> making use of multiple fingers. It can in principle be used as input
> to MPX applications; I will bring it up with Peter Hutterer. However,
> the main aim is to bring advanced gestures to the linux desktop.
>
> Henrik

I think this approach is cleaner than "fooling" userspace into seeing
a bunch of mice.
