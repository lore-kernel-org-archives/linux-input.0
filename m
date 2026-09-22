Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064551CF6C
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111840; cv=pass; b=F36t9WSKkg1XeG+7UB1ct3Z6sgOXhj85XRvpKAaEKRU1M4EkDNuCg/wYWJY5Ej4/DVOXoalovNG5Rwjz//9xmwNs67gKoja/CsH4GE4LZHmSsCtfF9ghOAVKbZ/6BZ+Cph62I3rZ7Ey04/fk+iXwSKBA/wlWGp3rl/grICZTDbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111840; c=relaxed/simple;
	bh=n+Yzo7ihSKHs3bpGXiSBg3zFQX8q1yeHsiwSB74gv74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEC/YutOBbJXNOIGHSpV8C713dTxa7nf4vVctLJvLxtqo95wtr9j4fkbS1ol4Efij6psQIS7sNsyOOxgNoRPiEK8e+er8GzT2b0BARpyxAY5zyx5qvGLDloA9pd5BOQT+RbLGAaRhqH4Yj38P4EDvAScNAZdqmwCfnrEEPVSmYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwKxjG6T; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwKxjG6T"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651cso218256e87.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 14:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790111821; cv=none;
        d=google.com; s=arc-20260327;
        b=qp2IJ2vcLufN7r/uSGjAcqJt3wMIuBIHFR5V1i410vHnUjsMfwtuYb9OMJ+hllcqxh
         bnrhP7znrVltmLsKtiuTVBEAHIpP/IhOTipBS7IqjgrvS02udcIPUe6EGGDOkeXt3USB
         c9Uu6UT+dNQmJicNUeRvNF+QvFRzBsSNB0RHVpnAW3Si9IpwHdvI0pQbO50qpK+aWkJX
         8+BdykJRCwxAxIk3H6TLxJ63cjyCaD20B1AY+xGeT35Iz0yhTxvHZJunFE9Xjur4fykv
         +medg/pcp90E/TQgMdoW9WqF9a0afw7BkU6iSLmoL8IMFCe3e4+c1A5T2uGWihHnK/Gr
         Phrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tmx5dBbmMlKCVVFF4vkR3MxavF7GRtAH3Uv9OpL0m7E=;
        fh=jDgsp0DmIdjl6P37k2qKDrh/xg5dSK4vBCRT5itXwIg=;
        b=k+pTCWLnHYPy0u5OtCnGzxocRuIiJGOOBwe49ML5/QRDLnnrhi+ne0ADroN1YqrF6P
         z7RoTpM5riPuuVtiBkzZ/QQvo0kAKTdDROkubi5bWxGP0W3IQb5tFaWNl+SRh++4nD5n
         IpGfVsQiZnayAXcL77uHPij5xHe1/BeVK26AGzGutsSF+cYIJ9T9XOoDpX1mr5mdzADh
         2He8SsdnodmUMDS+3ZORqIx6xK2/c4QikA7gUjF/PhvmR8oMsfz3jgZ27JmPhO9qXyld
         b28iZiQd6LU2vau6D2GPFjR1QoIKioECQYjJLI+tCBCn45ig3cW7o8nC+gu8/Bpw962M
         mVPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111821; x=1790716621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tmx5dBbmMlKCVVFF4vkR3MxavF7GRtAH3Uv9OpL0m7E=;
        b=lwKxjG6TVc81TAoOC1s7xFV76laRhL4E4FfXn+R0cLK9dU2PDiVpgKVsnzFUgXhQyl
         KE37ecK+SDpeIyD5tJ0XyvduTyRxhHDmGP5IMyczEbbN/EN5WSyLj+oCIJb2inyL3LwC
         mFsOckbubVhwSRWkDdYC7407+cXaoYk+baSAjKPO9B2og1x5zDGsyp0VUCZ+xOsY1S2Y
         4BgcnZS7srPLss14CXe8vU44jZUc3PQQ7+c0JudKG0BNCwkUl7CCNv/WUKa8nWOYQ3VN
         HriDZhmOVND4630enYprHQCib8bomkE5ySJCGFh/SHbjlqhfHnNXdsYscls9p83JqSjO
         AC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111821; x=1790716621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmx5dBbmMlKCVVFF4vkR3MxavF7GRtAH3Uv9OpL0m7E=;
        b=b9tD1PgUowCw7mzHtmALdt8uDqV4JaSaPEZ7HGuWhQ64yT/e72iJFOYICvMF2s5djj
         51Tf/5s3BN+ym+Ux0BRlb/+I4iUgrqZeB9K+cxy6vxrFKWzCBtrWIPxvTyEcJDvjmN4K
         YQ+F8KoMwUrH9P6OMne8D86wuO3lKKqZkBousF+PYTyQjLh9+Mbe7c9ocUHD9xKJO1n9
         QeacPiuNjqAYaOYWQmufIFJQdrS9AlBk+FNe2T7e8HiaTywnwtaWoqDVS39z41dqmPpJ
         LXMj3Po5mhX3nBy7CwiVBA7JayXDvPdEugb69+xdZJSf1HyUDANuxmLIoEFmE75QX3Bl
         EDZw==
