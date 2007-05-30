From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] new driver for wireless xbox receiver for review
Date: Wed, 30 May 2007 11:02:10 -0400
Message-ID: <d120d5000705300802v49ef7d29ydbd3e39d99aad214@mail.gmail.com>
References: <20070529043957.GB6157@rcn.com>
	 <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
	 <20070530002846.GA8595@rcn.com>
	 <d120d5000705300540v32b2f32eub8e74b88fea6a593@mail.gmail.com>
	 <bafd4ab0705300647w3d54aaa6meee94c98005650d7@mail.gmail.com>
	 <alpine.LRH.0.98.0705301614040.22353@twin.jikos.cz>
	 <bafd4ab0705300751q67eb54efi1a46779576e0d202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <bafd4ab0705300751q67eb54efi1a46779576e0d202@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Brian Magnuson <bdmagnuson@gmail.com>
Cc: Jan Kratochvil <honza@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/30/07, Brian Magnuson <bdmagnuson@gmail.com> wrote:
> On 5/30/07, Jan Kratochvil <honza@jikos.cz> wrote:
> >
> > It is not yet in Linus' tree, but it definitely is in Dmitry input tree.
> >
> http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=bad058541d848500b5f2cc049c1082d0b2935b7d
>
> Indeed it is.  I think this is just some basic git ignorance on my part.  I
> clearly see it in
> the link you provided but if I descend from the tree link starting from top
> commit at
> http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=summary
> I get some older
> version of xpad.c.  Am I just being dense (likely) or is there something
> wrong?

The topmost commit (time-wise) is on "for-linus" branch of my tree. It
contains bug-fixes and tiny cleanups that I plan to push to Linus
shortly. The main branch is "master" which contains all the stuff that
I want to merge once 2.6.23 opens (that includes xbox, aiptek and
more).

Apparently you are descending into the tree for "for-linus" branch.

-- 
Dmitry
