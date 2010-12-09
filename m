From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [GIT PULL] input: mt updates for 2.6.38
Date: Thu, 09 Dec 2010 19:23:31 +0100
Message-ID: <4D011EA3.2000905@euromail.se>
References: <4CFF49BC.8030202@euromail.se> <20101209085814.GA8821@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101209085814.GA8821@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 12/09/2010 09:58 AM, Dmitry Torokhov wrote:

> On Wed, Dec 08, 2010 at 10:02:52AM +0100, Henrik Rydberg wrote:
>> Dmitry,
>>
>> Please pull from
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next
>>
>> to receive input-mt updates for 2.6.38.
>>
>> The tree contains core changes as well as dependent changes to hid drivers. You
>> also find the new hid-egalax driver in there, signed off by Jiri.
> 
> Pulled, thank you Henrik.
> 
> I wonder if we should move input-mt.h into input/mt.h (and if someone
> would bother to input-polldev.h there that would be great too).


Sure, I have been wondering about that too. Right away, or later?

> Also I try to sync with mainline once per release, at -rc1, unless I
> know that my changes will conflict with some other work. I'd recommend
> you do the same so that when I pull from you I am getting just your
> changes and not the rest of stuff from mainline.


No problem - I will see what sync point you end up using, and I will rebase to
the same point.

> BTW, we need to document dev->trkid to avoid complaints from 'make
> htmldocs' and friends. I wonder if the patch below will do.


Looks good, thanks.

Henrik
