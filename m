From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v3] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
Date: Tue, 19 Sep 2017 22:29:54 -0500
Message-ID: <a8d56238-ae16-4b15-f60d-731f267737f4@landley.net>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
 <8760gp9jjl.fsf@concordia.ellerman.id.au>
 <20170526072437.46499fbd@canb.auug.org.au>
 <87a7e82d-0af5-7f9e-6bd6-7e28b238e866@landley.net>
 <87r2z86ykt.fsf@concordia.ellerman.id.au>
 <4aa9cb26-f868-0720-e5c8-3c4e08afad20@landley.net>
 <3ba5ddc7-d1a2-7f54-0a26-0752f3975226@c-s.fr>
 <d6a5ba05-5de2-24e0-49ae-437058001b37@landley.net>
 <20170917135119.nqo6dffx2zuqh36l@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170917135119.nqo6dffx2zuqh36l@khazad-dum.debian.net>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, Michael Ellerman <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>, sachinp <sachinp@linux.vnet.ibm.com>, mhocko@suse.com, peterz@infradead.org, viresh.kumar@linaro.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, mingo@kernel.org, lokeshvutla@ti.com, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, linux-input@vger.kernel.org, thomas.lendacky@amd.com, lauraa@codeaurora.org, keescook@chromium.org, Jiri Kosina <jikos@kernel.org>, rostedt@goodmis.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, tglx@linutronix.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, tj@kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-input@vger.kernel.org

On 09/17/2017 08:51 AM, Henrique de Moraes Holschuh wrote:
> On Sat, 16 Sep 2017, Rob Landley wrote:
>> So, I added a workaround with a printk in hopes of embarassing them into
>> someday fixing it.
> 
> Oh, it will be fixed in Debian alright.

Cool!

But part of the problem is people upgrade the kernel on existing
deployed root filesystems, some of which are a fork off of a fork off of
debian, so we won't exhaust the broken userspace for probably a couple
years.

I'd put it in feature-removal-schedule.txt but Linus zapped that, so...

> I am just waiting the issue to
> settle a bit to file the bug reports, or maybe even send in the Debian
> patches myself (note that I am not responsible for the code in question,
> so I am not wearing a brown paperbag at this time).  Even if I didn't do
> it, there are several other Debian Developers reading LKML that could do
> it (provided they noticed this specific thread and are aware of the
> situation) :p

There was a previous thread last merge window they didn't notice. I was
hoping the warning would be obvious enough. :)

> I can even push for the fixes to be accepted into the stable and
> oldstable branches of Debian, but that can take anything from a few
> weeks to several months, due to the way our stable releases work.  But
> it would eventually happen.
> 
> Whether such fixes will ever make it to LTS branches, especially
> Ubuntu's, *that* I don't know.

I have no idea what that powerpc system was, the guy didn't say...

Rob
