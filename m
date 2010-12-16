From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid: egalax: Add support for Samsung NB30 netbook
Date: Thu, 16 Dec 2010 10:59:53 +0100
Message-ID: <4D09E319.5000603@euromail.se>
References: <1292493175-21630-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1012161055060.16569@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1012161055060.16569@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Nauber <richard.nauber@googlemail.com>, Richard Nauber <Richard.Nauber@gmail.com>
List-Id: linux-input@vger.kernel.org

On 12/16/2010 10:55 AM, Jiri Kosina wrote:

> On Thu, 16 Dec 2010, Henrik Rydberg wrote:
> 
>> From: Richard Nauber <richard.nauber@googlemail.com>
>>
>> The Samsung NB30 touch has a DWAV dual-touch device. This patch adds
>> the NB30 to the list of supported devices, and grabs it accordingly in
>> hid-core.
>>
>> [rydberg@euromail.se: rename and log message changes]
>> Signed-off-by: Richard Nauber <Richard.Nauber@gmail.com>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> ---
>> Hi Jiri,
>>
>> do I have your ACK on this one?
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> I will happily apply the patch to my queue. Or are you planning to put it 
> together with some larger bundle?


Thanks! Yep, it depends on a number of other patches coming in from my tree, so
we had better put in on top of that pile.

Thanks,
Henrik
