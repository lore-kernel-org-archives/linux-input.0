From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Input: Let the FT5x06 driver build without debugfs
Date: Mon, 20 Aug 2012 06:53:03 -0700
Message-ID: <20120820135303.GA9278@roeck-us.net>
References: <87k3wy1ii3.fsf@xmission.com>
 <502DFC1D.20903@kernelconcepts.de>
 <87boi91g01.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87boi91g01.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Simon Budig <simon.budig@kernelconcepts.de>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 17, 2012 at 12:21:34PM -0700, Eric W. Biederman wrote:
> Simon Budig <simon.budig@kernelconcepts.de> writes:
> 
> > On 08/17/2012 02:15 AM, Eric W. Biederman wrote:
> >> When testing to make certain my user namespace code works in
> >> various configurations I tripped over the tf5x06.c not building
> >> with debugfs disabled.
> >
> > Sorry for that.
> >
> > There already is a patch for this issue which I slightly prefer. You
> > can find it in the mail from Guenther Roeck:
> >    http://www.mail-archive.com/linux-input@vger.kernel.org/msg00646.html
> 
> If you guys could get that merged into 3.6 I would appreciate it.
> 
Yes, that would be great. I don't recall seeing an e-mail from Dmitry accepting
it, though.

Guenter
