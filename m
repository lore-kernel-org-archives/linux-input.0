From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs-rst: add input docs at main index and use
 kernel-figure
Date: Tue, 9 May 2017 13:41:53 -0600
Message-ID: <20170509134153.2437469f@lwn.net>
References: <1183dff3e0dd809c866d646a0c41ddbc4452d85e.1491904368.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1183dff3e0dd809c866d646a0c41ddbc4452d85e.1491904368.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Kepplinger <martink@posteo.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 11 Apr 2017 07:01:19 -0300
Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:

> The input subsystem documentation got converted into ReST.
> 
> Add it to the main documentation index and use kernel-figure
> for the two svg images there.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
> 
> Jon/Dmitry,
> 
> This patch contains the final bits of the input documentation
> conversion. The linux-input tree has already the ReST conversion
> patches, but it doesn't have the
> Documentation/sphinx/load_config.py script with implements
> the kernel-figure directive, as it got merged via docs tree.
> 
> So, either one of you should merge from the other tree or this
> patch should be sent in separate upstream after both trees
> gets merged. What do you prefer?

This is now applied.

I do reserve the right to break apart and reorganize this documentation,
a bit; it's got the classic problem of jumbling stuff for different
audiences into one big document.  But that's for another day when I have
some time...2022 or so...

Thanks,

jon
