Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65F347BA9
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776633; cv=pass; b=T9oTXBC6ATV45zBrhRih3aSw1x+x2ZtcXjqXwN7WYCBEyHfsONQDYqX42RWYrwuvBPAYaP0Rvi6F1dXBT6TaPw0cgQIcnuXGcfJRHZr2Z7O72uFbTrR3P8qiRkL6u3rHuF43jZlBz0E46XUIF/7NQq8PhgPbORPGyD1RoLUyH4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776633; c=relaxed/simple;
	bh=BiYy7HF0IwDK6b0w79Auep+kv5O+s0n1cY+JcYz2QDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+9SW5Ir1sEuMsZoGjV5Jv1k9uBmaH3E8cHVH0lfwdwu1w0pFkV2l7nxi1p0C7jKMgd74fH9YJBn2aQZ3Jel4ZvXVFhZZFw7uM7pTvJuHAdw18GVAYX0XnJbIsYii0boAdW6ijj4ezKsiM395dYBulbmNG5B4c5poBynMKaLSfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNGCIrkJ; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNGCIrkJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a0ecbc713so46186346d6.1
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 21:57:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776631; cv=none;
        d=google.com; s=arc-20240605;
        b=gNA06xkqjZoGDy3BB32fmcTa5tVHaoafX8HDcEuwdJofUhcv/qZz1OmFdzdI5cqNHV
         AoFYSYcjtMbQmw/Cg3llUZuOwYK4ywDgp7Nfyed/h9qHXK4zpvSCCc2ZNx6hGISnpJTY
         g8Qfw/kKKGQntHwJGVI/wYgtKAdwghWT0cChOU0PdKZzIQy/QE2A7Fy2j0/Tn7zBMOkt
         UOCpnuPiKUbAS6/kr54KlXWARoE9jNXqA4mDkdP4XmdzSE2dsuEvx7MJ0e8GHRd+Emqm
         /1TZnnfrHhnSNYJM5sodArfAq4nOiU5cmuGb2XsB3ClClUnLSLdYcfv7VXr4+7M61uVS
         sfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U+ap96wfdaCd2LzkHjpinDRlU63T8/2F3iphCuU6xrk=;
        fh=P43ZPz3n3j4ixzPvzjEOR4vrPWzHqbQ5BjbtUt2R9LI=;
        b=FhigXoU8Cet7bv5KKoZnfA6VZRHVw/igG6XgUK9Q8on0aHCb5WkALv89auOsUjWJ+H
         shaahtsdgw10QZpK72GcuoRKWd3C73+BgNmrgylc3DkT4mBmJ3HnT88M4DcN7e+qD14t
         tyocnjPb3I7zUEukUkS89DWFCdjguoOUtHVA/6whqi2QgEEsuwSlRZYGHPUaSIUZO6Vg
         Fw66E4aALXY8wHxT6jqosFGJ8A/TueQ/OQx5diNyiTWD2yNP35pzXydb5rYKs66ivKrz
         5Ijb99UxWRPFUydpBAIMwkC8cTX+6OVK4o76jZImOZxGEmMA4kXpKKbYw1Pb3Iosqcfg
         bGsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772776631; x=1773381431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+ap96wfdaCd2LzkHjpinDRlU63T8/2F3iphCuU6xrk=;
        b=cNGCIrkJbR1vDZifGJgO4klnikJGx2ZgxFnQfw13yA/yWc0kvg5HnQyak4fjF2gyj4
         /MfGbD8hEwO/RA8lGG4cucJStxQKdZEsBgpdbjDXvvz/jvDE5WpbTgnDwXu/mbPPtCJw
         W1IDHYVSZ4pf83mnJHV67SkLVabsIzKfEtzDbyQ3TANAxmMxQqex3VYjxL8WJxMkfjhD
         gFdlW170h0jKNSrC+aNBb4kKh/lyYyqmy4j/leE0dO6/JMMviRceyvWtmhNGaGdr0aZo
         slBBZr7x5XwaYwRxhmCClr0ID4IRAfqJ6qT+THz1OeQH0C5hzQIGb7kpD8A7Cm7aayys
         6QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776631; x=1773381431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+ap96wfdaCd2LzkHjpinDRlU63T8/2F3iphCuU6xrk=;
        b=IWGwHRMJKOOmTY6wB6tNCCovtsmRm3w+kB3EKHdnxk/nbafxFVLt2UmYKy/hKI2wy6
         eSzQdQUa96rJMVyco4R3xIU0ovLyFUrEQiXCw+SWo4NaL0MNm3DN7gCBe/f37KgCw6+Q
         FWYKbLEJHfjJzWNmUm+Ujxs8SpV3N5asuLaa2ieKSF4EuTToC0UgVm8YmjFsdg+6rFxm
         mNH1FtpeJ81tooqRk3sp32KLxv9YN1KwT49B31nJUYRcHmS3uj/LHavL+8QnnMX6KsJY
         oy+4ccOiomq4HVEzZhLLTgf6APepDMgyTOIWo/J/IHQdUTsRzHciZ/JGsRpjHTnMZB0h
         XkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5HmzRCxPoRslEre2vcRsj8Z3SeDyoN6aGP5K53R0L8EqVdmpdNJt+a8tPIPG7Y0iRqGWWeFUqNdpADw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2fvF/Y78JfYx3wbnqoR1Vf9OjtyNuw4LEZfjNztCLk0o7kJq
	kSNWY8U82G0CFsELxZd/yUEkejDrzJXYWfgfEGxYu7l8O8TprKrKPw4CNAZbJwk5bTtmJRmYElh
	WHYYillgXhbfsbOGW3Mm7Z5wqIlCZjWEZ8Q==
