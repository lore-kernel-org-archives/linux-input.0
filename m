From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
 protocol
Date: Fri, 07 Nov 2008 16:07:09 +0100
Message-ID: <4914599D.9060403@euromail.se>
References: <49142351.9080805@euromail.se>	 <3aaafc130811070534p54eebeb6q9b57d3e847ed859a@mail.gmail.com>	 <49145016.7090206@euromail.se>	 <3aaafc130811070636g681accf5qae252679c2edcdb9@mail.gmail.com>	 <49145628.7030804@euromail.se> <3aaafc130811070657o63894848l3c11989c9b0f2911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753526AbYKGPH2@vger.kernel.org>
In-Reply-To: <3aaafc130811070657o63894848l3c11989c9b0f2911@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "J.R. Mauro" <jrm8005@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


> I think this approach is cleaner than "fooling" userspace into seeing
> a bunch of mice.

The many-input-device approach has problems with synchronicity. In
particular when envisioning the appearance of more advanced chips,
with finger matching in hardware. Currently, no chip with open or
sufficient documentation has these features, but it is probably
only a matter of time.
