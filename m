Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69721773D
	for <linux-input@vger.kernel.org>; Sat, 11 Apr 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775921370; cv=none; b=S7wjNlnPZ/ipUNznVXfMwuL4ZiYMF8ioSXJRvitL/wDQMkNuS5/F9QH8kuTHfg2DRT3is9091Mu0EwuJuEKLndByRy8gGXeKk4BJquRyxWtiiOStU0d2FdnGtl7YSAtSXTlK+5PUI5A8Aj3v131SBrfyFyqmfWw1N6KUT+DhtUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775921370; c=relaxed/simple;
	bh=+IeYmeEsYKVFu58qghijCdkW1HvfLdlqflUVRYKO5r4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=fAfZVmpb2i3bTCioPhx1BVGwBzKGN4mewn3NMHcBaRkPXtmF6VSorv4KRii5DkzpGSVQoSlL39FoTBcpeqBZS+/ZiEROGmuSDFq3J9HwQr8EWCU8DDl6HppMNSHWOornNCmlQtDGhE47FvP1eiechhhcOsW29dIAoQNWH9zKu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THzEIs5o; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THzEIs5o"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488afb0427eso37946875e9.1
        for <linux-input@vger.kernel.org>; Sat, 11 Apr 2026 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775921367; x=1776526167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HVw5hdV+julFflQe4lq0y/SMegaJuzRdE8s87uKsU8I=;
        b=THzEIs5ow0z9j80/hvDSQCXo+LjMMGo/opKbo2Q0TnfgvPNKjWwMcf6ze435RiLi5e
         CZ/9EM/k2UfejbAqeYpYNtX28yE4jABuP3AiBZtTXehEYYe1zz72sC1SqhHSXIh3f0S4
         LcBgIQroyslhBaYNwfgSrkmMho211pCKa3RDhMdlQ2yvnc/d+UX5NKyv8Ql7ZaedSpvO
         yTtopaGex61tCp4Febw9fYusI/jpqvNyhedBJbPPS4AuuzxauE49N+mta+PmY4D6bpTU
         ugVQNhuqSjVe4pnNkGs0Re5CDvZj3uK2kk7G3BE1h/llgNVnm/lkuB71gQ2NHFhUAE4e
         89dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775921367; x=1776526167;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVw5hdV+julFflQe4lq0y/SMegaJuzRdE8s87uKsU8I=;
        b=fvV5i3W60lVYIURHNCkCd6m4sIWz62+COCVLsOA0tLDBSG8WoAVyyn8SIgOwG56a9S
         T7HKbffrEjEUMBSPBx9A2cvtujT+MmkVaFYofrkzced8qgwP4g1Zn2f5HWVR+vwo9SXG
         1Bgk7BTAik6Xyv+8gc+mveAeb87X3VBvDvCKVeoiQWXAmPKFVHBtrleIFXEQdHUqvoQ1
         lY+rCr9tZaQIDEbraMWRxCYDfqcuFrb/6r0jJ13kjsVrFtou0pQWGJXGTI3m5LQDC3Wo
         wl2+oT+jljXnw3Thjwj9L1UWa+HnbDSUene64wyLI5NRTDa9skN7ZyR9/3c7DEamZFGP
         DU6A==
X-Forwarded-Encrypted: i=1; AJvYcCWfxsdfXMFJneRlP3pWJIcy+K989nB28EKM8BZ1vduoEW6ZkO6+gUGm3AehLQcrPV0C6lq4Npnmka3t3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZ7ZZrit5CMYlMEgJ17H+8qVFP5eo17O6tLlVDZYVxDNDTuqI
	EMKwe5nYb3p/h8nS3o28KkgGLYfzeWJJFHDKV+lfMK0Q2S/7MP28beHt
