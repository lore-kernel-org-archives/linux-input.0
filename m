Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1E30F7E8
	for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776361124; cv=none; b=tQFOvmTf3zTyFVGc9kTpzq1a90j3CFMApmVTpnj9cnPXciwke3HMXmup+ODi4HOhkmXzXb8R7IO8IKsPi3W6hISERgaHjX0qTGjdUXxGP7ecCpbqzfWuL94T3MJ0oApDtbg4vgXFby3WXOr3MBfBcLP2y8Tfsn2hqtG4S61OQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776361124; c=relaxed/simple;
	bh=BZ+24iXZEC1PRASbgGmmSh+Uju6qEmMfcHUxZ3xV5nY=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=i8lgvcgZp6AnT+FSZJHmM9loR/H7i/0udDam73CS7LPQRBpra5OaAtNwB5w6lh1ZRZkz+VzYtG1oFtSHeX93AoE1ra6WtknerrgYDcStV2jKdWpcCItr1NmszTwPYdOLNfDEfpJTU7sSchKV68EgTFsdjoVUstLW5timG8ul0CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAxd0CyA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAxd0CyA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso125977495e9.3
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776361121; x=1776965921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D8RSn48L4Hoxdvbx7PGbILJFZ/y2Lv8iAOeSsgk7+aQ=;
        b=ZAxd0CyAsxtb2U1DUx7nFAuM9w5kNBjVQQ6VS/eoLNBFvRhm0Z0TdTJAxfxzM48U7Z
         He1RGLN6AwOsPfXuvYp1xG3i3+fltE3RiJp7d5BcLOxlzhZVBo8x/1+/kxy1MS74yE5t
         KElQsjknf07tSmSvEWy0ExY1r7jF0dg9lu4T4+IecgDQG6jCj/x/GG5iB48I4agLEFvN
         oTHKpWu5fKgroJRwSZnMXguqMaSnp0sGMc0tR9Li4ux7h4UO0YdhAnTEY05F3cdJUMPm
         N13vc4NhFD1BslX4a6LI/rivEj6IaEDDzKHiBXjqFqH/IyRQXmi151jC8T3xrLSD9ya6
         09Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776361121; x=1776965921;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8RSn48L4Hoxdvbx7PGbILJFZ/y2Lv8iAOeSsgk7+aQ=;
        b=f3OSdSJkUaDBvNjlAu+T8tKfkLE0iohq6X69fZ8aOLd4tFMmrQyAQiS+v4Wy77y9M5
         9lOYpqj0i1synPOorF5A7ekVxGGpbSAe2Ji0NT24y0MHCjHTfJJ06vJhGuxbtNMFWOTl
         nCgSRPRpddY47ksCbdNExJM+MDDKk785vCuohHAhTsLqvP95/r5p9fLTNCq68jZsBMDi
         jhPQbBmz4OohiChL5qWvZTktYADOJDAsRfacvk6ccgdwgr+A60IZtzAVzkGRxohYvzpx
         EGUTYVw5Lj4hp39Zk4CbUSkPGgTOJ2v3I849dwhszw4yujaioP9P4He5GBWTmWMMX1sK
         5RNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WR0BcG+L+f6331nNr9FcfCYQZQBe31E4iaswPXxgCn6POM3xCzo2ITfzpc6kUdfSAJjAjeCDqEnQmTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqri4WujNVEfA7hxhYTVNC7JTBj4LSs0jUXoiSqwRC/az62A0g
	RgJ2QnB+rOnO8+DCzeeAa2rWlb6hRXm7ZaRnV69GfFi93MtSdHmeOydu
X-Gm-Gg: AeBDietHKKHJFal2BS5QZtWPyeassYVJkIcFbr04dOApxBxN42391fKQlRK+5u5sv+G
	1KaxVlAwP3DiK/FtRXa+vK6y4Qs8gatNLf0SMGxYpCyf12Kuhr9B662VFRLrcYSDsJuxBo85Sun
	p6NZUja4Fp06+IaWGmXY+YZ2FoyNiN5lfA+xibihM6mwAJXIHNQIxLeMcq9C1r2zeUUtLDMlN9o
	1y/7HJqy+0wMs3cxkRJB20L/UV/55uMZwdk1P3HNnzO+Jk8bF4P7ARjl/f2sHwG1w7Eg1rrmMZz
	TOSxhyump8ObGEy3700rBUYoyK0aety83GTR+AGrVXHt0Zq3BwqrOXpU9ycj52aShYBTLXgS5OI
	K6HOiTtiTovO05EpDM1NnRRbE2RjCNETzus111hJ/3xAIWXRlTcRunn3japX1t4qG2OO0muRtbz
	hAlnenfLcoR49GNP5H+g+i0EK4Yw==
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr260980485e9.19.1776361120405;
        Thu, 16 Apr 2026 10:38:40 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581b9fbsm66770985e9.5.2026.04.16.10.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 10:38:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 19:38:39 +0200
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260318030850.289712-1-vi@endrift.com>
 <20260318030850.289712-2-vi@endrift.com>
 <3GWQPE79MJ7Y0.2LOOIA8A83N7R@homearch.localdomain>
 <ee55d9f8-506d-4b95-a63b-01844e4e1bdf@endrift.com>
 <2Z2BPKWVI345D.3HJTS194G9TXN@homearch.localdomain>
 <a2b087ef-e814-444a-9c1e-716310ed1948@endrift.com>
 <3GLFHF2SBGI6U.3O3D6XCXP4074@homearch.localdomain>
 <631510d1-2b9a-4288-a0ac-1c3d1253a0fa@endrift.com>
 <3D95AXVJ22C7J.26Z5DELLJGZTA@homearch.localdomain>
 <092fa3e7-da59-4b3a-b3e4-c412e391fd3d@endrift.com>
