From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: add MAX7359 key switch controller driver
Date: Fri, 8 May 2009 20:36:25 -0700
Message-ID: <200905082036.26204.dmitry.torokhov@gmail.com>
References: <4A012C64.1020101@samsung.com> <20090508031859.GE30616@dtor-d630.eng.vmware.com> <4d34a0a70905081858y56dacf34of004301f93daf3e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752327AbZEIDgo@vger.kernel.org>
In-Reply-To: <4d34a0a70905081858y56dacf34of004301f93daf3e3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: Kim Kyuwon <q1.kim@samsung.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Hi Kim,

On Friday 08 May 2009 18:58:45 Kim Kyuwon wrote:
> By the way, can I ask the same question which I ask to Trilok.
> Even though I guard suspend/resume with #ifdef CONFIG_PM in the new
> patch, Could I know the good reason for this protection? Because
> '/Documentation/SubmittingPatches' says "ifdefs are ugly"

If kernel is compiled without CONFIG_PM then these functions would
be just dead weight. Generally speaking, #ifdefs are considered ugly
if they are in the middle of function code, affecting logic. But to
to compile out unneeded functionality they are OK. That's why you
often see in the kernel

#ifdef CONFIG_BAZ
void do_baz()
{
	.. real code ..
}
#else
void do_baz()
{
}
#endif

and then...

int foo()
{
	bar1();
	bar2();
	do_baz();
	bar3();
}


As you can see, foo()'s logic stays the same, there are no #ifdefs
cluttering it, but baz code either executed or not.

Hope this helps.

-- 
Dmitry