X-Gm-Gg: AeBDiet45wnG8vvkBUSU3X+HyV6BsoIM6vPJsiq3CYVddw9nhSBUKc47kDLoWQJd8jb
	+snhRnVIpQPOlq0WW2ZUFgYZ0mN+jl0jM07WKIjSylC5A5yhdW/60TN7XW4yETL9hREuF1i/O/M
	qlLY7jpiovk9D342NmAKH5gsnLmI/b67wv1CbSB2XYZm9mIYt+8s/XntRRHRjnW+YcvPDWVIzA9
	qiNX3dWq+7hr4wG9ifc3W4QIox1kZu5f2KnRjOfowwLgm6IcAHaSL50nfPDYiksvmKhR9sFKSwr
	3E37uLBmh9rC/psDkJUzPF+yd6ZUAvaF+77mtbcECJL/eX2eQircOBxi2BK1rwv2aVQzdMfycfF
	GnsHJ0t0T/1ErWpb5rkWZ3fOiWyJxF8QBLem1VGF/+H8ucqaLcrju7RnVuPTid2CvLLzPXabKoY
	dZM9xWDxSefr351Lug2vLT7vJP
X-Received: by 2002:a05:600c:c16d:b0:488:be21:54ae with SMTP id 5b1f17b1804b1-488d66504bfmr103120025e9.0.1775921367203;
        Sat, 11 Apr 2026 08:29:27 -0700 (PDT)
