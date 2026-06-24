Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72038BF62
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295155; cv=none; b=p0TiMKWRuCTJDXTOQcwTc2MhIQcnGQM4I5QnMLtv5p0Nt8aPX7B+hqb79ulA3MhGdPjUFfzvHUrnmPTCD+y9WjSTA3tcG1qLQkEQ3cDWwZrYsiVVAcIo+1y7+VUgS7vC3FckNIm/+BxHPj6hldRnqgbThUYYUQKyx2tJcCSSkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295155; c=relaxed/simple;
	bh=e7J2CPRFIR69JeZyDFNtW6q5HGld60vZ76v9QJ4AzmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DOED+iCm7TobaxDX09Qk6i8JZ1WKXnfujWTp7GvEtgW3h6PL22YKDTGdSPW4TCxSuHxiYYstJP7AxHOlasWmGve+u00RZpEIEXbX/YKdNrbmWQeOTAPuM4uNgTSS7/URd9bVT0pYeuJo4/TM7uj9C9qiqt0mcwqa50TXWyFzxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbaIU31q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbaIU31q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154B61F000E9;
	Wed, 24 Jun 2026 09:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782295154;
	bh=QSTU4d25wktc3uKoCtQqiIw7Y/j/aR40+DVSUzyksdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbaIU31qVwtLZw5Dnbb9lUCipA5j348u4NCNBfv78T0khtxc56IIepJLrSfQnm1s5
	 NmLGt1zFM+/OiiiBnorTsFY4maq1BZKQGxeFPi6LmiQfljuIpvkCL9XQg16HcQYVXZ
	 oHLPdoc1szLpT2aOo1nWW1cpqO8ctow7SwhBJ8JhapYTZKVgRAxpUv/AqBFTD/QcXe
	 dlQGWJA0S66NLc0spqMvmKeUV0ANL260lGsXR4s6Q/Ey9BBaJIerw9om4RLxrYz5cu
	 q3/H67U934Fk+2i0y/Xv2qj1XuUU6/IxdeN1NM8xYDbXTUxVVMDrxSK9prFuH4XukE
	 sfBWYJX06m1WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: gscps2 - advance receive buffer write index
Reply-To: sashiko-reviews@lists.linux.dev
To: raoxu <raoxu@uniontech.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com>
References: <460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:59:13 +0000
Message-Id: <20260624095914.154B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to the ring buffer consumer index causes a data ra=
ce and buffer corruption.
- [High] Lockless modifications and traversals of the global `ps2port_list`=
 lead to list corruption and use-after-free.
- [High] Registering the shared IRQ before adding the device to the port li=
st creates a window for an unhandled interrupt storm.
- [High] Unbounded hardware polling loops can hang the CPU if the device en=
ters a faulty state.
- [High] The shared interrupt handler unconditionally returns `IRQ_HANDLED`=
, defeating the kernel's spurious interrupt detector.
--

commit b6fd4271cba05f59b05437ee042428ed8db2fb92
Author: Xu Rao <raoxu@uniontech.com>

Input: gscps2 - advance receive buffer write index

Commit 44f920069911 moved the receive loop into gscps2_read_data() and
gscps2_report_data(), but omitted the producer index update. This patch
restores the omitted index update so data reaches the serio core.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 22b2f57fd91f5..bf9b993f57330 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
> @@ -219,6 +219,7 @@ static void gscps2_read_data(struct gscps2port *ps2po=
rt)
>  		ps2port->buffer[ps2port->append].str =3D status;
>  		ps2port->buffer[ps2port->append].data =3D
>  				gscps2_readb_input(ps2port->addr);
> +		ps2port->append =3D (ps2port->append + 1) & BUFFER_SIZE;
>  	} while (true);
>  }

[Severity: High]
This is a pre-existing issue, but can this unbounded loop hang the CPU?

If the hardware enters a faulty state or is hot-unplugged, reading the stat=
us
register might continually return 0xFF. The loop condition earlier in this
function:

	if (!(status & GSC_STAT_RBNE))
		break;

would remain true forever (0xFF & 0x01). Similar unbounded polling exists in
gscps2_flush() and gscps2_writeb_output(). Should there be a timeout or ret=
ry
limit here?

[Severity: High]
This isn't a bug introduced by this patch, but does the lockless access to
ps2port->act cause a data race?

In gscps2_report_data(), ps2port->act is evaluated and advanced without
holding ps2port->lock:

gscps2_report_data() {
    ...
    while (ps2port->act !=3D ps2port->append) {
        ...
        ps2port->act =3D (ps2port->act + 1) & BUFFER_SIZE;
    }
}

Since gscps2_interrupt() can be called synchronously from process context
(like in gscps2_writeb_output() with gscps2_interrupt(0, NULL)) while local
interrupts are enabled, a hardware IRQ could fire concurrently on another C=
PU.

Could both CPUs execute gscps2_report_data() simultaneously and corrupt the
buffer?

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to iterate
ps2port_list without locks?

gscps2_probe() and gscps2_remove() modify the global ps2port_list locklessl=
y:

gscps2_probe() {
    ...
    list_add_tail(&ps2port->node, &ps2port_list);
}

Meanwhile, gscps2_interrupt() iterates this list without any locks:

gscps2_interrupt() {
    ...
    list_for_each_entry(ps2port, &ps2port_list, node) {
}

Since gscps2_interrupt() can be invoked at any time by a shared hardware IRQ
or manually via gscps2_writeb_output(), could this traversal race with a
concurrent probe or remove operation on a different CPU and lead to a
use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but does registering the shared
IRQ before adding the device to the port list create an interrupt storm
window?

In gscps2_probe(), the IRQ is requested before the device is added to the
list:

gscps2_probe() {
    ...
    if (request_irq(dev->irq, gscps2_interrupt, IRQF_SHARED, ...))
    ...
    list_add_tail(&ps2port->node, &ps2port_list);
}

If an interrupt fires immediately after registration, gscps2_interrupt() wi=
ll
iterate the list, find nothing, and return IRQ_HANDLED without clearing the
hardware interrupt condition. For a level-triggered IRQ, could this
immediately re-fire and hang the CPU?

[Severity: High]
This isn't a bug introduced by this patch, but does the interrupt handler
always return IRQ_HANDLED?

gscps2_interrupt() is registered with IRQF_SHARED, but exits unconditionally
claiming it handled the interrupt:

gscps2_interrupt() {
    ...
    return IRQ_HANDLED;
}

If a different device sharing the same IRQ line continuously asserts the
interrupt due to a fault, the kernel relies on handlers returning IRQ_NONE
to detect the spurious storm and safely disable the IRQ line.

By always returning IRQ_HANDLED, does this prevent the kernel from detecting
spurious interrupts from neighboring devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/460B5655BA580C60+20=
260624094739.850306-1-raoxu@uniontech.com?part=3D1
