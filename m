From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] add analog devices AD714X
	captouchinput driver
Date: Fri, 9 Oct 2009 05:18:45 -0400
Message-ID: <8bd0f97a0910090218j6a2aa6aaq497fba3f04d7b19f@mail.gmail.com>
References: <1252652006-5270-1-git-send-email-21cnbao@gmail.com>
	<8A42379416420646B9BFAC9682273B6D0DC3BD95@limkexm3.ad.analog.com>
	<8bd0f97a0910090156g2a8fba58r4085422f3a79c892@mail.gmail.com>
	<1255079007.8362.70.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1255079007.8362.70.camel-uXGAPMMVk8bAQYKIod7YupZV94DADvEd@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "Hennerich,
	Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 9, 2009 at 05:03, David Woodhouse wrote:
> On Fri, 2009-10-09 at 04:56 -0400, Mike Frysinger wrote:
>> > Who says that a driver can't have two module_init()?
>>
>> Mr. C Code says it wont work.
>
> It could be fixed -- it works when the module is built-in; it could be
> made to work in the way way when it's a module.

probably, but it opens a fairly large can of worms that until now, no
one has really complained as a real problem.  if all the module_init
functions do not return the same thing (i.e. all pass or all fail),
what do you do ?
 - return an error to userspace an unload module (this happens today)
 - return an error to userspace but leave module loaded
 - do not return an error and leave the module loaded

if you leave the module partially loaded, how do you know which fini
functions to run ?  in this case, we have an init/fini func for spi
and an init/fini func for i2c.  if the spi worked but i2c failed, we
obviously dont want to run the fini i2c func with a partially loaded
module.

today, modules that lack a fini func are not allowed to be unloaded.
how do you know in a multi init/fini setup which ones have a
corresponding fini ?  presumably the answer here would be resolved
naturally if the previous question is answered.

i also imagine the rest of the module framework in the kernel will
need significant changes all over the place to handle an array of
init/fini functions.  this is a pretty hard sell when the answer could
simply be: make more damned modules in your driver.  we could have
three modules here: ad714x, ad714x-i2c, ad714x-spi.  then all of the
issues raised by Michael and the things i raise above all magically
resolve themselves with the framework we have today.

personally, i think catering to this highly unlikely edge case is time
that could be spent on other much more realistic cases

> How did I get subscribed to this list, anyway?

i think i might have accidentally added you to the subscribed list
while processing moderation requests when i meant to add you to just
the approved list.  i'll fix it up of course, sorry about that.
-mike
