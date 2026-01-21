Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DE28000B
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955310; cv=pass; b=oWoyHiiSoi1Leig+rlWV6Wng3r+oafs5tWfDvB1BaWIOYRyAfRQo7sneKJEkX7BWx9FtrNqJaH/lRCcxDP4GWyAkdOC1bMvZ72YSU8KVDXwmuKvx1ZUe2fcC0TZcOlOtB0apCjXba0cFN+V/p2olYRAwizRCTEuQpzhNk7ybpR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955310; c=relaxed/simple;
	bh=ykwRyuIkN7dQxXWoW01+uvJ/5EsJIeCfEW7aZ9T9joQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEqDUHbfWghtl7J7lGbAFkK3k6Bs2wmDt/ZK+ZdrQSdZGXdOj+e2xyZOxHPBypaFPSDaMzPUEfsW0YVTBVokPgpeT4+v36PbsDks7dW1/IfaquAmOMx9cHx3bPdUfBAOHkxnM15tH6TVra6WeX3bhRhg6mVqZSSKsqMtSAXxel0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAKET0xI; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAKET0xI"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3609610f8f.2
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 16:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955306; cv=none;
        d=google.com; s=arc-20240605;
        b=afErNe044NTEvrgLwpa7p6XALTxlowqO6yXDDwbIuTk92cF+a8mIgab3hiiHFG/0S9
         27kLj91+arU90sOY8ZaX+nbYMBrCiv8ylKYx7MaHveRlRDc3xzqMQ+Z8m9P3aCcxXGOi
         kBQvAS/UTslaJ24BlcgRLtv6/7SJ9mE3alq49zXbRLKopYQXfzHemU9j9xiqTkQd6lMG
         rSUULs3fA440maoe1nhs8hHD1Cv8vcVkz6ouKz1FiTVUpiAn2y8i7GcKnX3VWMpeoVni
         bxWfO6jt1mA5cdD0nqDlaCHKNu1yRRxHjFY0rbgE+q9FjHr0wGgq9phGRP6dD2vN9EXw
         MI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        fh=6G9DAGV86LnEjTCDHl6yZ87blJMpM760CDVHn6RDuYs=;
        b=km3XsJ3n3J1id3Wtf6b7Z4EvGjLZodbXFp693PIsU8XTKsuIW147su8JvdLPwNjiMx
         xMs0QWEG3TxXSGFSJtT9+poDalz1mjLKtZhkebK6yDe8Q9rMPsFj0nIEbQlu4SGqZ3iW
         DTB2hA2A+aWCsG1bt9OHjdGBW6oC1f/vSBeDQcM8Grfdeqxnj0QObBfHrpFlLDyNsP04
         2QcBYKU6gzTrFlqbuixtLjEmEq2alaKJMyEWtH4aYN0FCKzvU3yU9p+JKvA4cxH/H6h0
         A8ak4RYSGQAz9rr83nFk5kdLIQ6/JVeAF3Je1BH8JthGX4K81UnY3T/FugXHcYhHMRtc
         HuNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955306; x=1769560106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        b=PAKET0xIKck0bjYWDLDOfrCDlhfgRtKYNope12YE57MqMd/nY8Cpj/lro1f73nLUF3
         qpim06VjPGRECOeZKshBefDaekt/zXdGs2CwvwKuJNhnpN9c6BIogUoJz4WhT4IXD4sE
         TZ6RKkgtpMyD/rvVXKoQSJ56p9x2E1ocP9upqAQvsd7W5mE7CgCvdQvEYgKxeR++bqAG
         kEkbDJgtYsK5uT34GCJzisLT2fYc3PnMx2lHDMklPuN+Nb+nEUNaBeLiSoCulpbZktLR
         jduRvz+KR6i7+NqRtexK8TrFb1+nOXD88Py2rrPginAFCfoBqvC5QoVyKJpUy8LRtoiJ
         5QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955306; x=1769560106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTxxZRuya7/Gi3hLrrFK3AMW7Li4wzwhrblZHCa6ZEo=;
        b=OK9XO7otAWodMGVzQkJBQYawpv51bEZi5M1J2mIoSVl/uVhkTFM5Vj2pWrt/wozhK6
         4HyFPtFfy6VdWtqyLgsrIfIl6Arms5o5BOd6PMbv19GV8jQD8zX0SeLKPDzFInSqP2qy
         F0sUuu7dNNk4dyCq4LrMdaSRyZgz9WdUzm6c/uLHJCFdo9I/7PRRy18apouoeqHpx9ml
         IlYnuyWNqqPPbXvLPDXeMpSqB+vyh+7jRbeEOqsh1aNBUCXYaS7AB+l8HSezojbOzZiQ
         lIClbBDvQsKy8mHP5DGFyCjyUehF5usejuxuI2QV0E/Qmdvfx/C78VcxyH7Iw6cQZ8+9
         3dQw==
