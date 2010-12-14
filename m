From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 0/4] Alternative approach to MT_TOOL_ENVELOPE
Date: Tue, 14 Dec 2010 13:38:44 -0800
Message-ID: <4D07E3E4.50109@canonical.com>
References: <1292361672-2581-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292361672-2581-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/14/2010 01:21 PM, Chase Douglas wrote:
> Hello all,
> 
> I was left somewhat dissatisfied by the MT_TOOL_ENVELOPE addition, so I decided
> to try to propose a different solution for the problem. As a recap, the problem
> can best be defined by Synaptics hardware that provide two touch coordinates
> (X1, Y1) and (X2, Y2). Unfortunately, the real touches may be at (X1, Y2) and
> (X2, Y1). Further, three touches may be recognized, but only two coordinates are
> reported.
> 
> Following this are four patches.

[...]

I forgot to mention that these apply on top of Dmitry's next tree plus
the first synaptics multitouch patch. My bad :(.

-- Chase
