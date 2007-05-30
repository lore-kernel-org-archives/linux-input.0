From: "Brian Magnuson" <bdmagnuson@gmail.com>
Subject: Re: [PATCH] new driver for wireless xbox receiver for review
Date: Wed, 30 May 2007 10:51:05 -0400
Message-ID: <bafd4ab0705300751q67eb54efi1a46779576e0d202@mail.gmail.com>
References: <20070529043957.GB6157@rcn.com>
	 <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
	 <20070530002846.GA8595@rcn.com>
	 <d120d5000705300540v32b2f32eub8e74b88fea6a593@mail.gmail.com>
	 <bafd4ab0705300647w3d54aaa6meee94c98005650d7@mail.gmail.com>
	 <alpine.LRH.0.98.0705301614040.22353@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5685_19582898.1180536665443"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.LRH.0.98.0705301614040.22353@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <honza@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

------=_Part_5685_19582898.1180536665443
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

First off,  are there list archives for linux-input?  I wasn't able to find
any and
http://atrey.karlin.mff.cuni.cz/lab/listserv.html is a dead link.  Remaining
comments inline.

On 5/30/07, Jan Kratochvil <honza@jikos.cz> wrote:
>
> Hello,
>
> >> > Knew that was coming :).  Should be able to manage it.  Since the
> >> wireless
> >> > model returns a expanded data format it needs to be handled
> specially.
> >> > Another flag in the xpad_device struct?
> >>
> >> We have xtype field, I think it should be used.
> >
> >
> > I don't see this field in xpad_device in your tree or Linus'.
>
> It is not yet in Linus' tree, but it definitely is in Dmitry input tree.
>
> http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=bad058541d848500b5f2cc049c1082d0b2935b7d


Indeed it is.  I think this is just some basic git ignorance on my part.  I
clearly see it in
the link you provided but if I descend from the tree link starting from top
commit at
http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=summary I get
some older
version of xpad.c.  Am I just being dense (likely) or is there something
wrong?

I noticed in your patch that you worked on some old version of xpad. You'll
> see that in dmitry tree there is support for rumble as well as other minor
> changes. (And I submited support for controlling leds yesterday)
> Btw you are stating that it process packet is based on information from
> http://euc.jp/periphs/xbox-controller.en.html, which I doubt, because this
> page
> is actually about xbox (1) controller. Not xbox 360. But on the other hand
> you
> are interpreting the report correctly. :)


Turns out I started developing from a version of xpad.c  distributed with
Ubuntu which
1) is old and 2) appears to contain some extra patches on top of that.  That
link you
refer to is a a stale comment. I'll remove it.

>
> > In any case I'll take these changes and your earlier ones, merge it into
> > xpad.c and
> > resubmit.
>
> Good luck,
> Jan


Thanks :)

-Brian

------=_Part_5685_19582898.1180536665443
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>First off,&nbsp; are there list archives for linux-input?&nbsp; I wasn&#39;t able to find any and<br>
<a href="http://atrey.karlin.mff.cuni.cz/lab/listserv.html">http://atrey.karlin.mff.cuni.cz/lab/listserv.html</a> is a dead link.&nbsp; Remaining<br>comments inline.<br><br><div><span class="gmail_quote">On 5/30/07, <b class="gmail_sendername">
Jan Kratochvil</b> &lt;<a href="mailto:honza@jikos.cz">honza@jikos.cz</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello,
<br><br>&gt;&gt; &gt; Knew that was coming :).&nbsp;&nbsp;Should be able to manage it.&nbsp;&nbsp;Since the<br>&gt;&gt; wireless<br>&gt;&gt; &gt; model returns a expanded data format it needs to be handled specially.<br>&gt;&gt; &gt; Another flag in the xpad_device struct?
<br>&gt;&gt;<br>&gt;&gt; We have xtype field, I think it should be used.<br>&gt;<br>&gt;<br>&gt; I don&#39;t see this field in xpad_device in your tree or Linus&#39;.<br><br>It is not yet in Linus&#39; tree, but it definitely is in Dmitry input tree.
<br><a href="http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=bad058541d848500b5f2cc049c1082d0b2935b7d">http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commit;h=bad058541d848500b5f2cc049c1082d0b2935b7d
</a></blockquote><div><br>Indeed it is.&nbsp; I think this is just some basic git ignorance on my part.&nbsp; I clearly see it in<br>the link you provided but if I descend from the tree link starting from top commit at<br><a href="http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=summary">
http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=summary</a> I get some older<br>version of xpad.c.&nbsp; Am I just being dense (likely) or is there something wrong?<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I noticed in your patch that you worked on some old version of xpad. You&#39;ll<br>see that in dmitry tree there is support for rumble as well as other minor<br>changes. (And I submited support for controlling leds yesterday)
<br>Btw you are stating that it process packet is based on information from<br><a href="http://euc.jp/periphs/xbox-controller.en.html">http://euc.jp/periphs/xbox-controller.en.html</a>, which I doubt, because this page<br>
is actually about xbox (1) controller. Not xbox 360. But on the other hand you<br>are interpreting the report correctly. :)</blockquote><div><br>Turns out I started developing from a version of xpad.c&nbsp; distributed with Ubuntu which
<br>1) is old and 2) appears to contain some extra patches on top of that.&nbsp; That link you<br>refer to is a a stale comment. I&#39;ll remove it. <br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;<br>&gt; In any case I&#39;ll take these changes and your earlier ones, merge it into<br>&gt; xpad.c and<br>&gt; resubmit.<br><br>Good luck,<br>Jan</blockquote><div><br>Thanks :)<br><br>-Brian<br></div></div>

------=_Part_5685_19582898.1180536665443--
