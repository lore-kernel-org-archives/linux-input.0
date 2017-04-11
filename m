From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs-rst: add input docs at main index and use
 kernel-figure
Date: Tue, 11 Apr 2017 14:54:16 -0600
Message-ID: <20170411145416.2cf4d180@lwn.net>
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

> This patch contains the final bits of the input documentation
> conversion. The linux-input tree has already the ReST conversion
> patches, but it doesn't have the
> Documentation/sphinx/load_config.py script with implements
> the kernel-figure directive, as it got merged via docs tree.
> 
> So, either one of you should merge from the other tree or this
> patch should be sent in separate upstream after both trees
> gets merged. What do you prefer?

How about if I send it Linusward toward the end of the merge window?

FWIW, while I think the conversion is great, I'm not fully pleased with
having it as a separate top-level document.  Probably what needs to be
done here is to split it up into two pieces, one for driver-api and one
for userspace-api.  But that can happen later, I guess.

Thanks,

jon
