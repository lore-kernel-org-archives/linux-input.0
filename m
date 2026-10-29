Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793279233;
	b=W7Hn7u3xISfci5zD8yTYHJPy2qdINXsS69/zQ10oGqV0OwoQHsdjGxjGwacZH8soEDMz
	 gzsmolLrqMhw3EMQjL/+5sBF4mR1LMi5vkjMZysGbMkIXltE2uUZt7ZP8oCP0CtctNv8K
	 +q+MB8BI/ra3IUIh42sJmo6mHONXjYdic3Ke9WhTO8UFDIMjoMiONlhBroWryD0VXnK6L
	 W+jB4TRWHJmXl3Xt34pQmSBJPauLnzMnnurINXO0x4Z2QRw0al365a1zedQAa0wxTi/r/
	 CKDLJESwtWFDdBdjk6rWjiWGCxdqQvR5ZoYmEWIopf9sGYsdlOUG/2LYlGI4EI86GIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:In-Reply-To:
	 References:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=xdN6jk0eujZ1yoh5fgyzSi8ChLX6LUcyioDNVutJ+X4=;
	b=uZJhy0+iMGfYIQlkOrOTyED12VRs4N8diyH2SxuXVUo0lv4NfDR/pRq0cmACYRrFBZNm
	 YX/hNXSkHS+YwTop1LLVpIp0n5ATSLN5SWG5Mf6gV/0FOk8mxCZ5NuV6cgWygmzkGymtK
	 cLf7KQNXVIznfIAjUOeNdGRkBbpLh2CeNmEcgeT+s7r5A4tDX0NGhxfC8d/tLx12g76of
	 olDSkOqvhBQRAy6UAYxTP5pUiOOXeZWJZSpq7k5HhW060vMiFiisxHVMvGIL1VnCdj++E
	 tpY1XbLh+mzWR9XKvZfd0tXYn1JbhDv5lRjWchmmFUTtbhi5aQh/+jwFsjCQtvk5w2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZurprNWh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF606A31A
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 13:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B44DF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZurprNWh
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3564so415670a91.1
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 06:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793279232; cv=none;
        d=google.com; s=arc-20260327;
        b=H5f4eJiFaXktXFnmf/CGc8nYERdpRIvBjnMlXtCluWPE+eqMIVO+ezPc8YK9csNfK4
         bCe2beC/qKmT1V2dOmdfOP0BgGQ1uqF/Iq4/kCShr00wmt/WiSARKUDQaPAV81iv2M0P
         IT82rG9jhAmgWnY/+tdkva2j75pAr+tGr+fr3H0LtqtfWFwU32EBguLKgUxnP9x6uZJn
         5p55eLzlHfOMt3XCri1xdesyNnjwj5w32wxNmCRjY5MCMcNle+YzhdB9xf622i51CqKK
         3/guDy2NpC3JW5HG4uJx/YnNQeUg1SCky1aAUPba4d3H186ry/sW+iLhK7cTxnNmJI/g
         ue7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=xdN6jk0eujZ1yoh5fgyzSi8ChLX6LUcyioDNVutJ+X4=;
        fh=6SojDNOdUsx8BldkslaKZXO6doGA9uxt0tQnHsnNuOY=;
        b=JvgozVD6x+/83jJEW6+TQ+3htw/D9ihSzehVXzeLWNwXCeBqYVQqNRDIsSSwPNTciy
         2G/NE89Ffzj79jXUfDCv0Iy+Iwp/nAp4opIFuuyJpGPGVmFUIUmx9yP4o/6GUHS90zRp
         V8zZ8X72hmfZ65md/U2tBb4oko18cPUxN378j8lTYAHEgyK6M5fQbiylLj0HBy7glDzm
         XWCq1KezdyOTiNUCABFnQoaiAV0A7dEZCPAzJ4psSMmsuyev/xCbDE68AMylwdJL5fI3
         C/gzKRvqhiJQIrGrgnsuqzLLlwmJK4GxhqXhNiWFrFFiMZ6YT0YyZz/L/FXxCVsC+BOE
         XmeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793279232; x=1793884032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xdN6jk0eujZ1yoh5fgyzSi8ChLX6LUcyioDNVutJ+X4=;
        b=ZurprNWhVNlYOBBnNow4tRcpitsX5mNqll/GsA7lDlR0JFcvpCBhGvV+3ZWk3UTth6
         OOrNKKdOfU4+lA/VpLEZAmRmp4NAEhjkAb4XEIU5/BAFdsSaqC4IxtnjIwqFjXdq3KnV
         fQbKyOunZpcS/neTTOv2RJj3lOmZN9oquNP4FlBK+NPiS7ttebeYhJk9Y4NXiHtZh/ZK
         Tzls5nyTBnzSMuSDqiCPy1h7MhwJceoM6MWxyKfpDHxUlw74YmLEAzTa6nj3DW93eddb
         opifZc1COYMFIB6SGP8ONbVnZOkA1KBlwKeZApQ5v9kLqpsYIoQnajnPRXfz00ZcCln2
         Z85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279232; x=1793884032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdN6jk0eujZ1yoh5fgyzSi8ChLX6LUcyioDNVutJ+X4=;
        b=fOpGcVMI7qTUxiFrT/+yaKcTsjvGQeZLtIrB+jvxkEPLgCp1ou0UWeUoe3aextoNJs
         tRYIqo1sX5iDSv1IhQqVSsuRUC0TCWcOl/pmy3ZqexJof8YocjoxjZCFsaCjfSQuUJhk
         bdZN+N65rkBnLL7jeHAZ5+PfZA4/WsWEj60A9FVcdjYLVrZ65r/c9ngZu7CyN9WBXuee
         YXMgx0TViX6k64z7oQuYGzQPFPeDwYKCKCv22Q21dd/8s26CnBFT5LrA46KUZPD523/Y
         qNaRMW4l/0uI3K2Xjuxh2Sd8MdkaE6CbCs7iFyv4/Rh7Q5qNcyzyZtk6DDpHCL46i50I
         ezCA==
