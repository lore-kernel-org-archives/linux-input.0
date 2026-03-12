Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6475366565
	for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773356253; cv=pass; b=UCDow/HSWTVzshYUw7oYoy0GAlUXFS7KBaPjJyWxJfSIbXznXOXqVctM8ZiaPW+uuyjQqpV7bHO7Hu5lb13S5TCy7Ns0jJOdGOc459b9G3lixB2IkDehPSkOiTOh8q3wffdqk6c5U3GNGkMsewQLepNEMeGeA8iXSfefHo09wxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773356253; c=relaxed/simple;
	bh=zOgRkQnNB/+Ntg0KnD677Eyon1mNQy4poFFpVwIyOcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7dxxQ1L1T8BBoA/dx8uwA2NxsZepR8KOHvKszSrMEp0P6UunPbHtny+4YUdtOc+WM0SZPJfabBg4CYJ8+6Ps/116kRP6QeaM7QP70JOBYkUEGRx9OFVGbAeVM4dmhMfzpa6aw+2pkS5Ehag7pw0z6g+27/qem/uTdHNJBq+FUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7apzFEH; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7apzFEH"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb38e86cf2so163814385a.1
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 15:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773356250; cv=none;
        d=google.com; s=arc-20240605;
        b=DoCUBJLfHI3uiyH8fUOqzn3gDnSzZPNzDN1S/DTLJeSExJwQxFJprnk32smKuCqUS7
         rLmuilU/KGus2rgivkjMe4HYZ9sjDQuF/uvYjmx7cCmHiOICIgtelWKaSdcuw0pPEiaf
         LTa3/d2pRU+XOksO5NDt59d7EyLrIJb4xjcdbuzKO41YqgU4zQBHBm1DRaljmFHpZgh8
         jxIq2edVthL+qNNNendoVl3q1WaDnS+If6oAFuglQyJVuX9kXFgz0afMl/EnoEFingKJ
         HG3+14Fw9+Gaqr3Y2MinyGcpnTc7m4DzgrkPc7PchWk4tI4uTJTGijmvYP1MGZwSE8Nw
         71Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CFgglb1Zf4C09vLpT2zlrzPR5mBWBimjznIcvEhPlMw=;
        fh=f8ENKslMeLNS/MQioLvzgs9R34Gwhg902lNntiZzmno=;
        b=Qm9w9Rc0NHdVbVNvTWbYKp5Ck9qyGCK0pKPvPouEtSq1CQBlwhPj93ztUpny46k/sG
         3lzLQYB7dosXFSBg3ceF2b2mwKdmYW/VuR/lrY7Vh6xPByCikHsqbQB9Nn/p4Ra2ARnA
         NCdWmN+aYrzmwPe9h3atxw4QW0x2sRWgZviLheGJw58hY59AEurX9v38ComWtAk9IwiG
         cyW3WJeKJIu+UkMiA9cez/ghf+2rHr1/lvNg/KpqAvJUZcar7Io2Lla4kK79lNi/73uE
         b0uYY/QOUGT7eU07Bv0PPnRKBOshMrWRgvejg1EWE9wDG4WrlMiB30S/wSjGNafMhVwW
         IunQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773356250; x=1773961050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFgglb1Zf4C09vLpT2zlrzPR5mBWBimjznIcvEhPlMw=;
        b=T7apzFEHZqDG3eji3TWOe30IYSv1LuT9JC+rhFG5PLMQC0iRcn63ha2jfFOQvoeYJa
         9xlJjpdgvsyzKMlDl4n143np6AB7PnIzaGGqg7XD2gXiqmvfF3sJLUBANI+MP7REhlHu
         6JbOkcxBM7MxpCTIcDFQgxMxDTHDg2gZZLokTQ344VtMk+2vsfvD7G/zsafGsPnizoHe
         pAbvVpFB53Be0yl4wgiEXMrz0RmBdIXbsHCaPXe1vljNSQQJPNzFo5cBk2+77WQcAPDt
         HfUxleRRoGi23OA1KsSg6X3g++nEUJuwWepLn0LO3kBXME8pd1KJZhB496UznHKhb8Wh
         8WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773356250; x=1773961050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CFgglb1Zf4C09vLpT2zlrzPR5mBWBimjznIcvEhPlMw=;
        b=J13zEI698qdP5rET31lUBWt4HvA7J1IA9DctL61mk84WxBTFx8JXzQ+STuWOqxR3YI
         tFCEDm4jdJDThjjfTjcK4H9SbrWlh+rAdaVutPjuGVGqpQldtzgYrWkCM4IbQls4CmyH
         scRF/B5VHs1t/ASGRC7nnoEiLOfigE5iWS/wHgsbqaTVW4jut3LmW9zCbM1XYsLpN9dX
         nF5mqCYkI+KiAYFLqXWmdXS72hsEIh4hmgGhaQuWICjOE1xdNPKDiYMl5L9GtIkFd8iH
         R2Krj20IMr3q5ZjrybCswrtiynFEfuEV0IK4vTJBJvdbz7dPDcL90e5JpC7fkydr12AP
         G+sg==