X-Forwarded-Encrypted: i=1; AJvYcCXu+PKcHPrxbBVwPkIUAJ0BJF0w4HoVBdCfbMZssOp1z4icP5pUaDs5MSh5JBmwyGMO5e/B33SXTFs68Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnuQ/K17fTAE85kGeMGvuk243rRpr5MhKduQVGMdLimTI4SyV
	cvsRWK3R1gjk98iLjJVpOrPkxxwX9dCf5anjs6wTyHGBsaT9wyv8LOkBbiMTOB0DCLfTdlezkLf
	aoD7e+9pU9SJg9GNAaTIzyJ8YjPGCjuU=
X-Gm-Gg: AZuq6aI3XpRigGSkHPyi+kS9vAxPRFciMoSr78XlPyUSfY9Di85TozjVwkDDDcodVoL
	oy64Q0snihGP6AxNmHYv/K9C766OB6y1+m9602Idyd679UNY+QVtVvLw+Ly3KB7vjUM88CxqSeg
	F0hfmiz/1jezwWh9ZuLXNQKJEw1w3g/jElNmWOHQw5CV+Y0jFx1DwXKIHy46QwQbEGBtFwTBt2N
	9RoQCp/25LmXhcd4J6vGYO42I2Yw2ej2TIdsrrn7Ly7WK00hmqreAA7pFShc0wSzjgWtmMiI6PC
	mb2YywAnzzBSY/Ia6uELODrtQFJoVQaEmFASGBG1sKgEYKSlaRmWrUSk8C4+8fQwq/uEEa3tfOe
	lrn5hneckxfZ/IQ==
X-Received: by 2002:a5d:5887:0:b0:431:2b2:9628 with SMTP id
 ffacd0b85a97d-43569bc791bmr23387063f8f.52.1768955305540; Tue, 20 Jan 2026
 16:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev> <20260120222638.3976562-10-ihor.solodrai@linux.dev>
In-Reply-To: <20260120222638.3976562-10-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jan 2026 16:28:14 -0800
X-Gm-Features: AZwV_QirZ7by-RSgel-23msL5t8z84yNv4bEqKzD1qVtVLw3zvjD9Oq_RbOOeic
Message-ID: <CAADnVQLm7kOxTa47POtNGYcjHm-S3neKWKAgjZL_5uw--syMCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Migrate bpf_task_work_schedule_*
 kfuncs to KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 2:27=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
>                 return 0;
> -       bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, proc=
ess_work, NULL);
> +
> +       bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_w=
ork);
> +
>         return 0;
>  }
>
> @@ -102,6 +105,8 @@ int oncpu_lru_map(struct pt_regs *args)
>         work =3D bpf_map_lookup_elem(&lrumap, &key);
>         if (!work || work->data[0])
>                 return 0;
> -       bpf_task_work_schedule_resume_impl(task, &work->tw, &lrumap, proc=
ess_work, NULL);
> +
> +       bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_w=
ork);
> +
>         return 0;

I removed extra empty lines, since they don't fit the style
of these tests.
While applying.
