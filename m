From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V2 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Wed, 14 Sep 2011 09:46:21 +0200
Message-ID: <20110914074621.GA3582@polaris.bitmath.org>
References: <1315029042-27513-1-git-send-email-martinez.javier@gmail.com>
 <1315029042-27513-2-git-send-email-martinez.javier@gmail.com>
 <20110913082448.GA5046@polaris.bitmath.org>
 <CAAwP0s0FvkzTUo5kAZE_pd_8u-znDvoLks74gf8+75cUF0aM2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:41010 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab1INHmr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 03:42:47 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s0FvkzTUo5kAZE_pd_8u-znDvoLks74gf8+75cUF0aM2g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Kevin McNeely <kev@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > Compared to the staging version you sent earlier, this version seems
> > to be a step back towards the original version regarding the MT
> > implementation. Is this the right patch?
> 
> Hello Henrik,
> 
> Yes it is the right patch, or at least the patch I meant to send. The
> staging version I send earlier didn't support multi-touch protocol
> type A.

I see - the cyttsp_xydata struct seems to be the old version,
though. Any particular reason for that? Also, the similarity to the
problem found here, https://lkml.org/lkml/2011/8/25/516, suggests your
16 tracking ids could be mapped directly to slots instead, using the
example code. It ought to reduce the present patch significantly.

Thanks,
Henrik