X-Forwarded-Encrypted: i=1; AJvYcCXmCWZ5HgUqAYNrX/1Tc0DDYdhjAAKDJH/IMPmLuUVtBGJYgH4qKInF/mmYAVVS3YQmbB06yhvfJ8E3uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pqSZOO3IdJupTEjwEVkhxulZLz5hxl7VX366rxaCUi5qwsLt
	MmXiP6CWmpvxdaJ7Jxu3TRQQHlr3OrmWO7x8YtQRbjdasHsdqAllb9ahBMJ8BSVPE5+D+PZcp9+
	BNCFM7RL6A0pHz2DFFYclfTNdx7YX/P8=
X-Gm-Gg: ATEYQzy2nezP/8b1O9fM+v0hZdDJBS1SW2yTrKZzjqIWu+dU5BhppU39JtZBHs3ByD1
	nUYLDLYCYgAtrMF9ZZzvJWrTdk1E87fhAF92clgnOiVB9Y0aUSKAzbRFyU44P1ob7VAkVPNrcRj
	gPTLkkW7+jPPTXz/5ezsUpE4mAPVqZcXBNOOkdKl2e/Q1alyjemA4qUlr6WK4crT4+9pF6kcwmb
	pOGDVaefBDxY3x1LT9NNlF+3VhwRoiIX/DnJDAbp6xIo5ipIib83gnHCTa42gMUnTANCYJRgwxd
	h91Brc1DAWra+xVqWYk=
X-Received: by 2002:a05:620a:471f:b0:8ca:2a02:dfd5 with SMTP id
 af79cd13be357-8cdb5a709e6mr202126985a.30.1773356249805; Thu, 12 Mar 2026
 15:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310072937.3295875-17-derekjohn.clark@gmail.com> <7dc9bd14-b21f-461a-9794-070f43db4826@gmail.com>
In-Reply-To: <7dc9bd14-b21f-461a-9794-070f43db4826@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 12 Mar 2026 15:57:19 -0700
X-Gm-Features: AaiRm50DBo-3LxvMfUFcLMN_dcSC89X0sTH-eHWjKkx6AzFjTRQNvObMpScb3gw
Message-ID: <CAFqHKTmBBEHJgypooELKa7fU3oELnVk7bjfZwHsFD9Y0b1c3Xg@mail.gmail.com>
Subject: Re: [PATCH v6 16/19] HID: Add documentation for Lenovo Legion Go drivers
To: Akira Yokosawa <akiyks@gmail.com>
Cc: bentiss@kernel.org, hughsient@gmail.com, jikos@kernel.org, 
	linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
	mpearson-lenovo@squebb.ca, pgriffais@valvesoftware.com, shaohz1@lenovo.com, 
	zhangzx36@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:44=E2=80=AFPM Akira Yokosawa <akiyks@gmail.com> w=
rote:
>
> Hi,
>
> On Tue, 10 Mar 2026 07:29:34 +0000, Derek J. Clark wrote:
> > Adds ABI documentation for the hid-lenovo-go-s and hid-lenovo-go
> > drivers.
> >
> > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > ---
> > v3:
> >   - Remove excess + from every line of patch.
> > ---
> >  .../ABI/testing/sysfs-driver-hid-lenovo-go    | 724 ++++++++++++++++++
> >  .../ABI/testing/sysfs-driver-hid-lenovo-go-s  | 304 ++++++++
> >  MAINTAINERS                                   |   2 +
> >  3 files changed, 1030 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-g=
o
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lenovo-g=
o-s
>
> This (commit 168c91839139 in next-20260311) causes a lot of new warnings
> in "make htmldocs" such as:
>
> WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface n=
um>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: /<=
...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; /<...>/Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
> WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface n=
um>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 tim=
es: /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; /<...>=
/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
> WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface n=
um>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 =
times: /<...>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; /<.=
..>/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
> [snip]
>
> Please fix.
>
> Thanks, Akira

Akira,

What would an appropriate solution look like? There are two separate
drivers in this series that are modeled to provide a sysfs that is as
close to each other as possible. Because of that, they do end up
having identical attributes for many of the implemented features. In
most cases they are prefixed in the sysfs by a different component
name, but that isn't the case for os_mode or touchpad/enabled. I could
combine documentation for both drivers and de-duplicate, but I'm not
sure what that would be called, sysfs-driver-hid-lenovo-go? Add them
all to hid-lenovo docs?

If I do that there are some additional de-duplication that could
reduce the total number of lines. I.E
What:           /sys/class/leds/[go|go_s]:rgb:joystick_rings/effect

Would that syntax be alright? Some of them get a little excessive, for
example the auto sleep time is defined three times and would be
combined to something like this:
What:           /sys/bus/usb/devices/<busnum>-<devnum>:<config
num>.<interface
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/[left_handle|right_handle|gam=
epad]/auto_sleep_time

Otherwise, is there some way to flag the same attribute defined in two
separate documents provided by two drivers as not being duplicates?
Thanks,
Derek
