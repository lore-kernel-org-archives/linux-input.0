Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AA37C929
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286351; cv=none; b=NWk0EJtviPd0dHls45NE2QmD9/LSBao1RUR7B4EOECCz1w6ei+jFyU8gQIRndsPFW7mN4bxTTujESqalGwdO0KMTiIEDWtSS1R9I5zjkENdS7n0VyJmsmwVCSHkPBrKlOb0VKEn6mqNaK+bcSpW/Z/D5HrK+0Pos3obCSdrOtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286351; c=relaxed/simple;
	bh=mkecX4kpOGWnEmEhR/h/NI26iugyqtLlXJnEY6K+c3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iziO+WORoUkFlMlSTYEmbgPtnxvUI0DqTIZUtjgH8fEK6luwYymReZHRN44NWNGndIzeYVN8vAsnPV6xhDqXDYuqgd4TuavuianV0ZZ0bFVSPt+ilGdF4+1/HDULQAC1Lx27zXFMmhdDkpuxSHNCsLwGNrq58RWmV/iK0Kq350I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmIwVU9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmIwVU9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE521F00A3A;
	Fri, 21 Aug 2026 04:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787286349;
	bh=5HzIEnUZW11/SNm+ZSzaSbsUwipHrSqb0h6pmQUSC6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmIwVU9Isqa/bCtgIQcE+JHrIg1OB9dfHE+EfYaF6D+BkwWVho8Wy4JU2Y/e2/50L
	 Tqb++3fYdXxkzV8GuBrPmCQissGI4JMegN3TD1HSzMeUXhmJKelQhebHAixH+dDCB1
	 qq4mQ6sLgMRtlWJPAQCQk1VnaLDFy89fYWy4FDz75SViaLZYoB60+YWLwaRNoYxkl4
	 xcrM2EGZZmMm81IkP1PZ+pD1KvZTfNO+nCebgh/GIKf2d2Ys9Xpby6gO/XOB8Zj0Nx
	 FYmdq/YgU4XPMmv6v/S9lArZPezAj1hD59Jy+YZZtBsU6CFJOmxg21oS6Hkyo4Buda
	 sDz2uJ9+a17hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260821041546.110119-1-triet.hoang.dev@gmail.com>
References: <20260821025021.9F9891F000E9@smtp.kernel.org>
 <20260821041546.110119-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 04:25:49 +0000
Message-Id: <20260821042549.8CE521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds memory access in `pm80x_dev_suspend` and `pm80x_dev_=
resume` due to using a virtual IRQ number as a bit index.
--

--- Patch [1]: [PATCH v2] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS(=
) ---
commit 34551f878a1e83fc07284971e8c372f8a5be3f46
Author: Triet Hoang <triet.hoang.dev@gmail.com>

input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit converts the deprecated SIMPLE_DEV_PM_OPS to
DEFINE_SIMPLE_DEV_PM_OPS and uses pm_ptr/pm_sleep_ptr(). This allows
dropping the __maybe_unused annotations from the resume callbacks and
reduces kernel size when PM options are disabled.

[ ... ]
> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
> index 551ef1c367d65..be1b0d961e01a 100644
> --- a/include/linux/mfd/88pm80x.h
> +++ b/include/linux/mfd/88pm80x.h
> @@ -339,7 +339,6 @@ static inline void pm80x_free_irq(struct pm80x_chip *=
pm80x, int irq, void *data)
>  	free_irq(regmap_irq_get_virq(pm80x->irq_data, irq), data);
>  }
> =20
> -#ifdef CONFIG_PM
>  static inline int pm80x_dev_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);

[Severity: High]
This is a pre-existing issue, but does using the virtual IRQ as a bit
index here lead to out-of-bounds memory accesses?

Looking at the body of pm80x_dev_suspend():

    int irq =3D platform_get_irq(pdev, 0);

    if (device_may_wakeup(dev))
        set_bit(irq, &chip->wu_flag);

Since platform_get_irq() returns a virtual IRQ number dynamically assigned
by the kernel, can this value exceed the capacity of the unsigned long
wu_flag?

Also, if platform_get_irq() returns a negative error code such as -ENXIO,
would passing it as an unsigned bit index to set_bit() cause a massive
out-of-bounds memory write and corrupt memory?

The same pattern exists in pm80x_dev_resume() with clear_bit().

> @@ -363,7 +362,6 @@ static inline int pm80x_dev_resume(struct device *dev)
> =20
>  	return 0;
>  }
> -#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821041546.1101=
19-1-triet.hoang.dev@gmail.com?part=3D1
