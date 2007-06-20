From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch] hid: fix autocentering of PID devices
Date: Wed, 20 Jun 2007 20:37:17 +0300
Message-ID: <467965CD.20507@gmail.com>
References: <466FDC51.5030703@gmail.com> <Pine.LNX.4.64.0706131746020.23280@twin.jikos.cz> <46705CBD.5040302@gmail.com> <Pine.LNX.4.64.0706132340560.23280@twin.jikos.cz> <4670673A.3050702@gmail.com> <Pine.LNX.4.64.0706181742480.12361@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0706181742480.12361@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Diogo Kastrup <dk@bighost.com.br>
List-Id: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Thu, 14 Jun 2007, Anssi Hannula wrote:
> 
>>> I'd of course happily merge the fix which initializes the value 
>>> properly into my tree, but I would be curious what broke it, to double 
>>> check that we didn't break anything else along with it.
>> Okay, I'll get back to you in a few days :)
> 
> Hi Anssi,

Hi!

> did you make any progress here please? I am going to merge the patch, 
> still I'd be understand what caused it (on the other hand from Diogo's 
> last comment it doesn't seem 100% certain that we cased it somewhere 
> around 2.6.20).

I finally had time to bisect 2.6.20 vs 2.6.21, and for me it seems to 
start happening after commit 4237081e573b99a48991aa71364b0682c444651c:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4237081e573b99a48991aa71364b0682c444651c

-- 
Anssi Hannula
