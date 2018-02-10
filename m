From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: =?UTF-8?Q?Re:_Software_evolution_around_=e2=80=9ccheckpatch.pl?=
 =?UTF-8?B?4oCdPw==?=
Date: Sat, 10 Feb 2018 19:30:15 +0100
Message-ID: <a988eca2-36d4-19bd-e92c-1a92e497e0da@users.sourceforge.net>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
 <20180204112346.0977e938@archlinux>
 <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
 <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
 <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
 <20180210145336.233c721d@archlinux> <1518274783.6579.2.camel@perches.com>
 <20180210155734.708d01b6@archlinux> <1518284577.16865.8.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1518284577.16865.8.camel@perches.com>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Jiri Kosina <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

>> So I think checkpatch is striking the right balance here in
>> how it warns.  Obviously if it could assess the text
>> and come to an informed decision that would be great but
>> we are some way from that ;)
> 
> The 'informed' bit is difficult as it is mostly a political problem.

I find such a view very interesting.


> I just wish Markus would improve his consistently terrible commit messages

I tried to achieve another clarification a few times.


> that just restate the action being done and detail
> _why_ a particular thing _should_ be done.

Unfortunately, it seems that no other contributors picked
corresponding opportunities up so far.

You indicated also special software development challenges in your commit
“checkpatch: attempt to find unnecessary 'out of memory' messages”.

https://lkml.org/lkml/2014/6/10/382
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebfdc40969f24fc0cdd1349835d36e8ebae05374


> His acceptance rate would improve as many of these back and forth
> replies for what trivialities he posts as patches would be minimized.

My selection of change possibilities leads to mixed integration results.

I stumbled on variations for general change resistance.

Regards,
Markus
