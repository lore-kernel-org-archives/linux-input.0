From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 6/6] input: Add a detailed multi-touch finger data report
 	protocol (rev2)
Date: Fri, 30 Jan 2009 14:10:17 +0100
Message-ID: <4982FC39.7080308@euromail.se>
References: <1233138229-12489-1-git-send-email-rydberg@euromail.se>	 <1233138229-12489-2-git-send-email-rydberg@euromail.se>	 <1233138229-12489-3-git-send-email-rydberg@euromail.se>	 <1233138229-12489-4-git-send-email-rydberg@euromail.se>	 <1233138229-12489-5-git-send-email-rydberg@euromail.se>	 <1233138229-12489-6-git-send-email-rydberg@euromail.se>	 <1233138229-12489-7-git-send-email-rydberg@euromail.se> <4e1455be0901292210t793c942cg5776079ecc99080e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754511AbZA3NKd@vger.kernel.org>
In-Reply-To: <4e1455be0901292210t793c942cg5776079ecc99080e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joon Young Shim <dofmind@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Joon Young Shim wrote:
> 2009/1/28 Henrik Rydberg <rydberg@euromail.se>:
[snip]
> 
> Hi Henrik,
> 
> Sorry for multiple posts.
> 
> I want to know how calculates touch coordinates at user space using a
> set of ABS_MT.
> If i do dual touch, can i get correct two coordinates through ABS_MT report?

The coordinates for the two fingers are sent from the driver in sequence
as two separate finger packets. What then happens with it depends on the
kind of application. For normal desktop usage, the packets are read from
the input device by the multitouch X driver (a modified version of the
synaptics driver), which does finger matching and transforms the
messages into gestures, reported as X events. It is of course also
possible to read the input device directly. It goes without saying that
further development is needed before the multitouch X driver hits the
repos, but none of this can really become reality without basic support
in the kernel.

Henrik