X-Gm-Gg: ATEYQzwaoHUWsVpYW1PtAAesmubznBS/KachT3GbfR4IzHVGlwWfMxZcntPbcwcvNZX
	zC5hUbaHalMnopmc+LJn5/EiLXa8Y5OcsyT2KUogEIRB/Op7OJLbEgIOq/gM27cyNWw3jeZ1gK6
	U0A1l86wcune6caMqXMAnz70L28bLhaVQWe2Hzsvbxvrr5IdiGC+eeGZsvF0Ja8G08LUrhQxbKF
	mZTDx4mbYUvnsuWXk82cSYziRLKtFI27vr6yaTu1qaW2t2/L5DWXBiSEiqcjByNRFyyKqiELzu5
	9W6jKbMtWzlGaOPodg==
X-Received: by 2002:ad4:5fcc:0:b0:89a:649:f88e with SMTP id
 6a1803df08f44-89a247f5f6emr68855626d6.28.1772776631520; Thu, 05 Mar 2026
 21:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227205444.1083103-1-ethantidmore06@gmail.com> <20260227205444.1083103-2-ethantidmore06@gmail.com>
In-Reply-To: <20260227205444.1083103-2-ethantidmore06@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 5 Mar 2026 21:57:00 -0800
X-Gm-Features: AaiRm51U8ZMPUAykrqW3NBsyveMpVWIcwSe5A6bIlSDI9Ap3jdynOpK94_izvvU
Message-ID: <CAFqHKT=uv3Ur4HN=EMnfu6AhEDV_ZL3VZ7d708a41GJLxJ9HVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: hid-lenovo-go-s: Fix signedness bug
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:55=E2=80=AFPM Ethan Tidmore <ethantidmore06@gmai=
l.com> wrote:
>
> The function get_endpoint_address() returns type u8 but in its error
> path returns -ENODEV. Also, every variable that is assigned from this
> function is type int.
>
> Change return type to int from u8.
>
> Detected by Smatch:
> drivers/hid/hid-lenovo-go-s.c:391 get_endpoint_address() warn:
> signedness bug returning '(-19)'
>
> Fixes: 4325fdab5dbbf ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Serie=
s HID Driver")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/hid/hid-lenovo-go-s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.=
c
> index cacc5bd5ed2b..0ef98ba68d86 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -377,7 +377,7 @@ static int hid_gos_set_event_return(struct command_re=
port *cmd_rep)
>         return 0;
>  }
>
> -static u8 get_endpoint_address(struct hid_device *hdev)
> +static int get_endpoint_address(struct hid_device *hdev)
>  {
>         struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent)=
;
>         struct usb_host_endpoint *ep;
> --
> 2.53.0
>
Hmm, odd that I did this correctly in the Go driver.
Thanks.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
