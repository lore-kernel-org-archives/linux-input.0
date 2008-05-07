From: Alan Jenkins <aj504-l9TVMAoMiWs2EctHIo1CcQ@public.gmane.org>
Subject: Re: What is causing C2? / USB autosuspension?
Date: Wed, 07 May 2008 14:17:27 +0100
Message-ID: <4821ABE7.1090103@student.cs.york.ac.uk>
References: <1015f9200805021702n1558873es72ac798ccdc06966@mail.gmail.com>
	<200805062212.31947.oliver@neukum.org>
	<4820DABA.3000700@student.cs.york.ac.uk>
	<200805071457.16069.oliver@neukum.org>
Reply-To: alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <discuss-bounces-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org>
In-Reply-To: <200805071457.16069.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://mail.lesswatts.org/mailman/listinfo/discuss>,
	<mailto:discuss-request-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.lesswatts.org/pipermail/discuss>
List-Post: <mailto:discuss-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org>
List-Help: <mailto:discuss-request-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org?subject=help>
List-Subscribe: <http://mail.lesswatts.org/mailman/listinfo/discuss>,
	<mailto:discuss-request-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org?subject=subscribe>
Sender: discuss-bounces-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org
Errors-To: discuss-bounces-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: discuss-csvQSjAa8IAgsBAKwltoeQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Oliver Neukum wrote:
> Am Mittwoch 07 Mai 2008 00:24:58 schrieb Alan Jenkins:
>   
>> I think I've worked out how to avoid the lost key-presses.  Sometimes
>> they get lost; sometimes they don't.  The difference seems to how long I
>> wait after the keyboard suspends.  If I wait a few seconds after it's
>> suspended (as shown by the LEDs), then it resumes flawlessly.  It should
>> be possible to reduce the impact of the hardware misfeature by
>> increasing the timeout.  The longer the keyboard has been idle already,
>> the lower the probability it'll be used in the next few seconds. 
>>     
>
> This suggests a possible work around. Keyboards known to be buggy in this
> way could be reawoken periodically before the critical amount of time is over.
> How long is that time? What percentage of time does a keyboard need to be
> suspended for a positive energy balance?
>   
Sorry, I didn't explain that very clearly.

The problem happens if the keyboard resumes _immediately after_ it's 
autosuspended.  If I start typing as soon as the LED goes off, it loses 
some of the keypresses.  If I instead wait a few seconds before typing, 
it works flawlessly.  Since it's the keyboard that's resuming itself I 
don't think you could fix this.  Unless it's your code that's buggy and 
not the keyboard :-).

What I was trying to say was that I can mitigate this problem by 
increasing the autosuspend timeout from the default of 2 seconds.  I 
will quite often pause for periods of about 2 seconds while typing.  But 
if the keyboard is only suspended after 60 seconds of inactivity or 
longer, then it's far less likely that I will start typing immediately 
afterwards.

Alan
