From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] input: pegasus_notetaker: add license information
Date: Mon, 27 Nov 2017 08:52:52 +0100
Message-ID: <20171127075252.GA19416@kroah.com>
References: <20171126004259.xjl2icw3gbyg3hck@dtor-ws>
 <20171127074401.16388-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171127074401.16388-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: dmitry.torokhov@gmail.com, pombredanne@nexb.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 27, 2017 at 08:44:01AM +0100, Martin Kepplinger wrote:
> This adds an SPDX license identifier to this driver I wrote some time back.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> 
> Thanks for the feedback. GPL2+ was what I had in mind. My bad. And as I
> already see a lot of SPDX tags using /**/ comments, I'll use that too.
> I think if it is hand-written, it shouldn't look too ugly. And in case
> that's really a no-go, it seems that many many files need to be changed
> again in any case.

.h files should be the only ones using /* */, and that is for the ones
that break the build if they use // (usually arch-specific and uapi
files)

So please use // as Linus asked to have done.

thanks,

greg k-h
