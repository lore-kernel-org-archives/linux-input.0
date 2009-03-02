From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] genirq: assert that irq handlers are indeed run in hardirq context.
Date: Mon, 2 Mar 2009 11:48:40 -0800
Message-ID: <200903021148.41405.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902271518.58246.david-b@pacbell.net> <1236006812.5330.632.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758190AbZCBTs4@vger.kernel.org>
In-Reply-To: <1236006812.5330.632.camel@laptop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>
List-Id: linux-input@vger.kernel.org

On Monday 02 March 2009, Peter Zijlstra wrote:
> > But these handlers are *NOT* running in hardirq context;
> 
> Ah, let us stop this tinkering dead in its tracks

How about providing adequate support for threaded IRQs
first, before breaking code that's been working for the
last few years?

This patch fails the "no regressions" test.  And with
no reason given -- not even a bad one.

For what it's worth:  NAK.

- Dave
