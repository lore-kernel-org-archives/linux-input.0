Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793393039;
	b=pG8vRtvOi1bGR0NNLxSirIi4OrOfoqBSPznIQJk4HwCdJ0/RP63BblDjhOjfszN/xRzC
	 /hMdvjHR3KU7HutBBb7Mquyab13GViJET89ouwBHRkYupqnrtn2Qh/FBu17kInVqrhwX7
	 rflH90b7IVta/rR4o2WhCSRSDCeRN3iPa6av/1w+WMZdxOAzR//Dr3CySxLQfdriBzzVc
	 1pDjGKOqRe83KLWs6qobMon5jvWVhKV9vXHC2T8PV6MBGzFYLVFwssKS/66HqUOU8T2iS
	 KISKq+AwVf1WlYQI7T4lsnz7MUQRHWY4qer0mu38Io9LajvoC+zdK5hcw4iJLcqmx9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PGrC9jp81hhttgbK2LxOaZQLL73ahOthq614Lwim9O4=;
	b=bj10uqjUKkqcXrmWUFzx1NOYg5NOo02V9B+zzHBgLWYefzQjMHJqxWenSm+cPw43ZPsz
	 cEFaXfL+fbULMS88QK8WO6qXSgIsL45jYKOt/Td8oO8ecIqNAQJQUOEbMiUKJ+GUUjWtX
	 G7vBcn1JPYFWVxMKItRyTTD+wyxSIe0Kp2ZfwYVgtcg0dMMqYKiiAa29y0pmzho90JmCX
	 se+nJIRk73MxpXF/81L3RedSzZNpaHMf63xNYzwoXkmrbFhr06bYCoRYacNDu0bIcGwn7
	 3VnZyHBV9LeWUc45iMMw3XedSqD9tIKfjxOHtYQpKMTdOy+UuI0VG/YjQjMWriXTT6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="miuS/TF4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A1606A31C
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 20:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 904A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=miuS/TF4
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso638860a91.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 13:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793393038; cv=none;
        d=google.com; s=arc-20260327;
        b=BlOHVvHjqZGaLixaGNrJuLJrwkfZIg8mTSFUmj6vxiTKqb/WW2Sz9DwrdmRe4GzQUk
         Oip97G/6iUe4x4fHJyGmpbTlqQYmJbDPHembrOOUI8+EupzGdGxNZ7VZUi0VpMRGudQk
         baJVev86R7F+fuDUXfeS3RiER0+P3MFzmpXXNih+FkAoRvCIg4yUJE7wYCc5k4tL45rs
         IUjKnKKRkDgI+Xsnt2uG5mQENGTffol+eb/+bGmsDv9pLTnOpOMYSrQgMM9GFfkwXE2B
         P0IE8cWOq1OBXJT6lEgRaF30mpOcoYsmGIdNhLLmBVoPsO64g5JFWnk558KDV/sTN4kr
         UrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PGrC9jp81hhttgbK2LxOaZQLL73ahOthq614Lwim9O4=;
        fh=6hl+U4ZEjlyxX5EBBefnDd3tBOi01JiqxMmSchDRbbo=;
        b=it/4rg5NmdXyl5EWdcm0xtIShciuWvPyR0xLK0q8Tw5INvtkA33bwishZVyjW1lEFg
         y7Kz48IvfGMAGDfey1MLDD76J8+ST3ZJCvcMSF9iC6eKFuqCOelAusz55w3GomM1qZz6
         aaiZve85jEaUbAkFgpxBep04ZrxD7IsBCRdxyQR3ZWGtL9v9U68OkwmC5nky4bJdK3Bu
         ub56DPKzNcb6YXioNtjzk/0wt2OdYlbqN1CrSZ/8jKwnX2ll1fQZlxkiHf1iw8MYT1J6
         gxqB4jyOZ7/UM2naCg8jZ7pBSzw04gcXP6SkDRpde4A5V1SOJrhukOCRv3Hs9swjkFFu
         5+Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793393038; x=1793997838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PGrC9jp81hhttgbK2LxOaZQLL73ahOthq614Lwim9O4=;
        b=miuS/TF44qOoF132QOXvFNWRu1o0E7VzAOnjzAI+uNF60oUMS7MvSTN1o7w1wxVx9+
         6P0aP+c1QaF1TJe7ipN3fXi8JXZR/eopWEpjmw2DBq0Cqrj9wKbxTsSrt8+jb25v99y2
         OZKN5s479R2Wg3WZ1s0MV69MMB+FYpbC3LCKHz4hx0CIMr7zey/tiRsT3grDTBHPBu2M
         kOa4WYIdk2TueeZDNRBhliOVwfVra+tidFTfn4AdrKSds2btiYcX8acnr7a1xOMtLZ8d
         DAWeMJqsv9Px8tQkxnlBATSrqxOCvRpfldQDMtYscxtFYy+oLpTnqI9+b0rAXeBkag7C
         m/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793393038; x=1793997838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGrC9jp81hhttgbK2LxOaZQLL73ahOthq614Lwim9O4=;
        b=DlgZ+21bWHPqNtRvDjhW8Yq8dLVSdf5p1v7V4T1i+EE56LAnY1dtVI0o0lpoW9cmNx
         OnzQByEryf/uONM5rcSnvHc93BtSLntfRkxg3ZKqtE4eBAU00Y4vQkkXBHe5GXJeU0/l
         q1s/UJhExrqnhFpSdPR/eTtIa8tBAPn3YplT2FS7ZUvR3oJzkMCtbg09w2vXlSRWcW+V
         cxhTAojGoCaOGFZXGK/7F9SfD1rjGKF80pBeamV/w/Aoo/Nny1oxAZH0ZyAxxtJCIDma
         5/nTqjatTnD1zkZg1gmke7aw9OftIuHvlgO7BPqrsR1mWoJAP1thMY2iX8jhGQoAYoZi
         vBSQ==
