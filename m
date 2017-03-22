From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 1/3] Input: max11801_ts: Add missing of_match_table
Date: Wed, 22 Mar 2017 11:44:21 -0700
Message-ID: <20170322184421.GB2899@dtor-ws>
References: <1490180808-2856-1-git-send-email-jagan@openedev.com>
 <20170322183039.GA2899@dtor-ws>
 <CAMty3ZApz+GVkeoT4-75tiJcn6-CxkzdOrMcH7hjK1k2Ht=ZUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34786 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965566AbdCVSoZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Mar 2017 14:44:25 -0400
Content-Disposition: inline
In-Reply-To: <CAMty3ZApz+GVkeoT4-75tiJcn6-CxkzdOrMcH7hjK1k2Ht=ZUQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jagan Teki <jagan@openedev.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Matteo Lisi <matteo.lisi@engicam.com>, Michael Trimarchi <michael@amarulasolutions.com>

On Thu, Mar 23, 2017 at 12:05:17AM +0530, Jagan Teki wrote:
> On Thu, Mar 23, 2017 at 12:00 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Mar 22, 2017 at 04:36:46PM +0530, Jagan Teki wrote:
> >> From: Jagan Teki <jagan@amarulasolutions.com>
> >>
> >> Added missing of_match_table for max11801_ts driver with
> >> compatible as "maxim,max11801_ts"
> >>
> >
> > Why not "maxim,max11801"? Also, I think we'd need a binding document.
> 
> Compatibility purpose to make this is for touchscreen and few of other

Compatibility with what? The i2c id is "max11801" (without the "-ts").

> *_ts.c files follow the same, and added binding documentation in 2/3
> patch.

Sorry, it seems I am only copied on 1/3 patch.

Thanks.

-- 
Dmitry