X-Forwarded-Encrypted: i=1; AKwUvBxdq5mjasNBvGQRzj1Ujyu/HzQ+r74LIjCy7ThXd2zvVP49Lkenzy5aPolcK8b+AGhVp4QNsr7z4OU47Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lHzp6T9ultawO+ooWPj1lMxulgucaVL78R7CqCEgqhXUbZ47ay
	VsHEU/Mo353vo43SoioIUDd5jhYRljp58o9MvXf1iDTlJzSkFooQp09S+LHp4moCsW/WgOBc69N
	SPhiM5bNjHn0vWPWAoyQO6jRChwBghWHS4jyJ
X-Gm-Gg: AYBFou2VOqoThRZ74XGffttxYaQ5Px7p2WI5CaRHj50by0IpFaMiAt+oO6w6dD/wWuS
	ZOEnr2ZlQD7FyBH6HSidGRlk42ECfUlIX1K9MaP46uCziecxIDv2YBUnPkGsvqc//uX2zBn/GSn
	G2JuWKvfbZ3GoP3u9CLNL8IO6TRL/ZpJ6xFjbn5NKqN4OQMI+yLutOPFgXo8qyVGTcnglnPPekl
	UbOD/3IZ7o4OEmzZJqYgp7gsR1NFst/sCcbUg4hVWT07xRtErgmR0WZhTJOjmw1Iv+jakbz1yNB
	zEtWNHEALZp+n8ho2M0Cbz24+p0ZpptsmHRgR+av4LFLkIM24nOUa8hNlZsvkbqIPLRFiErw6qK
	mO+T6SVj4m/ob+g==
X-Received: by 2002:a05:6512:2529:b0:5b6:184c:7da5 with SMTP id
 2adb3069b0e04-5b8d89a7b61mr177150e87.46.1790111821108; Tue, 22 Sep 2026
 14:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916020301.24188-1-ping.cheng@wacom.com> <CAF8JNhKTVO7xro4qAoq4NG=4TWheb7rFU93AZEfeRJfJeqUfRw@mail.gmail.com>
 <20260922073134.GE2348773@google.com>
In-Reply-To: <20260922073134.GE2348773@google.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Tue, 22 Sep 2026 14:16:48 -0700
X-Gm-Features: AclHuK_nEtr4Ba21HKIDc3_0qWj4Pli70SkewhW_KJdIFN6mva9HRfdm5JV4FbE
Message-ID: <CAF8JNh++y2Zeik9iF=oZTfBsCOPn-J8BrL_gen3rNWrrPNT5NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Write shared touch initial status only once
To: Lee Jones <lee@kernel.org>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <Jason.Gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:31=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> > Do you have any questions about my patches, especially this first one?
> > I added it to make the assignment consistent with your patch. Since
> > the is_soft_touch_switch can only be set by pad, we would only get to
> > this assignment once. It won't be assigned more than once with the
> > current firmware logic. If you don't see an issue with the patch, can
> > you give it an acked-by?
> >
> > The second patch adds the softkey touch switch back, which is
> > important. I hope my fix can be merged upstream along with your
> > patchset. Otherwise we break userland.
>
> Honestly, you know this driver much better than I do.
>
> The change looks sound to my uninformed eyes though.
>
> Bear in mind that the subject line does not match the style expected of
> the subsystem - or anywhere else for that matter.  =3D:-)

I was so eager to get the patches out...

> > On Tue, Sep 15, 2026 at 7:03=E2=80=AFPM Ping Cheng <pinglinux@gmail.com=
> wrote:
> > >
> > > From: Ping Cheng <ping.cheng@wacom.com>
> > >
> > > To match the same logic as with other shared data during registeratio=
n,
>
> Spell check.
>
> > > use WRITE_ONCE for is_touch_on too.
> > >
> > > Cc: stable@vger.kernel.org
>
> Fixes:
>
> With those fixed:
>
> Reviewed-by: Lee Jones <lee@kernel.org>

Thanks for the review. A second set of eyes are always helpful.

Cheers,
Ping

> > > Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> > > ---
> > >  drivers/hid/wacom_sys.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > index 8dc7aa1c0a26..33fa491fba92 100644
> > > --- a/drivers/hid/wacom_sys.c
> > > +++ b/drivers/hid/wacom_sys.c
> > > @@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct waco=
m_wac *wacom_wac)
> > >                  * match historic default.
> > >                  */
> > >                 if (wacom_wac->is_soft_touch_switch)
> > > -                       wacom_wac->shared->is_touch_on =3D true;
> > > +                       WRITE_ONCE(wacom_wac->shared->is_touch_on, tr=
ue);
> > >         }
> > >
> > >         if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)=
 {
> > > --
> > > 2.55.0
> > >
>
> --
> Lee Jones