In-Reply-To: <092fa3e7-da59-4b3a-b3e4-c412e391fd3d@endrift.com>
Message-Id: <2GA4OPTHV6V4V.3QTZM7EDGHKCF@homearch.localdomain>
User-Agent: mblaze/1.4-1-g5a69507 (2026-01-24)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Vicki Pfau <vi@endrift.com> wrote:
>=20
>=20
> On 4/11/26 8:29 AM, Silvan Jegen wrote:
> > Vicki Pfau <vi@endrift.com> wrote:
> >> On 4/10/26 12:44, Silvan Jegen wrote:
> >>> Vicki Pfau <vi@endrift.com> wrote:
> >>>> Replies inline
> >>>>
> >>>> On 4/8/26 12:51, Silvan Jegen wrote:
> >>>>> Heyhey!
> >>>>>
> >>>>> Vicki Pfau <vi@endrift.com> wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Replies inline
> >>>>>>
> >>>>>> On 4/2/26 12:09 PM, Silvan Jegen wrote:
> >>>>>>> Hi
> >>>>>>>
> >>>>>>> Thanks for the patch!
> >>>>>>>
> >>>>>>> Just some comments and questions inline below.
> >>>>>>>
> >>>>>>> Vicki Pfau <vi@endrift.com> wrote:
> >>>>>>>>
> >>>>>>>> [...]
> >>>>>>>>
> >>>>>>>> +
> >>>>>>>> +static int switch2_set_report_format(struct switch2_controller =
*ns2, enum switch2_report_id fmt)
> >>>>>>>> +{
> >>>>>>>> +	__le32 format_id =3D __cpu_to_le32(fmt);
> >>>>>>>> +
> >>>>>>>> +	if (!ns2->cfg)
> >>>>>>>> +		return -ENOTCONN;
> >>>>>>>> +	return ns2->cfg->send_command(NS2_CMD_INIT, NS2_SUBCMD_INIT_SE=
LECT_REPORT,
> >>>>>>>> +		&format_id, sizeof(format_id),
> >>>>>>>> +		ns2->cfg);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static int switch2_init_controller(struct switch2_controller *n=
s2)
> >>>>>>>
> >>>>>>> This is now a recursive call while in v1 it wasn't. I think I pre=
ferred
> >>>>>>> the non-recursive version as there was one place where init_step
> >>>>>>> state was changed while now I am not sure where it happens (and w=
hether
> >>>>>>> there is a code path where we end up in an infinite recursion)
> >>>>>>>
> >>>>>>> What is the advantage of the recursive version compared to the
> >>>>>>> non-recursive one?
> >>>>>    >
> >>>>>>
> >>>>>> The old version incremented the step regardless of whether or not =
it
> >>>>>> could confirm it had happened. Since the confirmation is now handl=
ed
> >>>>>> with an external step, calling into switch2_init_step_done, the lo=
op
> >>>>>> condition would become somewhat complicated.
> >>>>>> I replaced it with explicit tail calls since that make the
> >>>>>> control flow simplier, and it is always matched with a call to
> >>>>>> switch2_init_step_done to ensure that the state is always advanced=
. As
> >>>>>
> >>>>>   From what I can tell switch2_init_step_done currently only advanc=
es
> >>>>> the state if the current state is the expected one. This seems fine=
,
> >>>>> but it also means that if the state is not the expected one, the
> >>>>> state is not advanced and the recursive call continues anyway (in t=
he
> >>>>> NS2_INIT_READ_USER_SECONDARY_CALIB case, for example). I assume thi=
s
> >>>>> should never happen but if we end up in this case for some reason w=
e
> >>>>> will recurse forever.
> >>>>
> >>>> That's correct, and the only way it would happen forever is if there=
's a
> >>>> bug. The same would be true in a loop version if it doesn't advance =
the
> >>>> state properly either, fwiw, which happened during development of th=
is
> >>>> version. Regardless, I can reduce the chance of introducing such a b=
ug
> >>>> by passing ns2->init_step instead of a constant, so I'll make that
> >>>> change in v4.
> >>>>
> >>>>>
> >>>>> The same case also potentially calls switch2_read_flash and it isn'=
t
> >>>>> clear to me if this means that the initialisation is done (as there=

> >>>>> is no switch2_init_step_done call and we are not in the FINISH stat=
e
> >>>>> either). There is also the possibility of switch2_read_flash callin=
g
> >>>>> switch2_init_controller again, which one then has to check ... (not=
e
> >>>>> that this is not the case here though)
> >>>>
> >>>> switch2_handle_flash_read will advance the state once it's verified =
that
> >>>> the read actually happened. If the step failed for whatever reason, =
this
> >>>> same codepath will retry the specific read, as the caller
> >>>> (switch2_receive_command) will always call into switch2_init_control=
ler
> >>>> if setup isn't done. This is how the retry logic works.
> >>>
> >>> Ah, so the call chain looks something like the below?
> >>>
> >>> switch2_read_flash->
> >>> switch2_usb_send_cmd->
> >>> switch2_usb_message_in_work (?)->
> >>> switch2_receive_command->
> >>> switch2_handle_flash_read->
> >>> switch2_init_step_done
> >>
> >> Yes, and then switch2_init_controller is called again at the end of=20=

> >> switch2_receive_command
> >>>
> >>>>
> >>>>>
> >>>>> To me it seems like it would be clearer to do a `ns2->init_step++` =
and
> >>>>> then `continue` to make the progress of the state more visible and =
to
> >>>>> do an explicit `break` when we are supposed to stop the initialisat=
ion.
> >>>>>
> >>>>
> >>>> The problem with the loop approach, in my opinion is due to the fact=

> >>>> that the loop is the *exception*, not the rule. The loop idiom makes=
 it
> >>>> look like a loop is expected. Further the ns2->init_step++ in the
> >>>> previous version means that the verification does not occur, so in t=
he
> >>>> case of any sort of failure it'll plow ahead anyway instead of retry=
ing.
> >>>> The point of this approach is to avoid that.
> >>>
> >>> In my mind a while-loop like you mentioned it above would make the st=
ate
> >>> changes more obvious (since they could all be done in the loop body),=
 while
> >>> still allowing for retries. Something like the below, perhaps (untest=
ed).
> >>>
> >>> while (ns2->init_step < NS2_INIT_DONE) {
> >>> 	switch (ns2->init_step) {
> >>> 		...
> >>> 		case NS2_INIT_READ_FACTORY_TRIGGER_CALIB:
> >>> 			if (ns2->ctlr_type !=3D NS2_CTLR_TYPE_GC) {
> >>> 				ns->init_step++
> >>> 				continue;
> >>> 			}
> >>>
> >>> 			ret =3D switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_TRIGGER_CAL=
IB,
> >>> 			        NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB);	=09
> >>> 			if (ret) {
> >>> 				// if it makes sense to retry here
> >>> 				continue;
> >>> 			}
> >>>
> >>> 			ns->init_step++
> >>> 			break;
> >>>
> >>> 		case ...
> >>> 	}
> >>> }
> >>>
> >>
> >> This can't be done because the process is fundamentally asynchronous.=20=

