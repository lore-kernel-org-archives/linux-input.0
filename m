From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH] docs-rst: add input docs at main index and use
 kernel-figure
Date: Wed, 12 Apr 2017 06:49:21 -0300
Message-ID: <20170412064921.4e86284c@vento.lan>
References: <1183dff3e0dd809c866d646a0c41ddbc4452d85e.1491904368.git.mchehab@s-opensource.com>
        <20170411145416.2cf4d180@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170411145416.2cf4d180@lwn.net>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Kepplinger <martink@posteo.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Em Tue, 11 Apr 2017 14:54:16 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 11 Apr 2017 07:01:19 -0300
> Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:
> 
> > This patch contains the final bits of the input documentation
> > conversion. The linux-input tree has already the ReST conversion
> > patches, but it doesn't have the
> > Documentation/sphinx/load_config.py script with implements
> > the kernel-figure directive, as it got merged via docs tree.
> > 
> > So, either one of you should merge from the other tree or this
> > patch should be sent in separate upstream after both trees
> > gets merged. What do you prefer?  
> 
> How about if I send it Linusward toward the end of the merge window?

Sounds fine.

> FWIW, while I think the conversion is great, I'm not fully pleased with
> having it as a separate top-level document.  Probably what needs to be
> done here is to split it up into two pieces, one for driver-api and one
> for userspace-api.  But that can happen later, I guess.

Yeah, separating uAPI from driver documentation makes sense to me.

IMHO, there are other type of documents there that aren't neither
uAPI or kAPI.

This one, for example, seems to be a good candidate for the admin
guide (except for the last item, with briefs uAPI events):
	https://mchehab.fedorapeople.org/kernel_docs/input/input.html

There are a number of docs there that describe driver-specific
internals, with, IMHO, won't fit on any of the "main" document
categories:
	https://mchehab.fedorapeople.org/kernel_docs/input/alps.html
	https://mchehab.fedorapeople.org/kernel_docs/input/appletouch.html
	https://mchehab.fedorapeople.org/kernel_docs/input/joystick-parport.html

Some describe messages used to communicate with devices, others
describe user-facing stuff, like modprobe parameters or X11 settings.
Some even have pinups for several device models. So, classifying
them require some thinking.

Btw, that's not that different from what I found on media after
converting all documents that were under Documentation/video4linux
and Documentation/dvb.

Thanks,
Mauro