X-Gm-Message-State: AFq9FYLgMzmifTPVKFSpBkKRITSudMQDsMPlocjAv/V7HKN+iiV59x72
	LLbDpzbkXjVaeIstrLvS87nFdtvGZJsG9YBDVVjtDdExef45a50G2TaNbopWkpNePffYhAE7MpY
	r5IlmTOnGwr3Xsh9rMp/wIedOaTjtRdc=
X-Gm-Gg: AYBFou2fwqlggOXrJ+rYPAXzgHx4LcN+RuAWMfM3o3hmq4sv+Zy65YcfO1i7qMxQ50U
	DfJBvUN0YOOh+quyOAvhSbK0M2RFV/ysmKaGTSdV/R2ylSIexB4kSyhO/tkLhYD6/+d+X9vQieH
	RLBdGlNKKY8u8Gn0sRhMAR0Z7H1+SBCn31cr4SvpM4/uY+UvF1wNDO+QC0EpBxNx4c17x8ndKmR
	ad6QA1A8NYygEVp6hXyABqufRllRZIZ3VRhzofTLTv1rTAJM+4Ds2RnEXhHPPOvNU6lSEPpatPO
	JDgRsMBi6p/wXc5sueJ//cyLudcWuqZC7eHjdRQ7syFYk1cRLYiOiMca2qR/RhpwE70Sh9d26PN
	ODE/h7ODXLBjXGQlEFgja3HrTGqfuO2xwLDYT
X-Received: by 2002:a17:90b:57cb:b0:3aa:fc22:8aad with SMTP id
 98e67ed59e1d1-3ae89855ca3mr2919962a91.54.1793393037441; Fri, 30 Oct 2026
 13:43:57 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030173108.45408-1-unseentactician27062006@gmail.com>
In-Reply-To: <20261030173108.45408-1-unseentactician27062006@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 30 Oct 2026 13:43:44 -0700
X-Gm-Features: AclHuK8D04ABqzfVwMfLf9BQljlnKexWMTD06uQ9BDkzY6GyDDHNgnMWwWmzIQo
Message-ID: <CANRwn3SF3Ywm_eLvH0H2J7960Ce0fngh0ToBJPiRnGjk_9ravw@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Prevent NULL dereference in wireless work
To: Devarjya Purkayastha <unseentactician27062006@gmail.com>
Cc: linux-input@vger.kernel.org, ping.cheng@wacom.com, jason.gerecke@wacom.com, 
	jikos@kernel.org, bentiss@kernel.org, linux-kernel@vger.kernel.org, 
	Indrath <indrathftw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sashiko responses notwithstanding (which the rest of the function
would be need to be updated to implement, not *just* this patch):

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


On Fri, Oct 30, 2026 at 10:35=E2=80=AFAM Devarjya Purkayastha
<unseentactician27062006@gmail.com> wrote:
>
> wacom_wireless_work() assumes that the active USB configuration has
> three interfaces and unconditionally accesses interface[1] and
> interface[2].
>
> A malformed configuration with fewer interfaces can therefore cause a
> NULL pointer dereference in the wireless workqueue. Return early unless
> the configuration has at least three interfaces.
>
> Reported-by: Indrath <indrathftw@gmail.com>
> Signed-off-by: Devarjya Purkayastha <unseentactician27062006@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 628372ab818a..dcf2811a5c48 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2619,7 +2619,7 @@ static void wacom_wireless_work(struct work_struct =
*work)
>
>         wacom_destroy_battery(wacom);
>
> -       if (!usbdev)
> +       if (!usbdev || usbdev->config->desc.bNumInterfaces < 3)
>                 return;
>
>         /* Stylus interface */
> --
> 2.53.0
>
>