Received: from localhost ([81.6.39.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63ab84cdsm16809239f8f.0.2026.04.11.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:29:26 -0700 (PDT)
Date: Sat, 11 Apr 2026 17:29:25 +0200
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
In-Reply-To: <631510d1-2b9a-4288-a0ac-1c3d1253a0fa@endrift.com>
Message-Id: <3D95AXVJ22C7J.26Z5DELLJGZTA@homearch.localdomain>
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
> On 4/10/26 12:44, Silvan Jegen wrote:
> > Vicki Pfau <vi@endrift.com> wrote:
> >> Replies inline
> >>
> >> On 4/8/26 12:51, Silvan Jegen wrote:
> >>> Heyhey!
> >>>
> >>> Vicki Pfau <vi@endrift.com> wrote:
> >>>> Hi,
> >>>>
> >>>> Replies inline
> >>>>
> >>>> On 4/2/26 12:09 PM, Silvan Jegen wrote:
> >>>>> Hi
> >>>>>
> >>>>> Thanks for the patch!
> >>>>>
> >>>>> Just some comments and questions inline below.
> >>>>>
> >>>>> Vicki Pfau <vi@endrift.com> wrote:
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>> +
> >>>>>> +static int switch2_set_report_format(struct switch2_controller *n=
s2, enum switch2_report_id fmt)
> >>>>>> +{
> >>>>>> +	__le32 format_id =3D __cpu_to_le32(fmt);
> >>>>>> +
> >>>>>> +	if (!ns2->cfg)
> >>>>>> +		return -ENOTCONN;
> >>>>>> +	return ns2->cfg->send_command(NS2_CMD_INIT, NS2_SUBCMD_INIT_SELE=
CT_REPORT,
> >>>>>> +		&format_id, sizeof(format_id),
> >>>>>> +		ns2->cfg);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int switch2_init_controller(struct switch2_controller *ns2=
)
> >>>>>
> >>>>> This is now a recursive call while in v1 it wasn't. I think I prefe=
rred
> >>>>> the non-recursive version as there was one place where init_step
> >>>>> state was changed while now I am not sure where it happens (and whe=
ther
> >>>>> there is a code path where we end up in an infinite recursion)
> >>>>>
> >>>>> What is the advantage of the recursive version compared to the
> >>>>> non-recursive one?
> >>>    >
> >>>>
> >>>> The old version incremented the step regardless of whether or not it=

> >>>> could confirm it had happened. Since the confirmation is now handled=

> >>>> with an external step, calling into switch2_init_step_done, the loop=

> >>>> condition would become somewhat complicated.
> >>>> I replaced it with explicit tail calls since that make the
> >>>> control flow simplier, and it is always matched with a call to
> >>>> switch2_init_step_done to ensure that the state is always advanced. =
As
> >>>
> >>>   From what I can tell switch2_init_step_done currently only advances=

> >>> the state if the current state is the expected one. This seems fine,
> >>> but it also means that if the state is not the expected one, the
> >>> state is not advanced and the recursive call continues anyway (in the=

> >>> NS2_INIT_READ_USER_SECONDARY_CALIB case, for example). I assume this
> >>> should never happen but if we end up in this case for some reason we
> >>> will recurse forever.
> >>
> >> That's correct, and the only way it would happen forever is if there's=
 a
> >> bug. The same would be true in a loop version if it doesn't advance th=
e
> >> state properly either, fwiw, which happened during development of this=

> >> version. Regardless, I can reduce the chance of introducing such a bug=

> >> by passing ns2->init_step instead of a constant, so I'll make that
> >> change in v4.
> >>
> >>>
> >>> The same case also potentially calls switch2_read_flash and it isn't
> >>> clear to me if this means that the initialisation is done (as there
> >>> is no switch2_init_step_done call and we are not in the FINISH state
> >>> either). There is also the possibility of switch2_read_flash calling
> >>> switch2_init_controller again, which one then has to check ... (note
> >>> that this is not the case here though)
> >>
> >> switch2_handle_flash_read will advance the state once it's verified th=
at
> >> the read actually happened. If the step failed for whatever reason, th=
is
> >> same codepath will retry the specific read, as the caller
> >> (switch2_receive_command) will always call into switch2_init_controlle=
r
> >> if setup isn't done. This is how the retry logic works.
> >=20
> > Ah, so the call chain looks something like the below?
> >=20
> > switch2_read_flash->
> > switch2_usb_send_cmd->
> > switch2_usb_message_in_work (?)->
> > switch2_receive_command->
> > switch2_handle_flash_read->
> > switch2_init_step_done
>=20
> Yes, and then switch2_init_controller is called again at the end of=20
> switch2_receive_command
> >=20
> >>
> >>>
> >>> To me it seems like it would be clearer to do a `ns2->init_step++` an=
d
> >>> then `continue` to make the progress of the state more visible and to=

> >>> do an explicit `break` when we are supposed to stop the initialisatio=
n.
> >>>
> >>
> >> The problem with the loop approach, in my opinion is due to the fact
> >> that the loop is the *exception*, not the rule. The loop idiom makes i=
t
> >> look like a loop is expected. Further the ns2->init_step++ in the
> >> previous version means that the verification does not occur, so in the=

> >> case of any sort of failure it'll plow ahead anyway instead of retryin=
g.
> >> The point of this approach is to avoid that.
> >=20
> > In my mind a while-loop like you mentioned it above would make the stat=
e
> > changes more obvious (since they could all be done in the loop body), w=
hile
> > still allowing for retries. Something like the below, perhaps (untested=
).
> >=20
> > while (ns2->init_step < NS2_INIT_DONE) {
> > 	switch (ns2->init_step) {
> > 		...
> > 		case NS2_INIT_READ_FACTORY_TRIGGER_CALIB:
> > 			if (ns2->ctlr_type !=3D NS2_CTLR_TYPE_GC) {
> > 				ns->init_step++
> > 				continue;
> > 			}
> >=20
> > 			ret =3D switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB=
,
> > 			        NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB);	=09
> > 			if (ret) {
> > 				// if it makes sense to retry here
> > 				continue;
> > 			}
> >=20
> > 			ns->init_step++
> > 			break;
> >=20
> > 		case ...
> > 	}
> > }
> >=20
>=20
> This can't be done because the process is fundamentally asynchronous.=20
> We'd have to block on waiting for a reply to the USB packet, which is=20
> not a good idea. This is why switch2_receive_command calls into=20
> switch2_init_controller at the end: it's resuming where it left off.=20

Ah, that wasn't clear to me either.

I assume having the code wait for the reply is not allowed because
otherwise it would stall the whole bootup process (or will there be some
sort of dedicated Kthread for this)?

Are you aware of any documentation where I can read up on how the probing
of USB HID devices work in the Linux Kernel?

Thanks for the help!

> Each of those returns is a step that interacts with the hardware, and we=20=

> need to wait for the hardware to reply.
>=20
> There is a potential weird interaction here whereby if we get an=20
> unprompted command and/or reply from the controller it will retry a step=20=

> before it gets a reply for it, but in practice this doesn't happen. The=20=

> controllers, as far as we know, only reply and never initiate any=20
> commands. Furthermore, all of these steps are also idempotent, so it's=20=

> not a big deal of they get repeated erroneously.

Could there be another reply incoming while the driver is still processing
the previous one? I assume at least at probing time that shouldn't be
the case. I wouldn't expect an USB HID device to send unsolicited replies
in general ...

Cheers,
Silvan
