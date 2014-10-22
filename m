From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Touch processing on host CPU
Date: Wed, 22 Oct 2014 14:20:16 +0100
Message-ID: <20141022142016.42e8032c@alan.etchedpixels.co.uk>
References: <5440F282.8040306@itdev.co.uk>
	<20141017171756.GA22238@dtor-ws>
	<20141021132229.37a1197c@alan.etchedpixels.co.uk>
	<54468E0D.2010200@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54468E0D.2010200@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Greg KH <greg@kroah.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

> This sounds promising. The only sticking point I can see is that a touch
> frontend has many more channels (possibly thousands), which would seem to
> impose a lot of overhead when put into the IIO framework. I will certainly
> take a closer look at it.

If that is the case then it may not be the right match - but it might
also be a good argument for fixing the IIO layer so it isn't ?

Alan
