From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 2/2] drivers: input: mouse: alps: drop unneeded likely()
 call around IS_ERR()
Date: Tue, 20 Aug 2019 16:22:04 +0200
Message-ID: <20190820142204.x352bftlvnb7s57n@pali>
References: <1566298572-12409-1-git-send-email-info@metux.net>
 <1566298572-12409-2-git-send-email-info@metux.net>
 <20190820111719.7blyk5jstgwde2ae@pali>
 <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On Tuesday 20 August 2019 14:21:33 Enrico Weigelt, metux IT consult wrote:
> On 20.08.19 13:17, Pali Rohár wrote:
> > On Tuesday 20 August 2019 12:56:12 Enrico Weigelt, metux IT consult wrote:
> > > From: Enrico Weigelt <info@metux.net>
> > > 
> > > IS_ERR() already calls unlikely(), so this extra unlikely() call
> > > around IS_ERR() is not needed.
> > > 
> > > Signed-off-by: Enrico Weigelt <info@metux.net>
> > > ---
> > >   drivers/input/mouse/alps.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > > index 34700ed..ed16614 100644
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -1476,7 +1476,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
> > >   		/* On V2 devices the DualPoint Stick reports bare packets */
> > >   		dev = priv->dev2;
> > >   		dev2 = psmouse->dev;
> > > -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> > > +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
> > >   		/* Register dev3 mouse if we received PS/2 packet first time */
> > >   		if (!IS_ERR(priv->dev3))
> > >   			psmouse_queue_work(psmouse, &priv->dev3_register_work,
> > 
> > Hello! Two months ago I already saw this patch. See discussion:
> > https://patchwork.kernel.org/patch/10977099/
> 
> phuh, that's long chain of links to folow ;-)
> 
> So, your primary argument is just *documenting* that this supposed to
> be a rare condition ?

Yes. Also Dmitry said that prefer explicit unlikely.

> In that case, wouldn't a comment be more suitable for that ?

And why to add comment if current state of code is more-readable and
does not need it?

I do not see anything wrong on this code path.

People normally add comments to code which is problematic to understand
or is somehow tricky, no so obvious or document how should code behave.

> It seems that this issue is coming up again and again ... when people
> run cocci scans (like I didn't), I'd suspect this to happen even more
> in the future.

People first need to understand that static code analysis cannot work
100% reliably and always is needed to properly review changes.

And if the only reason for this change is to satisfy some static code
analysis program, would not it better to teach this program to no
generate such false-positive results?

-- 
Pali Rohár
pali.rohar@gmail.com
