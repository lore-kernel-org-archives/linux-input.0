From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] Add drivers for Logitech G110, G13, G15v2 and G19
Date: Tue, 03 Mar 2015 22:52:17 +0100
Message-ID: <1425419537.24292.150.camel@x220>
References: <2205053.ll7fhHWnZQ@pink>
	 <1424533803-17017-1-git-send-email-cheepeero@gmx.net>
	 <1424539280.24292.33.camel@x220> <2215516.4kP1VObgmA@pink>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2215516.4kP1VObgmA@pink>
Sender: linux-kernel-owner@vger.kernel.org
To: Ciprian Ciubotariu <cheepeero@gmx.net>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Bruno Premont <bonbons@linux-vserver.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2015-02-23 at 22:47 +0200, Ciprian Ciubotariu wrote:
> On Saturday 21 February 2015 18:21:20 Paul Bolle wrote:
> > Apparently Alistair Buxton, Rick L Vinyard Jr, and Thomas Berger were
> > involved with this code too. There's no mention of them in the commit
> > explanation. They're also not CC-ed.
> 
> The driver moved around with a lot of people contributing small changes. Some 
> (including myself) chose to add a MODULE_AUTHOR line, but others didn't. While 
> I can list all contributors from the git fork I found, I am sure I won't be 
> able to track those before the git fork.
> 
> What is the appropriate follow-up? Add all contributors to MODULE_AUTHOR? 
> Leave them as is? Which ones should be CC'ed?

It depends, I think, on what Jiri is comfortable with for the HID tree.
And I can't read Jiri's mind.

Personally I would add a line or two to the commit explanation detailing
how this patch ended up in your tree. And CC-ing the people previously
working on this patch will cost you next to nothing, so I'd do that too.


Paul Bolle