> >> We'd have to block on waiting for a reply to the USB packet, which is=20=

> >> not a good idea. This is why switch2_receive_command calls into=20
> >> switch2_init_controller at the end: it's resuming where it left off.=20=

> >=20
> > Ah, that wasn't clear to me either.
> >=20
> > I assume having the code wait for the reply is not allowed because
> > otherwise it would stall the whole bootup process (or will there be som=
e
> > sort of dedicated Kthread for this)?
>=20
> I'm not sure there is a synchronous USB API at all, but if there is it
> should really only be used when absolutely necessary. If you can get
> away without blocking, do.

Makes sense!


> >=20
> > Are you aware of any documentation where I can read up on how the probi=
ng
> > of USB HID devices work in the Linux Kernel?
>=20
> This has nothing to do with HID, actually. The Switch 2 controllers
> have a proprietary side-channel interface that we need to poke at here
> to get it to do anything. It's called cfg in the code and over USB
> it uses a bulk interface, which is unusual. Presumably because the

I have seen this part of the code, but have assumed that it's actually
part of the regular HID spec ...


> side-channel doesn't care about latency, whereas the HID interface
> does. Something similar happens over bluetooth where they're accessed
> through disparate attributes. The latter isn't handled here yet,
> though.
>=20
> >=20
> > Thanks for the help!
> >=20
> >> Each of those returns is a step that interacts with the hardware, and =
we=20
> >> need to wait for the hardware to reply.
> >>
> >> There is a potential weird interaction here whereby if we get an=20
> >> unprompted command and/or reply from the controller it will retry a st=
ep=20
> >> before it gets a reply for it, but in practice this doesn't happen. Th=
e=20
> >> controllers, as far as we know, only reply and never initiate any=20
> >> commands. Furthermore, all of these steps are also idempotent, so it's=
=20
> >> not a big deal of they get repeated erroneously.
> >=20
> > Could there be another reply incoming while the driver is still process=
ing
> > the previous one? I assume at least at probing time that shouldn't be
> > the case. I wouldn't expect an USB HID device to send unsolicited repli=
es
> > in general ...
>=20
> Replies only come in one at a time. Unless we send multiple messages
> without waiting for a reply first, which this code is specifically
> designed *not* to do, I don't think it will happen in practice.

That's what I would have expected as well. Thanks for clearing that up!

Cheers,
Silvan
