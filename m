Received: from outbound.pv.icloud.com (pv-2006k-snip4-11.eps.apple.com [57.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CE3B4EA4
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354933; cv=none; b=PaAkbSOrUM82R2kp3IG71XQv+pcNliQQurghFsP0JAtfyD0FA/JG2iFvMso/K7hA5emkI9btmsk4vIhniahc08tU3C290k4Js2t9OErz73fUhGDhlb8OZRF6uEwN1t7A2LFpt3iY9RyTVju6e2jhf0lwlQzmyFTh+0s1Bb5cta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354933; c=relaxed/simple;
	bh=d0EAaselWhtwFqQjs//oTuOpV3lYDMw4jQFD5eFN+no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxCNomgpOptSLTZwfHMyA4xRE9X+vX/YfZvMJ4SiXsW4+Owc06pi18xY+CcgXdTHSh3bXxesU66dA3ou8xaSBOAkU4ndSIlIzIZRgXJxYgKktuWCuUZjSKTnhu8Nsvht6TmoeXk22ynGKNxng3qL5x3nUTasqnQzpg7QF53jn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me; spf=pass smtp.mailfrom=matias.me; dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b=QGJobpvv; arc=none smtp.client-ip=57.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b="QGJobpvv"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-10-percent-2 (Postfix) with ESMTPS id 9197818000AC;
	Fri, 25 Sep 2026 16:48:31 +0000 (UTC)
X-ICL-RepId: 01a0d977-f084-7be2-b406-d702d9c8146a
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhAAkMDWBxBDUAdVQFLVxQEEFYBWwRyHVgMWgxERV8VGR5XUFoKRhlYCx0AUktAEwRJAk1fDl4fBBdGGVUERx5dVkMbGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDgBWH1sRSlZeCBcGWxQERAFdBV0CSQtNAlsDUwBDF0ACVQNZH0EUEFYBWwRyHVgMWgxERV8VB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1790354919; x=1792946919; bh=pKrb+00BnD56KGeauHWqxEBRwP61f6KPp4UQvsrluyY=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=QGJobpvviDSGonyo1O6QX50oBa0fHebgjDaxdv935rlRs8OAj3ikgBt2BD1CO5rWhCwXkv4cDp23dIFv37UgoloKOwg4xe2LPAAb6E15ZfxoS4s05uXbz8vxgLGCqfOrHoMj7GP+yhku6Pk0sOINxBoxf+xOQJ81yZwlQOIct7bMkC+bmszBJiNoOO8DfHEwuI7A09V7aUwdj9qg/WHXg2W11tvvBFOS6laDNxpRL506A5E70xjuOkifpadalyXPTG4h63TpSA1/ePOTCPZNG+7Sk4Im1A/B3kLwlOlXtbBvyUOYGVYWB82QPeayRX3OqZOu5g7jk3QttwxO8nozsw==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-10-percent-2 (Postfix) with ESMTPSA id 054CC1800198;
	Fri, 25 Sep 2026 16:48:27 +0000 (UTC)
From: =?UTF-8?q?Mat=C3=ADas=20Mart=C3=ADnez?= <hello@matias.me>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: =?UTF-8?q?Mat=C3=ADas=20Mart=C3=ADnez?= <hello@matias.me>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Fri, 25 Sep 2026 13:48:23 -0300
Message-ID: <20260925164823.81842-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAGwozwEDBCs3zmCb6xbTBd48F+tbFOtZC-sC+F5uGvo82UL4zg@mail.gmail.com>
References: <20260925061941.75121-1-hello@matias.me> <CAGwozwEDBCs3zmCb6xbTBd48F+tbFOtZC-sC+F5uGvo82UL4zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oyx-XpE-PM2gk4koaKmt0NS96vS1ueYE
X-Authority-Info-Out: v=2.4 cv=FMwWBuos c=1 sm=1 tr=0 ts=6ab6a5e4
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=b4MELKoKnEC4wfmd7KwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NyBTYWx0ZWRfX5+CY2MTbvvqs
 kQh6OQVWgvfCoXwF9+fSAEegmT9p00OA2YHnUHrrOKvSNdi2AsTE+HDkyqtaRvoD00QCj2U3RRY
 +KDSdNd7XHDhql6NE+4ENLw3OvCDklFpt56PsWrTYKEtsONCRkSu2howP4iUdqXUCGk2Cwpk9W1
 EIrFdlKnXRcY3m9CLVGF3kiA8wM+21aRqw7wJi1bceDOuMrBnNILEihhWA/1ld88WzX+MlZQRuG
 vya2epIc3wBvwwQ4q+xkBuaElkabAW3xI0+vAhjrN4Mp8fholzu2tVN7TYtdmvmV4Z6JtzUBzfj
 uAtwDoUi6gYPCwSM9QxczG1dwOuHW9dGTNf2hqCQhfDMuPnRREZPXc0hv/ImzY=
X-Proofpoint-GUID: oyx-XpE-PM2gk4koaKmt0NS96vS1ueYE
X-JNJ: AAAAAAABk66Ecr/Ttss0fJMYXAjhqZ5unT8jUh/xmlMf4RKlOatEZoFZQuBhTeYV0hI4drYfR+J7Bvl78TFqa1n87BzxLKupVfonC53tVIJxvL0Fv2ibBaJpGAurYatq28FZkZxACO3/Iv4xzZZUQIVVznGFDv064zkuY+Mqb4vxV/9HfEMEDujvOxv92WfrMThL9NeAes8erjjPunHjgEPAMSUTu1sZZxIOxgLqNE3tQY/FcloLaO0A7KTEuFFoUYMEPFharx75PzcvLehd2NLTuc6iHY/qZAsKGE1Jrvm4H0oKzulrxOX1Z0IgF3CPUHjKDYfOHVUYw8YyH8qXHC6t16Rf3VscR7xk6fkrgRn/yVhIPpMrg0NOkWIKEJab1XkdzR3qHHJ5T0tjWi5jeTP+6/fMngKZ1vlwfxy15DTKz1wNMwZItnVQc/pQH6xihW/WtRHpftwAP2ry3+S6dVeOBA81+xOTTzlYO1LAqBhNwNef8ATxTW11otuz7Wd1sn7qPNj3nhgMci/opEX19uEAJhLDIDVYzYgbc36vgcg4P8GlR1nUESw+YZpokm62WLmXxt0kAyNzJLWhTGkZq5cRW5W2BNVaPimA6g1cuNw5hxKr4LWO9578N5hOHR+TMLHbWClwJ+j+PCsjeWqJZcBOVfYZPLWVfkcQTT+KR5n5P3z6Y4UPLkXGJ/BWeCftxOqIVlgfFfoIqAqExfnvhWbpHamwz1K2dpKI/irQR/W1/CpCTE+e41sn0jddHTgvNpOuNtzIrr1yTHM+K5bXGHbI3gDDS1hJhrAE6pWSxUp2b9B3+FXMPGch+GKhU2IvvXqtWz7cV2lIyTfTjex52q9paIeuJ85uoH+s/B7faYOk/MKsUiQvn5AI9Q15BazPagijz+nPDKlphmIs2Tgd3X3Go0sZIH3KemtkKklFZg8BUEQf1bTgTb95qtlaahmd6Oyyqj+72bsC8HG8nC1Yo9GaC0Ls94O
 NE0hFj2UU40sFS8ggqEdvZKfDi62XMds1uV86VHiC1o4BcpTf/ZifruBTVgU/zTPdoCl24BIFcUbiYoGFkuFX0eMdD39/ebtoEjehL+xcssnSRJIqm07z7jNIK6azM4wMsBO/R15g1eNzmqhz5/FLb9fQSGBjw4tHO9X+7UDZe7YbszNH/7ExPoMUjCNYyGEMLR4pnAqXi+xfbpieAxs4JKxXvLObFgCiWi6ITpP6ByxT6LRzAz+J6ePxO3FjSrRl1oAd5jJvA6OHLMMKpiJpZM7/uBQjNQc5mZH5zM8EqPA3YeXJzgabbqNZqwSQeq6ribC6LgASHseof0X6yROg3V1WFvMbmfhSKNAt4GAEiAK444yfLq6KijCkc0nA/EeyAJy9WgCJEqmzkjCn8LVdabGOdcht

On Fri, 25 Sept 2026 at 12:01, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >   Antheas suggested generalizing the lenovo-go file instead, but that
> >   left it internally inconsistent (its other entries on the same LED
> >   keep the go: prefix) and placed this driver's ABI outside its
> >   MAINTAINERS entry, so the lenovo-go-s model won.
>
> That is fine. You should have asked for me to clarify. This driver
> does not need to own that sysfs entry.

Got it, plan for v5 below, under your ABI comment.

> > - Default the subled intensities to full so brightness writes produce
> >   light before userspace configures colours.
>
> You mean the opposite? Writes to colors produce full brightness if
> brightness is not written? Because the other way is not a problem. You
> can skip led writes if a color has not been provided.

No: the multicolor class computes each channel as
brightness * intensity / max_brightness (led_mc_calc_color_components),
and the subled intensities start at zero. Without this change a plain
"brightness" write reports the LED as on while emitting nothing until
multi_intensity is also written. With intensities defaulting to full, a
bare brightness write produces white at that brightness, and a
multi_intensity write scales it as usual. Nothing lights up
spontaneously: brightness starts at 0 and the driver sends no command
until userspace writes something.

Skipping the device write when no colour was provided keeps that
surprising state: brightness-only users (desktop sliders, triggers)
would write brightness and see nothing. hid-lenovo-go-s also starts
from non-zero subled intensities; it can read the current colour back
from the firmware, which this device cannot (the protocol has no
config read-back), so a fixed default is the only option, and white
seemed the least surprising one.

> > +What:          /sys/class/leds/<dev>:rgb:joystick_rings/effect
> [...]
> > +What:          /sys/class/leds/<dev>:rgb:joystick_rings/effect_index
>
> You cannot add a new sysfs entry for an existing ABI. You must correct
> the original one or move the led registrations to their own unique
> file and correct them.

Noted for v5. I will make it a two-patch series again: patch 1 adds
Documentation/ABI/testing/sysfs-class-led-effect describing
/sys/class/leds/<led>/effect and effect_index generically (the shared
value names — monocolor, breathe, chroma, rainbow — defined once,
effect_index listing what each device supports), and removes those
entries from sysfs-driver-hid-lenovo-go and -go-s, which currently
duplicate each other. Patch 2 then adds nothing LED-related to this
driver's ABI file. Should the other duplicated LED entries (enabled,
enabled_index) move in the same patch, or only effect/effect_index?

> Too much detail in comments. Obvious observations need not be listed.
> This applies to most comments in the current driver. E.g., the generic
> vid/pid note may remain.

Will definitely trim for v5.

> Review the use of reset_resume. It is only used for buggy devices.
> Doesn't resume work? Is it needed in your usage? does the device not
> restore colors after sleep?

Ordinary resume is fine and the driver does not hook it. reset_resume
is a different path: usbhid's hid_reset_resume only runs when the
device was reset while suspended (post hid_post_reset), i.e. the
firmware state is gone no matter how well normal resume behaves.

Two uses here. On the transparent interfaces it mirrors hid-generic,
which registers reset_resume itself (hid_generic_reset_resume ->
hidinput_reset_resume); since this driver takes over interfaces
hid-generic would otherwise drive, dropping it would regress keyboard
LED-state restoration after a reset. On the vendor interface it
reapplies the cached configuration for the same reason, and only if
userspace had successfully applied one ("configured"), so an untouched
device stays untouched.

> I think these are all my comments. Given you are still doing changes
> for stability's shake, this will need to be tested for a bit longer.

Agreed. The v4 driver is now soaking on the distribution kernel this
device ships with, and v5 will wait for that plus any maintainer
comments.

Thanks for the review and for all of your help,
Matías