X-Gm-Message-State: AFq9FYK78IRXNF1s/0BHUlCi6F6F7KJ/Dli3x9wxYxkEpV+TcT6OS+Qh
	kAcA+mOc9aRiknmNfA+G5+aYrRMys/zu8ET329HKhc/Lxg28Q1/qv9GxgnHb6pEJQ4Wp5ambX38
	kluzCwbEJgFfkPbEfDGwxEPim9RSnE/4=
X-Gm-Gg: AYBFou0TiJf/O9zpcHXlX3nasGK1WvPCntBHrsf4fNnXpfSQ3QsHap+ZMoTJvhu6I9b
	scc6yFXgYqt8XeRvk6OXRBGoroGoTF87ZMDIPhvmMe3LpZuxnvB0toSHxN/OpNXodUlaezb5xwN
	ydVsSV9AS44k2ZDQm0nDbYyiCpBdyaVe1+meXufTCZfhMHTKrHLt3eMw008LDC6AYg8ZmHQdEvK
	LppaqMQmxw0nuESDXy59cpL/vGumbaPTFR3fVhAvfJ9zdZcJ+z884IIz3Li6n8AAsJ+/OlOH92M
	LTPGOicAOFiyi2vy5VpVDqR9ruwUE+A7hlL+q8ZKqeewNTixXZIGbvghYUC23kdwi1veib8IkPA
	rLSQTCgrxLdxND2YuxH5EIkmj0BS8YgJDALvOCjSizJKsb7hJC5W/gySoUj4voCDYtM4=
X-Received: by 2002:a17:90b:17c2:b0:3ad:1da4:2ddf with SMTP id
 98e67ed59e1d1-3ae581bbdcbmr4109405a91.51.1793279231953; Thu, 29 Oct 2026
 06:07:11 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 06:07:09 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 06:07:09 -0700
In-Reply-To: <CANOyQmH4EU=6kb+d2ELL68FLj8yvtq8McHtUMWthQ3WUJQTuWQ@mail.gmail.com>
References: <CANOyQmH4EU=6kb+d2ELL68FLj8yvtq8McHtUMWthQ3WUJQTuWQ@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 29 Oct 2026 06:07:09 -0700
X-Gm-Features: AclHuK8x9bqC8M491Cgb06HbjsT-vATriEI3JD2nxTuspYvDZeJJQuf75a-dpjo
Message-ID: <CANOyQmHU_aynnHxDwiGPp_jRBB+ZEK_stZGfix-7=kRx67a6-Q@mail.gmail.com>
Subject: Re: HID: picolcd: maintainer address in MAINTAINERS is bouncing
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Benjamin,

Just following up on my earlier report about Bruno's address
in MAINTAINERS. My emails to bonbons@linux-vserver.org
bounced with a notification that the account does not exist.

My PicoLCD v2 series is also awaiting review of patch 1/2,
while patch 2/2 has received an Acked-by from Helge Deller.

Is there an updated contact address for Bruno, or should
the MAINTAINERS entry be updated?

I'd also be happy to help with PicoLCD maintenance if needed.

Thanks,
Aveline

On Mon, 5 Oct 2026 04:33:20 -0400, Aveline Noir <jm5905938@gmail.com> wrote=
:
> Hi Jiri, Benjamin,
>
> Resending as plain text; the previous copy was rejected by the mailing li=
st.
>
> When sending my picoLCD patch series on 28 September 2026,
> "[PATCH 0/2] HID: picolcd: Fix output-request and framebuffer locking",
> I received delivery failures for Bruno Pr=C3=A9mont's address,
> bonbons@linux-vserver.org. A follow-up reply on the same day also bounced
> for that recipient. The delivery notification says:
>
> > The email account that you tried to reach does not exist.
>
> This address is still listed under "PICOLCD HID DRIVER" in the mainline
> MAINTAINERS file.
>
> Does anyone know whether Bruno has an updated contact address, or whether
> this is a known delivery issue? I'd like to make sure future picoLCD
> patches reach the right people.
>
> Thanks,
> Aveline Noir
