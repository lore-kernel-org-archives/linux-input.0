Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E23DFC65
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654328; cv=pass; b=NUNBFjVJIbvH2rWJCsyLL0Z/BnqCqHLzN+5hsyGONpAH7qPyDzaAyGxd3DdjrkqUyBtYc9h09xgRGES/0DGMC4Bw+X2/Gl1+cRqBb4ki23CGySF9Eo8si1W8qf1TSkvOCstzZg56DxTB978TV91SBaHD/uCqNPucKYuLp6ClwX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654328; c=relaxed/simple;
	bh=mvI04qvZp8HUqnJLJ4Bj1Xss/Dkbf2fCYum5sSK2xfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk7pugmxJVy7PiWT+B4mA/kdPP2Y6DslbbbwPIHnaojJUuhPCAzMCIO2me79/wcU1BMXKhsGwIStE0NVzB/mQk8t64Z7GX12cqLPpSm4IQI8lGHh2Z8yZQ25HPvVOE2iimbD801I7+iuJ/a7014l2QMId3I6nsVgABWUhRb4MSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvq6loSC; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvq6loSC"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a3486419cso1450341fa.3
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 11:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772654326; cv=none;
        d=google.com; s=arc-20240605;
        b=BLStFHe9ODfYrOnasFNOrW7me33eMOQTcU1tcPxzLTiySqTAkb6WrAmQYjd2jC/hs+
         gz5xhyIt1SSyOTcEh4QXGUqWmUieD1VJFAXJKjBSHCE3ChQ6ZWfM4belCc1ECGe6ckgg
         wTz2HOugy3N7VLiX+fy+s0zE09NPXyXuirLdbMqYr5uxgD6htpCDAppG6mcHRX7ceLfA
         DOM1BqW4GP8XK3EUaCXXoGtNSAR7mVsZ2JMMMPrsR0jL0oMeDui+rRgGE0ZPKrHJ1p3q
         pcmume4g1AXEZaDFMs0z5LfQx05sTv5vxXfwAKxr46YutaMh3wgUNWyQrm34Kast0JaD
         YczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mvI04qvZp8HUqnJLJ4Bj1Xss/Dkbf2fCYum5sSK2xfA=;
        fh=b0bhvTnyQedhfE6LNlor90MIQQW12g7ANtcVVdTLQ2c=;
        b=B5xJLD0uV4cxcRWM2WLC3qKhMWG5Fl3CTMVksJsDHJeVaxODMhVBK0S5fl7Z1Asvtt
         Zu3J3TywQecM+JMK2OXzjMwfoKENWZP84rIJ6uzaT02lPJV5TVZQ8JkZp5GXhHg24k7A
         zHQb1TAhuyLnCk3nA3x0kowdxIMqUZ5xLflTXdERWJzuRZYnIHMMZpNyZ7MHKVxwZYdS
         ndFuR2lxJKrQgsQ5T8fvPTsRxNWeMJB3gBUSgeva0NRp7CEQK2svUNTaKbj0bqHOGdtU
         oGqGGOHAUKoy3THYdvYh7Oc74pholidiXFnrwwDcuxUCm3mOu5+wpk49wd5noS98KExq
         IEAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772654326; x=1773259126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvI04qvZp8HUqnJLJ4Bj1Xss/Dkbf2fCYum5sSK2xfA=;
        b=Cvq6loSCm7um2lgOFz1ZkNx55afLZvnv4VKTkUUySnEhSeZC/DQ8gQqYK+uj47Dldm
         BBFCZd9NKdwAv+qKCpb+y0GkCQjonIyidPYffLFPRL7GKfVcS7ScQiXGWGzHsxSkEc/2
         mV2gglaRZL4l0t1btZ4lTPuPXVQp5EUMVuT/w1/lR7RA87XMef/1rZVTEuOkki2V2yw6
         MJaQQ2qvNsp4DyU+6y97iCEQUoWZMWoTuajl7O/y1OkNSzZEJ54eoTG0a6Tf9I0CqY/k
         OHIu5Z/P3cJ6mUQXL6YQtG82wK0LHOtMvdux/5RmTkBqPjQgNHxm9PscJBEd3ooouDcz
         rVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772654326; x=1773259126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvI04qvZp8HUqnJLJ4Bj1Xss/Dkbf2fCYum5sSK2xfA=;
        b=eTTZ0E4C1Z3RsvtcTUESwGvymPFZnAuDXgA5OuMYoVgBfc6vrrqRx+Hyjx3vSCzWzY
         YMFUtItYbDgpyAQ68N1yK8b4cwoNgoNaip/7x7/EyFOOhqgIsNZKp4otLjvGjjrCTKVd
         FWvWKUQS7RuLyPBS/WS9uCDHRtuBYyd44GJWjPXsosVGEJJ/rXsFiokPpQRC2UExw4BJ
         P0/ZcnNOQ8OyWHJxYreGW2ti/mZMFPcIFhxr+LQa1LgblOoc2/TeNUz6vJpmUMMuo0T5
         skaCCmVODBAi1pPgnBoW+hAeqVaa4BdDBoj7G8tUNcMCbvLI1g/V+x1LupSvcgosWFa0
         4GvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSkiTfSAV7vDBDDq+Qm/+c/GxcciaJ5B+qPZ9ok+eoVnuq5yxm806Yo854pJ3neqHQNFWFgf+Sn0eMeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXPPC/wHzAi0fgvCSUzmRg/ECDMYvISxr1IAYsCsIqDyo3Ait
	UPrn+c76hTeDmqsOEelM/JDILa105tl/cJEtzVYIqvNcgaDqrhEA9U4GwNNbehTOXikRpjeb5Dy
	qsQKJzTdGqd6Z/BzGDKuqp+e+sg3FdTk=
