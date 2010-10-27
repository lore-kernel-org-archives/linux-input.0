From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 0/3] input / sysrq fixes for use with
	kdb
Date: Wed, 27 Oct 2010 07:53:14 -0500
Message-ID: <4CC820BA.3000203@windriver.com>
References: <1286483748-1171-1-git-send-email-jason.wessel@windriver.com>
	<20101010211944.GB27553@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <20101010211944.GB27553@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/10/2010 04:19 PM, Dmitry Torokhov wrote:
> On Thu, Oct 07, 2010 at 03:35:45PM -0500, Jason Wessel wrote:
>   
>> The goal of this patch set is to help eliminate the problems of
>> resuming from the kernel debugger and having "stuck keys".
>>
>> I am completely open to moving the code chunks around if it makes more
>> sense to put the function in the input.c.
>>
>> I had posted the first patch in the series before and never received
>> an ack or acceptance into the linux-input merge queue.
>>
>>     
>
> Jason,
>
> I am aware of the problem however I am not quite happy with the proposed
> solution yet. Let me mull it over for a bit and I will get back to you.
>   
Ping :-)

The merge window for 2.6.37 is almost over, and I would really like to
fix this or make it better than it is today, given that remainder of the
atomic KMS API is now merged in 2.6.37.


Thanks,
Jason.

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
