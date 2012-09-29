From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] hid:Fix problem on GeneralTouch multi-touchscreen
Date: Sat, 29 Sep 2012 17:47:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209291747040.837@pobox.suse.cz>
References: <1348798739-2950-1-git-send-email-aroundight77@gmail.com> <CAN+gG=G6V_O5W6DCuByAmymeLSvyOtDbsaHTZOqbNgNKu+m6cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=G6V_O5W6DCuByAmymeLSvyOtDbsaHTZOqbNgNKu+m6cQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: GeneralTouch <aroundight77@gmail.com>, yxhma <yxhma@163.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 28 Sep 2012, Benjamin Tissoires wrote:

> > From: Xianhan Yu <aroundight77@gmail.com>
> >
> > Fix the touch-up no response problem on GeneralTouch twofingers 
> > touchscreen and modify the driver for new GeneralTouch PWT 
> > touchscreen.
> >
> > Signed-off-by: Xianhan Yu <aroundight77@gmail.com>
> 
> Hi,
> 
> Thank you for re-submitting the patch. It's cleaner now.
> 
> I have a few questions, but generally speaking, the patch is good in
> its current form.

Thanks for the review, Benjamin.

> Jiri: I know that I have not been as reactive as I used to, but I'm 
> ending my contract in my current lab now, and I've been pretty busy. 
> Please don't put me in the grave, I'm still the maintainer of 
> hid-multitouch.... ;-)

Glad to hear that :) Perhaps it'd make sense adding yourself to 
MAINTAINERS alongside Henrik?

-- 
Jiri Kosina
SUSE Labs
