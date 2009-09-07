From: Harald Welte <laforge@gnumonks.org>
Subject: Re: Fragmentation of Samsung SoC code (was INPUT][KEYBOARD] Add
	new keypad driver for s3c series SoCs)
Date: Mon, 7 Sep 2009 18:38:40 +0900
Message-ID: <20090907093840.GA3962@prithivi.gnumonks.org>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com> <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com> <20090907062658.GS3962@prithivi.gnumonks.org> <9c9fda240909062359s1629f7a4p65717ad07dcc22ca@mail.gmail.com> <20090907080202.GW3962@prithivi.gnumonks.org> <9c9fda240909070132u64df987cydd5cfacec989819@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:47925 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbZIGK3H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 06:29:07 -0400
Content-Disposition: inline
In-Reply-To: <9c9fda240909070132u64df987cydd5cfacec989819@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: =?utf-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?utf-8?B?6rmA6rK97J28L0FQ6rCc67Cc7YyAL0UzL+yCvOyEseyghOyekA==?= <ki0351.kim@samsung.com>, =?utf-8?B?6rmA6rWt7KeEL0FQ6rCc67Cc7YyAL0U1L+yCvOyEseyghOyekA==?= <kgene.kim@samsung.com>

Hi Kyungmin,

On Mon, Sep 07, 2009 at 05:32:08PM +0900, Kyungmin Park wrote:
> > They will merge your patches if you send them! =A0They will learn a=
s much from
> > you, as they are from me when I provide feedback.
>=20
> It's already sent by Joonyoung,

Do you mean the patch for your full driver code, or actually patches th=
at
modify the System LSI driver?

System LSI will merge patches you send which they can apply to their co=
de.

If you just simply send your driver (which conflicts with their driver)=
, this
will not work.

Your patches will have to come incremental to their work, so System LSI=
 can apply
them to their tree.

> > So rather than continue to try to compete with each other, you need=
 to work
> > together. =A0If you think your code is superior, why not submit you=
r code as
> > patches to System LSI, or even ask System LSI if you can either
>=20
> It's because we don't get same base code. LSI works on s3c6410, but w=
e
> s3c6410, s5pc100 and s5pc110.

System LSI also works on s5pc100 and s5pc110, as I assume you know.  Th=
ey
work on code for all of their SoCs ;)

It is simply that the way their workflow is now structured with regard =
to
mainline that they will first send patches to complete the 6410 support=
,
and then move to 6440, c100 and last c110

> we trying to post the patches related with s3c6410 but it takes long
> time to merge to Ben's git.

Well, I think this is something you have to discuss with Ben.

But anyone who works with mainline has to send incremental changes.  So=
 if you
submit a keypad driver that contains code for a SoC that is not in main=
line
yet, it will not get accepted.  You need to get the order right.   This=
 is
independent who does the work, LSI or DMC, or anyone else.

> Anyway. please let me know which the next patch. touchscreen? or othe=
rs?
> Than we can compare the devices sources and discuss internally and th=
en post it.

I will follow-up in a different mail, as this is becoming way too off-t=
opic for
linux-input.

> > It is not "they" vs. "you" vs. "us", it is all of us together. =A0T=
here is too
> > much work to be done. =A0There is 6400,6410,6440,6430,6442,c100,c11=
0 and more
> > products lining up in the future. =A0Many drivers spanning various =
subsystems.
> > Only if the resources are put together this task can be finished in=
 any
> > reasonable amount of time.
>=20
> That's reason to send our codes. Now you focus on the s3c6410 but we
> already know the s5pc1xx series.

My focus is on aligning System LSI division's development for _all_ SoC=
's.

As indicated before, they now no longer work on fixed kernel versions, =
but they
always pull/merge from torvalds/linux-2.6 to make sure their code is mu=
ch
closer to mainline.

> > System LSI is pushing their code for mainline, one patch at a time,=
 like
> > we are seeing with this keypad driver right now. =A0This will gener=
ate feedback
> > by the community (including you). =A0System LSI then incorporates t=
hat feedback
> > and re-submit an updated version of the driver - just like any othe=
r person
> > who submits code to Linux mainline.
>=20
> I think no problem to send several patch or drivers parallel. If so w=
e
> can get more feedbacks.

I disagree.  Two departments of Samsung writing two drivers and then su=
bmitting
them to the mailinglists

1) makes everyone, esp. the maintainer have to review two drivers
2) confuses the maintainer, as he does not know which one to apply

Anyway, I think we should continue this discussion off-list and see how
we can structure the workflow in a better way.

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks=
=2Eorg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch=
=2E A6)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