X-Gm-Gg: ATEYQzyzQCyvdBLmrhJzRT2PjFXtprAg4JZ0cPbbDyJ39icb2551t6xj4s2Va6RmI9n
	D87OEMDKVzF72YxOEBc2+vB3dj8wBYcb9bFquo8AM4ThcV0q5PbOD8m0i5OI+ZseVr68Tmb+2zc
	taTFvAQDR3AfamqxABhf3joFjXU4bqLaxa/jzrBSf3Vy9KJeutoJ1292BHd0XSbQcjEPIjTB/rK
	vwk6WamN55Mz6z/Z37RsI6Nve2nqb5mgZ0Un5JJLIgwV2uZHz6HkFFCE1mN1upxSuWN2uMnO9Ml
	3U907onzb6LURL2BlLd5gaQuj5vOkb8le9UqezLil5uZxMrU+W/lzfmrzzBBDLuXG52Jte2bOZ7
	pB7COKjwnCpKE
X-Received: by 2002:a05:651c:20c2:b0:383:246a:74ec with SMTP id
 38308e7fff4ca-38a2c58fb4fmr18269771fa.18.1772654325457; Wed, 04 Mar 2026
 11:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304010345.1355896-2-sanjay.govind9@gmail.com>
 <aaeI1p_Zd0v31-p1@google.com> <CALQgdA0PL82yLxWbjcqchWzsf+bA7_Egq9hZFzz7toL4kByAvw@mail.gmail.com>
 <aaeLgPyFDeA6dxq1@google.com> <CALQgdA0q=+6L2mQBqNPUBzo+HE6=AjhSPv5G_dK9g=V2npSsWA@mail.gmail.com>
In-Reply-To: <CALQgdA0q=+6L2mQBqNPUBzo+HE6=AjhSPv5G_dK9g=V2npSsWA@mail.gmail.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Thu, 5 Mar 2026 08:58:33 +1300
X-Gm-Features: AaiRm50ujhlxGQnRkrhUbHz_bmi9FKkkDeI-gtvpDb5vLJYaqpDM0SJ862QxmTU
Message-ID: <CALQgdA1jJUzpSvva-YM3UOvK2Cwtyb3sK7uQO8T5NxZ-OB4Y_Q@mail.gmail.com>
Subject: Re: [PATCH] xpad: expose xinput capabilities via sysattr
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 2:34=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> You need to start with enumerating what data is currently not available
> through other means and why it is needed. Is this something that other
> gamepad-like devices also lack?

Other controllers do have this sort of thing though, PS4 and PS5
controllers have a capabilities report, but since they are HID based,
SDL just requests the report directly via a hid get feature report
request.
Since xinput isn't HID based, there isn't a way to fetch these
reports, and right now that makes it difficult to discern these
devices in SDL and Wine.
Usually you could also fall back and rely on vids and pids, but 360
wireless devices don't include pids anywhere, so that isn't a usable
method here.
The only other devices I can think of that would have similar problems
would be the Xbox One controllers, but at least there we do have a
workable vid and pid, so we can just rely on that since the descriptor
format is much more complicated in that scenario.

If it was prefered, we could go some route where we put the entire
capabilities blob into a single sysattr as JSON or something, which is
similar to the route unity went with for this sort of thing, or if
there is some way to request data in a similar fashion to how HID has
feature reports, i'd be happy to just implement some sort of
capabilities request, I just didn't see a way to do that when i was
trying to implement this.

On Wed, Mar 4, 2026 at 2:46=E2=80=AFPM Sanjay Govind <sanjay.govind9@gmail.=
com> wrote:
>
> On Wed, Mar 4, 2026 at 2:34=E2=80=AFPM Dmitry Torokhov <dmitry.torokhov@g=
mail.com> wrote:
> > You need to start with enumerating what data is currently not available
> > through other means and why it is needed. Is this something that other
> > gamepad-like devices also lack?
>
> This information in particular is important for xinput specifically, as i=
t gives context for determining what kind of controller is in use.
> For most other gamepads, that was done via the vid and pid, but for xinpu=
t that isn't enough as the vid and pid isn't exposed over wireless.
> XInput also just doesn't expose the vid and pid on windows, so a lot of c=
ontrollers encode information into the other capabilities like the sticks,
> and the flags, so you need the entire capabilities blob to properly diffe=
rentiate every controller, and my goal is to then feed this into Wine and S=
DL,
> so that they can properly differentiate these controllers.
